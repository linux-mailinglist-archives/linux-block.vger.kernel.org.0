Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F94482A2A
	for <lists+linux-block@lfdr.de>; Tue,  6 Aug 2019 06:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfHFEJo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Aug 2019 00:09:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44847 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFEJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Aug 2019 00:09:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so37265353plr.11
        for <linux-block@vger.kernel.org>; Mon, 05 Aug 2019 21:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SOsBb/aQAYxLU2ilbUJcZu773GlOsl8Ye7L37NrMJJ8=;
        b=LXTwZpw+JU5BIyBBiPDOasLfQ+uzjEpAA+0G/hUZEEJvX00/8eWi8M2oOggMX/Kcz0
         Gu31HPq/EyNxV5qos57oOVxqX4OHv3i2vHCBvbuurOwIWTr1yI4+Ze3G6zYkfRS+3nmF
         rvlRMW+Kr08wXl4aPfV4YhpqmI/fiJy5bRJvpA5FqR7cNjNdsP+6Ac7kBeovqw/r0RxJ
         6SqzJIlM5CHX3uEshW3OjnUpWiwlLLPEcx9Mh69riBdSOGPCrohvtGdgD97aaTHz7yjH
         vQrUJS4lR1IoLdoJ+lDvQQmI8c+Nwam6E95xicyPHpQsHCyroSn+6/3u3t7pqsXg9wGt
         NWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SOsBb/aQAYxLU2ilbUJcZu773GlOsl8Ye7L37NrMJJ8=;
        b=rGcZV0sQsw25uxaYZoXY1RQF72n8kiFMRrRh7soM0rMocRnWmszCcdctIt8GgfHBFM
         AFd5YTj0IDyo6Lx8hy5x8EzNiIx0ElrWgukOwx6typ04aVJI+0iCDFhDy4WmESTZtZgD
         M0FwrgjSGPNhM6Kgh46KkOvvK15ZyJN7lTsAX+FptFbZHJEMKcQJaDi+zTju7NfJaaaz
         jAHxbvSxsD/zSWkT3FEH1m3TWyAO0GjUusKofcA71w3qs+JsRFikLN1/eM5fXVjT/3sh
         eYRxMR+kgiou9LH/tJNFU48//x+GOFQbxjgCDKUgALUjt+ukw/679wBciQHnZqVYOyIh
         +zbQ==
X-Gm-Message-State: APjAAAWthQ9Gc+7PLQbSQ80WsSsJGJIcNDaDIZd16FHfhSiDHPPsKd1K
        SDQ7RNjpTbWAHyR4/8i8A0kX0g==
X-Google-Smtp-Source: APXvYqxn0mYAq5WQzBtF4Fe4fvvlJ7QwLnusuZLhrWZ0ziim6zmGFXP08ZXuVobBfKWAkN9x8mvalQ==
X-Received: by 2002:a17:902:24c:: with SMTP id 70mr1139679plc.2.1565064583191;
        Mon, 05 Aug 2019 21:09:43 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:939:cd30:5103:86da? ([2605:e000:100e:83a1:939:cd30:5103:86da])
        by smtp.gmail.com with ESMTPSA id g2sm104450602pfb.95.2019.08.05.21.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 21:09:41 -0700 (PDT)
Subject: Re: Block device direct read EIO handling broken?
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
References: <20190805181524.GE7129@magnolia>
 <66bd785d-7598-5cc2-5e98-447fd128c153@kernel.dk>
 <36973a52-e876-fc09-7a63-2fc16b855f8d@kernel.dk>
 <BYAPR04MB5816246256B1333C048EB0A1E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <474c560f-5de0-6082-67ac-f7c640d9b346@kernel.dk>
 <BYAPR04MB5816C3B24310C1E18F9E024CE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <f3f98663-8f92-c933-c7c0-8db6635e6112@kernel.dk>
 <BYAPR04MB581644536C6EAEA36E3B4912E7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816C7D04915AF7B656F900BE7DA0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <43435418-9d70-ec33-1f2d-c95fb986979c@kernel.dk>
