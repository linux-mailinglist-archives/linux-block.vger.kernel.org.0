Return-Path: <linux-block+bounces-229-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE17EE2BF
	for <lists+linux-block@lfdr.de>; Thu, 16 Nov 2023 15:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F185A1C209B0
	for <lists+linux-block@lfdr.de>; Thu, 16 Nov 2023 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21592CCD1;
	Thu, 16 Nov 2023 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J23K/T8Z"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E714FC4
	for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 06:28:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so12469281fa.0
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2023 06:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700144880; x=1700749680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDPytPlbuIEdji7bPqJ82gOdsYtvnEt3H5aB60qX2ug=;
        b=J23K/T8ZTfJ/uB4teYgegdJyrGFWx4j0sJZbtjRJUCDUa4zuJ52ZAHeQcR1brROMuX
         XIp2Q706BzFvRW1RPVoZbWF0e68pVibHXO0GXW+1X34assG/EHHJ43TJt3Jn8z9v8uEO
         d1T6epAKzTU7F+AvdWrGJdn2a17W4YnAMR0X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700144880; x=1700749680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aDPytPlbuIEdji7bPqJ82gOdsYtvnEt3H5aB60qX2ug=;
        b=k3qXpihLjycjDaOiSs5cdj9rysJuWWHM4F3IxEZivdbljfeGPXNqHqnHL+ZLAJxEVZ
         JVJ3rNrct0NF3fVvE053aR5wgXhMfnkaMDRRAPgr1i9BJcewLhKvxOWfoJaSAepd5Nbl
         mXAyx+QCM/bRPXgCTBO8VfGAZKHfUHbxCFMJLUkGYTvsUBhV+X1LOWAz66YsE0pwF9BM
         SLO+kszO8TEK8f9pvyGoHpaCviy7ag6sX9obnJgmlJrkBtJXjT2mvy43Hg/Pc+m68oX3
         iVEgyrWpHm+OgUQ9zaSLrD1BLi4ADUGbPDaisq7z/H0sIF/cKuWRZqVN0CpJadMe7820
         AnXg==
X-Gm-Message-State: AOJu0YzLsUmiamX2sa218kvsB0/AwacrsK+LS1La2NnzvoCaTYMztgGt
	2HOkefG04ZJywykgwb2scwduJ35UGzy5IFwReJwQvQ==
X-Google-Smtp-Source: AGHT+IE/ew6Hf3Z3kZzg6snnlz/vavoOHGrBGLpq9xqkFt59qx6B7d8JQQlnRfMZ6D9GnFQfmA9Rgw==
X-Received: by 2002:a05:6512:20d3:b0:503:653:5711 with SMTP id u19-20020a05651220d300b0050306535711mr8910493lfr.9.1700144879924;
        Thu, 16 Nov 2023 06:27:59 -0800 (PST)
Received: from [10.43.1.246] ([83.142.187.84])
        by smtp.gmail.com with ESMTPSA id e13-20020ac2546d000000b0050914b41f41sm12181lfn.88.2023.11.16.06.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:27:59 -0800 (PST)
Message-ID: <e8fc0801-359a-495d-bad5-c550105ddfa1@chromium.org>
Date: Thu, 16 Nov 2023 15:27:58 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] zram: split memory-tracking and ac-time tracking
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org
References: <20231115024223.4133148-1-senozhatsky@chromium.org>
From: Dmytro Maluka <dmaluka@chromium.org>
In-Reply-To: <20231115024223.4133148-1-senozhatsky@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/23 03:42, Sergey Senozhatsky wrote:
> @@ -293,8 +301,9 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
>  		zram_slot_lock(zram, index);
>  		if (zram_allocated(zram, index) &&
>  				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> -#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> -			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
> +#ifdef ZRAM_TRACK_ENTRY_ACTIME

CONFIG_ZRAM_TRACK_ENTRY_ACTIME?

> +			is_idle = !cutoff || ktime_after(cutoff,
> +							 zram->table[index].ac_time);
>  #endif
>  			if (is_idle)
>  				zram_set_flag(zram, index, ZRAM_IDLE);

