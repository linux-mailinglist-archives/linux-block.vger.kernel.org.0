Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FC566155
	for <lists+linux-block@lfdr.de>; Tue,  5 Jul 2022 04:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiGEClk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jul 2022 22:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbiGEClh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:41:37 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B21277D
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988896; x=1688524896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0WVOR2kObukyt6P4nHIcCb2g78T5NJG8PZyFdo+kN0g=;
  b=G1v4YKDNsZbPAKiLEZLtn6H77B7ZS60Vuqhqor680W5i8KsJ+jPDmh7V
   nVrDAeIX18MoiIF/dJvJ1kahXFGZVJUEdYuwsRtoHJIm1r82HCgXk0Lor
   31aRAgTxQAXix0hgdW9xjDp0MIS89UGkIXbBodlj1KtD4DC2QSWW8COEn
   WPXoHudJYlxUo4KnPe7GOtJw/hFlLR/LhvOBW6ySHVo7p439M4D1gFr7K
   E/9NHQpUG/yQ3lQmnlemJWWrwf3AFk1uCzwo67J/0aR1z9kWCN3Cp2CGg
   ieHAESu/XxTa9QgMPxZPn6KnhCYaViuRbeYUPBm7hu1BJlBldH7NKvUFH
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="316926151"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:41:35 +0800
IronPort-SDR: oTXViReOY56Zg1e0+aGeX0uq2i0queGnK+qEZrBndU41VY/jcyDVMe32u+94SWALMJKwWrgzeu
 jv5PvLHA/HHXZLfkEZiRQ3t8uCjMKv/9MeFBwka5pxXHx5DaekwQ4inF5L8ABynPXK3xU59QOB
 97gw63qQ98m2e0atHVfo88RE6x+Pn08Ret98FsQdLRr5a/9cruCPP8CJxp1Myps14SB9iQhcB6
 AvvUKiGalnEt+qaivxOWPAvw6az0GHAGCTh6GV6MOnRXHVDxQmV9OhqqCrDRmVDUOBC2TE0YI5
 GGUlppwOFV7JHz3BRZsPViA2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:58:54 -0700
IronPort-SDR: lsM62ijvAjkCj0/nBRrb/Bw5Hz0CrEKqzDzo+bZYmm66Z+QBIzFXD14+LxXAUBBkSz9N+5cIT0
 X/3WkGDLDFzEtV9igiNcuqJSJVjmmokaYmOfJWkR7FrbnPhuOcsheWNQa1GWBB+dlxPHmFLO4B
 nMvqvDpAL8VqfCTmxuA1vX6C5NcUid31iBUHUkv4dflLMW6F1hyw8uG+5qxsykhjj6iCJ1hEIK
 F5RyVZZOgMtoEO4SYCDBPOHOlX4QSMw60CCYpoUzhgDjuxgcpNFhDmAK1lM4oOCltpW539P74b
 qcc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:41:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRl265gCz1Rwnx
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:41:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656988894; x=1659580895; bh=0WVOR2kObukyt6P4nHIcCb2g78T5NJG8PZy
        Fdo+kN0g=; b=STy4PWP+fqJ9bFrVqpESifv0DtyGOFCTlPOU2gXrovSRiaYQxi+
        prnu5C3fvoWJN1pBi29Pl9Lo5adPA4GzbuhO3Oj/h6Hq5K/JCooYtm/Lwjk/nnYY
        4s0qGbD7MrmZW1VOwd01Ja+U/FgcsNG5vP1NpZFAkrxPhR1Aa8ACeYgLkNw5D3Om
        xxBJaLP9Ckxhb+OuTQQAc5e6Oc6xiD4EVAuRRpLEhTQDmE9atSHyC77gT3/jATAJ
        K30XL9ntCh1AJFqU4eosmS1zaTA81v9lI3kjzLM2upwAusYcUn8sRay7kWJWROdO
        OhVasYUTS9amm0DWqY9b4EQ8J5EndeQq5+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ITlEt8iU-f1X for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:41:34 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRl10ptgz1RtVk;
        Mon,  4 Jul 2022 19:41:32 -0700 (PDT)
