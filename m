Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29484A8401
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfIDM5A (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Sep 2019 08:57:00 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34172 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfIDM47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Sep 2019 08:56:59 -0400
Received: by mail-io1-f65.google.com with SMTP id s21so44013539ioa.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2019 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=75iMfH7EEXhbGGrWPnlP6nj0Xir+moE5RQ+sKgLPRNY=;
        b=kdG9noEpHEHEBAQRW2XMpdpvLr511vFWRb6qxgP+Q6UPrnAn8JxFi39xw2eqlADNHV
         Bxt5LCA9y0Tk/5AyDOoKB/A6bnbywBAUrDiG7YgmnvYBLLYsI7EaWRcPNMVfhcRPGU+i
         gbuAUMojbQpIqkv4GJ6zE9Jehrd0RcywdkHQjKPxDOYq4tMQro8/luMwv1bXuoiLeT5Y
         kxJJFx8o3ZyG5mBqnaLjErbNe8z+lQBHqLqH8lm4iis9RvmAVZ39mop9GRJyDprJG6Zi
         Q3HKqoD+nt5FZxALgfs+Gau8qrKWbJy5Ci8xuzMlrz5qDBbWGFeP6uYPdiwSUwTr8hVF
         j39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=75iMfH7EEXhbGGrWPnlP6nj0Xir+moE5RQ+sKgLPRNY=;
        b=Z8yIAgxPDj3vx4C85FaCa0eK1pQXMzgkO2xaz89b0dmpeXBXaDwUPFCz+QBwdn4a8R
         ATAd3d0MG/s/Dzc9Y3n1Uch1dk0CMrXWanwnGdojv0OdLT1K8Ul4vLI2RVl5Je7TLmkq
         l/NZeN0BDG4KBJnmZAxGS8OcsW/vplr5SYbmBiQffd3WjzmytWrLH6QpHnvONhx4ZCqW
         q99mwtxN1scZDu9AXWDqEaPZR73GV724o31Hbt4RFzkGcS/eCLxaddVTPUhA2vaAkKJE
         PapTwuur46I4jCnfxpUDV8ZnyHkq1iSoZlZNLxB/Pj30XP9w8TeDNfvJxgVnApwnvSq/
         LLwg==
X-Gm-Message-State: APjAAAUJM7waU/0XeA2Oezs7pynJ3+aMy0J8TURpeavnuifdN2YhZ9tg
        Ya81KCemANaY7hXseOIyTHBLa3gFMyArzQ==
X-Google-Smtp-Source: APXvYqxOc9zhjcAdOOZR/ZoC0fv44rZYBtSMM14qc1QfkygD/0cSMfcO48ZA37T8nh7y6BWeNxrR5g==
X-Received: by 2002:a5d:8e15:: with SMTP id e21mr25845056iod.296.1567601819078;
        Wed, 04 Sep 2019 05:56:59 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l13sm21622537iob.73.2019.09.04.05.56.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 05:56:58 -0700 (PDT)
Subject: Re: [PATCH v3 5/7] block: Delay default elevator initialization
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190904084247.23338-1-damien.lemoal@wdc.com>
 <20190904084247.23338-6-damien.lemoal@wdc.com>
 <22bc754b-541d-3c72-6bb0-68cd841faee5@suse.de>
 <BYAPR04MB5816ADDE69D61A3CB47DCC3FE7B80@BYAPR04MB5816.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <68bd56dd-46cf-efa3-14f2-4f8e50ac15c0@kernel.dk>
Date:   Wed, 4 Sep 2019 06:56:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816ADDE69D61A3CB47DCC3FE7B80@BYAPR04MB5816.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/4/19 3:02 AM, Damien Le Moal wrote:
> On 2019/09/04 17:56, Johannes Thumshirn wrote:
>> On 04/09/2019 10:42, Damien Le Moal wrote:
>>> @@ -734,6 +741,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>>>   				    exact_match, exact_lock, disk);
>>>   	}
>>>   	register_disk(parent, disk, groups);
>>> +
>>>   	if (register_queue)
>>>   		blk_register_queue(disk);
>>
>> That hunk looks unrelated, but anyways:
>> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Oops. Yes, did not delete the blank line when I moved elevator_init_mq() call.
> Jens, should I resend a v4 to fix this ?

Series looks good to me, I'll just delete this one hunk, not a big deal.

-- 
Jens Axboe

