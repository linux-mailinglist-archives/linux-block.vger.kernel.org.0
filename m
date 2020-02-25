Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8154316EBA6
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2020 17:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgBYQnx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Feb 2020 11:43:53 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39085 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgBYQnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 11:43:53 -0500
Received: by mail-il1-f193.google.com with SMTP id w69so56374ilk.6
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2020 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ptuBikuvx1n72b69f5GFtZDCaDnREx2JRheiA6ifZ/E=;
        b=Es0Ai5yjDOXrynnmjpTZm0+Anp7kBXgBGQIVFpzx37hZepTbICkrUSYrkPuYBz6rbG
         UHSy7Ksm8jQU2QzexYbRyPAtMSPheLGmVn8lruBifATHnpmsHwPGUM9fQiv5lRMrknUl
         WiwrgrUkMSOZkD5iNTEZ8A+4vkEKdKdUSaVpzCYs/caEFIuzxSBfwnvh+IMF72dhdleU
         8RiVnjvxWx5WK0yD4WSfzzLbLLLVuDC0YGvkl/H31DlBD0IXMjXYRO/u7aR1nCCwlTH1
         foKxJEluiuSl7WqTSEhDzy/MsodVN8MoMnp7BV2sTxcCj36767ht94/FbLiCRAATqQqA
         28iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ptuBikuvx1n72b69f5GFtZDCaDnREx2JRheiA6ifZ/E=;
        b=obIMO7m8BE94BzB9OxI0vhPYAJjl9n1d27W8C8QPXdJn31ZmPUYo/eft/19Fhw80Fo
         OcjZwawZu+wrMJPMs4uH9D/+vsxMWbp8olrBWPq4LLKAMMwGcphYWKgV9mbmNxIBrlRp
         Na3CsphFdbZFAWm68LfDX6fYC0VEBvySGwmYnb70ezKvU1OewlJPG2cgFqSDQxdfhPXS
         HDxNXI36hCABGSQF5yXC2+OBUv+ZA9C0a8veA+owpXIAVHV+zyumFFTzshZfI952OKfB
         L3vR8Rg8KdjCAPqrd0ieRpGrmS7ZgK9YhmXOqEcSTQW1I7wTDBpOvZ5Xrv4XDaTUFvnI
         d1GQ==
X-Gm-Message-State: APjAAAXvnxOOTE6xnyVhVLMF1bm0tEXKZiBQ1Q+eM/iKeYBpQ0b7HLO8
        sG+9YpCZcdCRkUniNSl2d+Cz/g==
X-Google-Smtp-Source: APXvYqxBKxRpHZ4VWxYc/SOhkA9+f1ToPdotu/ruZ4hbpJVvIQrAiXadwkKdiQKUnnEAKvTxmzC5eg==
X-Received: by 2002:a92:405a:: with SMTP id n87mr67309416ila.299.1582649032564;
        Tue, 25 Feb 2020 08:43:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z8sm5632654ilk.9.2020.02.25.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 08:43:52 -0800 (PST)
Subject: Re: [PATCH v2 1/1] null_blk: remove unused fields in 'nullb_cmd'
To:     Dongli Zhang <dongli.zhang@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200224183911.22403-1-dongli.zhang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ad83d8c0-4d3d-6cec-3e5a-70be9505c15b@kernel.dk>
Date:   Tue, 25 Feb 2020 09:43:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224183911.22403-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/20 11:39 AM, Dongli Zhang wrote:
> 'list', 'll_list' and 'csd' are no longer used.
> 
> The 'list' is not used since it was introduced by commit f2298c0403b0
> ("null_blk: multi queue aware block test driver").
> 
> The 'll_list' is no longer used since commit 3c395a969acc ("null_blk: set a
> separate timer for each command").
> 
> The 'csd' is no longer used since commit ce2c350b2cfe ("null_blk: use
> blk_complete_request and blk_mq_complete_request").

Applied, thanks.

-- 
Jens Axboe

