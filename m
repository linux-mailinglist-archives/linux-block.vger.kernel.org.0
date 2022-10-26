Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB0860E13E
	for <lists+linux-block@lfdr.de>; Wed, 26 Oct 2022 14:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiJZMyZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Oct 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiJZMyY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Oct 2022 08:54:24 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA56AF07F8
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:54:23 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id o4so17944991wrq.6
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 05:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=bEuCgyBTL5HtWAzz37PQFgXmz3O7Izpjb5vWIGpscVwRM3L9WPKiTH0C8nUKPdlH0J
         wrLGcSfhFOcx7RsqhHpnR1FYgsXFThEahHgdmePYqFcIQReWW77j+aTxpbGJrHX0e1bn
         kO/UJeA9MkAiYxxT8bQhZ77BaMFD7onRQXrbvxa0ep7vodU935hxIYM9O1AlTKfrQZx/
         JbR+btIPcdndDct46+LT+Fc3QoxkTZsibIZBrY2gltiEUx4u8qLEctbMKVQaEPsPe6rv
         ViQU7ggahBkjliNNDM7J/wvpoDNbELF5hlKB0F2GgkX/4Q8Tqe421HCbaldlKyErlUaK
         JCHg==
X-Gm-Message-State: ACrzQf2QIE1t7B5mD9MblnVXUUaP/5J77e3Why2j+mkTn8DQtThuVjh/
        3GCehAH8F+TlqTQZZoW6zq0=
X-Google-Smtp-Source: AMsMyM5ePG/9M6uwrcm6xSHVMuSkGSKZVC2Q9oxXwhDhTmaGBKat5SzS44mBh3XqSOKYI4w1iZEL0A==
X-Received: by 2002:adf:e610:0:b0:236:737f:8e5d with SMTP id p16-20020adfe610000000b00236737f8e5dmr10045843wrm.316.1666788862313;
        Wed, 26 Oct 2022 05:54:22 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003c6f1732f65sm1880649wmn.38.2022.10.26.05.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:54:21 -0700 (PDT)
Message-ID: <0488bde1-e36b-e3ea-a40b-9b1294273ac5@grimberg.me>
Date:   Wed, 26 Oct 2022 15:54:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 09/17] nvme: don't unquiesce the I/O queues in
 nvme_kill_queues
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-10-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-10-hch@lst.de>
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
