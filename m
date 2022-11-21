Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1DD631762
	for <lists+linux-block@lfdr.de>; Mon, 21 Nov 2022 00:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiKTXlM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 20 Nov 2022 18:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiKTXlM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Nov 2022 18:41:12 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905C915804
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 15:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668987671; x=1700523671;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+XIwttKFgbNBoFJSWuSeYcN6oZwEPMOr9GSzsTycsZQ=;
  b=oZuTVCXMPTV/flPtTDIsikLpHQYJYj3uJJKd0IPwzUZOx0D+Bqw+IlCb
   SeSPsd0Br9VnvYoC7Px8h9nLZ4mYDTmdL899/AC9l2tS3R+wZiLbgCDAd
   51yoJDu2fIm8UAM8gdHaZYnX09SbbsZC9VZl4zFwP802t2nPNhbZ4O/tk
   tG1W8X0fhEmsLPuFXSNUxmgZK+Oa2S6210mUgqTWct690O40pzPb7irl3
   mu5D9MYhGOI2Mo9ohjGP7WKT5D1ppVZ5ZGiQxMn+etSB9ncJGdzIV+J8S
   tCXamuFz2kNpgm6YbO0DM1WO6yF8HDCflDRmj88QMd4Qc+xBZLm2q8bHq
   g==;
X-IronPort-AV: E=Sophos;i="5.96,180,1665417600"; 
   d="scan'208";a="216735514"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2022 07:41:09 +0800
IronPort-SDR: 2Pi31gryzkvJhq8nN1/98108hsRvQqLAewUiM1uRnqmyGHRgAwutKh+oe4AfOJBYNNWpvRjlBf
 QhSXGKJDeGp8UkHQQ90p3cjf7vpqVrQqbJPmPSAJB77EP1hXqBXBDbYCGrOuNXxa3OVZrnYXLw
 1KLS8KpvcklNLeQM9P16vZzWHFluwTK4Ky4mvG6mdi0r2iLrAiLsmRxTZKdHoLJR+nu0D4TDNP
 nzZgAvCPXbdb/0ENKan9QblQmUmI85Yxtekz8VDXO6YQyK6TUPS6N/kGeID2y1Gu5EhQUNSxto
 j94=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 14:54:15 -0800
IronPort-SDR: T4R4DaK9ZKW/3CUB6cEfT3rUsMaFrryzrzKKfx5LjNU/wVuMPfzyWgzBSGlxLGH/C9pyo4wznW
 3c54ApLnlxty+Dn0zK/IFu2zDNh63TP2epfLPtoKIHuIHB52ccloJKT+5WQULXdznGEib1jHGs
 yEDx+WuapvD02wXc2C/AxqYm04u1fUcc4wX+4WbOdGpTN59axUoEE1Xv/LILmr9SSjtqKzXOA2
 3QVK09qJDP1KtFI1dbvBXZAjSiyN/hlOTuXBdtIbz11VVfyv1rZpIywvPMT0bsOCKJ9Mlaadw0
 0x0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2022 15:41:10 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NFn8j00t6z1Rwt8
        for <linux-block@vger.kernel.org>; Sun, 20 Nov 2022 15:41:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1668987665; x=1671579666; bh=+XIwttKFgbNBoFJSWuSeYcN6oZwEPMOr9GS
        zsTycsZQ=; b=OUKA67y8WGn8LkpiB3gVXr70gEbNA7akqRMa14x5ZBM8maAeuFj
        BIeusjp8jn5HksW058+QUHttGqlfUvQjTRngWYQJxBOnirrVX0nibqkzPHTven3l
        aQE/65VyQDpeZt4pBpQbQp9oNBBccv/tpy6EbREDSkT3YtFXH8DC5uMZhLNcPsq4
        uIOZI09b2vTVc5dM4kou40CICIbbTTNJIMvWuw3SmlH4AdlJ7PBClgqi3yamWlRU
        yWavkbwoe4KDOfVOgJaUR2UrRG21/by8ONFsunTOplg9siUKFZR57FuFiVMqqnhr
        JO9aQqSQGnkmDLp3FYnMs17/ztaB9eRqOag==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H0qKBPer1r5n for <linux-block@vger.kernel.org>;
        Sun, 20 Nov 2022 15:41:05 -0800 (PST)
Received: from [10.225.163.53] (unknown [10.225.163.53])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NFn8c0rSzz1RvLy;
        Sun, 20 Nov 2022 15:41:03 -0800 (PST)
Message-ID: <fd584474-c6f6-37ce-debe-151d33a2d636@opensource.wdc.com>
Date:   Mon, 21 Nov 2022 08:41:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V6 8/8] block, bfq: balance I/O injection among
 underutilized actuators
To:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rory Chen <rory.c.chen@seagate.com>,
        Davide Zini <davidezini2@gmail.com>
References: <20221103162623.10286-1-paolo.valente@linaro.org>
 <20221103162623.10286-9-paolo.valente@linaro.org>
 <PH7PR20MB5058FFC62E46AB2AE3AB0F38F1019@PH7PR20MB5058.namprd20.prod.outlook.com>
 <FB99E53F-886D-4193-9B38-32452E70A35B@linaro.org>
 <e2565d52-e75f-0320-6136-97b7953deda2@kernel.dk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <e2565d52-e75f-0320-6136-97b7953deda2@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/21/22 07:06, Jens Axboe wrote:
> On 11/20/22 12:29 AM, Paolo Valente wrote:
>>
>>
>>> Il giorno 10 nov 2022, alle ore 16:25, Arie van der Hoeven <arie.vanderhoeven@seagate.com> ha scritto:
>>>
>>> Checking in on this series and what we can communicate to partners as to potential integration into Linux.  Is 6.1 viable?
>>
>> Hi Arie,
>> definitely too late for 6.1.
>>
>> Jens, could you enqueue this for 6.2?  Unless Damien, or anybody else
>> still sees issues to address.
> 
> Would be nice to get Damien's feedback on the series.

I will try to have a look today.

> 

-- 
Damien Le Moal
Western Digital Research

