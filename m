Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2347744531A
	for <lists+linux-block@lfdr.de>; Thu,  4 Nov 2021 13:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKDMft (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Nov 2021 08:35:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39337 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhKDMft (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 08:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636029191; x=1667565191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LtBy39t5zEVI3x0/1E6ODBKN5DFMdG9pColeMnfbRVk=;
  b=IohX6PsfaUrLulokFDM9reV9mgPGNc/z0DFrNK8EpGlm19jNG0O83oNI
   4CeoW0IYCl6cicGMvGysGr54V5d7/vy0UhdezQFX/q7UtLQf+bcvpgNFM
   yxdupbzvwhqyxOrYUgi0/PXS8mNgnW+UVNQJwmJ/Lg+ZyFdIvTgwFxsc9
   xjhYaewWkYzDjKb+bCSEfrjsh+hEbRgGkG1H04ZA63fBPxw0Uq0dDJ/yN
   JZ3eSMig5riHLtBlP7+3Ejt7UdDjibFqSqIbWXoFDmoYYBNV7u6ND8pC2
   idtaZIe7oBQ7wt1FOuqnJ+ggzuxrDJt6sHfl9+RFHdRDVWp2WMIW6n8cx
   w==;
X-IronPort-AV: E=Sophos;i="5.87,208,1631548800"; 
   d="scan'208";a="296467232"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2021 20:33:10 +0800
IronPort-SDR: yHWzZq//Im2rMR/x6t3CDoy2ejhdak/5Y67vbhf6rDOpnvtrBEGGJZe2oYJjHfMfUSBmYd5PQc
 YZiaunz/Js47wtVfQ5nyMJVOJIEnjsmjLjgNxLNs2aKjVjdLVnMVtfAmm2zBN3hovfJ5o4Zgul
 aj5Z7MoPhJC1NMKPiINegiWIeKaOeSiTfbw40O/99D7G1FsI/lZEEVcTUBUlk5cNtjhrg+Ij1Q
 KgDVbXSgovNPbXU6PYFzUrei9ZKoAigtzkH1g6/TYEIv753bd4AHnKP20T+ILwoTMlQj9spQEH
 hziCJyL5g3J1NG0ozrlDxgkz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:08:29 -0700
IronPort-SDR: 98sA4rKw5BHZsZoUxFL1441XEKtDGQ8kEdS7wbXe2WhTJ5hsRM3DJheyXLi6XKKOrTpqEBLa1t
 CP9U1ESF5BxvehCWlEd5+7HH6aisfaKIH75AqYUKP0hHiB4qfDmcjLYcYI5j+R7/OSUXEta2Ui
 hmwcDM2l2wCGHOz0Nup6Sml5VVDRwkyXfhwAvJTREOegEsTb0GaGrnMIgL0Pt9MQBpaVVv/8Kk
 VN7anLXyn9qKd64gegO5BnvTPMi0fF9/Rhosp46bb9rg7fENWGTA+D9hIHX0D4y0MXCgIENU2o
 PPU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:33:11 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HlNMp3cnPz1RtVn
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 05:33:10 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1636029189; x=1638621190; bh=LtBy39t5zEVI3x0/1E6ODBKN5DFMdG9pCol
        eMnfbRVk=; b=gjkF0nwoBQIODC1Re40fslJPDpfiOr+OQ31j2LQjMDBi8PHndSb
        Tex0lRKDUJ8uJYuVkpU6mzGYoegjxQYSoHassMtcUml9iAG3CK5CUnLRqk0SWgqj
        TNa27IQgrf53sXJRfVafNG0IwIX16OTlBjVHlMccp7t4UWVRsKWnJ7S3m4jS3wdr
        0SaYoixwmAZOgxshe8wWzeqanW7GfZgOo+593TEZ8nAGm1sOVxbZx5fLg+CRRWTW
        o823HP5Qk+cEx4LPZzewNRffDzrSemtys5ZoINuiBBqyRa+vYhLqCVGbVsAdMXAR
        29ZZIAR7L1gBqRMynqZe1Kh2QETYL8s50iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id giK_rSIz94e8 for <linux-block@vger.kernel.org>;
        Thu,  4 Nov 2021 05:33:09 -0700 (PDT)
Received: from [10.225.54.48] (unknown [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HlNMd5TBrz1RtVl;
        Thu,  4 Nov 2021 05:33:01 -0700 (PDT)
Message-ID: <bd36ee58-8273-cd0a-295e-0c66b0142bcd@opensource.wdc.com>
Date:   Thu, 4 Nov 2021 21:33:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [RFC PATCH 2/8] scsi: add REQ_OP_VERIFY support
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, dm-devel@redhat.com
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, djwong@kernel.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com, osandov@fb.com,
        willy@infradead.org, jefflexu@linux.alibaba.com,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jlayton@kernel.org,
        idryomov@gmail.com, danil.kipnis@cloud.ionos.com,
        ebiggers@google.com, jinpu.wang@cloud.ionos.com,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104064634.4481-3-chaitanyak@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <20211104064634.4481-3-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/04 15:46, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/scsi/sd.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/sd.h |  1 +
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index a3d2d4bc4a3d..7f2c4eb98cf8 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -106,6 +106,7 @@ MODULE_ALIAS_SCSI_DEVICE(TYPE_ZBC);
>  
>  static void sd_config_discard(struct scsi_disk *, unsigned int);
>  static void sd_config_write_same(struct scsi_disk *);
> +static void sd_config_verify(struct scsi_disk *sdkp);
>  static int  sd_revalidate_disk(struct gendisk *);
>  static void sd_unlock_native_capacity(struct gendisk *disk);
>  static int  sd_probe(struct device *);
> @@ -995,6 +996,41 @@ static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
>  	return sd_setup_write_same10_cmnd(cmd, false);
>  }
>  
> +static void sd_config_verify(struct scsi_disk *sdkp)
> +{
> +	struct request_queue *q = sdkp->disk->queue;
> +
> +	/* XXX: use same pattern as sd_config_write_same(). */
> +	blk_queue_max_verify_sectors(q, UINT_MAX >> 9);

VERIFY 10, 12, 16 and 32 commands are optional and may not be implemented by a
device. So setting this unconditionally is wrong.
At the very least you must have an "if (sdkp->verify_16)" here, and call
"blk_queue_max_verify_sectors(q, 0);" if the device does not support verify.

> +}
> +
> +static blk_status_t sd_setup_verify_cmnd(struct scsi_cmnd *cmd)
> +{
> +       struct request *rq = cmd->request;
> +       struct scsi_device *sdp = cmd->device;
> +       struct scsi_disk *sdkp = scsi_disk(rq->rq_disk);
> +       u64 lba = sectors_to_logical(sdp, blk_rq_pos(rq));
> +       u32 nr_blocks = sectors_to_logical(sdp, blk_rq_sectors(rq));
> +
> +       if (!sdkp->verify_16)
> +	       return BLK_STS_NOTSUPP;

I think this should be "return BLK_STS_TARGET;"

> +
> +       cmd->cmd_len = 16;
> +       cmd->cmnd[0] = VERIFY_16;

And what if the device supports VERIFY 10 or 12 but not VERIFY 16 ?

> +       /* skip veprotect / dpo / bytchk */
> +       cmd->cmnd[1] = 0;
> +       put_unaligned_be64(lba, &cmd->cmnd[2]);
> +       put_unaligned_be32(nr_blocks, &cmd->cmnd[10]);
> +       cmd->cmnd[14] = 0;
> +       cmd->cmnd[15] = 0;
> +
> +       cmd->allowed = SD_MAX_RETRIES;
> +       cmd->sc_data_direction = DMA_NONE;
> +       cmd->transfersize = 0;
> +
> +       return BLK_STS_OK;
> +}
> +
>  static void sd_config_write_same(struct scsi_disk *sdkp)
>  {
>  	struct request_queue *q = sdkp->disk->queue;
> @@ -1345,6 +1381,8 @@ static blk_status_t sd_init_command(struct scsi_cmnd *cmd)
>  		}
>  	case REQ_OP_WRITE_ZEROES:
>  		return sd_setup_write_zeroes_cmnd(cmd);
> +	case REQ_OP_VERIFY:
> +		return sd_setup_verify_cmnd(cmd);
>  	case REQ_OP_WRITE_SAME:
>  		return sd_setup_write_same_cmnd(cmd);
>  	case REQ_OP_FLUSH:
> @@ -2029,6 +2067,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
>  	switch (req_op(req)) {
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_WRITE_ZEROES:
> +	case REQ_OP_VERIFY:
>  	case REQ_OP_WRITE_SAME:
>  	case REQ_OP_ZONE_RESET:
>  	case REQ_OP_ZONE_RESET_ALL:
> @@ -3096,6 +3135,17 @@ static void sd_read_write_same(struct scsi_disk *sdkp, unsigned char *buffer)
>  		sdkp->ws10 = 1;
>  }
>  
> +static void sd_read_verify(struct scsi_disk *sdkp, unsigned char *buffer)
> +{
> +       struct scsi_device *sdev = sdkp->device;
> +
> +       sd_printk(KERN_INFO, sdkp, "VERIFY16 check.\n");

Remove this message please.

> +       if (scsi_report_opcode(sdev, buffer, SD_BUF_SIZE, VERIFY_16) == 1) {
> +	       sd_printk(KERN_INFO, sdkp, " VERIFY16 in ON .\n");

And this one too.

> +               sdkp->verify_16 = 1;

Why not checking for VERIFY 10 and 12 if VERIFY 16 is not supported ?
Also, why don't you call "blk_queue_max_verify_sectors(q, UINT_MAX >> 9);" here
instead of adding the not so useful sd_config_verify() helper ?

> +       }
> +}
> +
>  static void sd_read_security(struct scsi_disk *sdkp, unsigned char *buffer)
>  {
>  	struct scsi_device *sdev = sdkp->device;
> @@ -3224,6 +3274,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  		sd_read_cache_type(sdkp, buffer);
>  		sd_read_app_tag_own(sdkp, buffer);
>  		sd_read_write_same(sdkp, buffer);
> +		sd_read_verify(sdkp, buffer);
>  		sd_read_security(sdkp, buffer);
>  	}
>  
> @@ -3265,6 +3316,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
>  
>  	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
>  	sd_config_write_same(sdkp);
> +	sd_config_verify(sdkp);
>  	kfree(buffer);
>  
>  	/*
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
> index b59136c4125b..94a86bf6dac4 100644
> --- a/drivers/scsi/sd.h
> +++ b/drivers/scsi/sd.h
> @@ -120,6 +120,7 @@ struct scsi_disk {
>  	unsigned	lbpvpd : 1;
>  	unsigned	ws10 : 1;
>  	unsigned	ws16 : 1;
> +	unsigned        verify_16 : 1;

See right above this line how write same supports the 10 and 16 variants. I
think you need the same here. And very likely, you also need the 32 version in
case the device has DIF/DIX (type 2 protection).

>  	unsigned	rc_basis: 2;
>  	unsigned	zoned: 2;
>  	unsigned	urswrz : 1;
> 


-- 
Damien Le Moal
Western Digital Research
