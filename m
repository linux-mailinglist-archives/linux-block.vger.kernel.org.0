Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2960ED89
	for <lists+linux-block@lfdr.de>; Thu, 27 Oct 2022 03:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiJ0Bmt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Oct 2022 21:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiJ0Bms (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 21:42:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5C12A348
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666834967; x=1698370967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V3VNtrd2sSuIeHi0rSjd4oShumm9o/iApZNZPCXWpZo=;
  b=WxazhQ8iCMF8/JBGeL5t59XFC/ruXdIO//z10lIpAWkUz+90dxJoFBTq
   8ng/RNnRBYA+y5NOlPKeMX+OfwWYOmETgkw9U7p3xpdCYIkK6BIg+tWKK
   lburpS7iX0AhT5/K6Zz+xHMUFsaTUjuPwkPGT4Edl0YmM2i+sXtQ4k+2Y
   jihHNuD11bZY8eSTMF2VcVAt703Du2BM3x68r+q0gOjYdu47ABTcMF3n9
   kgtPtubKUgCZydvtdDRSJzRXHj+suHh7Rs5+jjSE4BHITREP8Vg5gIfak
   ngL/ExVoUq9ihHoOon+FGMt5X4SJTvEqxsoI8U2bXBRv2wMINK09SqT4h
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="214829906"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:42:47 +0800
IronPort-SDR: jB6uKPjGHTh/FcTolQwclSJNuB+p347JhN1J64vu+vXeTPpCmHA0zy+nezLQITBsyk2q+Ulc+D
 vkYPTIlW16RZ5WuYES9ZjcSBABhODA4NV96kM0HUHOcy+zAHbR9qhgYKUBiSblrMK/JSj3CoDy
 cJqF3BPr7mixABMmREbGRarpKj9eJcZfw5NKXOiHKA59Bqt9uc9I3+pboaHacmRQ3eMHQpyp/u
 s7mNENKN/LjYMvS4HOsFFuwN1nWG7Apq28XFNrd/LsjGTuqqZ1eOTOtRtX7MWnCW+qtdcOv1Fy
 VxsCWUrOJ8TG3VboNx8axj6Y
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:02:08 -0700
IronPort-SDR: gzDIW+EOzH1PBg0nLQf2soaWamO3wDZc3OWj6FsIMd/JCQfjSPX0U8YUDECiu9Bp8DGuMcxN5+
 ZgIcS2ix/T8D4IKcVaAVDw1wGAs43Ynw0pWL7hm01FU8voACruMEtlZVWHnMNJ72EnLiStlQbj
 QvwtFRo0o5wOeOUSehtz2xYgQID2V/Ks0fg6kF7Y4tK9UsIrOaEvF9E6poViVhDoS0+HVs1Rqa
 aUJBaJEKFy1sTGqOxhYCfgO47OnxmsO/a8pjGaoUk3ymcoRLEPv5yn/6NIsJShrM72/33e9sHY
 YUA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:42:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MyT2Z6MPcz1RwtC
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:42:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666834965; x=1669426966; bh=V3VNtrd2sSuIeHi0rSjd4oShumm9o/iApZN
        ZPCXWpZo=; b=iF+Yhl8c1M35Pfw+xhXyZVfrU88Z/Q+3Je58YIC1IRRT5eV12zP
        Lx1xzm0RazzjPUK8H1r3Q6bjOIyKu1uQGSjCmQkvTtoIK/XfdgF2ZPNw7Jv3ZiS1
        sp1g5LQaYginN6vWYMMzO2wOIMfog9aOcM9G+1zJ2cGTGsk4cg39MDoFBHmt5tH7
        mrl77znNZ8K6uhNfJw1K62B5T/rNZ14ZneIfzm+Io4fQh9sHJT0uTq4GzXdHjE/D
        6go+gIXRmHAa1W2pd0eWO5Bafwm03mXH3dWvNYV5bA7vKeAGDnyPIveTKk93YVMV
        vfhRrHrOKRE3QA5Mv87Fou7Ud55bgGx/tNA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6dz_5mixkP6Y for <linux-block@vger.kernel.org>;
        Wed, 26 Oct 2022 18:42:45 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MyT2W0VPrz1RvLy;
        Wed, 26 Oct 2022 18:42:42 -0700 (PDT)
Message-ID: <8ed42281-4400-a0ed-92f1-c57b9de726a4@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:42:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 1/7] ata: libata-scsi: Add
 ata_scsi_queue_internal()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     axboe@kernel.dk, jinpu.wang@cloud.ionos.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693976-181094-1-git-send-email-john.garry@huawei.com>
 <1666693976-181094-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693976-181094-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/22 19:32, John Garry wrote:
