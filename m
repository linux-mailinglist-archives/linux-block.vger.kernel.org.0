Return-Path: <linux-block+bounces-404-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26C7F688A
	for <lists+linux-block@lfdr.de>; Thu, 23 Nov 2023 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A197281671
	for <lists+linux-block@lfdr.de>; Thu, 23 Nov 2023 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01811C81;
	Thu, 23 Nov 2023 20:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0q3BIvit"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D60D5C
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:48:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2800db61af7so313855a91.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700772524; x=1701377324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ceLgR/SOfAukbOIDzDVDS1fjNFjDuiUm7tXHvXYzZ0Q=;
        b=0q3BIvitmUa5kXIPajUJPsfYffHnSC00Q3uiiFITLS39Xgi3dFafrr4ZfyaMl2nXJG
         hOionDE4gN6ppZMKoB6GrSVL/oxR04S+GqOmX8qezvn/yTXX+AsptNItOrDDxMpfllwc
         pYtJfkPFQ00r75F5DhkcNthcMYUfyJt73JdjfzSoSB9rI1uUBhuVP8MFGE92mgCEnJ/c
         I/AxDzn2iC6tsFHB9QpP7gY0q/QSpRYbOUKEhLNNPKoVQzk+N+z8ejOl2R6O/2S6rk83
         5VrWefDTTQoNwUxSNn5JEsfWBMAjz+jLyV2UkmVXQVGVcaBZIGamRr2HRfmjg8HoMHmT
         ULyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700772524; x=1701377324;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ceLgR/SOfAukbOIDzDVDS1fjNFjDuiUm7tXHvXYzZ0Q=;
        b=BK2EmuZYO5u6fNTqxiMRa+pVzV/LDmJnDmcUz6RbJH9Ggkb/ctxPFjNrXVKtzhemSv
         mqsdmKTUUTHt9FstOttlrjAlAYJAZIOpLxw1j0sdZS12GA4PCpgNzcZbuR6DqVB9XUUT
         D/ciK3cw87g1GZyzztTXqK4l9YJ33/AJrScvIqVY+2RF1wZO+JP6L0hMMXFBlVpoq/Zk
         nAuMblYZBRxo3hsa0z0QCtv/zlTZ0h4/MmXdYSkebEvD7BJx6WSHIP3yNvYgnV2u7bRQ
         bixtllVpujb85LKXrEYpZ8H/nXzTu/hnnEypnpzu/bxSd+JKhmlrntxOxH4BQZy0ukHH
         T6Fg==
X-Gm-Message-State: AOJu0Yz2laHIXnIpSK/thMxDt8V6oAt3THcn/4ZNeDth+0lFQtGxU4Qv
	5OOqa66ukzaWMT+90hm/ZeNY2Q==
X-Google-Smtp-Source: AGHT+IGd2LI4jFXs3yKxun2LPUQQgiej77EZdosL+JnLqKhPimLr3PkHL7izRbtRC+5Xi4DBEbn5rw==
X-Received: by 2002:a05:6a00:194c:b0:6cb:7b09:9989 with SMTP id s12-20020a056a00194c00b006cb7b099989mr707065pfk.3.1700772524189;
        Thu, 23 Nov 2023 12:48:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fd39-20020a056a002ea700b006cb7b0c2503sm1659751pfb.95.2023.11.23.12.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:48:43 -0800 (PST)
Message-ID: <ecc3f0f6-4d9a-47d1-8fdc-e517a8c7bf14@kernel.dk>
Date: Thu, 23 Nov 2023 13:48:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 0/2] Misc patches for RNBD
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Haris Iqbal <haris.iqbal@ionos.com>, linux-block@vger.kernel.org
Cc: hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
 jinpu.wang@ionos.com
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
 <CAJpMwyh-24qFt4U1L2Ki270oWis-GUBLRQVC+Lf4cG7EumkpPw@mail.gmail.com>
 <a27b66a6-7d3b-42f4-b25f-1dffc0d33a83@kernel.dk>
In-Reply-To: <a27b66a6-7d3b-42f4-b25f-1dffc0d33a83@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 1:47 PM, Jens Axboe wrote:
> On 11/22/23 7:52 AM, Haris Iqbal wrote:
>> On Wed, Nov 15, 2023 at 5:37?PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>>>
>>> Hi Jens,
>>>
>>> Please consider to include following changes to the next merge window.
>>>
>>> Santosh Pradhan (1):
>>>   block/rnbd: add support for REQ_OP_WRITE_ZEROES
>>>
>>> Supriti Singh (1):
>>>   block/rnbd: use %pe to print errors
>>>
>>>  drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
>>>  drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
>>>  drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
>>>  3 files changed, 31 insertions(+), 21 deletions(-)
>>>
>>> --
>>> 2.25.1
>>
>> Gentle ping.
> 
> I'll queue them up now, but won't get pushed out post -rc3 to avoid too
> many conflicts on the block side.

Well maybe resend them first, patch 2 doesn't even apply to the current
branch.

-- 
Jens Axboe



