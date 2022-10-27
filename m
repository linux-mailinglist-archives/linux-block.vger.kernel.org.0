Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD96560ED75
	for <lists+linux-block@lfdr.de>; Thu, 27 Oct 2022 03:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiJ0Bew (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Oct 2022 21:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0Bev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 21:34:51 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E9C28E0F
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666834491; x=1698370491;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mfvs68MMxP21OfOV+MNKT20Qml7kPOHQBwE5n8aakKc=;
  b=pIai1wsiKU0TEM5Q3fNap8j9tF7Qv9s/pkcyHrhBt0nNEP8+fx2Hu+b5
   ZjmHY/HH+Eqlk+QMprTp8dxSP3YtpCiHqFBtyc55FDoLJbxgp9QsrDg95
   UhNNJp6bCaOAKpoBpxeZsi2iIO1G31KPWyIYGoBx1d9quUd2wjol5F48J
   JH+IIEbJNDD4Vy2F0w0H675OTUXZdJH+XRLHiE1HGI4f4HqOG9a9hri0o
   afdINKiDAeXoZEmZRmc+SieDvtLi/+ffkU8wU+pbWWu2+pufLtyI9bqpe
   CYaAC6BCs7NSb0fKgu9yP8eH10g6RBMxyCIQZqd+LtgdxrNmmFutMXe98
   w==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="326938339"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 09:34:51 +0800
IronPort-SDR: uZ4N9y5667ZDuPzK/VMcdLvp5/GOHTkRsgP7+k6En2KNplQdBSm6vQLE4m31StB2JBpc4tiyFD
 xU48wPzDyvg2wzQ6ydZ2z5zF9aFFaxM4zS8f+B+sYXBrBkOtkVovX2OOEIkWoaMUi/Tdg1CFEL
 nKSnAWEFQhto0ZwaZHuol13nu9BsiBzc3dVg2Lb024ki5OGebDLlP895hOyBKvp3zRGYvjtTGx
 HnjH+gGJ3Ws3w9yyfQlJNwO1qD3rJDaCXPquVNVDoKv5VhELVt2z/E3PXi8UYDtYxW2iXebhwr
 GkukXLGwbyf6Zs77mQ6do6Kp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:54:10 -0700
IronPort-SDR: zlinI9GbzLC65L2PwUiVuiZWWRNLiwW1fP7yI0K+8rpQnx9TDwLENKiPWYKyx1hMS2Ul5rC0Yv
 562zW8AkmHC7c02EegS7YwSSAm6oD6v7made8OTamLaToPnGN5RXZcyAz6WZrgOBqfKTyrBnFs
 Iz7fHhE3yhQ4dDkrRA67fIpWU26WFwGEfTrdfiX3bryLOF1g1aEdJMBK97UZIS4Do7T+bI8XWh
 eTjkQ+ohKQN0i7fCp0svkgrx8W0eWLEVhjwGH8KDZMO2XE+144/5PyENURr/o4AdMU/qRIuTZF
 kk0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 18:34:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MySsN6sfqz1RwvT
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 18:34:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666834487; x=1669426488; bh=Mfvs68MMxP21OfOV+MNKT20Qml7kPOHQBwE
        5n8aakKc=; b=NJa8xT5UzqO5+O30ifNYx3LY4Jt7KdV/eDg25EZRBy0mgXCqHi5
        oFxp66raECNTbrvQtzrHYSrM5oOrNC1Pz9tuluAu/1UU4F68oBs5cVi76vBydr7x
        +wIBs0gfPwngDiBpLzzyhOduehzRrGYI/VZDe+mUHROFGKWI2iFXU3ZUaUcjco+k
        fq6tVSlvZcVtG/P4E+obckSYjJXGvXBVxXD1lldssoMjsMQCzJGzEyGV43E8z27C
        GU5JXqNBAtuwwNo0b8h4Jd4Y5MJ13fJn1oPaRVROfMLhfJx4ezPwEGTvStIxOxl7
        9JziKPSZyyfqNa+9/h1QTOgED3pO3s/0GkA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CHbBaYq81xnG for <linux-block@vger.kernel.org>;
        Wed, 26 Oct 2022 18:34:47 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MySsK2k8Kz1RvLy;
        Wed, 26 Oct 2022 18:34:45 -0700 (PDT)
Message-ID: <6c0a4a75-786a-c946-57f2-c511bd765bcc@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 10:34:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC v3 16/22] ata: libata-scsi: Allocate sdev early in
 port probe
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        jinpu.wang@cloud.ionos.com, hare@suse.de, bvanassche@acm.org,
        hch@lst.de, ming.lei@redhat.com, niklas.cassel@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxarm@huawei.com