Date:   Mon, 5 Aug 2019 21:09:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816D1AB6B586FAD664F8D79E7D50@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/19 5:05 PM, Damien Le Moal wrote:
> On 2019/08/06 7:05, Damien Le Moal wrote:
>> On 2019/08/06 6:59, Damien Le Moal wrote:
>>> On 2019/08/06 6:28, Jens Axboe wrote:
>>>> On 8/5/19 2:27 PM, Damien Le Moal wrote:
>>>>> On 2019/08/06 6:26, Jens Axboe wrote:
>>>>>>> In any case, looking again at this code, it looks like there is a
>>>>>>> problem with dio->size being incremented early, even for fragments
>>>>>>> that get BLK_QC_T_EAGAIN, because dio->size is being used in
>>>>>>> blkdev_bio_end_io(). So an incorrect size can be reported to user
>>>>>>> space in that case on completion (e.g. large asynchronous no-wait dio
>>>>>>> that cannot be issued in one go).
>>>>>>>
>>>>>>> So maybe something like this ? (completely untested)
>>>>>>
>>>>>> I think that looks pretty good, I like not double accounting with
>>>>>> this_size and dio->size, and we retain the old style ordering for the
>>>>>> ret value.
>>>>>
>>>>> Do you want a proper patch with real testing backup ? I can send that
>>>>> later today.
>>>>
>>>> Yeah that'd be great, I like your approach better.
>>>>
>>>
>>> Looking again, I think this is not it yet: dio->size is being referenced after
>>> submit_bio(), so blkdev_bio_end_io() may see the old value if the bio completes
>>> before dio->size increment. So the use-after-free is still there. And since
>>> blkdev_bio_end_io() processes completion to user space only when dio->ref
>>> becomes 0, adding an atomic_inc/dec(&dio->ref) over the loop would not help and
>>> does not cover the single BIO case. Any idea how to address this one ?
>>>
>>
>> May be add a bio_get/put() over the 2 places that do submit_bio() would work,
>> for all cases (single/multi BIO, sync & async). E.g.:
>>
>> +                       bio_get(bio);
>>                          qc = submit_bio(bio);
>>                          if (qc == BLK_QC_T_EAGAIN) {
>>                                  if (!dio->size)
>>                                          ret = -EAGAIN;
>> +                               bio_put(bio);
>>                                  goto error;
>>                          }
>>                          dio->size += bio_size;
>> +                       bio_put(bio);
>>
>> Thoughts ?
>>
> 
> That does not work since the reference to dio->size in
> blkdev_bio_end_io() depends on atomic_dec_and_test(&dio->ref) which
> counts the BIO fragments for the dio (+1 for async multi-bio case). So
> completion of the last bio can still reference the old value of
> dio->size.
> 
> Adding a bio_get/put() on dio->bio ensures that dio stays around, but
> does not prevent the use of the wrong dio->size. Adding an additional
> atomic_inc/dec(&dio->ref) would prevent that, but we would need to
> handle dio completion at the end of __blkdev_direct_IO() if all BIO
> fragments already completed at that point. That is a lot more plumbing
> needed, relying completely on dio->ref for all cases, thus removing
> the dio->multi_bio management.
> 
> Something like this:

Don't like this, as it adds unnecessary atomics for the sync case.
What's wrong with just adjusting dio->size if we get BLK_QC_T_EAGAIN?
It's safe to do so, since we're doing the final put later. We just can't
do it for the normal case of submit_bio() succeeding. Kill the new 'ret'
usage and return to what we had as well, it's more readable too imho.

Totally untested...

diff --git a/fs/block_dev.c b/fs/block_dev.c
index a6f7c892cb4a..131e2e0582a6 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -349,7 +349,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	loff_t pos = iocb->ki_pos;
 	blk_qc_t qc = BLK_QC_T_NONE;
 	gfp_t gfp;
-	ssize_t ret;
+	int ret;
 
 	if ((pos | iov_iter_alignment(iter)) &
 	    (bdev_logical_block_size(bdev) - 1))
@@ -386,8 +386,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	ret = 0;
 	for (;;) {
-		int err;
-
 		bio_set_dev(bio, bdev);
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_write_hint = iocb->ki_hint;
@@ -395,10 +393,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_end_io = blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
-		err = bio_iov_iter_get_pages(bio, iter);
-		if (unlikely(err)) {
-			if (!ret)
-				ret = err;
+		ret = bio_iov_iter_get_pages(bio, iter);
+		if (unlikely(ret)) {
 			bio->bi_status = BLK_STS_IOERR;
 			bio_endio(bio);
 			break;
@@ -421,7 +417,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		if (nowait)
 			bio->bi_opf |= (REQ_NOWAIT | REQ_NOWAIT_INLINE);
 
-		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
@@ -433,13 +428,13 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 				polled = true;
 			}
 
+			dio->size += bio->bi_iter.bi_size;
 			qc = submit_bio(bio);
 			if (qc == BLK_QC_T_EAGAIN) {
-				if (!ret)
-					ret = -EAGAIN;
+				dio->size -= bio->bi_iter.bi_size;
+				ret = -EAGAIN;
 				goto error;
 			}
-			ret = dio->size;
 
 			if (polled)
 				WRITE_ONCE(iocb->ki_cookie, qc);
@@ -460,18 +455,17 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 			atomic_inc(&dio->ref);
 		}
 
+		dio->size += bio->bi_iter.bi_size;
 		qc = submit_bio(bio);
 		if (qc == BLK_QC_T_EAGAIN) {
-			if (!ret)
-				ret = -EAGAIN;
+			dio->size -= bio->bi_iter.bi_size;
+			ret = -EAGAIN;
 			goto error;
 		}
-		ret = dio->size;
 
 		bio = bio_alloc(gfp, nr_pages);
 		if (!bio) {
-			if (!ret)
-				ret = -EAGAIN;
+			ret = -EAGAIN;
 			goto error;
 		}
 	}
@@ -496,6 +490,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 out:
 	if (!ret)
 		ret = blk_status_to_errno(dio->bio.bi_status);
+	if (likely(!ret))
+		ret = dio->size;
 
 	bio_put(&dio->bio);
 	return ret;

-- 
Jens Axboe

