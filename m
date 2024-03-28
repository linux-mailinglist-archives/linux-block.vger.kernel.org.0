Return-Path: <linux-block+bounces-4757-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76B881942
	for <lists+linux-block@lfdr.de>; Wed, 20 Mar 2024 22:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C11E1F214CD
	for <lists+linux-block@lfdr.de>; Wed, 20 Mar 2024 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3C85955;
	Wed, 20 Mar 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsYHLFVY"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2312B97
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710971089; cv=none; b=V2Io8WGsu6oa5oUFwoFSxpgg0lPiYhy+9a0qElNG/qO7fKaqLVIfVUYeu7oOZpi/M13eSodz+UdUNcXDC12l37UI+CONw3ZvpUzdeFOJYh9iIlsSAswWuJEFYPPS36MnKZ3+LaCKAIcEa0fdekxr+sz+lx6Qjj658a4eA11+p+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710971089; c=relaxed/simple;
	bh=z0NFGlaV5tIEpB4HlebxDCtYtKtcVNp96Ib+g8JphIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stEEUhkE75ZZ6rIb2FmeJ/uUjgKT9mHGd2be8Nw7WjhXio8brG+id63qlBXQ0dtBxEPzTjFju5riJYn8gD01MESvh2VmrGy7Qr3lQAWfNz7tj0C8Fi8R8sdrZj26+89abFDXs41g4LM57MABfLsnXep/8OBFp3++Nl/KJDnOM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsYHLFVY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710971086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zE1ffGdRT/wxohThmFP46bxQ8xBTgdpn15gU6MCDWs=;
	b=dsYHLFVYdDZqWrze9woTgVV9Yfs+kERUGENzltjsBL0oWDdX1X6o3Rqm7V3ev6/FFRUf1i
	rHZZbIoXnnd9WICrZIXIBaoTYfZ6bzMl19rQ8atyLMZolsY9XV7iUKPwQbpIL/nFrNZeb1
	b9Ncgg2wFoWLXhxFAO2PnGYlWPgWtss=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-WJir9G5wPqKxsN0lG7dFRw-1; Wed, 20 Mar 2024 17:44:45 -0400
X-MC-Unique: WJir9G5wPqKxsN0lG7dFRw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6958320e157so3969386d6.1
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 14:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710971084; x=1711575884;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9zE1ffGdRT/wxohThmFP46bxQ8xBTgdpn15gU6MCDWs=;
        b=lTfITO0l/J9JMKzxSBxHHuLGruAyDIjvNCquZNV9SB+caBC2xT+EKYxxLC+i3eMgAs
         YGhktMn7GD35cymeolsUsMDRFsAoB0qr35k+iqD/e4Ow/7NqGK5QAc3CZS+OqixVRRR2
         ULmbH0mAdRQfd+EuQNCMeU9YXE5+CbBTWB4O2ELwOXkvB6hVvTeGwXB2aK0LvHT2ax0M
         R0m+u3N8E6Y0le9pgzP1bBB1o7Ql7Sk2Pl3xSnkdik9AGH35HJGNPou2T5vITAb4LEn9
         zVx2NW7tFXVX01VRJEdP/y3ZcgWM3IP6+/2CE/A04SL0zptlG02RWt9qF7szhTVLuo69
         oH/w==
X-Forwarded-Encrypted: i=1; AJvYcCWiEeLpQHvPz2y8eheOsFXj5+o0y9JQSmCQ/f2lgQebNnNXM+dHhO6zBveLxI7/hjK8gt0dnh99m3hg+M5/7Ld/3rN2b340kFk9RFc=
X-Gm-Message-State: AOJu0Yw8hjhO10xEAwuwpIaCUtlsogME9tGkgg0mlg2LCYl30xuaK+jb
	jyZ1gyJPBzpTouLfQfa9Ml8PxERm2pYadwUZPVd+Xm+G6OSfZPjzqYCvnLiTRaTtTjf7/OmKhyo
	ai2BoY0I8kQk3febZ97Q6fFPbYTwIJtLnaFz6Us9QdoDQToh9NSTQ1T+4D1AapAFB/DZmaNs=
X-Received: by 2002:a05:6214:ccf:b0:690:bde1:ab85 with SMTP id 15-20020a0562140ccf00b00690bde1ab85mr84751qvx.50.1710971084575;
        Wed, 20 Mar 2024 14:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0PeKTXX7ttL8y1bFVmoRX8me9F2X6p93pvAZqvMgm2b3qfA7f6gvGdNqS3e0OOGHJdfNH9w==
X-Received: by 2002:a05:6214:ccf:b0:690:bde1:ab85 with SMTP id 15-20020a0562140ccf00b00690bde1ab85mr84736qvx.50.1710971084252;
        Wed, 20 Mar 2024 14:44:44 -0700 (PDT)
Received: from [192.168.1.164] ([70.22.187.239])
        by smtp.gmail.com with ESMTPSA id im6-20020a056214246600b0068fdb03a3a3sm8243841qvb.95.2024.03.20.14.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 14:44:43 -0700 (PDT)
Message-ID: <cee6169f-f635-e3fb-29a7-e68829cdf1db@redhat.com>
Date: Wed, 20 Mar 2024 17:44:43 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 02/39] dm vdo: add the MurmurHash3 fast hashing
 algorithm
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Kenneth Raeburn <raeburn@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org
References: <20231026214136.1067410-1-msakai@redhat.com>
 <20231026214136.1067410-3-msakai@redhat.com>
 <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
 <CAK1Ur38jAmWo35HTNrDDAaN5Awiie9wRiPDMVrNUg6+ZM8mJ7A@mail.gmail.com>
 <28a88525-6b06-4215-9e78-2b3d8c0d8657@roeck-us.net>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <28a88525-6b06-4215-9e78-2b3d8c0d8657@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/18/24 16:54, Guenter Roeck wrote:
> On 3/18/24 13:37, Kenneth Raeburn wrote:
>> (resend because of accidental HTML lossage)
>>
>> On Thu, Mar 14, 2024 at 7:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On sparc64, with gcc 11.4, the above code results in:
>>>
>>> ERROR: modpost: "__bswapdi2" [drivers/md/dm-vdo/dm-vdo.ko] undefined!
>>>
>>> Guenter
>>
>> Thanks for catching that. I don't think our team has any sparc
>> machines readily available for testing.
>> This is an artifact of our having imported user-mode code to use in
>> the kernel. We should probably be using le64_to_cpup and friends, as
>> we do elsewhere, so it doesn't try to pull in libgcc support routines.
>>
> 
> I am kind of getting wary about reporting such issues. Should I drop
> building dm-vdo images for sparc ? Would it be possible to add
> "depends on BROKEN if SPARC" configuration option to indicate that
> the code isn't expected to be buildable on sparc, much less work ?
> 
> Thanks,
> Guenter
> 

Could you try out the patch I just sent to see if it fixes your build 
problem?

Matt


