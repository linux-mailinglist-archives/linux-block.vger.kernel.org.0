Return-Path: <linux-block+bounces-282-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACE7F0C0D
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 07:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F611F215D1
	for <lists+linux-block@lfdr.de>; Mon, 20 Nov 2023 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13C3D64;
	Mon, 20 Nov 2023 06:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYfs7z2t"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC0C1
	for <linux-block@vger.kernel.org>; Sun, 19 Nov 2023 22:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700463523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3Wb7smznhQ1O5YfmYQBuWMh/Izn5DimV+3IJJnnizs=;
	b=QYfs7z2tUOWFnDM6WZgeELqxglU4jGHrR7EjyQFBNZrMZv3P3e0Swx6XIY3UkSZg5hLPUL
	MBb5sZJkij0ccfts4PZJAbADXZmrsmKe2uR1Yq8VMqW7ERwm19Kmg6qxZ4O8MZkn5N2p9o
	qocKty9sT29I/cOLdEh9fOlMTd5c+X8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-SFaIrzkMPGuntee77smefQ-1; Mon, 20 Nov 2023 01:58:39 -0500
X-MC-Unique: SFaIrzkMPGuntee77smefQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA32585A58B;
	Mon, 20 Nov 2023 06:58:38 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 041C440C6EBA;
	Mon, 20 Nov 2023 06:58:33 +0000 (UTC)
Date: Mon, 20 Nov 2023 14:58:29 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] block: introduce new field flags in block_device
Message-ID: <ZVsDlcg9cAdIHiV8@fedora>
References: <20231120093847.2228127-1-yukuai1@huaweicloud.com>
 <20231120093847.2228127-2-yukuai1@huaweicloud.com>
 <ZVrLvcIhlnQl7xAb@fedora>
 <9fc5e82f-9106-e3f9-4f06-d2d79e8e99a8@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fc5e82f-9106-e3f9-4f06-d2d79e8e99a8@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Mon, Nov 20, 2023 at 02:37:59PM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2023/11/20 11:00, Ming Lei 写道:
