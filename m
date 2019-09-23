Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07956BBA41
	for <lists+linux-block@lfdr.de>; Mon, 23 Sep 2019 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407423AbfIWRR6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Sep 2019 13:17:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34632 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbfIWRR6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Sep 2019 13:17:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so2569040pgl.1
        for <linux-block@vger.kernel.org>; Mon, 23 Sep 2019 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0OoLMt3cPQMMkHCkzNyLB7oVkTHloWxW2o+Dsts6CI=;
        b=hQ0Ci0h2K461sZUI1u0ev81aWvaMlm/PSaD68MEDxV4HlDIjsW5lzDbbR4NCibTwPb
         rHespEeSvm+HQnyjSb8lqvKLaN82Uf7xyHOZ3IoO8XtfupKxJvplV231DMmph7gYFcZj
         SLCQS+K54k4KLd7cZoWBbtBQ2hOEyloSqB7T4P/ot4t5Wk7ItPy/XPav58P5F6HELsJt
         eYhgC8STm3kCVzbqZeqQ9shUmNOnH/pHnbsulW7O2QChIs3CLjbc3ZUWKbSuuDsXKDGY
         2u5ELLTnh0EEY7L76B7z83U8Ez9T4kS3BeVB98BpN3be6L936PcGV0GY49WrsO2odei2
         X7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0OoLMt3cPQMMkHCkzNyLB7oVkTHloWxW2o+Dsts6CI=;
        b=rJbgekFK0vfwvd9WKr25xUcXrvACokHulDXtLr2D+NNNchcyn/isc75JZ6tOS/otnv
         k8os36G0YLX9Wa9NIl5kuhIfoi82oRdLtseMBMhbf4mSGdDHZ7jMinKT8OwRJnoM43j9
         fa9h4Y0wR7aZvlrjTne8EJ+krY9d/CCjqhySSeARyuaI5vhroNc4T1vZxa7DXgz0mckn
         G6hrNiUz1L8vH5qFs6XBW+qMdkE/v4LiELQ9WFnAgB8rhf0+iTpLwzVswZq8DhKuKrFb
         gU3nXS6zBNb2B50PtHMjSlvMPE53wwpTeR+2NtTWYWzTcFjQFSWVFppK1Z+KHG3haUuO
         McNg==
X-Gm-Message-State: APjAAAVn2uBQW1J65zaHUQoZEIVTA0X46+ePoOvapasiZBtIp76nWnWa
        9fQhvyaidKMgwNOoQuVhrYcwnot4bk7Hiw==
X-Google-Smtp-Source: APXvYqx9952KGiDoJnZssfpr5VuSKQJqWo/OYQhuR68ipwk0tMNQOtikdNlvIaW733ccvJEZqXqv5Q==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr715784pfh.176.1569259077022;
        Mon, 23 Sep 2019 10:17:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e1sm15070761pgd.21.2019.09.23.10.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 10:17:56 -0700 (PDT)
Subject: Re: [PATCH] block: drop device references in bsg_queue_rq()
To:     Martin Wilck <Martin.Wilck@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20190923135744.13955-1-martin.wilck@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c27d66a-9664-23b1-f938-c0b4fba272cd@kernel.dk>
Date:   Mon, 23 Sep 2019 11:17:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923135744.13955-1-martin.wilck@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/19 8:02 AM, Martin Wilck wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> Make sure that bsg_queue_rq() calls put_device() if an error is
> encountered after get_device() was successful.

Thanks, looks good to me, applied.

-- 
Jens Axboe

