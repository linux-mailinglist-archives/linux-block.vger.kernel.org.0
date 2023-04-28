Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48B6F1F08
	for <lists+linux-block@lfdr.de>; Fri, 28 Apr 2023 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjD1T73 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Apr 2023 15:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjD1T72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 15:59:28 -0400
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7091FD0
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 12:59:27 -0700 (PDT)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-63b620188aeso501934b3a.0
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 12:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682711967; x=1685303967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8QOmFtch9F4RTvKlWBRuAJuSpHSSIcR2JkedUsBUMQ=;
        b=DpKwRIDwGJuQwFeSxn4ajM+YISKpReYdyfnZS2RYBuzElMO+6Ltnry8DJ/avO+U6G1
         e/PNXUVwpdvKo3NaEcJHaqY/rter03/hGn2AY02iMCnXfi5hx9osRfVl0gboeM6Fjgsc
         LNTN0BboMy8mxPwfHA3U38Ityje93Jd8+n1t6/RaJmbm4iISmcU3q1IGs4chQBXhed2c
         yGrT0wH+SayOsS3+VM0RmZ3s8DdUgToaz7CPZkOaEn5YDkPYr6ohz3eLpoZPxZ9XuxUu
         gnsUlKn/16ax1pi372oL2C17xOqZbAL4aQMmXBARuV8zyk4ea71hqSG7vu+YrIOFjaeD
         JvaA==
X-Gm-Message-State: AC+VfDy34h5ZDblj3BiH/bFaSRIVIWxE29P8pp5oW3/i26Z8pNLWqab5
        B52lwrErje+p48Rd/e1UCBA=
X-Google-Smtp-Source: ACHHUZ5ICKE+e+b32m0dvp33I1i+dhCQpO7xy+ctoRaniSDDuYEJnc1nA/jdNE3xT8UuGWRgdsgrjQ==
X-Received: by 2002:a17:902:c782:b0:1a1:ca37:5257 with SMTP id w2-20020a170902c78200b001a1ca375257mr6060070pla.7.1682711967230;
        Fri, 28 Apr 2023 12:59:27 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001a69d1bc32csm13617214plg.238.2023.04.28.12.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 12:59:26 -0700 (PDT)
Message-ID: <54b60a07-9379-7f4e-31e9-82f739415892@acm.org>
Date:   Fri, 28 Apr 2023 12:59:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 3/9] block: Introduce blk_rq_is_seq_zoned_write()
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230424203329.2369688-1-bvanassche@acm.org>
 <20230424203329.2369688-4-bvanassche@acm.org> <20230428054559.GD8549@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230428054559.GD8549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/23 22:45, Christoph Hellwig wrote:
>>   bool blk_req_needs_zone_write_lock(struct request *rq)
>>   {
>>   	return rq->q->disk->seq_zones_wlock &&
>> -		(req_op(rq) == REQ_OP_WRITE ||
>> -		 req_op(rq) == REQ_OP_WRITE_ZEROES) &&
>> -		blk_rq_zone_is_seq(rq);
>> +		blk_rq_is_seq_zoned_write(rq);
>>   }
> 
> .. and given that this just reshuffles the previous patch it might
> make sense to just move it before that.

Hi Christoph,

I will move this patch in front of the micro-optimization patch.

Thanks,

Bart.
