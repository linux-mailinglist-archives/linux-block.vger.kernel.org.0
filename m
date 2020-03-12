Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23F841831C2
	for <lists+linux-block@lfdr.de>; Thu, 12 Mar 2020 14:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCLNkB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Mar 2020 09:40:01 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40331 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgCLNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:40:01 -0400
Received: by mail-il1-f195.google.com with SMTP id g6so5486805ilc.7
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jbi7C3dQMyYp0QOBoB5IQGdpuYGprgNV50S/E2bWnyI=;
        b=AnnSjWcZr8v2NKr0kc2K7TGSB3dyJ2Njx/OQ2Xq0jFemMrvU51+EB1O5TaRoyRwak/
         aSXkAOiNGcKFcNUq92NppuhbPF5+y5DWmwuH6mFYn9Re8RWJocYkilcawhiHbIeKBEpx
         z3KpBbJFhcmXv17DCy0Cqcs99HCo4Biq2tFrdPRsYUAS8nwLuehBMKq/FkPAOTS+/w5f
         ES7Dsdu4H+8B1eQam7saFUFEKHTCtmn1mkh5D9oHMusSgFT88/XOBKSA1auiviMPHcrF
         Sc0/30GYMUeLWNGuXs+GyXsggC0encE+5Q709RBunpqNyx/gS1m6Xwoogkw56KA8Jutg
         mHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jbi7C3dQMyYp0QOBoB5IQGdpuYGprgNV50S/E2bWnyI=;
        b=efW+NofLdC/hi9N4D3ubJBHr92ZpXVq12e22tuQDkLI/z9QjWfyJ4TY1P3sVtKcIS4
         kxCcXIbvCuIQJK/cQVnU7KknV5zZopeACsCDQZUy0ltIxCKwXbIKG5YRMRq5Rq1uT8iQ
         zOM9uQGLnFz7twpVyV1znRqf7citaYmC4j7zlCPZfrIvgyyJQqTpPZM/OdVKjBH0WWwY
         JKUbSnFtZkuzf8+zbGGS5S/D3aHTHet5SqQn4IMSXH3y71IICq4HPXInmCpYYhQmY4BL
         gIlmRBcB12AJ0P5tVxXjXQGjp3s7zjjtqUZTyILFZbxDg6lqwwQNnT6G1jqysQZT2MNv
         gIRw==
X-Gm-Message-State: ANhLgQ24zG1c1dwIJRWkSg6g/VyCE537BDyMhHJm9znynn0B0BH3nRby
        9I1Du9nQTiVCw/MESGnPdK1lsolYvmxpqA==
X-Google-Smtp-Source: ADFU+vt08cEgpjb+z6IN+PcuT7nK7Yegt+ChgNzYgyf1Z6aZ8lnMkEaHXp9AKDisWZXeuQzrlYQY/g==
X-Received: by 2002:a92:589a:: with SMTP id z26mr8769240ilf.19.1584020398394;
        Thu, 12 Mar 2020 06:39:58 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b19sm13392873ior.43.2020.03.12.06.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:39:58 -0700 (PDT)
Subject: Re: [PATCH] block: aoe: Use scnprintf() for avoiding potential buffer
 overflow
To:     Takashi Iwai <tiwai@suse.de>, Justin Sanders <justin@coraid.com>
Cc:     linux-block@vger.kernel.org
References: <20200311071258.4284-1-tiwai@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00fdb88a-c6f6-377b-f62b-f654170dc6d0@kernel.dk>
Date:   Thu, 12 Mar 2020 07:39:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311071258.4284-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/11/20 1:12 AM, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Applied for 5.7, thanks.

-- 
Jens Axboe

