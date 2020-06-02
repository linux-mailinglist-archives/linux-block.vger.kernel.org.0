Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B86A1EC46D
	for <lists+linux-block@lfdr.de>; Tue,  2 Jun 2020 23:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgFBVjX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jun 2020 17:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgFBVjX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 17:39:23 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF5720870;
        Tue,  2 Jun 2020 21:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591133963;
        bh=CZ3tWKdReHovy4+PiN8qETj3xN00roFN4Fdq69Iju3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlWCmV02nKvoT3ayPGLRXh16q6wUlhjyRD885mMnBhe6GBBBCsCQJ8lRbQS8WU3HH
         O8yemse4UWKf6pVRr6hh0+rgj8THe/+bWjhGNQTWj2KTQzA9Uh7H1xaW21WS1hbuXI
         75zavsDEFZAXXYTRYkFUnA6HJiWkNo2ohUMH5ZVo=
Date:   Tue, 2 Jun 2020 14:39:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>
Subject: Re: [PATCH] block: fix an integer overflow in logical block size
Message-ID: <20200602213921.GA229073@gmail.com>
References: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2001150833180.31494@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 15, 2020 at 08:35:25AM -0500, Mikulas Patocka wrote:
> Logical block size has type unsigned short. That means that it can be at
> most 32768. However, there are architectures that can run with 64k pages
> (for example arm64) and on these architectures, it may be possible to
> create block devices with 64k block size.
> 
> For exmaple (run this on an architecture with 64k pages):
> # modprobe brd rd_size=1048576
> # dmsetup create cache --table "0 `blockdev --getsize /dev/ram0` writecache s /dev/ram0 /dev/ram1 65536 0"
> # mkfs.ext4 -b 65536 /dev/mapper/cache
> # mount -t ext4 /dev/mapper/cache /mnt/test
> 
> Mount will fail with this error because it tries to read the superblock using 2-sector
> access:
>   device-mapper: writecache: I/O is not aligned, sector 2, size 1024, block size 65536
>   EXT4-fs (dm-0): unable to read superblock
> 
> This patch changes the logical block size from unsigned short to unsigned
> int to avoid the overflow.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Mikulas, a question about this patch.  In crypt_io_hints() in
drivers/md/dm-crypt.c there is:

       limits->logical_block_size =
                max_t(unsigned short, limits->logical_block_size, cc->sector_size);

Shouldn't that have been changed to 'unsigned int', now that
limits->logical_block_size is 'unsigned int' rather than 'unsigned short'?

- Eric
