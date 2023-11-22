Return-Path: <linux-block+bounces-372-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394A37F3E97
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 08:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697621C20B09
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 07:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196A3125D7;
	Wed, 22 Nov 2023 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C261AA;
	Tue, 21 Nov 2023 23:06:28 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SZsjS6J3Yz4f3n5j;
	Wed, 22 Nov 2023 15:06:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 21F791A0407;
	Wed, 22 Nov 2023 15:06:25 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP1 (Coremail) with SMTP id cCh0CgBXWhBvqF1lEnxtBg--.47979S3;
	Wed, 22 Nov 2023 15:06:24 +0800 (CST)
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
To: Michael Kelley <mhklinux@outlook.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
 "yangerkun@huawei.com" <yangerkun@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <SN6PR02MB41574D8169D62EBFAE90427CD4BAA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <09210f85-8a34-1ae8-59ec-55fefe7ba81a@huaweicloud.com>
Date: Wed, 22 Nov 2023 15:06:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <SN6PR02MB41574D8169D62EBFAE90427CD4BAA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXWhBvqF1lEnxtBg--.47979S3
X-Coremail-Antispam: 1UD129KBjvJXoW3GryDWFyUJr1DtrW7Ar1DKFg_yoWDGr4UpF
	WkJFWYk3yUGr1fWa1Iqa13J3ZYgw40yr18C3y3C342yrZ0yr1vgF1kGryj9as3urW8CFW7
	ZF1UuFW3Cryj9a7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
	DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

