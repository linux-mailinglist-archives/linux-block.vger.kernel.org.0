Return-Path: <linux-block+bounces-647-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 906BC801D6D
	for <lists+linux-block@lfdr.de>; Sat,  2 Dec 2023 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD3A1F211CC
	for <lists+linux-block@lfdr.de>; Sat,  2 Dec 2023 14:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C95D310;
	Sat,  2 Dec 2023 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dxC8V38i"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE62FA
	for <linux-block@vger.kernel.org>; Sat,  2 Dec 2023 06:58:34 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d072f50a44so1745245ad.0
        for <linux-block@vger.kernel.org>; Sat, 02 Dec 2023 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701529113; x=1702133913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XW1UgdrkcqxXWOvmhkp24/Qp8+IcQ4Iq6pEPuTKK3Ww=;
        b=dxC8V38imb/+a0etNuQIX8U5esj6IwLxktmTJ5n1nFq0V0pM8VA98Js8x5QqvKzutE
         V3Nca2wBqvuArDsfcyZ8MEPWDgnLGlTd633Xuo8Vk4QghRf4Ym/t2PAN8s/Gx1IrxWVr
         zV1zt7dZddU5KTAgRxDMYqONCKGPV4ySlRFvLgaoxZOLPYFfFnUI63tGffru8lUIS0J7
         m2d/LO1DGKxUn4NrTOgtsX39yeKgisZ6zXB30bFVc56kI/44RFfl29IPQcdke2XnckxI
         n30ea8CA0iK2i9mUqvlr6VHYbVajrO0YExHhQfgC0Bb7LHcmxuBaTNR4kdEkNa8u1lTj
         DI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701529113; x=1702133913;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW1UgdrkcqxXWOvmhkp24/Qp8+IcQ4Iq6pEPuTKK3Ww=;
        b=RHl++OFDTF6oUsUDOH40jAzFMBMpVw70UKaFYz++ynfHjZ14NQHII+aNjWkG1137ip
         nVDIGWJDTqtA2Dhh5rjMwQBKDPdgum4eDw5Fgh63vWe5pDPyUFMAsQl/krpvIriOFYiF
         zSJmBkVyMA9cWw9uBKmtROT0CKBM8b0/DcdarGpxuWi0tv4M9ED5Rfn5JYXbdeaQ2N/r
         X4TCWPQTHGwQghSAZdBQnVhn+gRXLzzRiFSFHxtPhrPi+xH4MMULE+SXiYFk/v1vUMPX
         izlOnjnMzbUcezSuBIod9dAnNvc/f2Y1HwDgzRRxLRwZqIizX1V9bfxZqQ8S1BIPS5w9
         7dOQ==
X-Gm-Message-State: AOJu0YwD9gKbzAsqsiOVnLLsnfpdYpMUHSCQQbZ99wzq7QzB93eR2meg
	XvjSsJ05/DCRUkxNG5YCOJ/PDw==
X-Google-Smtp-Source: AGHT+IEdYA1zBSx0/GweJouqcxEpYNoCqs4MttA1Lpvc82tGgIMit/GYbebWL74MRUmEp33KNYAP4g==
X-Received: by 2002:a05:6a20:72a3:b0:18b:fece:ff60 with SMTP id o35-20020a056a2072a300b0018bfeceff60mr31298181pzk.1.1701529113460;
        Sat, 02 Dec 2023 06:58:33 -0800 (PST)
Received: from [10.0.0.185] (50-255-6-74-static.hfc.comcastbusiness.net. [50.255.6.74])
        by smtp.gmail.com with ESMTPSA id s5-20020a17090aad8500b002853349e490sm6784095pjq.34.2023.12.02.06.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 06:58:32 -0800 (PST)
Message-ID: <f04ad3dd-05a1-4cef-b837-9c51a18fdc7c@kernel.dk>
Date: Sat, 2 Dec 2023 07:58:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/4] block integrity: directly map user space addresses
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, io-uring@vger.kernel.org, hch@lst.de,
 martin.petersen@oracle.com, ming.lei@redhat.com
References: <CGME20231130215715epcas5p33208ca14e69a68402c04e5c743135e6c@epcas5p3.samsung.com>
 <20231130215309.2923568-1-kbusch@meta.com>
 <e3c2d527-3927-7efe-a61f-ff7e5af95d83@samsung.com>
 <ZWopLQWBIUGBad3z@kbusch-mbp> <ZWpjBCF4KueqKlPN@kbusch-mbp>
 <ac5e99c6-7297-4c56-8f3c-98755c58092b@kernel.dk>
 <2fe7b3e3-3481-3a67-88f8-13e47ceba545@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2fe7b3e3-3481-3a67-88f8-13e47ceba545@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/23 7:04 PM, Kanchan Joshi wrote:
> On 12/2/2023 7:01 AM, Jens Axboe wrote:
>>> Jens already applied the latest series for the next merge. We can append
>>> this or fold atop, or back it out and we can rework it for another
>>> version. No rush; for your patch:
>> I folded this into the original to avoid the breakage, even if it wasn't
>> a huge concern for this particular issue. But it's close enough to
>> merging, figured we may as well do that rather than have a fixup patch.
>>
>> Please check the end result, both for-next and for-6.8/block are updated
>> now.
> 
> Looks good to me.
> May not matter now, so a symbolic
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

It still matters imho, because this thread is linked in the commit. So
even for the cases where I don't amend a commit to insert reviewed-bu
etc, I still think it's nice to have in the linked thread.

Ditto for the fixup - it's referenced in the original commit, and the
link will show you what that fixup was.

-- 
Jens Axboe


