Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48D7274438
	for <lists+linux-block@lfdr.de>; Tue, 22 Sep 2020 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVO1H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 10:27:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:35314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVO1G (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:27:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600784824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iap8OhR0mg2o+oQKvKr4dqpchp5k/Qdg/nP8obFaeY=;
        b=lHK/Q++sNDhMHjfjX0PVnGHzyRr4Dmz3rwSIx27UoO/Z2Lj7DKxvtEhgyNqSf7AL0BiHPY
        BnikXzfUR6ktJG5L0tmT+M/3qlgufoXtAj7UgEbRcdZR+58CVor2HlmziILdD7UNQ5Zca+
        LEbsS7eQ/iOnCbOuuBlh2e6jVGEqbaE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39C7EAD20;
        Tue, 22 Sep 2020 14:27:41 +0000 (UTC)
Subject: Re: [PATCH v3 2/3] xen-blkfront: add a parameter for disabling of
 persistent grants
To:     SeongJae Park <sjpark@amazon.com>, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, axboe@kernel.dk,
        aliguori@amazon.com, amit@kernel.org, mheyne@amazon.de,
        pdurrant@amazon.co.uk, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200922141549.26154-1-sjpark@amazon.com>
 <20200922141549.26154-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <28773bff-7664-99fa-a542-b87e907bf705@suse.com>
Date:   Tue, 22 Sep 2020 16:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922141549.26154-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22.09.20 16:15, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overheads[1] and thus it is
> required to be disabled.  It can be disabled from blkback side using a
> module parameter, 'feature_persistent'.  But, it is impossible from
> blkfront side.  For the reason, this commit adds a blkfront module
> parameter for disabling of the feature.
> 
> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   .../ABI/testing/sysfs-driver-xen-blkfront     |  9 +++++++++
>   drivers/block/xen-blkfront.c                  | 20 ++++++++++++++-----
>   2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> index c0a6cb7eb314..9c31334cb2e6 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> @@ -8,3 +8,12 @@ Description:
>                   is 32 - higher value means more potential throughput but more
>                   memory usage. The backend picks the minimum of the frontend
>                   and its default backend value.
> +
> +What:           /sys/module/xen_blkfront/parameters/feature_persistent
> +Date:           September 2020
> +KernelVersion:  5.10
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                Whether to enable the persistent grants feature or not.  Note
> +                that this option only takes effect on newly created frontends.
> +                The default is Y (enable).
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 91de2e0755ae..b2d3b1262404 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -1866,8 +1866,8 @@ static int talk_to_blkback(struct xenbus_device *dev,
>   		message = "writing protocol";
>   		goto abort_transaction;
>   	}
> -	err = xenbus_printf(xbt, dev->nodename,
> -			    "feature-persistent", "%u", 1);
> +	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
> +			info->feature_persistent);
>   	if (err)
>   		dev_warn(&dev->dev,
>   			 "writing persistent grants feature to xenbus");
> @@ -1941,6 +1941,13 @@ static int negotiate_mq(struct blkfront_info *info)
>   	}
>   	return 0;
>   }
> +
> +/* Enable the persistent grants feature. */
> +static bool feature_persistent = true;
> +module_param(feature_persistent, bool, 0644);
> +MODULE_PARM_DESC(feature_persistent,
> +		"Enables the persistent grants feature");
> +
>   /**
>    * Entry point to this code when a new device is created.  Allocate the basic
>    * structures and the ring buffer for communication with the backend, and
> @@ -2007,6 +2014,8 @@ static int blkfront_probe(struct xenbus_device *dev,
>   	info->vdevice = vdevice;
>   	info->connected = BLKIF_STATE_DISCONNECTED;
>   
> +	info->feature_persistent = feature_persistent ? 1 : 0;

Just use the value.

With that changed:

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
