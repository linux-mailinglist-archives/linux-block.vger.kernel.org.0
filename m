Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A749C196E50
	for <lists+linux-block@lfdr.de>; Sun, 29 Mar 2020 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgC2QJA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Mar 2020 12:09:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43818 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgC2QJA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 12:09:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id u12so7446747pgb.10
        for <linux-block@vger.kernel.org>; Sun, 29 Mar 2020 09:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xUjMfxIIS1iKsG6HzgG+NxuJGhknMOExVgFkzh/o9+M=;
        b=vUX2rCihEDSjZvozJWYx9lAuzBHv6HukM/rN7Tlw4rFigiU920eu5sH5yKViDtv3Mr
         4lvxBQ0tkNi7tEws1cTBSJYyBqqbwEiVrrSFSyDZQ0cU77p5Gmq0lkaYZkZ5cmBiw2x8
         8k5WAnfpZU/DfaeLEI3tQWPIJ69rHN1eEKi9XWCEyfGvEW4YEAbbZvUGDk9w3VP3vQ0b
         KtTGfY/4emJxqGDsPH+v731MwMbEcVYq9plLEok/lAgs0VM3ln06W3LbxMxZaj58Oc1t
         8XATtz/vRK5hjBC6Az3C0CFY2FTF13XCrREDktlG4hFXB3SIRMI8IE6OMNjgnsQ0jZTM
         QDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xUjMfxIIS1iKsG6HzgG+NxuJGhknMOExVgFkzh/o9+M=;
        b=mZ8tP267MzNfrE9yuQivbRbrPxWY7zXohxmh9SkoSAvB1wEi0X++IyY4FgXIDYs3PE
         eHxrs89OlhdOuhfrKxPXOSh1mjxS53NxN0/UbysWXSBmryrdIvit523Q8HTVo5I9eKax
         2VCvSTwYZreW76y19SUa+AgrjaJ0ADAi1oihQG/XaA5k+/vSiUU9HgIAJfx+1me3QO2u
         cr9+iz3xJOyIEa/lhUIkVYlIBd97G3sSNkb1psZUTJlMM+FuSRatieSg6InKbqJ/npWN
         /8TlZ8G2W9JeX5OswOo873v5712Hu2N6mkOqgeaQM2gWhj6xEAlQsLrRjqOXVu6bh/+8
         y06g==
X-Gm-Message-State: ANhLgQ3yvxuvtRB1Offv9AMhYJpsooAvIBiSdhBW9wJWaiDu/EPB1T1c
        ER4HC/CHo5cpdajJ4DP5Yr28eWOBi13ZQQ==
X-Google-Smtp-Source: ADFU+vuvEI/ydFfe4K0nqJdIBq6KZvUASEdwWqAegJqJ8yj2+hZKh4B6X9IU2uxUkKawCrVeiWj4kQ==
X-Received: by 2002:a62:76d1:: with SMTP id r200mr9160394pfc.298.1585498138961;
        Sun, 29 Mar 2020 09:08:58 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id e26sm8322607pfj.61.2020.03.29.09.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 09:08:58 -0700 (PDT)
Subject: Re: [PATCH] block: return NULL in blk_alloc_queue() on error
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de
References: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <86a32268-be6f-9f4c-fe3e-1357ff0e0c50@kernel.dk>
Date:   Sun, 29 Mar 2020 10:08:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/28/20 12:27 PM, Chaitanya Kulkarni wrote:
> This patch fixes follwoing warning:
> 
> block/blk-core.c: In function ‘blk_alloc_queue’:
> block/blk-core.c:558:10: warning: returning ‘int’ from a function with return type ‘struct request_queue *’ makes pointer from integer without a cast [-Wint-conversion]
>    return -EINVAL;

Applied, thanks.

-- 
Jens Axboe