�� 2023/11/22 11:52, Michael Kelley д��:
> From: Yu Kuai <yukuai1@huaweicloud.com> Sent: Wednesday, November 22, 2023 2:31 AM
>>
>> There are multiple switches in struct block_device, use separate bool
>> fields for them is not gracefully. Add a new field bd_flags and replace
>> swithes to a bit, there are no functional changes, and prepare to add
>> a new switch in the next patch. In order to keep bd_flags in the first
>> cacheline and prevent layout to be affected, define it as u16.
>>
>> Also add new helpers to set/clear/test each bit like 'bio->bi_flags'.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   block/bdev.c              | 15 ++++++++-------
>>   block/blk-core.c          |  7 ++++---
>>   block/genhd.c             | 15 +++++++++++----
>>   block/ioctl.c             |  6 +++++-
>>   include/linux/blk_types.h | 27 +++++++++++++++++++++------
>>   include/linux/blkdev.h    |  5 +++--
>>   6 files changed, 52 insertions(+), 23 deletions(-)
>>
>> diff --git a/block/bdev.c b/block/bdev.c
>> index e4cfb7adb645..10f524a7416c 100644
>> --- a/block/bdev.c
>> +++ b/block/bdev.c
>> @@ -402,10 +402,10 @@ struct block_device *bdev_alloc(struct gendisk
>> *disk, u8 partno)
>>   	bdev->bd_partno = partno;
>>   	bdev->bd_inode = inode;
>>   	bdev->bd_queue = disk->queue;
>> -	if (partno)
>> -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
>> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
>> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>>   	else
>> -		bdev->bd_has_submit_bio = false;
>> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>>   	bdev->bd_stats = alloc_percpu(struct disk_stats);
>>   	if (!bdev->bd_stats) {
>>   		iput(inode);
>> @@ -606,7 +606,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   		bdev->bd_holder = NULL;
>>   		bdev->bd_holder_ops = NULL;
>>   		mutex_unlock(&bdev->bd_holder_lock);
>> -		if (bdev->bd_write_holder)
>> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>>   			unblock = true;
>>   	}
>>   	if (!whole->bd_holders)
>> @@ -619,7 +619,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>>   	 */
>>   	if (unblock) {
>>   		disk_unblock_events(bdev->bd_disk);
>> -		bdev->bd_write_holder = false;
>> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>>   	}
>>   }
>>
>> @@ -805,9 +805,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev,
>> blk_mode_t mode, void *holder,
>>   		 * writeable reference is too fragile given the way @mode is
>>   		 * used in blkdev_get/put().
>>   		 */
>> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
>> +		if ((mode & BLK_OPEN_WRITE) &&
>> +		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
>>   		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
>> -			bdev->bd_write_holder = true;
>> +			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
>>   			unblock_events = false;
>>   		}
>>   	}
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index fdf25b8d6e78..f9f8b12ba626 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -482,7 +482,8 @@ __setup("fail_make_request=",
>> setup_fail_make_request);
>>
>>   bool should_fail_request(struct block_device *part, unsigned int bytes)
>>   {
>> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
>> +	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
>> +		should_fail(&fail_make_request, bytes);
>>   }
>>
>>   static int __init fail_make_request_debugfs(void)
>> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>>   	if (unlikely(!blk_crypto_bio_prep(&bio)))
>>   		return;
>>
>> -	if (!bio->bi_bdev->bd_has_submit_bio) {
>> +	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
>>   		blk_mq_submit_bio(bio);
>>   	} else if (likely(bio_queue_enter(bio) == 0)) {
>>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
>> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>>   	 */
>>   	if (current->bio_list)
>>   		bio_list_add(&current->bio_list[0], bio);
>> -	else if (!bio->bi_bdev->bd_has_submit_bio)
>> +	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
>>   		__submit_bio_noacct_mq(bio);
>>   	else
>>   		__submit_bio_noacct(bio);
>> diff --git a/block/genhd.c b/block/genhd.c
>> index c9d06f72c587..57f96c0c8da0 100644
>> --- a/block/genhd.c
>> +++ b/block/genhd.c
>> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device
>> *parent, struct gendisk *disk,
>>   	elevator_init_mq(disk->queue);
>>
>>   	/* Mark bdev as having a submit_bio, if needed */
>> -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
>> +	if (disk->fops->submit_bio)
>> +		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
>>
>>   	/*
>>   	 * If the driver provides an explicit major number it also must provide
>> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
>>   ssize_t part_fail_show(struct device *dev,
>>   		       struct device_attribute *attr, char *buf)
>>   {
>> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
>> +	return sprintf(buf, "%d\n",
>> +		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
>>   }
>>
>>   ssize_t part_fail_store(struct device *dev,
>> @@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
>>   {
>>   	int i;
>>
>> -	if (count > 0 && sscanf(buf, "%d", &i) > 0)
>> -		dev_to_bdev(dev)->bd_make_it_fail = i;
>> +	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
>> +		if (!i)
>> +			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
>> +		else
>> +			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
>> +
>> +	}
>>
>>   	return count;
>>   }
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index 4160f4e6bd5b..a64440f4c96b 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
>>   		if (ret)
>>   			return ret;
>>   	}
>> -	bdev->bd_read_only = n;
>> +
>> +	if (!n)
>> +		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
>> +	else
>> +		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
>>   	return 0;
>>   }
>>
>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>> index f7d40692dd94..de652045111b 100644
>> --- a/include/linux/blk_types.h
>> +++ b/include/linux/blk_types.h
>> @@ -37,6 +37,11 @@ struct bio_crypt_ctx;
>>   #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
>>   #define SECTOR_MASK		(PAGE_SECTORS - 1)
>>
>> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
>> +#define BD_FLAG_WRITE_HOLDER	1
>> +#define BD_FLAG_HAS_SUBMIT_BIO	2
>> +#define BD_FLAG_MAKE_IT_FAIL	3
>> +
>>   struct block_device {
>>   	sector_t		bd_start_sect;
>>   	sector_t		bd_nr_sectors;
>> @@ -44,10 +49,8 @@ struct block_device {
>>   	struct request_queue *	bd_queue;
>>   	struct disk_stats __percpu *bd_stats;
>>   	unsigned long		bd_stamp;
>> -	bool			bd_read_only;	/* read-only policy */
>> +	unsigned short		bd_flags;
>>   	u8			bd_partno;
>> -	bool			bd_write_holder;
>> -	bool			bd_has_submit_bio;
>>   	dev_t			bd_dev;
>>   	struct inode		*bd_inode;	/* will die */
>>
>> @@ -67,9 +70,6 @@ struct block_device {
>>   	struct super_block	*bd_fsfreeze_sb;
>>
>>   	struct partition_meta_info *bd_meta_info;
>> -#ifdef CONFIG_FAIL_MAKE_REQUEST
>> -	bool			bd_make_it_fail;
>> -#endif
>>   	/*
>>   	 * keep this out-of-line as it's both big and not needed in the fast
>>   	 * path
>> @@ -86,6 +86,21 @@ struct block_device {
>>   #define bdev_kobj(_bdev) \
>>   	(&((_bdev)->bd_device.kobj))
>>
>> +static inline bool bdev_flagged(struct block_device *bdev, unsigned int bit)
>> +{
>> +	return bdev->bd_flags & (1U << bit);
>> +}
>> +
>> +static inline void bdev_set_flag(struct block_device *bdev, unsigned int bit)
>> +{
>> +	bdev->bd_flags |= (1U << bit);
>> +}
>> +
>> +static inline void bdev_clear_flag(struct block_device *bdev, unsigned int bit)
>> +{
>> +	bdev->bd_flags &= ~(1U << bit);
>> +}
> 
> It seems like there's atomicity problem with this approach.  In the above
> code, setting and clearing a bd_flag is *not* atomic with respect to
> setting/clearing some other bd_flag.  For example, setting/clearing
> BD_FLAG_MAKE_IT_FAIL via the /sys interface could race with
> setting/clearing BD_FLAG_READ_ONLY via an ioctl, and one of the
> two changes could be lost.  This problem wouldn't happen when
> each flag was a separate field.  Admittedly, the likelihood of a
> problem with BD_FLAG_MAKE_IT_FAIL is extremely low, but
> conceptually the lack of atomicity is still wrong.  There might
> be a similar problem with BD_FLAG_WRITE_HOLDER, but I
> didn't investigate thoroughly.

Thanks for the explanation, however, currently bio->bi_opf,
bio->bi_flags and req->rq_flags, and I can't understand now how do they
prevent to change bit concurrently? I'm probably missing something...

Thanks,
Kuai

> 
> Michael
> 
>> +
>>   /*
>>    * Block error status values.  See block/blk-core:blk_errors for the details.
>>    * Alpha cannot write a byte atomically, so we need to use 32-bit value.
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 51fa7ffdee83..fc1d55ef5107 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -741,13 +741,14 @@ void disk_uevent(struct gendisk *disk, enum
>> kobject_action action);
>>
>>   static inline int get_disk_ro(struct gendisk *disk)
>>   {
>> -	return disk->part0->bd_read_only ||
>> +	return bdev_flagged(disk->part0, BD_FLAG_READ_ONLY) ||
>>   		test_bit(GD_READ_ONLY, &disk->state);
>>   }
>>
>>   static inline int bdev_read_only(struct block_device *bdev)
>>   {
>> -	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
>> +	return bdev_flagged(bdev, BD_FLAG_READ_ONLY) ||
>> +		get_disk_ro(bdev->bd_disk);
>>   }
>>
>>   bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
>> --
>> 2.39.2
> 
> .
> 


