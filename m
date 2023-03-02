Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4266A7CBE
	for <lists+linux-block@lfdr.de>; Thu,  2 Mar 2023 09:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCBIde (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Mar 2023 03:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCBIdb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 03:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74938656
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 00:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677745962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pa46/tf59jw++qihe2yOHoYOhP7Ie6wHeVDILetA9S4=;
        b=Mc/hMh6QDTDIx2pRm95hjgGXx7Il30yDPhoBOCZcZI20uU/sQaAIzkXVVRVov2CvW0b4OH
        jXS+pDVE1tdVUNHr4YWzW8aWja5LF+bcKSFpb0IOrs9VWAFmtTS3fBfmtMjXA8k3AK0KOA
        o7fFwGyI3inghNz1MMwiHjQ8akd5Faw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-N5-0bu9XMYWRHYRCL2fFqA-1; Thu, 02 Mar 2023 03:32:38 -0500
X-MC-Unique: N5-0bu9XMYWRHYRCL2fFqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2597F18E5381;
        Thu,  2 Mar 2023 08:32:38 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 684F71121319;
        Thu,  2 Mar 2023 08:32:27 +0000 (UTC)
Date:   Thu, 2 Mar 2023 16:32:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        kernel test robot <lkp@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH v2] block: ublk: enable zoned storage support
Message-ID: <ZABfFW+28Jlxq+Ew@T590>
References: <20230224200502.391570-1-nmi@metaspace.dk>
 <ZAAPBFfqP671N4ue@T590>
 <87o7pblhi1.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7pblhi1.fsf@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 02, 2023 at 08:31:07AM +0100, Andreas Hindborg wrote:
> 
> Hi Ming,
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > On Fri, Feb 24, 2023 at 09:05:01PM +0100, Andreas Hindborg wrote:
> >> Add zoned storage support to ublk: report_zones and operations:
> >>  - REQ_OP_ZONE_OPEN
> >>  - REQ_OP_ZONE_CLOSE
> >>  - REQ_OP_ZONE_FINISH
> >>  - REQ_OP_ZONE_RESET
> >> 
> >> This allows implementation of zoned storage devices in user space. An
> >> example user space implementation based on ubdsrv is available [1].
> >> 
> >> [1] https://github.com/metaspace/ubdsrv/commit/14a2b708f74f70cfecb076d92e680dc718cc1f6d
> >
> > As I suggested, please write one simple & clean zoned target for verifying
> > the interface, and better to not add to tgt_null.c.
> 
> For ubdsrv, I understand that you prefer to reimplement null and loop targets for
> zoned storage. I don't understand why you think this is a good idea,
> since we will have massive code duplication. This would be comparable to
> having a separate null_blk driver for zoned storage. Am I understanding
> you correctly?

It is userspace, code duplication isn't a big deal, but putting lots
of un-related things together is just one mess.

> 
> Anyway, I think we can discuss the kernel patch even though the ubdsrv
> implementation is not a separate target yet? The code would be almost
> identical, it would just live in a separate translation unit.

I just suggest to make the userspace test code clean & easy, which plays
big role for looking kernel interface from user side.

