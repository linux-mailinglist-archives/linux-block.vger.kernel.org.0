Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60C160E13C
	for <lists+linux-block@lfdr.de>; Wed, 26 Oct 2022 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiJZMxo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Oct 2022 08:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiJZMxn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:53:43 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FBF5CEC
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:53:41 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bk15so26146300wrb.13
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=azri0Jtwws8lfaFBKBKLdUeLkRHY/FwuOj4fx4ELnmBz6IU/d6ZmLuYxVYj4UVPgAs
         UU/uawnmaJhBWnnOsA3QXMQZit4V8/gN/NAFn7Gm2K96mUSSTHydWt+s9w2EkeXEYCPn
         H3ut+uKTmvzPjtwJiq+cpAJct0tjXjl3VgryhRtP75UhyUqrllKtmgCLIPpfteVOKMX7
         6ZvX2ZEltXBwEskgR1ZfHtmZWTe7fhuRbW+Gs/8bfow560QtAPoEea0eKRYzW71ufzn+
         y7T7lBQIcpm0Sjcso35R8G/GVY/iWEiqvvDPiwaiLQOgA/oCvb4fQbHX84zhZtc8DdVr
         blSA==
X-Gm-Message-State: ACrzQf3ffOc+s5v2EyB+kF7xtpiWPBCpdmmw5u2IDyZP9VE02sKvddD3
        pFnb9u7Vf9QWSWgvrGL6Odo=
X-Google-Smtp-Source: AMsMyM60cJ7pzhIUQsZa5T0LPmBf/N+cRsqOyuUydrBP8q+Xh6a7AafWS/QhA5wFTAXkaa49R+5uxw==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr28551504wrz.465.1666788820301;
        Wed, 26 Oct 2022 05:53:40 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r11-20020adfda4b000000b0022e653f5abbsm5277939wrl.69.2022.10.26.05.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:53:39 -0700 (PDT)
Message-ID: <588e8f30-e7c0-5a21-2830-59b37df7ce34@grimberg.me>
Date:   Wed, 26 Oct 2022 15:53:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/17] nvme: don't unquiesce the admin queue in
 nvme_kill_queues
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-9-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