> > On Mon, Nov 20, 2023 at 05:38:46PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > There are multiple switches in struct block_device, use seperate bool
> > > fields for them is not gracefully. Add a new field flags and replace
> > > swithes to a bit, there are no functional changes, and preapre to add
> > > a new switch in the next patch.
> > > 
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   block/bdev.c              | 15 ++++++++-------
> > >   block/blk-core.c          |  7 ++++---
> > >   block/genhd.c             |  8 +++++---
> > >   block/ioctl.c             |  2 +-
> > >   include/linux/blk_types.h | 12 ++++++------
> > >   include/linux/blkdev.h    |  5 +++--
> > >   6 files changed, 27 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/block/bdev.c b/block/bdev.c
> > > index fc8d28d77495..cb849bcf61ae 100644
> > > --- a/block/bdev.c
> > > +++ b/block/bdev.c
> > > @@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
> > >   	bdev->bd_partno = partno;
> > >   	bdev->bd_inode = inode;
> > >   	bdev->bd_queue = disk->queue;
> > > -	if (partno)
> > > -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
> > > +	if (partno && test_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags))
> > > +		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
> > >   	else
> > > -		bdev->bd_has_submit_bio = false;
> > > +		clear_bit(BD_FLAG_HAS_SUBMIT_BIO, &bdev->flags);
> > >   	bdev->bd_stats = alloc_percpu(struct disk_stats);
> > >   	if (!bdev->bd_stats) {
> > >   		iput(inode);
> > > @@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
> > >   		bdev->bd_holder = NULL;
> > >   		bdev->bd_holder_ops = NULL;
> > >   		mutex_unlock(&bdev->bd_holder_lock);
> > > -		if (bdev->bd_write_holder)
> > > +		if (test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags))
> > >   			unblock = true;
> > >   	}
> > >   	if (!whole->bd_holders)
> > > @@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
> > >   	 */
> > >   	if (unblock) {
> > >   		disk_unblock_events(bdev->bd_disk);
> > > -		bdev->bd_write_holder = false;
> > > +		clear_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
> > >   	}
> > >   }
> > > @@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
> > >   		 * writeable reference is too fragile given the way @mode is
> > >   		 * used in blkdev_get/put().
> > >   		 */
> > > -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
> > > +		if ((mode & BLK_OPEN_WRITE) &&
> > > +		    !test_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags) &&
> > >   		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
> > > -			bdev->bd_write_holder = true;
> > > +			set_bit(BD_FLAG_WRITE_HOLDER, &bdev->flags);
> > >   			unblock_events = false;
> > >   		}
> > >   	}
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index fdf25b8d6e78..577a693165d8 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
> > >   bool should_fail_request(struct block_device *part, unsigned int bytes)
> > >   {
> > > -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
> > > +	return test_bit(BD_FLAG_MAKE_IT_FAIL, &part->flags) &&
> > > +		should_fail(&fail_make_request, bytes);
> > >   }
> > >   static int __init fail_make_request_debugfs(void)
> > > @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
> > >   	if (unlikely(!blk_crypto_bio_prep(&bio)))
> > >   		return;
> > > -	if (!bio->bi_bdev->bd_has_submit_bio) {
> > > +	if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags)) {
> > >   		blk_mq_submit_bio(bio);
> > >   	} else if (likely(bio_queue_enter(bio) == 0)) {
> > >   		struct gendisk *disk = bio->bi_bdev->bd_disk;
> > > @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
> > >   	 */
> > >   	if (current->bio_list)
> > >   		bio_list_add(&current->bio_list[0], bio);
> > > -	else if (!bio->bi_bdev->bd_has_submit_bio)
> > > +	else if (!test_bit(BD_FLAG_HAS_SUBMIT_BIO, &bio->bi_bdev->flags))
> > >   		__submit_bio_noacct_mq(bio);
> > >   	else
> > >   		__submit_bio_noacct(bio);
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index c9d06f72c587..026f4c6d5b7e 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
> > >   	elevator_init_mq(disk->queue);
> > >   	/* Mark bdev as having a submit_bio, if needed */
> > > -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
> > > +	if (disk->fops->submit_bio)
> > > +		set_bit(BD_FLAG_HAS_SUBMIT_BIO, &disk->part0->flags);
> > >   	/*
> > >   	 * If the driver provides an explicit major number it also must provide
> > > @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
> > >   ssize_t part_fail_show(struct device *dev,
> > >   		       struct device_attribute *attr, char *buf)
> > >   {
> > > -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
> > > +	return sprintf(buf, "%d\n",
> > > +		       test_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags));
> > >   }
> > >   ssize_t part_fail_store(struct device *dev,
> > > @@ -1072,7 +1074,7 @@ ssize_t part_fail_store(struct device *dev,
> > >   	int i;
> > >   	if (count > 0 && sscanf(buf, "%d", &i) > 0)
> > > -		dev_to_bdev(dev)->bd_make_it_fail = i;
> > > +		set_bit(BD_FLAG_MAKE_IT_FAIL, &dev_to_bdev(dev)->flags);
> > >   	return count;
> > >   }
> > > diff --git a/block/ioctl.c b/block/ioctl.c
> > > index 4160f4e6bd5b..a548c718a5fb 100644
> > > --- a/block/ioctl.c
> > > +++ b/block/ioctl.c
> > > @@ -394,7 +394,7 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
> > >   		if (ret)
> > >   			return ret;
> > >   	}
> > > -	bdev->bd_read_only = n;
> > > +	set_bit(BD_FLAG_READ_ONLY, &bdev->flags);
> > >   	return 0;
> > >   }
> > > diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> > > index 52e264d5a830..95bd26c62655 100644
> > > --- a/include/linux/blk_types.h
> > > +++ b/include/linux/blk_types.h
> > > @@ -37,17 +37,20 @@ struct bio_crypt_ctx;
> > >   #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
> > >   #define SECTOR_MASK		(PAGE_SECTORS - 1)
> > > +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
> > > +#define BD_FLAG_WRITE_HOLDER	1
> > > +#define BD_FLAG_HAS_SUBMIT_BIO	2
> > > +#define BD_FLAG_MAKE_IT_FAIL	3
> > > +
> > >   struct block_device {
> > >   	sector_t		bd_start_sect;
> > >   	sector_t		bd_nr_sectors;
> > >   	struct gendisk *	bd_disk;
> > >   	struct request_queue *	bd_queue;
> > >   	struct disk_stats __percpu *bd_stats;
> > > +	unsigned long		flags;
> > >   	unsigned long		bd_stamp;
> > > -	bool			bd_read_only;	/* read-only policy */
> > >   	u8			bd_partno;
> > > -	bool			bd_write_holder;
> > > -	bool			bd_has_submit_bio;
> > 
> > The idea looks good, but not necessary to add new 8 bytes, and you may
> > put all these flags and `bd_partno` into single 'unsigned long', and add
> > helpers to retrieve part no, since there are not many ->bd_partno
> > references.
> 
> Yes, it make sense.
> 
> By the way, take a look at component of block_device, I think they can
> be reorganized to save some space, in this case, new 8 bytes won't make
> this struct bigger, in fact, total size will be shrinked by 8 types
> after following changes:
> 
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 95bd26c62655..c94242a9ad92 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -50,7 +50,6 @@ struct block_device {
>         struct disk_stats __percpu *bd_stats;
>         unsigned long           flags;
>         unsigned long           bd_stamp;
> -       u8                      bd_partno;
>         dev_t                   bd_dev;
>         atomic_t                bd_openers;
>         spinlock_t              bd_size_lock; /* for bd_inode->i_size
> updates */
> @@ -60,13 +59,14 @@ struct block_device {
>         const struct blk_holder_ops *bd_holder_ops;
>         struct mutex            bd_holder_lock;
>         int                     bd_holders;
> +       u8                      bd_partno;

'bd_partno' needs to be kept in the 1st cacheline, so not good to move
it.


Thanks,
Ming


