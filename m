Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393A0566175
	for <lists+linux-block@lfdr.de>; Tue,  5 Jul 2022 04:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiGECu4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Jul 2022 22:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiGECux (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 22:50:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C1612AB5
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989452; x=1688525452;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YV32qaUBwpXJwemzo0Wv/JfDuW5/GwMliI6E3LKQ3DY=;
  b=iDXrHLNMybtbPVmAnOQ2JEuQNA+6rzNuJAy7CV2kbzb7iv6NqficISzE
   ScUcrdzj39168Z961o41y05tpLmtBuHOjzdD7XsuF594txt5eqeMqY/FT
   j6AlU/0RTjCrMA2L7nPGojGtR9ARuIsoS3Q1Tpde/0ZXkQjWiRZE4UL3c
   ClbdNUT07Ov13DKD7jmhxwGKgxIkE4uZlnzcyGhuZlulhmGZhHTN3Xy1w
   jdjJhj04VSuV5SJ0cct1dRIzORsu3G8EycAo4h3G+6LioPoU8O5cQAH2J
   w2T1M3MCPqj0j3oclP+ctFZbu6RiZTwrtm/jw4dRO6fTytOK1hX8lhYGb
   g==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205520725"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:50:51 +0800
IronPort-SDR: DufmTG8WHWw1wiJ3jYucXOKvdkTiblzvLSY2RIfqR6LJXMEhOWNJDZXfY1w06s78vFYKwFXELv
 afbPChZscUcDN+EyZ5ErQkKOI9pN8DemQbGBvpha29+myFhWwAgHfD8vmiAmNLkcb6catVkI+F
 NlUq7wTEi0AxlzMKb8n58dvcCNTuHZO2itW5ti9CpTXE8gK6KG0Xs6qvYDX54h43sBMTUiIylv
 iCI0vU5c86o+fcAiOYEMqHHWY8VzFgjEpD2BR/3GPM2ZdcUBhuy3lDxfMK30it8lNnWhG49sNY
 zQ0FUgeB22Xn3kaZgEHB01eQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:12:43 -0700
IronPort-SDR: Bfqh/EDWG2YndCqLKTsQIlpfguTlA2QX1ESW9zQHgXnR1rJP5JdB8vhsMUHbUfH3D6yAml5AH/
 jZ8h6hw+LlQJLgxVbuauWxtT80xLlNzsY5bzXZGsnf3Z8Pvc/Y4NPLrWzZm2w0znJZOnXbO5cQ
 orTpyiQjIrfgaCk3wRVpFKr7wK0Ks4cQh2u6G23/gJQHO6trdrcQd8n4pnwAjYdKWrXIkAx6UA
 PN2i6MoCc3svABR/QNYeqP+shS9Mf671pTU4ZpG3dcXCOErVsIhuHpLFrB5JfLqmNNykuTRnT5
 vrk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:50:52 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRxl3LD3z1RwqM
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 19:50:51 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1656989450; x=1659581451; bh=YV32qaUBwpXJwemzo0Wv/JfDuW5/GwMliI6
        E3LKQ3DY=; b=gNHpX7V4k18wTnKi4ifgMxVtLCAAFg7dSmeEvbQ22F4SWh7RPPS
        2Ujyd42pgkyq9cVXXHjZI9apxvurCff/o1eQyq+FtNfjib1TDTXDM6OL33wSMH/q
        OYfWMI7ThPQmoVPlT9N/o+KebdU6q8LHdEHWNQ8b0GBLS9J+Cwun0/38oLZvcr73
        xsaNUUWhghYAYoqPbpmVO+YMcwnVD8RlCgqB1RnQY8vs7gKrxRAGSHsO8U8lARt1
        nm14YV2vf64HAI4j4RwJ/8gkf2K2+4EJXAMcSskJnoL+HAfS+WgzGljGzU+/qWl5
        PCaljFNegRAx4wcb/96bfnJm9146YAIOUsg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P8Q7G1xwGH-r for <linux-block@vger.kernel.org>;
        Mon,  4 Jul 2022 19:50:50 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRxj3h60z1RtVk;
        Mon,  4 Jul 2022 19:50:49 -0700 (PDT)
Message-ID: <1c7795a3-4a18-6741-a86b-64f1eee42dbd@opensource.wdc.com>
Date:   Tue, 5 Jul 2022 11:50:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/17] block: pass a gendisk to blk_queue_max_open_zones
 and blk_queue_max_active_zones
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-13-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/4/22 21:44, Christoph Hellwig wrote:
> Switch to a gendisk based API in preparation for moving all zone related
> fields from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/zoned.c | 4 ++--
>  drivers/nvme/host/zns.c        | 4 ++--
>  drivers/scsi/sd_zbc.c          | 6 +++---
>  include/linux/blkdev.h         | 8 ++++----
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index b47bbd114058d..576ab3ed082a5 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -174,8 +174,8 @@ int null_register_zoned_dev(struct nullb *nullb)
>  	}
>  
>  	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
> -	blk_queue_max_open_zones(q, dev->zone_max_open);
> -	blk_queue_max_active_zones(q, dev->zone_max_active);
> +	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
> +	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
>  
>  	return 0;
>  }
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 0ed15c2fd56de..12316ab51bda6 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -111,8 +111,8 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
>  
>  	disk_set_zoned(ns->disk, BLK_ZONED_HM);
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> -	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
> -	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
> +	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
> +	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
>  free_data:
>  	kfree(id);
>  	return status;
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
> index 0f5823b674685..b4106f8997342 100644
> --- a/drivers/scsi/sd_zbc.c
> +++ b/drivers/scsi/sd_zbc.c
> @@ -950,10 +950,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
>  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
>  	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
>  	if (sdkp->zones_max_open == U32_MAX)
> -		blk_queue_max_open_zones(q, 0);
> +		disk_set_max_open_zones(disk, 0);
>  	else
> -		blk_queue_max_open_zones(q, sdkp->zones_max_open);
> -	blk_queue_max_active_zones(q, 0);
> +		disk_set_max_open_zones(disk, sdkp->zones_max_open);
> +	disk_set_max_active_zones(disk, 0);
>  	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
>  
>  	/*
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index a14cc3e46e6ad..e32c147f72868 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -698,16 +698,16 @@ static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>  	return !test_bit(blk_queue_zone_no(q, sector), q->conv_zones_bitmap);
>  }
>  
> -static inline void blk_queue_max_open_zones(struct request_queue *q,
> +static inline void disk_set_max_open_zones(struct gendisk *disk,
>  		unsigned int max_open_zones)
>  {
> -	q->max_open_zones = max_open_zones;
> +	disk->queue->max_open_zones = max_open_zones;
>  }
>  
> -static inline void blk_queue_max_active_zones(struct request_queue *q,
> +static inline void disk_set_max_active_zones(struct gendisk *disk,
>  		unsigned int max_active_zones)
>  {
> -	q->max_active_zones = max_active_zones;
> +	disk->queue->max_active_zones = max_active_zones;
>  }
>  
>  static inline unsigned int bdev_max_open_zones(struct block_device *bdev)


-- 
Damien Le Moal
Western Digital Research