References: <1666693096-180008-1-git-send-email-john.garry@huawei.com>
 <1666693096-180008-17-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666693096-180008-17-git-send-email-john.garry@huawei.com>
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

On 10/25/22 19:18, John Garry wrote:
> Currently the per-ata device sdev is allocated as part of the scsi target
> scan, which is after the ata port probe.
> 
> However it is useful to have the sdev available in the port probe. As an
> example of an advantage, if the request queue is available in the probe
> (which it would be if the sdev is available), then it is possible to use
> a SCSI cmnd for ATA internal commands. The benefit of this is then we can
> put the ATA qc structure in the SCSI cmnd private data. It will also be
> useful if we want to send ATA internal commands as requests.
> 
> Export scsi_target_reap() so that it can be used to put the extra
> reference we get when allocating the sdev.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/ata/libata-eh.c   |  1 +
>  drivers/ata/libata-scsi.c | 23 +++++++++--------------
>  drivers/scsi/scsi_scan.c  |  1 +
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 08e11bc312c2..1ed5b1b64792 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -3446,6 +3446,7 @@ static int ata_eh_schedule_probe(struct ata_device *dev)
>  
>  	ata_eh_detach_dev(dev);
>  	ata_dev_init(dev);
> +	ata_scsi_setup_sdev(dev);
>  	ehc->did_probe_mask |= (1 << dev->devno);
>  	ehc->i.action |= ATA_EH_RESET;
>  	ehc->saved_xfer_mode[dev->devno] = 0;
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index efdba852e363..476e0ef4bd29 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1109,7 +1109,12 @@ int ata_scsi_dev_config(struct scsi_device *sdev, struct ata_device *dev)
>  	if (dev->flags & ATA_DFLAG_TRUSTED)
>  		sdev->security_supported = 1;
>  
> -	dev->sdev = sdev;
> +	/*
> +	 * Put extra reference which we get when allocating the starget
> +	 * initially
> +	 */
> +	scsi_target_reap(scsi_target(sdev));
> +
>  	return 0;
>  }
>  
> @@ -4289,26 +4294,16 @@ void ata_scsi_scan_host(struct ata_port *ap, int sync)
>   repeat:
>  	ata_for_each_link(link, ap, EDGE) {
>  		ata_for_each_dev(dev, link, ENABLED) {
> -			struct scsi_device *sdev;
> +			struct Scsi_Host *shost = ap->scsi_host;
>  			int channel = 0, id = 0;
>  
> -			if (dev->sdev)
> -				continue;
> -
>  			if (ata_is_host_link(link))
>  				id = dev->devno;
>  			else
>  				channel = link->pmp;
>  
> -			sdev = __scsi_add_device(ap->scsi_host, channel, id, 0,
> -						 NULL);
> -			if (!IS_ERR(sdev)) {
> -				dev->sdev = sdev;
> -				ata_scsi_assign_ofnode(dev, ap);

Is there something equivalent to what this function does inside
scsi_scan_target() ? I had a quick look but did not see anything...

> -				scsi_device_put(sdev);
> -			} else {
> -				dev->sdev = NULL;
> -			}
> +			scsi_scan_target(&shost->shost_gendev, channel, id,
> +					 0, SCSI_SCAN_INITIAL);
>  		}
>  	}
>  
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
> index b795c138f2c1..da7bc14b030c 100644
> --- a/drivers/scsi/scsi_scan.c
> +++ b/drivers/scsi/scsi_scan.c
> @@ -598,6 +598,7 @@ void scsi_target_reap(struct scsi_target *starget)
>  	BUG_ON(starget->state == STARGET_DEL);
>  	scsi_target_reap_ref_put(starget);
>  }
> +EXPORT_SYMBOL_GPL(scsi_target_reap);
>  
>  /**
>   * scsi_sanitize_inquiry_string - remove non-graphical chars from an

-- 
Damien Le Moal
Western Digital Research

