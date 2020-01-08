Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8F134443
	for <lists+linux-block@lfdr.de>; Wed,  8 Jan 2020 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAHNs7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jan 2020 08:48:59 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60794 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgAHNs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jan 2020 08:48:59 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008Dj5gx083617;
        Wed, 8 Jan 2020 13:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=2uTK4g4CQJicliRTlc039WqDpQsuM2LGrYpFrRugILg=;
 b=QBCoyKTf4uMX7fDyZI7KsEIIMix/aRarDtmbw0zwpy/n/0LeWA23COeX0ex5+/mIyJBN
 8wZEZT2wWyTKs78ydWRrRcTgNBzFuJ6q0OKTYaR8k2zehSDA+Vp/Qyo/w3OZR+V1zNXE
 4Yg3hXL9eNos5/IgrkKQgNTUEl/+Mmf7I1T6Z0lP/tlp8U54WKOZCGrp6+RS3G4kSRgp
 4ZVuSE8z6XZZYdR/BctJGvfkZeAt9K35hU+d2K0YNlAKJDqw2ScWl8VXc7gtP9fGYryk
 uLkcwlH5o+qDhMULVZwSpijSRJJaNcU3bNNIsrRTY2lC04iaSzTEcNfcqAqIPOgeJXlr 3w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xakbquvgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 13:48:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 008Dj1rY012369;
        Wed, 8 Jan 2020 13:46:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xcpapvptc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Jan 2020 13:46:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 008DknMD024551;
        Wed, 8 Jan 2020 13:46:50 GMT
