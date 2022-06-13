Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2D854800B
	for <lists+linux-block@lfdr.de>; Mon, 13 Jun 2022 09:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiFMHB6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jun 2022 03:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238760AbiFMHBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 03:01:48 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3090919F90
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655103699; x=1686639699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2WDWmTstpttzQMnzDUtwtitJl5qbFuuxhfKS7fyFC48=;
  b=J102CryXJ5oyjb9U1R1OtCLkUwjdEgrxbenM6gGGUIh6vvJptYGOQdQC
   tbmAaeLbS8/WMwDWyH2gEIbbHEaOU7XdSc3j2jXwyBD7RJo9DuEMJUBcF
   pf1kTLSFGC4UfQR8zOfQIX0///9rOmjbvrarySE3Q1L6TMOu7XJbL+qTM
   aRunLUMEBDpyMEdh/J3czD12hqRB15NqW76859ObL+4KYJrMSZDiVRA+y
   sBV9jWswhJuY9FA6lwa0+HP4vjSFPa4rL1fmkqyccWTf+Vzvx6cFMcHtp
   vPGiL2SJMxBfRKt7DCmS4SlOaVhGs4dsjs371/KzC9FBTuey+gTPoguvB
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,296,1647273600"; 
   d="scan'208";a="315034293"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2022 15:01:23 +0800
IronPort-SDR: zDVbdw/WeHywzCu9y068uVCE2yM8vLnMPATbHwWO8yYJiQXmU0JmFSvK78ZjwsLEIiMqb2a9M8
 8Lff+DzgKx4qkP7w9wQ2DoK/Y6HKgv6q3r1gucyQVlBKLBXUNjY4mxAU+Qq9zfyYLfH1n41J4c
 EiEhf2hde7b/VsXHBRUgDyJ9WHiW2Lq9FrJ4M2OPJ2jbdJR28anoJIKOX5djVOOHCtsLKTxzlT
 898By4Cluf1wVc78X0otjnv5yx96m5peAFnmxB6ic96JGouh2YqKPO7yjCv2ray+VMmdkOUnrI
 9c+D6u0MEkUIOIbvSM219JX7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2022 23:20:03 -0700
IronPort-SDR: JYO/jIoFv8SfXhi8dX4Xl6Ck/ckaT9xe7kCNWGTqox+4OmaY1MXDVD9gqbFNhtC+QDV7cJX1Fj
 QCECCvRtPkGnPxwDxVPNVvpsZX2nKzOD/1M/iqSbb27VmBABL34qvWhQe0Q+AcntxMMhJ1c++4
 HMxTuf/mf/3wWqHPbQJVgCLzAQNj9zflpiHi96zPqzHeYUzvUrqShL0YmDGq8zg2DZHKIxxGVB
 r8geSfUcAY2xP9fJ0kQZu/4gMb8cQjGz7JX2HM/XqOhkv7zYSsuvQCFrii5D2stFyysmdmKxUu
 rvI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2022 00:01:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LM2Xy0f3lz1SVp2
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 00:01:22 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655103681; x=1657695682; bh=2WDWmTstpttzQMnzDUtwtitJl5qbFuuxhfK
        S7fyFC48=; b=NAC1DTbeyxKroJVWMYklxSfOC6ojkBozAkqbY2tbC0u8SWJPGp5
        nAtl8CO4eCWVrBSvAtAOgW/rrNEhlYIDJZUcIgJkNWZIXeOhDRhJqqGqo+NdrDaP
        tV8tL3QSHXzM2FyVWQqs3ftYJOjcClIMTcqmOXY8aAMpGcQ1cTFQOy5pPdoTX42y
        EBpb3dqccpn866Sp2GDOjNJ1htIg8oqqlEFuBsoR3yZYbd+nA1jc/DtB17Dugbmt
        8P+rPboRjUQzmsstjdBUVdGdgfs5Mi+seJM/79+j8hIIf0rXXMZoFZZGUDWIj9gi
        GD7Jz8fxf12bYNpOo0/wvN2fHKnKkULAO3A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Us9t2bWXeSOi for <linux-block@vger.kernel.org>;
        Mon, 13 Jun 2022 00:01:21 -0700 (PDT)
