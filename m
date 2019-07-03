Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26BBC5D63A
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2019 20:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGBSiD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 14:38:03 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43957 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 14:38:03 -0400
Received: by mail-io1-f42.google.com with SMTP id k20so13075701ios.10
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MrS60jOCM2Ps212tKlrmWlDV/2w+xfhZrZUd8Zd2Io4=;
        b=dffxewgqYOXlLZAJ2BQeD1CHL0eHw8jkxdPv9/fYueYY5bbT3OndN0k5jf2+ZPXSfi
         a+oWuaZZRMVKxX1Xkk4vYX0VkWipmI3XcTHSXTeYAenANBuco/j4zr5nT6GhPcgolIjt
         y9eqT53bpvcQ9QSnVUsxxlg8pqfV05GkTBt2ToShudOM4IilcKVJpZKt9mUmVkMRON+r
         t6buAf19vs53ENSnRs99RyyczCfGgs4XjEvtcfbiAk4lQthwOEZJopqm6TRE9Gu5aDd9
         spmOWmE27sq+7U05KGeBOuD3xJmdocvr76J+XOePwGlba164hYIK/YFbk6DVaGXcyzqV
         h0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MrS60jOCM2Ps212tKlrmWlDV/2w+xfhZrZUd8Zd2Io4=;
        b=lrtUQWaCF+x1NIoWF7gtTm3iMPEnZs+XWxytMNwapSgf5mw9xWDo+1CIBB/gXSf2Ug
         LDgOS1qDe42RxDnCq2fZlrQdFF4ZKtYNc33REhVbqeg/LOk1OCzZL/R59YCjkyKyU77g
         jdZSZaH6LaK8kay4TuNmuz1vDgnxFonsQAxcL+ceaFAjZ1n810Xt8OnKHrzMv0TtapjZ
         7B5gMjceVcTILSVCNjOdJzLKRTrCN2A09qbzDQ3xueiCWpggG8dNOyPVsswrRLUjsONi
         VxYeGUYHhrajSrjlVqiqmTEIn0mEpNh8oPHys2U4OlgWehAk6KzqLcjIsaHHZgVv0Vb7
         ON8Q==
X-Gm-Message-State: APjAAAWlkUT6M/eIobNKzrQqkN3QLb38QEDSjbowrJSOJRWk/jJG2JZL
        W3Lf+qkukkAC4qarwEViIUeqtWlAy+PCiw==
X-Google-Smtp-Source: APXvYqzhWoL9FHlLWYhOt6t5fiiEH7a+/cSlcvRe8+6Ha0ic91S55nTOzEkFRAJdoogExZbkn7xWdA==
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr36318775jao.82.1562092681725;
        Tue, 02 Jul 2019 11:38:01 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p63sm19442338iof.45.2019.07.02.11.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 11:38:00 -0700 (PDT)
Subject: Re: remove bi_phys_segments and related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <a703a5cb-1e39-6194-698a-56dbc4577f25@fb.com>
 <bbc9baba-19f2-03ec-59dc-adab225eb3b2@kernel.dk>
 <20190702133406.GC15874@lst.de>
 <bfe8a4b5-901e-5ac4-e11c-0e6ccc4faec2@kernel.dk>
 <20190702182934.GA20763@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef4a5fb5-9d79-75e1-1231-fdfc14f91835@kernel.dk>
Date:   Tue, 2 Jul 2019 12:37:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702182934.GA20763@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 12:29 PM, Christoph Hellwig wrote:
> On Tue, Jul 02, 2019 at 07:39:52AM -0600, Jens Axboe wrote:
>> .config attached.
> 
> I couldn't get that to boot in my test systems even with mainline,
> but that seems to be do to systemd waiting for some crap not supported
> in the config.
> 
> But with my usual test config I've just completed a test run with
> KASAN enabled on a VWC=1 driver with no issues, so this keeps puzzling
> me.

Let me know what you want me to try. I can't reproduce it in qemu, but
it's 100% on my laptop. My qemu drives also have VWC=1, so it's not
(just) that.

-- 
Jens Axboe