Received: from [192.168.1.14] (/114.88.246.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Jan 2020 05:46:49 -0800
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "shirley.ma@oracle.com" <shirley.ma@oracle.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
 <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <9e7d2f84-6efa-7c44-2313-860d5e8ed067@oracle.com>
Date:   Wed, 8 Jan 2020 21:46:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001080117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9493 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001080117
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/20 3:40 PM, Damien Le Moal wrote:
> On 2020/01/08 16:13, Nobody wrote:
>> From: Bob Liu <bob.liu@oracle.com>
>>
>> Motivation:
>> Now the dm-zoned device mapper target exposes a zoned block device(ZBC) as a
>> regular block device by storing metadata and buffering random writes in
>> conventional zones.
>> This way is not very flexible, there must be enough conventional zones and the
>> performance may be constrained.
>> By putting metadata(also buffering random writes) in separated device we can get
>> more flexibility and potential performance improvement e.g by storing metadata
>> in faster device like persistent memory.
>>
>> This patch try to split the metadata of dm-zoned to an extra block
>> device instead of zoned block device itself.
>> (Buffering random writes also in the todo list.)
>>
>> Patch is at the very early stage, just want to receive some feedback about
>> this extension.
>> Another option is to create an new md-zoned device with separated metadata
>> device based on md framework.
> 
> For metadata only, it should not be hard at all to move to another
> conventional zone device. It will however be a little more tricky for
> conventional zones used for data since dm-zoned assumes that this random
> write space is also zoned. Moving this space to a conventional device
> requires implementing a zone emulation (fake zones) for the regular
> drive, using a zone size that matches the size of sequential zones.
> 

Indeed.
I'll try to implement zone emulation next version.

> Beyond this, dm-zoned also needs to be changed to accept partial drives
> and the dm core code to accept mixing of regular and zoned disks (that
> is forbidden now).
> 

Do you mean the check in device_area_is_invalid()? 

 320         /*
 321          * If the target is mapped to zoned block device(s), check
 322          * that the zones are not partially mapped.
 323          */
 324         if (bdev_zoned_model(bdev) != BLK_ZONED_NONE) {

> Another approach worth exploring is stacking dm-zoned as is on top of a
> modified dm-linear with the ability to emulate conventional zones on top
> of a regular block device (you only need report zones method
> implemented). That is much easier to do. We actually hacked something
> like that last month to see the performance change and saw a jump from
> 56 MB/s to 250 MB/s for write intensive workloads (file creation on
> ext4). I am not so warm in this approach though as it modifies dm-linear
> and we want to keep it very lean and simple. Modifying dm-zoned to allow
> support for a device pair is a better approach I think.
> 
>>
>> Signed-off-by: Bob Liu <bob.liu@oracle.com>
>> ---
>>  drivers/md/dm-zoned-metadata.c |  6 +++---
>>  drivers/md/dm-zoned-target.c   | 15 +++++++++++++--
>>  drivers/md/dm-zoned.h          |  1 +
>>  3 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
>> index 22b3cb0..89cd554 100644
>> --- a/drivers/md/dm-zoned-metadata.c
>> +++ b/drivers/md/dm-zoned-metadata.c
>> @@ -439,7 +439,7 @@ static struct dmz_mblock *dmz_get_mblock_slow(struct dmz_metadata *zmd,
>>  
>>  	/* Submit read BIO */
>>  	bio->bi_iter.bi_sector = dmz_blk2sect(block);
>> -	bio_set_dev(bio, zmd->dev->bdev);
>> +	bio_set_dev(bio, zmd->dev->meta_bdev);
>>  	bio->bi_private = mblk;
>>  	bio->bi_end_io = dmz_mblock_bio_end_io;
>>  	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META | REQ_PRIO);
>> @@ -593,7 +593,7 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
>>  	set_bit(DMZ_META_WRITING, &mblk->state);
>>  
>>  	bio->bi_iter.bi_sector = dmz_blk2sect(block);
>> -	bio_set_dev(bio, zmd->dev->bdev);
>> +	bio_set_dev(bio, zmd->dev->meta_bdev);
>>  	bio->bi_private = mblk;
>>  	bio->bi_end_io = dmz_mblock_bio_end_io;
>>  	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
>> @@ -620,7 +620,7 @@ static int dmz_rdwr_block(struct dmz_metadata *zmd, int op, sector_t block,
>>  		return -ENOMEM;
>>  
>>  	bio->bi_iter.bi_sector = dmz_blk2sect(block);
>> -	bio_set_dev(bio, zmd->dev->bdev);
>> +	bio_set_dev(bio, zmd->dev->meta_bdev);
>>  	bio_set_op_attrs(bio, op, REQ_SYNC | REQ_META | REQ_PRIO);
>>  	bio_add_page(bio, page, DMZ_BLOCK_SIZE, 0);
>>  	ret = submit_bio_wait(bio);
>> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
>> index 70a1063..55c64fe 100644
>> --- a/drivers/md/dm-zoned-target.c
>> +++ b/drivers/md/dm-zoned-target.c
>> @@ -39,6 +39,7 @@ struct dm_chunk_work {
>>   */
>>  struct dmz_target {
>>  	struct dm_dev		*ddev;
>> +	struct dm_dev           *metadata_dev;
> 
> This naming would be confusing as it implies metadata only. If you also
> want to move the random write zones to a regular device, then I would
> suggest names like:
> 
> ddev -> zoned_bdev (the zoned device, e.g. SMR disk)
> metadata_dev -> reg_bdev (regular block device, e.g. an SSD)
> 

Will update.

> The metadata+random write (fake) zones space can use the regular block
> device, and all sequential zones are assumed to be on the zoned device.
> Care must be taken to handle the case of a zoned device that has
> conventional zones: these could be used as is, not needing any reclaim,

Agree, that won't make things too complicate.
Thank you for all the suggestions.

Regards,
Bob

> so potentially contributing to further optimization.
> 
>>  
>>  	unsigned long		flags;
>>  
>> @@ -701,6 +702,7 @@ static int dmz_get_zoned_device(struct dm_target *ti, char *path)
>>  		goto err;
>>  	}
>>  
>> +	dev->meta_bdev = dmz->metadata_dev->bdev;
>>  	dev->bdev = dmz->ddev->bdev;
>>  	(void)bdevname(dev->bdev, dev->name);
>>  
>> @@ -761,7 +763,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  	int ret;
>>  
>>  	/* Check arguments */
>> -	if (argc != 1) {
>> +	if (argc != 2) {
>>  		ti->error = "Invalid argument count";
>>  		return -EINVAL;
>>  	}
>> @@ -774,8 +776,16 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  	}
>>  	ti->private = dmz;
>>  
>> +	/* Get the metadata block device */
>> +	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
>> +			&dmz->metadata_dev);
>> +	if (ret) {
>> +		dmz->metadata_dev = NULL;
>> +		goto err;
>> +	}
>> +
>>  	/* Get the target zoned block device */
>> -	ret = dmz_get_zoned_device(ti, argv[0]);
>> +	ret = dmz_get_zoned_device(ti, argv[1]);
>>  	if (ret) {
>>  		dmz->ddev = NULL;
>>  		goto err;
>> @@ -856,6 +866,7 @@ static int dmz_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>>  err_dev:
>>  	dmz_put_zoned_device(ti);
>>  err:
>> +	dm_put_device(ti, dmz->metadata_dev);
>>  	kfree(dmz);
>>  
>>  	return ret;
>> diff --git a/drivers/md/dm-zoned.h b/drivers/md/dm-zoned.h
>> index 5b5e493..e789ff5 100644
>> --- a/drivers/md/dm-zoned.h
>> +++ b/drivers/md/dm-zoned.h
>> @@ -50,6 +50,7 @@
>>   */
>>  struct dmz_dev {
>>  	struct block_device	*bdev;
>> +	struct block_device     *meta_bdev;
>>  
>>  	char			name[BDEVNAME_SIZE];
>>  
>>

