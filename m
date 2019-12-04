Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55E112F7E
	for <lists+linux-block@lfdr.de>; Wed,  4 Dec 2019 17:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfLDQE5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Dec 2019 11:04:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37477 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDQE5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 11:04:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so3349149plb.4
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2019 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUmM41vBsk28CMO+iqcQTf7E8TWP0a/rIFV5hyHrpYc=;
        b=CNmlvyrDREwGHq9667dRSk28gWzPY0XdlVlF9ehNpEY7n48n5t5mZgmDzfcoregDlY
         vw0De5QdnU28bKfCL30ikc8vjk14bxg6ERgN94Mh+cF6I+cSck3qrwGNfxs/w2iw5wlc
         EiS/JwxOe1LbYt+lNgYQRhWT1hsSnY6ForLPnEyrSaOfd9Am0d6LcM9kGkK+RNwsEtqS
         TroDf9Q88GktiI4/2RD4GKK/mC21xW2dryp5n11uc5TViKOjbi/mIKgGZ9HP5/s1OS6I
         N+M9jrUTXdqIQNHe+v+cZI61EGase44hYPJLqfQXsXMCCK82xpCaPEG4DZhQOHIBb9IC
         /zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUmM41vBsk28CMO+iqcQTf7E8TWP0a/rIFV5hyHrpYc=;
        b=MMihPFulpKvzDE69Dn5P77nqyWTPR5DyJScy8RYsCoxm760lGQk2AnZvUnpntR7z/W
         lIO5wFRMaq8y5Jl298KoJoLKUgHSoBBiST62cHaeEtjGQETSTvpVaGbrT0ejOI9GFqnd
         lVBtwCKgfSkE6RvMpQ7En91W/NBMJVCyXPCCmU53IX9bgU+dA2h/8UhlU+FSwmmBd+F4
         ZudcKXqGzqe/EuWo+bKiuxNKxGqGeEeAVcYZBz1CAWkCx1hJ7Af4MinxLAimPjaROc6E
         gOVyeNTCNijD3u0pSSdZ7y5si4P5veAZVZShFDvWUp1p7dQcolx9gzvreNWhjXosJezm
         JoUw==
X-Gm-Message-State: APjAAAUFtR3rMmjVqi/4amfmhqki2Gl2sMINjoUVlPIgGF+HQGIu+w83
        pE2XTg71HU57LDOhLyyW8VoILQ==
X-Google-Smtp-Source: APXvYqzBmsUhdS6PBPKxFK3a3wN7YmbMziPl31IFdWAeqk01ukjRhCh60t9+/NPcDGH/K6wa8mK0bA==
X-Received: by 2002:a17:90a:374b:: with SMTP id u69mr3989804pjb.23.1575475496707;
        Wed, 04 Dec 2019 08:04:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m7sm9131001pfb.153.2019.12.04.08.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 08:04:55 -0800 (PST)
Subject: Re: [PATCH 0/2] brd: remove max_hw_sectors limit and warn on
 un-aligned buffer
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Stephen Rust <srust@blockbridge.com>
References: <20191204113115.17818-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <36d33c98-6812-2c09-d89e-ef74fd79f216@kernel.dk>
Date:   Wed, 4 Dec 2019 09:04:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191204113115.17818-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/19 4:31 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes max_hw_sectors queue limit.
> 
> The 2nd one adds warning on un-aligned buffer.
> 
> 
> Ming Lei (2):
>    brd: remove max_hw_sectors queue limit
>    brd: warn on un-aligned buffer
> 
>   drivers/block/brd.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Cc: Stephen Rust <srust@blockbridge.com>

Applied, thanks Ming.

-- 
Jens Axboe

