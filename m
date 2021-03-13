Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63ED339B94
	for <lists+linux-block@lfdr.de>; Sat, 13 Mar 2021 04:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhCMDhu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Mar 2021 22:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhCMDhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Mar 2021 22:37:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557BFC061762
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 19:37:25 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso11991956pjb.3
        for <linux-block@vger.kernel.org>; Fri, 12 Mar 2021 19:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CBNgQRKeBzdDifSEOgKTaiLunUuYSZ8882u6ppXU5+U=;
        b=eSqXv0ctfLqgigrMQ8PF9EWZOhecpDPODocztQkLMOQ9YOXCKxb6aGcV0SRFdGr9O/
         SXAjhD1m4PZ2QeA9AwCL6vq4XZQZmY51dZDRKQwIU6B5X1V8i43Wcr1eTiYFEy5GkbB7
         kxv7AI1W4IvaKAO8GXohAheVSCtalgLMdOlZUIIK4moC9F2R653fNXf0U4PRnDoC84HG
         JZRfjM1tgk/7SSX1LoxK7Sd6fP+7xCV3b9JRSbzKaM6zIHvtBfN2+OpqOGLfmNCv8hwp
         Z34rYUhez5+AFzOFoTMVxrKfhPizb9woR1sPWIEa5uCOST00D5h/UDN89crL5p23cZI1
         hfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CBNgQRKeBzdDifSEOgKTaiLunUuYSZ8882u6ppXU5+U=;
        b=fJe85IlT/LelwQ/y2dBPeVqwejmJI5mE6Wim8bsxXPxgZ72kcst3bDGlp/R1urQiyE
         f8a3CWkqTuFWmXt+S15KvXesTmeJiCB9rWm3nvlGl9VuXNkx820BfFSDhOJiR0DYQ4uX
         8c3Y75/HFE89/yByr+w4Ur3scQCak1+P1tqYT2sOGShtqKpabsbdeLOJp1S7F6Uicn6Q
         f+cTRn6tanurNGeFUV4ZqenMbXGwfH2G/i8SZOQotxb5gotjYsjdXqmEosylBsRNVoyo
         PUyLJItLPMp7fe7lQPZaYX1XbmxM3FBFyEX9gnWgLmIPAEk0tZwwfNgw13axDuVsCClv
         Ey+A==
X-Gm-Message-State: AOAM530Jb0GHd8awriFEudTCg0eT5nx6WlV7ub414jM1S/gEcAH+b0uM
        WqJIeUhbCWXUAERhSw4Lbvb79A==
X-Google-Smtp-Source: ABdhPJwMgcLJD1SGGsLHCeRLzP10AkhbPEX9/l2NI2H9kx1l/lAMuKameOG8HK5rfGwY4CWLZuEjuA==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr1513866pjb.55.1615606639689;
        Fri, 12 Mar 2021 19:37:19 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j23sm6881761pfn.94.2021.03.12.19.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 19:37:19 -0800 (PST)
Subject: Re: [RFC PATCH 0/3] block_dump: remove block dump
To:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        jack@suse.cz
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, hch@infradead.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <15f9c6ce-f22a-59cd-8ce7-eb908f663826@kernel.dk>
Date:   Fri, 12 Mar 2021 20:37:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210313030146.2882027-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/21 8:01 PM, zhangyi (F) wrote:
> Hi,
> 
> block_dump is an old debugging interface and can be replaced by
> tracepoints, and we also found a deadlock issue relate to it[1]. As Jan
> suggested, this patch set delete the whole block_dump feature, we can
> use tracepoints to get the similar information. If someone still using
> this feature cannot switch to use tracepoints or any other suggestions,
> please let us know.

Totally agree, that's long overdue. The feature is no longer useful
and has been deprecated by much better methods. Unless anyone objects,
I'll queue this up for 5.13.

-- 
Jens Axboe

