Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B874A708756
	for <lists+linux-block@lfdr.de>; Thu, 18 May 2023 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjERRwe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 May 2023 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjERRwd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 13:52:33 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629F131
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:52:27 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ae6dce19f7so5991155ad.3
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 10:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684432347; x=1687024347;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t48M6GXKCfAs9Mw7rWI62G/DfMc58hyveP8cja75zGQ=;
        b=OWGz/ME8BudjFDyvo/dSfdD7Rtke6Gep0wboNfVt50nG21y1x5ElH8VbnUaBZvZfF5
         cv9Kl56Ia1KZCkAurmse9st2CuztF3MWwKjYp1+JBK8x8M95Weusksv6F7nFphIQnGHa
         BJSqePSgQy9xgwCisLJos3L4ghuBMsVWyKKzHjlEsO6kVznPBuuGHexGcq7f116crnW7
         QDI4kLV7qPWN8od2nzXP6qIUoRaIkKkhGK/1YVwoNMFMSjVR/XHs6xfNyr+GLZOpvp2G
         kM4ArPm1fF7KlnC6CDs1ULVrkHDYK9nOfgVx13en/mf4Rqlq1mtvZzFZqKzqMahXAo1V
         Ah7Q==
X-Gm-Message-State: AC+VfDws15i+bRc/m1erR/nPGag7rTbFkxK/vId+wtMRaiWsGr+T/GD1
        lrpB2Zovxn+Ce4C0G7ylnYQ=
X-Google-Smtp-Source: ACHHUZ7MZdKJWjJNg0kMIPKAIZzZLO8DNqDBDYtYx3JuwmbmpABMbq+5UNqZSHfRdMu3pQFIBq9osw==
X-Received: by 2002:a17:902:b707:b0:1ad:fcdc:2a9f with SMTP id d7-20020a170902b70700b001adfcdc2a9fmr2954383pls.51.1684432346852;
        Thu, 18 May 2023 10:52:26 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902680500b001a245b49731sm1748451plk.128.2023.05.18.10.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 10:52:26 -0700 (PDT)
Message-ID: <9275b563-c0e2-e003-6566-de06af46ed35@acm.org>
Date:   Thu, 18 May 2023 10:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-3-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230518053101.760632-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 22:31, Christoph Hellwig wrote:
> RQF_ELVPRIV is set for all non-flush requests that have RQF_ELV set.
> Expand this condition in the two users of the flag and remove it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
