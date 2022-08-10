Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97F58F148
	for <lists+linux-block@lfdr.de>; Wed, 10 Aug 2022 19:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbiHJRMZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 10 Aug 2022 13:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiHJRMY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 13:12:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9074879EDF
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151543; x=1691687543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hlZ97m2efNWma/mlvKQ2Zr7hdfeg2GhMgsv7FANQHgc=;
  b=JgHY4wfdkuRfI4qEeG0wx+AgzwCqR7RurGfDpzfDt/MwtS/qbMlK1Ulw
   6ffDCn807GVuMGvMz+iC7QZt1J1mDdZiq05QcI6uIRBSxy6HATw9S4DKT
   m1bIVdcPAbUCon51Y3FOrF1W8VIf4Lgws87jvcLtKBAVz148BcDembTl9
   v4hrCQChVwU+grY2F1GAvTr65AdKOZEWAYlqvX9yc4nJQ7ui2RYbF+1BO
   7ew0hcVjmPkQuM+go8sT9rbquQOOssCPSt64KuuYJ3cS4+b99dpJCip29
   5M56j2D9nGeoJLUVdlngHtdlQ8nlitZoEfTrVYi65XvZ28M6e1Z6vGxvr
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="312649361"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:12:22 +0800
IronPort-SDR: 8TorMnTPI0uWRH8Pb7WmWctLPA/U/BqJPsSu/aZRq67Pd3fEIh6nQCdvowruuu07h3OJze6PP1
 IWNQg3pG5rTMJa60/dDjrbqDSgshhB7mIVWUGmHKJgZMkKp6lGCiu+utlHuvtb5slpjMydYImX
 Z8wAr3ZjoRBZkED7J851gtv3wuW/9nge9aVvva7S28EcJ38c9NQfpi5sX5t2RcIkIMQcXVS71D
 XAincXxjbTMdivdWGFqYWUmXmLedpDK76jJAkxhcHcl7FtZIwQS171a13D5Z1ReD53Jz0vf7lv
 ax3nztEkHXnHS78ymVofrpoT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:33:17 -0700
IronPort-SDR: edRy05R7s4gRX57xjgNQ2MAIYB0ThoQ2BDMkGftfC3IGfKWSyBsoKx0hFoYIyA9VJuGGkuW9Sj
 MI0rWJaG4jwQojkYoHkTk6Sl8NkGCdgyMCF9EsBPVI3AYYvW6nn58qqHZWZ1w+ERoJybypKquZ
 dGKwZYAf+PfxnF6HSM3YsgGdl8bDkYMZujMmFsH8qtqLhTtvXrSff66SQ0/VUEkik9BijpaHod
 jioh0yK62PAHUwd4kKIh+WSY93TiFsXdF5pD7bVVrL2LOzD4Bc5/hQd5bA2U19COpe6sxFdtT/
 IIg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:12:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xM96krWz1Rws9
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 10:12:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660151540; x=1662743541; bh=hlZ97m2efNWma/mlvKQ2Zr7hdfeg2GhMgsv
        7FANQHgc=; b=cKgvNAbZkPeUbd9WivRHefYc4O8AXg9KkT6hrG6tdWvCYYuJEPj
        XmLvMuUT6Drud/yLe+NUjCvYJT+qBsLHMqCQekj80wGa1chTTr0LiR93ZP/hjN7T
        avzYzRCZgOAl056SKSLbJg8pNAdfbLoAAw134AMDkwd0iUcxmEHkJmXpCawrfHVj
        qKYU/BTMSeu0mx/l3DWalmr7G/EvRNuNVeruWMttGSrOEpJUEDST/j44NpCTs2Fo
        SsQdj3DQIBTU5PaRpwT3xgzKy5rYg8npCViA9ZNr4cZOM+o4fVWzeCST8ZPGedNz
        sjM0oPKwLwUPAXGWGPQbGZsX0CpISDkVzKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N3zhsgINft4E for <linux-block@vger.kernel.org>;
        Wed, 10 Aug 2022 10:12:20 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xM81DwYz1RtVk;
        Wed, 10 Aug 2022 10:12:20 -0700 (PDT)
Message-ID: <40e8f0b2-0bf1-3859-cb97-4da2d34eeab2@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 10:12:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc:     dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, hare@suse.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, bvanassche@acm.org
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094813eucas1p2eab78901e97417ad52be1f8023db3d82@eucas1p2.samsung.com>
 <20220803094801.177490-11-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-11-p.raghav@samsung.com>
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-table.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 332f96b58252..31eb1d29d136 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -250,7 +250,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  	if (bdev_is_zoned(bdev)) {
>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>  
> -		if (start & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_start(bdev, start)) {
>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)start,
> @@ -267,7 +267,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>  		 * devices do not end up with a smaller zone in the middle of
>  		 * the sector range.
>  		 */
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_start(bdev, len)) {
>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>  			       dm_device_name(ti->table->md),
>  			       (unsigned long long)len,
> @@ -1642,8 +1642,7 @@ static int validate_hardware_zoned_model(struct dm_table *t,
>  		return -EINVAL;
>  	}
>  
> -	/* Check zone size validity and compatibility */
> -	if (!zone_sectors || !is_power_of_2(zone_sectors))
> +	if (!zone_sectors)
>  		return -EINVAL;
>  
>  	if (dm_table_any_dev_attr(t, device_not_matches_zone_sectors, &zone_sectors)) {


-- 
Damien Le Moal
Western Digital Research
