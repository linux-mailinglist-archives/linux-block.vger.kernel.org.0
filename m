Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68659274085
	for <lists+linux-block@lfdr.de>; Tue, 22 Sep 2020 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgIVLNK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 07:13:10 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:4514 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVLNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 07:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600773189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IQMCrguX0Zu48XQzFFouyUahameKH6iitE40YxYZ2Ck=;
  b=Pmm01SNrBwJUbQoeKYaL6SkpoAdnXGtc9Ahi6nubaM8ORkYALv0RSApW
   LXawgGYPeXRPWIXVrBKNblMl3mUVYW76uPSxtTyZc+u02WSG7yEO5CDNb
   JWRo9sy76/qT2pS6ruZhXXPLFdN0+Jm3DpV3WIteKHEgHZrPtDB4aUPuw
   0=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: BACWPl6ota1d6f9w/PF7Fb0srce6p1w5a0LPM2qpw0Nh3JdwIjbv4W5m581fIlPGTtRhFT1BOu
 I6S6aMcVO8UljCouABphIkOT8Yh5G4dWhmKkhDLGehqv/aF0euEaiJC4GNx/zByi+Dd/PwTwlJ
 BVfr4wg/YLI/HagCZMmRo9D4usP1LXdaKeqdnV7meEsAZweT0EmMW4PqbKXkO8MLUTM+QlW9Ko
 3XCvEMs5I0KCnA5V9SaRdoeA3+z16mCwaYKo/yRu0g2sFIuFC6WtPRkIvz6M3xxNKRyD3TlSvv
 hAs=
X-SBRS: 2.7
X-MesageID: 28235081
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,290,1596513600"; 
   d="scan'208";a="28235081"
Date:   Tue, 22 Sep 2020 13:12:59 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <konrad.wilk@oracle.com>, <jgross@suse.com>,
        SeongJae Park <sjpark@amazon.de>, <axboe@kernel.dk>,
        <aliguori@amazon.com>, <amit@kernel.org>, <mheyne@amazon.de>,
        <pdurrant@amazon.co.uk>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] xen-blkback: add a parameter for disabling of
 persistent grants
Message-ID: <20200922111259.GJ19254@Air-de-Roger>
References: <20200922105209.5284-1-sjpark@amazon.com>
 <20200922105209.5284-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200922105209.5284-2-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 12:52:07PM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overheads[1] and thus it is
> required to be disabled.  But, there is no option to disable it.  For
> the reason, this commit adds a module parameter for disabling of the
> feature.
> 
> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> 
> Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++
>  drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++++++-----
>  2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index ecb7942ff146..ac2947b98950 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -35,3 +35,12 @@ Description:
>                  controls the duration in milliseconds that blkback will not
>                  cache any page not backed by a grant mapping.
>                  The default is 10ms.
> +
> +What:           /sys/module/xen_blkback/parameters/feature_persistent
> +Date:           September 2020
> +KernelVersion:  5.10
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                Whether to enable the persistent grants feature or not.  Note
> +                that this option only takes effect on newly created backends.
> +                The default is Y (enable).
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b9aa5d1ac10b..8a95ddd08b13 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
>  
>  /* ** Connection ** */
>  
> +/* Enable the persistent grants feature. */
> +static bool feature_persistent = true;
> +module_param(feature_persistent, bool, 0644);
> +MODULE_PARM_DESC(feature_persistent,
> +		"Enables the persistent grants feature");
> +
>  /*
>   * Write the physical details regarding the block device to the store, and
>   * switch to Connected state.
> @@ -906,11 +912,15 @@ static void connect(struct backend_info *be)
>  
>  	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
>  
> -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
> -	if (err) {
> -		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
> -				 dev->nodename);
> -		goto abort;
> +	if (feature_persistent) {
> +		err = xenbus_printf(xbt, dev->nodename, "feature-persistent",
> +				"%u", feature_persistent);
> +		if (err) {
> +			xenbus_dev_fatal(dev, err,
> +					"writing %s/feature-persistent",
> +					dev->nodename);
> +			goto abort;
> +		}
>  	}
>  
>  	err = xenbus_printf(xbt, dev->nodename, "sectors", "%llu",
> @@ -1093,8 +1103,12 @@ static int connect_ring(struct backend_info *be)
>  		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
>  		return -ENOSYS;
>  	}
> -	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
> -					   0);
> +	if (feature_persistent)
> +		pers_grants = xenbus_read_unsigned(dev->otherend,
> +				"feature-persistent", 0);
> +	else
> +		pers_grants = 0;
> +

Sorry for not realizing earlier, but looking at it again I think you
need to cache the value of feature_persistent when it's first used in
the blkback state data, so that it's consistent.

What would happen for example with the following flow (assume a
persistent grants enabled frontend):

feature_persistent = false

connect(...)
feature-persistent is not written to xenstore

User changes feature_persistent = true

connect_ring(...)
pers_grants = true, because feature-persistent is set unconditionally
by the frontend and feature_persistent variable is now true.

Then blkback will try to use persistent grants and the whole
connection will malfunction because the frontend won't.

The other option is to prevent changing the variable when there are
blkback instances already running.

Thanks, Roger.
