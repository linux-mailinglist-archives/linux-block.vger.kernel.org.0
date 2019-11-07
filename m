Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00067F2FFA
	for <lists+linux-block@lfdr.de>; Thu,  7 Nov 2019 14:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfKGNkX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Nov 2019 08:40:23 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34965 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfKGNkX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Nov 2019 08:40:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so1496953plp.2
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 05:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4jwWug07MWOkr2qYik00IBFcec60QuuQYmHGTX5Nfvk=;
        b=wH3+KwrCqWpVGRfSTjUUlZGDGoRu3adOrQELxMAsfC0X9zWnU8LI+X1FuqtcenJ4Ih
         ApOt9YzExOdEtVt0WETR9+3OLChFDUMl1LZI+euhn9v8WCIwMuGajNwzNMn1ubzGN1PL
         qa2KCx5JuVeMyLOtAYijCYZcULRT4B7BSW6XVSedKLRrNYqCx9cJ6N5DrbG5nao4ugWk
         TOF92HaAS5mQT4e5ayyDObQmRrwqAuYnlze5K1sMZjF29VMn0/v3kFMG586GC58NZF5y
         cmTIkoMk9VL+es1FsKZ4EAu9aDtR3KlHYouPP3AxnOyReUTF972b7PjNZU0+JBkkI3Lo
         cSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jwWug07MWOkr2qYik00IBFcec60QuuQYmHGTX5Nfvk=;
        b=UysWumdOaKGim44G8nxcj0aYAfdX/xB79VUua6cFwf2AmoZPYmCt51fAoMT4NhMI7z
         NuWVKDbazF8hn3RLUkUxfBt7anEYkRVIS0RDF2uIy8OxJ9OGtWLHdoNFIaOBRpCRnvkJ
         1zhqAD7xtyriEExk6fxqOH5mw8cIPc+tlykOM+aihx3NPwBxhqnWA1Afm66o9p0DAxwS
         kP0c5xaUqGSTll+qAuNUn8jAIbw33NYREbXmchT1kv8IRtTet8ZHYioW4HJ25jjNRBAk
         SKYFDxBfd72wil8Z7qhDlMKU48k/yp63W1hO9mD94lJCBBNiTSkvUozWXl7KAjpcVU/h
         G8FA==
X-Gm-Message-State: APjAAAXRK21e9Y7kWD9WxPn0AQNFTrUUFLIASs0/O2hUgaArZOhLa1my
        I3W8NXP4gwPnWVvBIp7EO8UQqQ==
X-Google-Smtp-Source: APXvYqxUqwziIRejg0VlHTo/IjAZ8qKz+Umil4abg66UwevSjmyaJOge6jJD9qFWjmRFk+eqOImpbg==
X-Received: by 2002:a17:902:47:: with SMTP id 65mr3722636pla.94.1573134021445;
        Thu, 07 Nov 2019 05:40:21 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r11sm2255570pjp.14.2019.11.07.05.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 05:40:20 -0800 (PST)
Subject: Re: [PATCH 0/8] Zone management commands support
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc:     Ajay Joshi <ajay.joshi@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Keith Busch <kbusch@kernel.org>
References: <20191027140549.26272-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <31755ade-ae21-8842-05c0-47017cea7e29@kernel.dk>
Date:   Thu, 7 Nov 2019 06:40:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027140549.26272-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/27/19 8:05 AM, Damien Le Moal wrote:
> This series implements a few improvements and cleanups to zone block
> device zone reset operations with the first three patches.
> 
> The remaining of the series patches introduce zone open, close and
> finish support, allowing users of zoned block devices to explicitly
> control the condition (state) of zones.
> 
> While these operations are not stricktly necessary for the correct
> operation of zoned block devices, the open and close operations can
> improve performance for some device implementations of the ZBC and ZAC
> standards under write workloads. The finish zone operation, which
> transition a zone to the full state, can also be useful to protect a
> zone data by preventing further zone writes.
> 
> These operations are implemented by introducing the new
> REQ_OP_ZONE_OPEN, REQ_OP_ZONE_CLOSE and REQ_OP_ZONE_FINISH request codes
> and the function blkdev_zone_mgmt() to issue these requests. This new
> function also replaces the former blkdev_reset_zones() function to reset
> zones write pointer.
> 
> The new ioctls BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE are also
> defined to allow applications to issue these new requests without
> resorting to a device passthrough interface (e.g. SG_IO).
> 
> Support for these operations is added to the SCSI sd driver, to the dm
> infrastructure (dm-linear and dm-flakey targets) and to the null_blk
> driver.

Applied for 5.5, thanks. I've got the last sd patch pending, the conflict
is rather ugly. I'll setup a post branch for drivers with this in, once
the dependent fix has landed in Linus's tree.

-- 
Jens Axboe