Received: from [10.225.163.77] (unknown [10.225.163.77])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LM2Xv09BWz1Rvlc;
        Mon, 13 Jun 2022 00:01:18 -0700 (PDT)
Message-ID: <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
Date:   Mon, 13 Jun 2022 16:01:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hare@suse.de, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1654770559-101375-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/22 19:29, John Garry wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Quite some drivers are using management commands internally, which
> typically use the same hardware tag pool (ie they are being allocated
> from the same hardware resources) as the 'normal' I/O commands.
> These commands are set aside before allocating the block-mq tag bitmap,
> so they'll never show up as busy in the tag map.
> The block-layer, OTOH, already has 'reserved_tags' to handle precisely
> this situation.
> So this patch adds a new field 'nr_reserved_cmds' to the SCSI host
> template to instruct the block layer to set aside a tag space for these
> management commands by using reserved tags.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/scsi/hosts.c     |  3 +++
>  drivers/scsi/scsi_lib.c  |  6 +++++-
>  include/scsi/scsi_host.h | 22 +++++++++++++++++++++-
>  3 files changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index 8352f90d997d..27296addaf63 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -474,6 +474,9 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	if (sht->virt_boundary_mask)
>  		shost->virt_boundary_mask = sht->virt_boundary_mask;
>  
> +	if (sht->nr_reserved_cmds)
> +		shost->nr_reserved_cmds = sht->nr_reserved_cmds;
> +
>  	device_initialize(&shost->shost_gendev);
>  	dev_set_name(&shost->shost_gendev, "host%d", shost->host_no);
>  	shost->shost_gendev.bus = &scsi_bus_type;
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 6ffc9e4258a8..f6e53c6d913c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1974,8 +1974,12 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
>  	else
>  		tag_set->ops = &scsi_mq_ops_no_commit;
>  	tag_set->nr_hw_queues = shost->nr_hw_queues ? : 1;
> +
>  	tag_set->nr_maps = shost->nr_maps ? : 1;
> -	tag_set->queue_depth = shost->can_queue;
> +	tag_set->queue_depth =
> +		shost->can_queue + shost->nr_reserved_cmds;
> +	tag_set->reserved_tags = shost->nr_reserved_cmds;
> +
>  	tag_set->cmd_size = cmd_size;
>  	tag_set->numa_node = dev_to_node(shost->dma_dev);
>  	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 59aef1f178f5..149dcbd4125e 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -366,10 +366,19 @@ struct scsi_host_template {
>  	/*
>  	 * This determines if we will use a non-interrupt driven
>  	 * or an interrupt driven scheme.  It is set to the maximum number
> -	 * of simultaneous commands a single hw queue in HBA will accept.
> +	 * of simultaneous commands a single hw queue in HBA will accept
> +	 * excluding internal commands.
>  	 */
>  	int can_queue;
>  
> +	/*
> +	 * This determines how many commands the HBA will set aside
> +	 * for internal commands. This number will be added to
> +	 * @can_queue to calcumate the maximum number of simultaneous

s/calcumate/calculate

But this is weird. For SATA, can_queue is 32. Having reserved commands,
that number needs to stay the same. We cannot have more than 32 tags.
I think keeping can_queue as the max queue depth with at most
nr_reserved_cmds tags reserved is better.

> +	 * commands sent to the host.
> +	 */
> +	int nr_reserved_cmds;
> +
>  	/*
>  	 * In many instances, especially where disconnect / reconnect are
>  	 * supported, our host also has an ID on the SCSI bus.  If this is
> @@ -602,6 +611,11 @@ struct Scsi_Host {
>  	unsigned short max_cmd_len;
>  
>  	int this_id;
> +
> +	/*
> +	 * Number of commands this host can handle at the same time.
> +	 * This excludes reserved commands as specified by nr_reserved_cmds.
> +	 */
>  	int can_queue;
>  	short cmd_per_lun;
>  	short unsigned int sg_tablesize;
> @@ -620,6 +634,12 @@ struct Scsi_Host {
>  	 */
>  	unsigned nr_hw_queues;
>  	unsigned nr_maps;
> +
> +	/*
> +	 * Number of reserved commands to allocate, if any.
> +	 */
> +	unsigned nr_reserved_cmds;
> +
>  	unsigned active_mode:2;
>  
>  	/*


-- 
Damien Le Moal
Western Digital Research