> Add a function to handle queued ATA internal SCSI cmnds - does much the
> same as ata_exec_internal_sg() does (which will be fixed up later to
> actually queue internal cmnds through this function).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-sata.c |  3 +++
>  drivers/ata/libata-scsi.c | 43 +++++++++++++++++++++++++++++++++++++++
>  drivers/ata/libata.h      |  3 ++-
>  include/linux/libata.h    |  6 ++++++
>  4 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b6806d41a8c5..e8b828c56542 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -1258,6 +1258,9 @@ int ata_sas_queuecmd(struct scsi_cmnd *cmd, struct ata_port *ap)
>  {
>  	int rc = 0;
>  
> +	if (blk_mq_is_reserved_rq(scsi_cmd_to_rq(cmd)))
> +		return ata_scsi_queue_internal(cmd, ap->link.device);
> +
>  	if (likely(ata_dev_enabled(ap->link.device)))
>  		rc = __ata_scsi_queuecmd(cmd, ap->link.device);
>  	else {
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 476e0ef4bd29..30d7c90b0c35 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3965,6 +3965,49 @@ static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev, u8 cmd)
>  	return NULL;
>  }
>  
> +unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
> +				     struct ata_device *dev)
> +{
> +	struct ata_link *link = dev->link;
> +	struct ata_port *ap = link->ap;
> +	struct ata_queued_cmd *qc;
> +
> +	/* no internal command while frozen */
> +	if (ap->pflags & ATA_PFLAG_FROZEN)
> +		goto did_err;
> +
> +	/* initialize internal qc */
> +	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
> +	link->preempted_tag = link->active_tag;
> +	link->preempted_sactive = link->sactive;
> +	ap->preempted_qc_active = ap->qc_active;
> +	ap->preempted_nr_active_links = ap->nr_active_links;
> +	link->active_tag = ATA_TAG_POISON;
> +	link->sactive = 0;
> +	ap->qc_active = 0;
> +	ap->nr_active_links = 0;
> +
> +	if (qc->dma_dir != DMA_NONE) {
> +		int n_elem;
> +
> +		n_elem = 1;
> +		qc->n_elem = n_elem;
> +		qc->sg = scsi_sglist(scmd);
> +		qc->nbytes = qc->sg->length;
> +		ata_sg_init(qc, qc->sg, n_elem);
> +	}
> +
> +	scmd->submitter = SUBMITTED_BY_BLOCK_LAYER;
> +
> +	ata_qc_issue(qc);

Arg, no ! This potentially mixes NCQ and non-NCQ commands, which is
forbidden by ATA spec. You need to use something like:

	if (ap->ops->qc_defer) {
		if ((rc = ap->ops->qc_defer(qc)))
			goto defer;
	}

	ata_qc_issue(qc);

which is done in __ata_scsi_queuecmd() -> ata_scsi_translate()

Unless you guarantee that ata_scsi_queue_internal() is always called
from libata EH context ?

> +
> +	return 0;
> +did_err:
> +	scmd->result = (DID_ERROR << 16);
> +	scsi_done(scmd);
> +	return 0;
> +}
> +
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev)
>  {
>  	u8 scsi_op = scmd->cmnd[0];
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 0c2df1e60768..15cd1cd618b8 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -82,7 +82,6 @@ extern int ata_port_probe(struct ata_port *ap);
>  extern void __ata_port_probe(struct ata_port *ap);
>  extern unsigned int ata_read_log_page(struct ata_device *dev, u8 log,
>  				      u8 page, void *buf, unsigned int sectors);
> -
>  #define to_ata_port(d) container_of(d, struct ata_port, tdev)
>  
>  /* libata-acpi.c */
> @@ -130,6 +129,8 @@ extern int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
>  void ata_scsi_sdev_config(struct scsi_device *sdev);
>  int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev);
>  int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
> +unsigned int ata_scsi_queue_internal(struct scsi_cmnd *scmd,
> +				     struct ata_device *dev);
>  
>  /* libata-eh.c */
>  extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 827d5838cd23..8938b584520f 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -764,7 +764,9 @@ struct ata_link {
>  
>  	struct device		tdev;
>  	unsigned int		active_tag;	/* active tag on this link */
> +	unsigned int		preempted_tag;
>  	u32			sactive;	/* active NCQ commands */
> +	u32			preempted_sactive;
>  
>  	unsigned int		flags;		/* ATA_LFLAG_xxx */
>  
> @@ -857,6 +859,10 @@ struct ata_port {
>  #ifdef CONFIG_ATA_ACPI
>  	struct ata_acpi_gtm	__acpi_init_gtm; /* use ata_acpi_init_gtm() */
>  #endif
> +
> +	u64 preempted_qc_active;
> +	int preempted_nr_active_links;
> +
>  	/* owned by EH */
>  	u8			sector_buf[ATA_SECT_SIZE] ____cacheline_aligned;
>  };

-- 
Damien Le Moal
Western Digital Research

