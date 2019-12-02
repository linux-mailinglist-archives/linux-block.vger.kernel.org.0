Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A10210E9A9
	for <lists+linux-block@lfdr.de>; Mon,  2 Dec 2019 12:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfLBLmN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Dec 2019 06:42:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:41162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727399AbfLBLmN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Dec 2019 06:42:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5C727B1AA;
        Mon,  2 Dec 2019 11:42:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 12:42:11 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: io_uring: EIO on write to a file on a ram dev
Message-ID: <5c8191161dad15ae6bbd60e5953a5b51@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I stumbled upon EIO error while writing to a file which is on ram device
(actually any dev which is in bio mode, i.e. uses make_request_fn hook).
All details will be clear from the reproduction description.

How to reproduce:

   mkfs.ext4 /dev/ram0
   mount /dev/ram0 /mnt

   # Works fine, since we take async path in io_uring and create kiocb
   # without IOCB_NOWAIT
   fio --rw=write --ioengine=io_uring --size=1M --direct 1 --name=job 
--filename=/mnt/file

   # Repeat, all fs blocks are allocated and pure nowait & direct path
   # is taken and eventually we get -EIO
   fio --rw=write --ioengine=io_uring --size=1M --direct 1 --name=job 
--filename=/mnt/file


The culprit is the following check:

    generic_make_request_checks():
         if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
		    goto not_supported;


Probably the solution can be to complete bio with BLK_STS_AGAIN which
can be then correctly handled in dio_bio_complete() and eventually
async path in io_uring will be taken:

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -889,20 +889,31 @@ generic_make_request_checks(struct bio *bio)
         /*
          * For a REQ_NOWAIT based request, return -EOPNOTSUPP
          * if queue is not a request based queue.
          */
-       if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
-               goto not_supported;
+       if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q)) {
+               status = BLK_STS_AGAIN;
+               goto end_io;
+       }

(and this works) but I'm afraid that should degrade performance, since
on each IO we hit the error deeply in the stack, rewind the stack and
repeat the whole procedure from a worker.


Other confusing thing is that when io_uring writes directly to /dev/ram0
no errors are returned, because eventually bio is created and does not
inherit NOWAIT flag on this path:

    __blkdev_direct_IO():
         bio->bi_opf = dio_bio_write_op(iocb);

as opposed to writing directly to a file on the same ram dev, where all
flags are inherited from dio:

    __blockdev_direct_IO
    do_blockdev_direct_IO
    dio_send_cur_page
    dio_new_bio
    dio_bio_alloc():
         bio_set_op_attrs(bio, dio->op, dio->op_flags);

Not clear is that an intention not to inherit the NOWAIT flag inside
__blkdev_direct_IO or the flag is simply lost?

--
Roman

