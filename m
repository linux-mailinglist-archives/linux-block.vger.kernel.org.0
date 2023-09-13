Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6679DE22
	for <lists+linux-block@lfdr.de>; Wed, 13 Sep 2023 04:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjIMCN4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Sep 2023 22:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjIMCNz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Sep 2023 22:13:55 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C5A170B
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a9e89fa553so829168b6e.1
        for <linux-block@vger.kernel.org>; Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694571231; x=1695176031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=tcnC9UfRLA6uxGKWTNg4gxSepsyOiHvGK3MbsaJ2exWu5eFAFPrL36YfFZ9qdIP2/F
         /+UXhxdCZwqooroyaRF/yrxqOSSEZAOCewZee80/ihCK5ASZjkddicej9BpTJkgfj/3H
         ekOlqm92NsO7Kuen7L+QyLOpIsTB6e69unxuaiK/NVTkrv4Ig7GvEFAuWyDig9Ds65Mu
         7qGRZd3cJtgvvUS4xwkxXcn0V3XGehI+A0RbhneKwPWCfnb/2BoJ++7sXv/+cLIDHB7h
         mVQUCv55ggT1IjGnjFQyLLtowK2kLztAlDsCWi1wKGJvPRsL9+qSA9m+6RJw+vC/vykQ
         tf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571231; x=1695176031;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23rqbeU88G+H/X4YiesJiBFthRxmZeNP6+NeVuIKyqQ=;
        b=UhqL0OxR4/VVd1bFP4ojb+P0NryX5Oc/Bluqq5M1xgQJT6iAZj7q84HoUT/MHzUH4d
         OqAMWkdmalaFqADIA5oN5XZVFlNUYcDuuw/bLGE58xLc37yIfxHh/rdWKy2y73sSOy6t
         LdzKpSVf0vT3nXs6Tf6yzPK7xd4E0XTVHCfOYXk0nMHHzwcQxX55vQDv/WC+rdJNMnOP
         1RL5gMsViF8JOl0aVa7HjZm4AY6tYqEza+69vutqtq4NEhQ4y6GD97Uvej9UmO8vXIVY
         pr216CmSqo26W1pugrwPBNg7dntOYkyNTidPizaCMtT/2pMy5j2KBRug9j74dphAohxA
         fydQ==
X-Gm-Message-State: AOJu0YwW50D22jOeaH7/Nhupr2b0hLDHQGjmISxcx9UFIMiat74RJuWw
        uaK5TowIXsjJRpf0yfm7fQvoPg==
X-Google-Smtp-Source: AGHT+IHVjIFaCshNBaiPY+rZ4MupNKLAmafkcW6cF13HfuoZWHkT0jVAj0nhyAIPv6stui/Hf1oS3g==
X-Received: by 2002:a05:6808:bd3:b0:3a8:8b74:fd59 with SMTP id o19-20020a0568080bd300b003a88b74fd59mr1750655oik.0.1694571231249;
        Tue, 12 Sep 2023 19:13:51 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w20-20020a63af14000000b00577ae8ad823sm1630196pge.80.2023.09.12.19.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 19:13:50 -0700 (PDT)
Message-ID: <8d633491-b767-4e63-9964-fabe830191c4@kernel.dk>
Date:   Tue, 12 Sep 2023 20:13:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: general protection fault in reset_interrupt
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>
Cc:     "efremov@linux.com" <efremov@linux.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB31064006356930AAD778ACCAE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BL0PR11MB31064006356930AAD778ACCAE1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

https://lore.kernel.org/all/7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk/

-- 
Jens Axboe