Message-ID: <612f6e15-ea72-374a-9eba-d3a13a63ee00@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:41:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/17] block: pass a gendisk to blk_queue_set_zoned
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-9-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Prepare for storing the zone related field in struct gendisk instead
> of struct request_queue.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-settings.c           | 9 +++++----
>  block/partitions/core.c        | 2 +-
>  drivers/block/null_blk/zoned.c | 2 +-
>  drivers/nvme/host/zns.c        | 2 +-
>  drivers/scsi/sd.c              | 6 +++---
>  drivers/scsi/sd_zbc.c          | 2 +-
>  include/linux/blkdev.h         | 2 +-
>  7 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6ccceb421ed2f..35b7bba306a83 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -893,18 +893,19 @@ static bool disk_has_partitions(struct gendisk *disk)
>  }
>  
>  /**
> - * blk_queue_set_zoned - configure a disk queue zoned model.
> + * disk_set_zoned - configure the zoned model for a disk
>   * @disk:	the gendisk of the queue to configure
>   * @model:	the zoned model to set
>   *
> - * Set the zoned model of the request queue of @disk according to @model.
> + * Set the zoned model of @disk to @model.
> + *
>   * When @model is BLK_ZONED_HM (host managed), this should be called only
>   * if zoned block device support is enabled (CONFIG_BLK_DEV_ZONED option).
>   * If @model specifies BLK_ZONED_HA (host aware), the effective model used
>   * depends on CONFIG_BLK_DEV_ZONED settings and on the existence of partitions
>   * on the disk.
>   */
> -void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
> +void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  {
>  	struct request_queue *q = disk->queue;
>  
> @@ -948,7 +949,7 @@ void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		blk_queue_clear_zone_settings(q);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(blk_queue_set_zoned);
> +EXPORT_SYMBOL_GPL(disk_set_zoned);
>  
>  int bdev_alignment_offset(struct block_device *bdev)
>  {
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 7dc487f5b03cd..1a45b1dd64918 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -330,7 +330,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
>  	case BLK_ZONED_HA:
>  		pr_info("%s: disabling host aware zoned block device support due to partitions\n",
>  			disk->disk_name);
> -		blk_queue_set_zoned(disk, BLK_ZONED_NONE);
> +		disk_set_zoned(disk, BLK_ZONED_NONE);
>  		break;
>  	case BLK_ZONED_NONE:
>  		break;
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index 2fdd7b20c224e..b47bbd114058d 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -159,7 +159,7 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	struct nullb_device *dev = nullb->dev;
>  	struct request_queue *q = nullb->q;
>  
> -	blk_queue_set_zoned(nullb->disk, BLK_ZONED_HM);
> +	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 9f81beb4df4ef..0ed15c2fd56de 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -109,7 +109,7 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  		goto free_data;
>  	}
>  
> -	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
> +	disk_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
>  	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index cb587e488601c..eb02d939dd448 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2934,15 +2934,15 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>  
>  	if (sdkp->device->type == TYPE_ZBC) {
>  		/* Host-managed */
> -		blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HM);
> +		disk_set_zoned(sdkp->disk, BLK_ZONED_HM);
>  	} else {
>  		sdkp->zoned = zoned;
>  		if (sdkp->zoned == 1) {
>  			/* Host-aware */
> -			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_HA);
> +			disk_set_zoned(sdkp->disk, BLK_ZONED_HA);
>  		} else {
>  			/* Regular disk or drive managed disk */
> -			blk_queue_set_zoned(sdkp->disk, BLK_ZONED_NONE);
> +			disk_set_zoned(sdkp->disk, BLK_ZONED_NONE);
>  		}
>  	}
>  
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 6acc4f406eb8c..0f5823b674685 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -929,7 +929,7 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
>  		/*
>  		 * This can happen for a host aware disk with partitions.
>  		 * The block device zone model was already cleared by
> -		 * blk_queue_set_zoned(). Only free the scsi disk zone
> +		 * disk_set_zoned(). Only free the scsi disk zone
>  		 * information and exit early.
>  		 */
>  		sd_zbc_free_zone_info(sdkp);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b9baee910b825..ddf8353488fc8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -291,7 +291,7 @@ struct queue_limits {
>  typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
>  			       void *data);
>  
> -void blk_queue_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
> +void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model);
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  


-- 
Damien Le Moal
Western Digital Research
