Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735ED6518D5
	for <lists+linux-block@lfdr.de>; Tue, 20 Dec 2022 03:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiLTCiT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Dec 2022 21:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiLTCiP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 21:38:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9E811A27
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 18:38:13 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d82so7574046pfd.11
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 18:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdsW29O/6Xn6rXQsu5aPcLciaxL4xlcszGahdv8fEa4=;
        b=JX+Yf4WHK86OHRDqIF+sLMufhIcZDg+3+srs173HnZoa49DGsPAWF5Dr5GAckDMRWz
         FKHkNX+zSoaW4T6mj7PFoBB+R7aIPFkoDT6C/zaKh7Fr6YFcJKKB+3TP03RHpygnFjIk
         zT4pk334VL7ur7W5QNW3BqlUa/W794r2umr3pX1aAVp3AXfUJGFwSzJu8dGpw7ZCgTEG
         4NVifBZ8i6VMj0URqFcOG+fZKYrG0HAfPsGfyCS0BgcNENC/nKgRAk4PMZc5vosOwenc
         Y434W1ZNjXPpGBrbmjcVPOpgMpveICUYsPsb8oI5lQrxmvtyQ5C3+4gEoXEATonYs6ZV
         7YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XdsW29O/6Xn6rXQsu5aPcLciaxL4xlcszGahdv8fEa4=;
        b=mWm+HdsfPqkb9SSiiVEpJjBHO0tJOEDscsKAtMdlXsMDDJzD/izxviLzi8akpV6jQV
         hHJr9/S40MtlgGqvfoXikBcggUJc2R/pXjdC8Vl58PLOzy/PzIBXtRNNrsL2mlsvXSix
         ZEvkODW/hPpUv9hwPAgOpZ4Q9VyJee2RRw2lT8CL/gjQ33MW6cysBUVKl6HTs9gurbTg
         LyHqYfPwsc1Kfeht0MXAVRsSnfra1WavPLnvZBDb90nbQPDf9UwJ7NJEvnSZaaaayFhd
         ahJnaUn6p1AAzgW1Cr6+18babUDW1EiZ9crS4rTWJ9I7EkeDQMaU6zMr7awUovnSkYGo
         TYCA==
X-Gm-Message-State: ANoB5pk2134c7P3JGmAuKjqZkIFhbWdk5BB5KXYMqBC2cK+cckDBjfeX
        +dVp7CaxTf40xZR2lUTGf4rDbg==
X-Google-Smtp-Source: AA0mqf56VtST1wkF2n8PGxLj9I+dEzc6pW0gRfjpWT3uBZx2CydeTcTnKx4AzFZWXiGsSCMKonwciw==
X-Received: by 2002:aa7:956f:0:b0:576:e1f0:c812 with SMTP id x15-20020aa7956f000000b00576e1f0c812mr42718289pfq.30.1671503893422;
        Mon, 19 Dec 2022 18:38:13 -0800 (PST)
Received: from [10.254.36.84] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id 81-20020a621654000000b00574740c99e9sm7306038pfw.129.2022.12.19.18.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 18:38:12 -0800 (PST)
Message-ID: <78028f86-4fb4-e24e-a01b-d1f8a51cff87@bytedance.com>
Date:   Tue, 20 Dec 2022 10:38:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20221218111314.55525-1-hanjinke.666@bytedance.com>
 <Y6DWGBQSP/DA7apC@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y6DWGBQSP/DA7apC@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2022/12/20 上午5:22, Tejun Heo 写道:
> Hello,
> 
> This looks generally fine to me. Some nits below.
> 
>> +static inline struct bio *throtl_qnode_bio_peek(struct throtl_qnode *qn)
>> +{
>> +	struct bio *bio1, *bio2;
>> +
>> +	/* qn for read ios */
>> +	if (qn->dispatch_sync_cnt == UINT_MAX)
>> +		return bio_list_peek(&qn->bios[SYNC]);
>> +
>> +	/* qn for write ios */
>> +	bio1 = bio_list_peek(&qn->bios[SYNC]);
>> +	bio2 = bio_list_peek(&qn->bios[ASYNC]);
>> +
>> +	if (bio1 && bio2) {
>> +		if (qn->dispatch_sync_cnt == THROTL_SYNC_FACTOR)
>> +			return bio2;
>> +		return bio1;
>> +	}
>> +
>> +	return bio1 ?: bio2;
>> +}
> 
> Wouldn't it be simpler to write:
> 
>          if (qn->dispatch_sync_count < THROTL_SYNC_FACTOR)
>                  return bio1 ?: bio2;
>          else
>                  return bio2 ?: bio1;
> 
>> +/**
>> + * throtl_qnode_bio_pop: pop a bio from a qnode
>> + * @qn: the qnode to pop a bio from
>> + *
>> + * For read io qn, just pop bio from sync queu and return.
>> + * For write io qn, the target queue to pop was determined by the dispatch_sync_cnt.
>> + * Try to pop bio from target queue, fetch the bio and return when it is not empty.
>> + * If the target queue empty, pop bio from other queue instead.
>> + */
>> +static inline struct bio *throtl_qnode_bio_pop(struct throtl_qnode *qn)
>> +{
>> +	struct bio *bio;
>> +
>> +	/* qn for read ios */
>> +	if (qn->dispatch_sync_cnt == UINT_MAX)
>> +		return bio_list_pop(&qn->bios[SYNC]);
>> +
>> +	/* try to dispatch sync io */
>> +	if (qn->dispatch_sync_cnt < THROTL_SYNC_FACTOR) {
>> +		bio = bio_list_pop(&qn->bios[SYNC]);
>> +		if (bio) {
>> +			qn->dispatch_sync_cnt++;
>> +			return bio;
>> +		}
>> +		bio = bio_list_pop(&qn->bios[ASYNC]);
>> +		qn->dispatch_sync_cnt = 0;
>> +		return bio;
>> +	}
>> +
>> +	/* try to dispatch async io */
>> +	bio = bio_list_pop(&qn->bios[ASYNC]);
>> +	if (bio) {
>> +		qn->dispatch_sync_cnt = 0;
>> +		return bio;
>> +	}
>> +	bio = bio_list_pop(&qn->bios[SYNC]);
>> +
>> +	return bio;
>> +}
> 
> This also seems like it can be simplified a bit.
> 
> Thanks.
> 

Indeed, I will make it more clear and send the v2.

Thanks.
