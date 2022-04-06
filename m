Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467E74F63A1
	for <lists+linux-block@lfdr.de>; Wed,  6 Apr 2022 17:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiDFPka (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Apr 2022 11:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiDFPj5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 11:39:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F41B72EB
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 05:55:34 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q19so2124728pgm.6
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ia9+/STEIK6s5M7yq5g28XApY0uGE7BS8OCfCM69b6A=;
        b=1jHJjG0vgz25gIzyBuScalLuzhFAfWyPNeNxdThD5QdRv6nV6NS/H9b5sgMPyXcpeA
         jCApD1jmvsgeKI5/tguxrCXmMwlkeU+UtDeN87DbXpH4BDnpcB6dNPoaNFysouTNi34D
         mwPOhoX8zj1JT2o34AsxHa7g1kWrXlKyqZo4B12OymnG/M27MMOZOiT0ZqBIcj9nC5R8
         nEgHt4nRlVA9IBDe+fKF7fgMLJMJoAxtikpXI44H+hEZOFb1kQS4ccI3urifRwJofOu2
         YNBnw7a4es5sxt9ZeJGKY6WGELxoWRLrYJlPP0GAzQkQbAbpFKYrApa4HUSOepOQTWEw
         CfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ia9+/STEIK6s5M7yq5g28XApY0uGE7BS8OCfCM69b6A=;
        b=JknemXbS1T08nwMH9QbXW9IHx6dYkFNTRNRGC2EXfX1EHiq4bEgaCz2d6TDZKBgaLJ
         +UQapiQc8QcNgHMNA/8RufqEFDUIYca8KAgEB0nTkjAokzVysAVk+phehqWBaKVg3L5c
         WQU/qFBSuH0bmyGNMz7ohrtbKECqRAbUE+cxtpjytRSU80gaokpCJRa2aJMDk8TjAkgS
         cIdZJ/ocaF6/akWRZhmBDqqlqotQXP56rn0Cnr0pIuNiLosamdVZaTu1mbwp/HM7nrY5
         zBcaoFaf4FpmnDmovhnVl5pditqasrfOf4maFQIm69Fd832sM6ukiJ9nLs+pOJJxpcl2
         sSgg==
X-Gm-Message-State: AOAM531b60A3Mg7VrKUKozUYEIbbsJIpK580s5CXH19tCHngbpkZxn7G
        2AZGO32CsyETW/zrn9iTPIIt+9AqMJcM/A==
X-Google-Smtp-Source: ABdhPJw2Mh1njoqbEPjpvRC2p3sOjeTsg/pWyOftIQWGeQ7ifA9CMlk2Fr9+xIAJq2EzH3psDacsUg==
X-Received: by 2002:a05:6a00:a92:b0:4e0:57a7:2d5d with SMTP id b18-20020a056a000a9200b004e057a72d5dmr8534617pfl.81.1649249734194;
        Wed, 06 Apr 2022 05:55:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a38-20020a056a001d2600b004f72acd4dadsm19647671pfx.81.2022.04.06.05.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:55:33 -0700 (PDT)
Message-ID: <263199dd-34e4-36ff-51ef-23a8f4bbe5b2@kernel.dk>
Date:   Wed, 6 Apr 2022 06:55:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] nbd: fix possible overflow on 'first_minor' in
 nbd_dev_add()
Content-Language: en-US
To:     Zhang Wensheng <zhangwensheng5@huawei.com>, josef@toxicpanda.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org
References: <20220406112449.2203191-1-zhangwensheng5@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220406112449.2203191-1-zhangwensheng5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/22 5:24 AM, Zhang Wensheng wrote:
> When 'index' is a big numbers, it may become negative which forced
> to 'int'. then 'index << part_shift' might overflow to a positive
> value that is not greater than '0xfffff', then sysfs might complains
> about duplicate creation. Because of this, move the 'index' judgment
> to the front will fix it and be better.

What's changed in this version? Always add a v2 to both the subject
line and below the '---' so that folks reviewing this will know
what changes you made since the last posting.

-- 
Jens Axboe

