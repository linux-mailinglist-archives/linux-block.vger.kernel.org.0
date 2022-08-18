Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05380598D8E
	for <lists+linux-block@lfdr.de>; Thu, 18 Aug 2022 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345929AbiHRUM0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Aug 2022 16:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345916AbiHRUMH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Aug 2022 16:12:07 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CB3D2E90
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:07:44 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id x23so2398004pll.7
        for <linux-block@vger.kernel.org>; Thu, 18 Aug 2022 13:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JlRHUvzsD6VgbLaRQHRnF96wosqjRA9ST8cu7rb0rKA=;
        b=p8jD/BEEG2j4z6It2WGf0RT3woIBIFIMnYqOHLXkwkgTLW1WpqAi0N//0hMNup26J/
         Y5rLObsO6pNEmrv0H+7Qc1cm5XO6xltv+UDiT5LNKvRK6s60jSN4TW9qsSU0f+9tEv20
         qHGNhEqvU5NUxPSV+b9m+G+H7Fnp1o0E3dY0eH0UPBVvf3iC5dxBfLSFwvZlVJXEz0hL
         GH15Yv6uax7z+v6tuBvQULDYpslyGGrRpv3i7O7GSkmfLeJFSFVa4TGV+Pqwz1hMkgeI
         0NLh+GeppsUE38XY4o23ncijKXPnRNG6xz3S0sH/eb/Ncg612RpIvtLTQ/Ai1OcGl8+5
         ZN/g==
X-Gm-Message-State: ACgBeo29ueLzUD5LPfM6yPa5TMy402OnvQaRtZzwFg7d3AiP3YKyFoFp
        s1htLEv45RZnnU55MABuwpIk1nlAOQ0=
X-Google-Smtp-Source: AA6agR6Q5EEObV3fuPvxpYnVIcn2WQODNsYhjMdpKWuNzk7f3LzRJdzWkYwdQej1rfOGIiXzS5W1LQ==
X-Received: by 2002:a17:902:76cb:b0:170:9f15:b9a1 with SMTP id j11-20020a17090276cb00b001709f15b9a1mr3930578plt.95.1660853263933;
        Thu, 18 Aug 2022 13:07:43 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id o6-20020a170902d4c600b0016d2d2c7df1sm1784798plg.188.2022.08.18.13.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 13:07:42 -0700 (PDT)
Message-ID: <bbd13579-4279-8263-9d7d-684d7faa495f@acm.org>
Date:   Thu, 18 Aug 2022 13:07:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests v2 6/6] srp/rc: allow test with built-in sd_mod
 and sg drivers
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220818012624.71544-1-shinichiro.kawasaki@wdc.com>
 <20220818012624.71544-7-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220818012624.71544-7-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/17/22 18:26, Shin'ichiro Kawasaki wrote:
> +	required_drivers=(
> +		sd_mod
> +		sg
> +	)
> +	_have_drivers "${required_drivers[@]}"

Can the above be simplified into _have_drivers sd_mod sg?

Thanks,

Bart.