> 
> >
> >> 
> >> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> >> ---
> >> Changes since v1:
> >>  - Fixed conditional compilation bug
> >>  - Refactored to collect conditional code additions together
> >>  - Fixed style errors
> >>  - Zero stack allocated value used for zone report
> >> 
> >> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Link: https://lore.kernel.org/oe-kbuild-all/202302250222.XOrw9j6z-lkp@intel.com/
> >> v1: https://lore.kernel.org/linux-block/20230224125950.214779-1-nmi@metaspace.dk/
> >> 
> >>  drivers/block/ublk_drv.c      | 150 ++++++++++++++++++++++++++++++++--
> >>  include/uapi/linux/ublk_cmd.h |  18 ++++
> >>  2 files changed, 162 insertions(+), 6 deletions(-)
> >> 
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 6368b56eacf1..37e516903867 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -20,6 +20,7 @@
> >>  #include <linux/major.h>
> >>  #include <linux/wait.h>
> >>  #include <linux/blkdev.h>
> >> +#include <linux/blkzoned.h>
> >>  #include <linux/init.h>
> >>  #include <linux/swap.h>
> >>  #include <linux/slab.h>
> >> @@ -51,10 +52,12 @@
> >>  		| UBLK_F_URING_CMD_COMP_IN_TASK \
> >>  		| UBLK_F_NEED_GET_DATA \
> >>  		| UBLK_F_USER_RECOVERY \
> >> -		| UBLK_F_USER_RECOVERY_REISSUE)
> >> +		| UBLK_F_USER_RECOVERY_REISSUE \
> >> +		| UBLK_F_ZONED)
> >>  
> >>  /* All UBLK_PARAM_TYPE_* should be included here */
> >> -#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD)
> >> +#define UBLK_PARAM_TYPE_ALL (UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD \
> >> +			     | UBLK_PARAM_TYPE_ZONED)
> >>  
> >>  struct ublk_rq_data {
> >>  	struct llist_node node;
> >> @@ -187,6 +190,98 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
> >>  
> >>  static struct miscdevice ublk_misc;
> >>  
> >> +#ifdef CONFIG_BLK_DEV_ZONED
> >> +static void ublk_set_nr_zones(struct ublk_device *ub)
> >> +{
> >> +	const struct ublk_param_basic *p = &ub->params.basic;
> >> +
> >> +	if (ub->dev_info.flags & UBLK_F_ZONED && p->chunk_sectors)
> >> +		ub->ub_disk->nr_zones = p->dev_sectors / p->chunk_sectors;
> >> +}
> >> +
> >> +static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
> >> +{
> >> +	const struct ublk_param_zoned *p = &ub->params.zoned;
> >> +
> >> +	if (ub->dev_info.flags & UBLK_F_ZONED) {
> >> +		disk_set_max_active_zones(ub->ub_disk, p->max_active_zones);
> >> +		disk_set_max_open_zones(ub->ub_disk, p->max_open_zones);
> >> +	}
> >> +}
> >> +
> >> +static int ublk_revalidate_disk_zones(struct gendisk *disk)
> >> +{
> >> +	return blk_revalidate_disk_zones(disk, NULL);
> >> +}
> >> +
> >> +static int ublk_report_zones(struct gendisk *disk, sector_t sector,
> >> +			     unsigned int nr_zones, report_zones_cb cb,
> >> +			     void *data)
> >> +{
> >> +	struct ublk_device *ub;
> >> +	unsigned int zone_size;
> >> +	unsigned int first_zone;
> >> +	int ret = 0;
> >> +
> >> +	ub = disk->private_data;
> >> +
> >> +	if (!(ub->dev_info.flags & UBLK_F_ZONED))
> >> +		return -EINVAL;
> >> +
> >> +	zone_size = disk->queue->limits.chunk_sectors;
> >> +	first_zone = sector >> ilog2(zone_size);
> >> +	nr_zones = min(ub->ub_disk->nr_zones - first_zone, nr_zones);
> >> +
> >> +	for (unsigned int i = 0; i < nr_zones; i++) {
> >
> > The local variable 'i' needs to be declared in the front part
> > of this function body.
> 
> Ok.
> 
> >
> >> +		struct request *req;
> >> +		blk_status_t status;
> >> +		struct blk_zone info = {0};
> >> +
> >> +		req = blk_mq_alloc_request(disk->queue, REQ_OP_DRV_IN, 0);
> >> +
> >> +		if (IS_ERR(req)) {
> >> +			ret = PTR_ERR(req);
> >> +			goto out;
> >> +		}
> >> +
> >> +		req->__sector = sector;
> >
> > Why is req->__sector set?
> 
> I use it to carry information about the first zone of the report request.

No, please do not use __sector in this way, which is supposed to be used by
driver for ZNS/ZONE_APPEND only.

> 
> >
> >> +
> >> +		ret = blk_rq_map_kern(disk->queue, req, &info, sizeof(info),
> >> +				      GFP_KERNEL);
> >> +
> >> +		if (ret)
> >> +			goto out;
> >> +
> >> +		status = blk_execute_rq(req, 0);
> >> +		ret = blk_status_to_errno(status);
> >> +		if (ret)
> >> +			goto out;
> >> +
> >> +		blk_mq_free_request(req);
> >> +
> >> +		ret = cb(&info, i, data);
> >> +		if (ret)
> >> +			goto out;
> >> +
> >> +		/* A zero length zone means don't ask for more zones */
> >> +		if (!info.len) {
> >> +			nr_zones = i;
> >> +			break;
> >> +		}
> >> +
> >> +		sector += zone_size;
> >> +	}
> >
> > I'd suggest to report as many as possible zones in one command, and
> > the dev_info.max_io_buf_bytes is the max allowed buffer size for one
> > command, please refer to nvme_ns_report_zones().
> 
> I agree about fetching more zones. However, it is no good to fetch up to
> a max, since the requested zone report may less than max. I was

Short read should always be supported, so the interface may need to 
return how many zones in single command, please refer to nvme_ns_report_zones().

> considering overloading req->__data_len and iod->nr_sectors to convey
> the number of requested zones. What do you think about that?

Any field pre-suffixed with "__" in 'struct request' should be only for
block layer, but __sector is one exception and its scenario is obvious.

So please do not misuse req->__data_len, but using iod is fine.

> 
> >
> > Also we are going to extend ublk in the multiple LUN/NS style, and I
> > guess that won't be one issue since ->report_zones() is always done on
> > disk level, right?
> 
> Yes, that should be fine.
> 
> >
> >> +	ret = nr_zones;
> >> +
> >> + out:
> >> +	return ret;
> >> +}
> >> +#else
> >> +void ublk_set_nr_zones(struct ublk_device *ub);
> >> +void ublk_dev_param_zoned_apply(struct ublk_device *ub);
> >> +int ublk_revalidate_disk_zones(struct gendisk *disk);
> >> +#endif
> >> +
> >>  static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> >>  {
> >>  	struct request_queue *q = ub->ub_disk->queue;
> >> @@ -212,6 +307,9 @@ static void ublk_dev_param_basic_apply(struct ublk_device *ub)
> >>  		set_disk_ro(ub->ub_disk, true);
> >>  
> >>  	set_capacity(ub->ub_disk, p->dev_sectors);
> >> +
> >> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> >> +		ublk_set_nr_zones(ub);
> >>  }
> >>  
> >>  static void ublk_dev_param_discard_apply(struct ublk_device *ub)
> >> @@ -268,6 +366,9 @@ static int ublk_apply_params(struct ublk_device *ub)
> >>  	if (ub->params.types & UBLK_PARAM_TYPE_DISCARD)
> >>  		ublk_dev_param_discard_apply(ub);
> >>  
> >> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && (ub->params.types & UBLK_PARAM_TYPE_ZONED))
> >> +		ublk_dev_param_zoned_apply(ub);
> >> +
> >>  	return 0;
> >>  }
> >>  
> >> @@ -361,9 +462,13 @@ static void ublk_free_disk(struct gendisk *disk)
> >>  	put_device(&ub->cdev_dev);
> >>  }
> >>  
> >> +
> >>  static const struct block_device_operations ub_fops = {
> >> -	.owner =	THIS_MODULE,
> >> -	.free_disk =	ublk_free_disk,
> >> +	.owner = THIS_MODULE,
> >> +	.free_disk = ublk_free_disk,
> >> +#ifdef CONFIG_BLK_DEV_ZONED
> >> +	.report_zones = ublk_report_zones,
> >> +#endif
> >
> > Define one null ublk_report_zones in #else branch of the above #ifdef, then we
> > can save one #ifdef.
> 
> I would have to define it as a null pointer in the #else case then?

#define ublk_report_zones       NULL

> 
> >
> >>  };
> >>  
> >>  #define UBLK_MAX_PIN_PAGES	32
> >> @@ -499,7 +604,7 @@ static int ublk_unmap_io(const struct ublk_queue *ubq,
> >>  {
> >>  	const unsigned int rq_bytes = blk_rq_bytes(req);
> >>  
> >> -	if (req_op(req) == REQ_OP_READ && ublk_rq_has_data(req)) {
> >> +	if ((req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN) && ublk_rq_has_data(req)) {
> >>  		struct ublk_map_data data = {
> >>  			.ubq	=	ubq,
> >>  			.rq	=	req,
> >> @@ -566,6 +671,26 @@ static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
> >>  	case REQ_OP_WRITE_ZEROES:
> >>  		ublk_op = UBLK_IO_OP_WRITE_ZEROES;
> >>  		break;
> >> +#ifdef CONFIG_BLK_DEV_ZONED
> >> +	case REQ_OP_ZONE_OPEN:
> >> +		ublk_op = UBLK_IO_OP_ZONE_OPEN;
> >> +		break;
> >> +	case REQ_OP_ZONE_CLOSE:
> >> +		ublk_op = UBLK_IO_OP_ZONE_CLOSE;
> >> +		break;
> >> +	case REQ_OP_ZONE_FINISH:
> >> +		ublk_op = UBLK_IO_OP_ZONE_FINISH;
> >> +		break;
> >> +	case REQ_OP_ZONE_RESET:
> >> +		ublk_op = UBLK_IO_OP_ZONE_RESET;
> >> +		break;
> >> +	case REQ_OP_DRV_IN:
> >> +		ublk_op = UBLK_IO_OP_DRV_IN;
> >> +		break;
> >> +	case REQ_OP_ZONE_APPEND:
> >> +		/* We do not support zone append yet */
> >> +		fallthrough;
> >> +#endif
> >
> > The above '#ifdef' is needn't, since  OP_ZONE should be defined no
> > matter if CONFIG_BLK_DEV_ZONED is enabled or not.
> 
> I see. But do we want to process the requests if BLK_DEV_ZONED is not
> enabled, or do we want to fail the IO?

Here we should trust block core code.

> 
> >
> >>  	default:
> >>  		return BLK_STS_IOERR;
> >>  	}
> >> @@ -612,7 +737,8 @@ static void ublk_complete_rq(struct request *req)
> >>  	 *
> >>  	 * Both the two needn't unmap.
> >>  	 */
> >> -	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE) {
> >> +	if (req_op(req) != REQ_OP_READ && req_op(req) != REQ_OP_WRITE &&
> >> +	    req_op(req) != REQ_OP_DRV_IN) {
> >>  		blk_mq_end_request(req, BLK_STS_OK);
> >>  		return;
> >>  	}
> >> @@ -1535,6 +1661,15 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
> >>  	if (ret)
> >>  		goto out_put_disk;
> >>  
> >> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> >> +	    ub->dev_info.flags & UBLK_F_ZONED) {
> >> +		disk_set_zoned(disk, BLK_ZONED_HM);
> >> +		blk_queue_required_elevator_features(disk->queue, ELEVATOR_F_ZBD_SEQ_WRITE);
> >> +		ret = ublk_revalidate_disk_zones(disk);
> >> +		if (ret)
> >> +			goto out_put_disk;
> >> +	}
> >> +
> >>  	get_device(&ub->cdev_dev);
> >>  	ret = add_disk(disk);
> >>  	if (ret) {
> >> @@ -1673,6 +1808,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
> >>  	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
> >>  		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
> >>  
> >> +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> >> +		ub->dev_info.flags &= ~UBLK_F_ZONED;
> >> +
> >>  	/* We are not ready to support zero copy */
> >>  	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
> >>  
> >> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> >> index 8f88e3a29998..074b97821575 100644
> >> --- a/include/uapi/linux/ublk_cmd.h
> >> +++ b/include/uapi/linux/ublk_cmd.h
> >> @@ -78,6 +78,10 @@
> >>  #define UBLK_F_USER_RECOVERY	(1UL << 3)
> >>  
> >>  #define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
> >> +/*
> >> + * Enable zoned device support
> >> + */
> >> +#define UBLK_F_ZONED (1ULL << 5)
> >>  
> >>  /* device state */
> >>  #define UBLK_S_DEV_DEAD	0
> >> @@ -129,6 +133,12 @@ struct ublksrv_ctrl_dev_info {
> >>  #define		UBLK_IO_OP_DISCARD	3
> >>  #define		UBLK_IO_OP_WRITE_SAME	4
> >>  #define		UBLK_IO_OP_WRITE_ZEROES	5
> >> +#define		UBLK_IO_OP_ZONE_OPEN		10
> >> +#define		UBLK_IO_OP_ZONE_CLOSE		11
> >> +#define		UBLK_IO_OP_ZONE_FINISH		12
> >> +#define		UBLK_IO_OP_ZONE_APPEND		13
> >> +#define		UBLK_IO_OP_ZONE_RESET		15
> >> +#define		UBLK_IO_OP_DRV_IN		34
> >>  
> >>  #define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
> >>  #define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
> >> @@ -214,6 +224,12 @@ struct ublk_param_discard {
> >>  	__u16	reserved0;
> >>  };
> >>  
> >> +struct ublk_param_zoned {
> >> +	__u64	max_open_zones;
> >> +	__u64	max_active_zones;
> >> +	__u64	max_append_size;
> >> +};
> >
> > Is the above zoned parameter enough for future extension?
> > Does ZNS need extra parameter? Or some zoned new(important) features?
> 
> @Damien, @Hans, @Matias, what do you think?
> 
> >
> > I highly suggest to reserve some fields for extension, given
> > it is one ABI interface, which is supposed to be defined well
> > enough from the beginning.
> 
> How many bytes would you reserve?

It really depends on storage/zoned field knowledge.


Thanks,
Ming

