Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4195875889A
	for <lists+linux-block@lfdr.de>; Wed, 19 Jul 2023 00:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGRWiW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Jul 2023 18:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGRWiU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jul 2023 18:38:20 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE3198E
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:38:20 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-557790487feso4797991a12.0
        for <linux-block@vger.kernel.org>; Tue, 18 Jul 2023 15:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719900; x=1692311900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tCFwEw3ff3osnpNmyqvHC7jX1iwe4oTQ2V0dRmCXvDw=;
        b=AgE5sTXo316ZB5auv/k4+I/PlTCRL0LLyXNb093EOP6tiUbkzGmQfyO8fVvUmP2W5d
         6Qvy7ZW9lFHssA2dR3qfVCB4IcjESG17N8TIVuWy3mujGDaTAIXAo8r+b4uA7hspFhLK
         V5yNmdnzmZ6YGBFu7bWMFOmt0Tj1RwTK7g0BD5bAbB6tueTnfGb8mSqLSLS4f1PiMZgP
         VYudX5vn9k/ByiJenAiXtrukr/VaLFrfaHzhLafQd34N+P+W48jKotPSMDHl2d7vhcs+
         v85fJ2Qr+okYwM1dtkYYMI9Cm9W1Ka5W4UoBckTbIqgbplJXCtUaKF7Wt1+ppCgsWRkc
         GziA==
X-Gm-Message-State: ABy/qLb8FSdwGAtAWv/3bXmFGIIToHvcKigvYufpufWzOrPkcMKVZ+5x
        cV7tDMVIXEOrhoydvfN97TPUXNeH+VM=
X-Google-Smtp-Source: APBJJlHNMXU8TwREwhuJyhHaHDCMJLQzT8dO2M3vjS7NMFUyVVUUT2Buy2yCORTRoOVZLMqoPY/d+A==
X-Received: by 2002:a17:90a:dd93:b0:263:4962:94c6 with SMTP id l19-20020a17090add9300b00263496294c6mr14971728pjv.20.1689719899533;
        Tue, 18 Jul 2023 15:38:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3cb6:9d30:79d0:90cc? ([2620:15c:211:201:3cb6:9d30:79d0:90cc])
        by smtp.gmail.com with ESMTPSA id gd18-20020a17090b0fd200b0026358dfd2a3sm69094pjb.24.2023.07.18.15.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 15:38:19 -0700 (PDT)
Message-ID: <b50e2365-fa36-3e9f-a2b2-962a303a6de0@acm.org>
Date:   Tue, 18 Jul 2023 15:38:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] block/mq-deadline: Only use zone locking if
 necessary
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-3-bvanassche@acm.org>
 <98e2f100-76b0-c28f-bb02-4a41c1b71f5e@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <98e2f100-76b0-c28f-bb02-4a41c1b71f5e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/23 23:38, Damien Le Moal wrote:
> On 7/11/23 03:01, Bart Van Assche wrote:
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 0f9f97cdddd9..59560d1657e3 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -504,7 +504,8 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>>   		break;
>>   	case BLK_ZONE_TYPE_SEQWRITE_REQ:
>>   	case BLK_ZONE_TYPE_SEQWRITE_PREF:
>> -		if (!args->seq_zones_wlock) {
>> +		if (!blk_queue_pipeline_zoned_writes(q) &&
>> +		    !args->seq_zones_wlock) {
> 
> I think that this change should go into the first patch, no ?

That's a good point. I will move this change into the first patch.

Thanks,

Bart.

