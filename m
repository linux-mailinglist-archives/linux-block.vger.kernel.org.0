Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C904241D8F
	for <lists+linux-block@lfdr.de>; Tue, 11 Aug 2020 17:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgHKPsu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 11 Aug 2020 11:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHKPsu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 11:48:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38447C06174A
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 08:48:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m20so9441180eds.2
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 08:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yoEe1Ej3jGb2+oD8j8Te2ep7E+5cYfUwOpnUUVRTv2I=;
        b=iCSzMwKRzHNiY6pMdRfITXYABxdBP9XPLRxovedSocAHBAIkzqVU8iDCkat54q3qqS
         4Tz27siRVcQC7EBo8vUlfg3mZTPqQlGhrUHxg5kXZA1L2EjK9STh6niL6aP9aZHFXEME
         fspNMGUxTh9TMG0SUNuBTZki/IzSRep0mp8Hhb2P/Ig5UWOdHZXbnShNHiMgKjfsbs2F
         cH1BdCYWhltQ5QHkKbacRqYYn9BvszJVMKoWyzJCpCJSEForj37O1ZVXgHYXFs4+P5Mu
         1vGjPgDxX2ZZz46F1ZXEGZj6vi/SI8cdxWgXSdqnXv/O8RAQxAroH6HDNI5/+0lWZyYO
         A6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yoEe1Ej3jGb2+oD8j8Te2ep7E+5cYfUwOpnUUVRTv2I=;
        b=d29lAbDlnWExBCZe8J2YzLkOF/bA/ytyq5hK5bckD54Hc8O01KStAtEk3Pe/WCWrfH
         V4CrTvvSxnkklnkrs/4NvJySEr0+Hc8P/p1Ap6ipgIJpNIYTyoXWiOj9AtsaIklJnfKD
         34Xm0K5/IN8ur1Ex7gmElgUulteZJp1/uR0uAgrHqljBeZmSSRNgIteUXsuG0XX1o+S4
         C1Yeg79ewSB0s3o2W9P2timqjgknM/o+xqIw7qVndu1bE5lZZRQ8begTlTsKBps7pOVs
         u0KokRgBXOmhElqB8QqFMs65WbJYVoyK3L5+ws5tmwNl3ypogi7trljdk+jNBgAssv6i
         jAYw==
X-Gm-Message-State: AOAM530Bfw5oXpaUC0VfzBdDgKIvp0lZpbGJ3MO8W5zQSOLZBoSctD9S
        Z6lbEpTSIRUW6uIJTaUVPCJToEPUpFA=
X-Google-Smtp-Source: ABdhPJxAy6Q++TTWmNguGZZcC39vZ4wMZ0y8biNBwtbfYsvnrF8rQIJVTZyJHnEiKM5/oAqMJVOiYQ==
X-Received: by 2002:a05:6402:22c8:: with SMTP id dm8mr27703852edb.41.1597160928359;
        Tue, 11 Aug 2020 08:48:48 -0700 (PDT)
Received: from ?IPv6:2001:16b8:488f:d900:6040:e108:8964:94c3? ([2001:16b8:488f:d900:6040:e108:8964:94c3])
        by smtp.gmail.com with ESMTPSA id g11sm12595514edt.88.2020.08.11.08.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 08:48:47 -0700 (PDT)
Subject: Re: [PATCH RFC V2 2/4] block: add a statistic table for io sector
To:     Aleksei Marov <alekseymmm@mail.ru>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
References: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
 <20200713211321.21123-3-guoqing.jiang@cloud.ionos.com>
 <d9c35f557772f97255e64d29172b57f7225d23ad.camel@mail.ru>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <46ed3e8f-6845-4e0a-a9b7-46562641e8d3@cloud.ionos.com>
Date:   Tue, 11 Aug 2020 17:48:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9c35f557772f97255e64d29172b57f7225d23ad.camel@mail.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/20 5:04 PM, Aleksei Marov wrote:
> Is it possible to collect the very same stats (distribution of sizes and
> distribution of lat) without having static maps in kernel but with eBPF tracing?
> Like using https://github.com/iovisor/bcc/tree/master/tools/
> * biolatency for lat distribution
> * bitesize for size distribution
> Please, have a look at these and similar tools (biolatpcts, biosnoop). Check the
> examples they have
> https://github.com/iovisor/bcc/blob/master/tools/bitesize_example.txt
> https://github.com/iovisor/bcc/blob/master/tools/biolatency_example.txt
> Let me know what is the difference comparing to your stats.

The difference is about the cost, please see the link.

https://marc.info/?l=linux-block&m=159458634517068&w=2

Thanks,
Guoqing
