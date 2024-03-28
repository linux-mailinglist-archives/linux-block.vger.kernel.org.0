Return-Path: <linux-block+bounces-4759-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE38881A13
	for <lists+linux-block@lfdr.de>; Thu, 21 Mar 2024 00:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD41C20EF7
	for <lists+linux-block@lfdr.de>; Wed, 20 Mar 2024 23:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7636BFDB;
	Wed, 20 Mar 2024 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwXzGZgt"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9712B7D
	for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975950; cv=none; b=K09FaklWBoZrTMFp5t1692EiVmmyUp89ogh66P1bVhabXlKErEb+tvsZ99dzJbPhqE1XDSikO9PH0VglvNlEHZ63X2m/Z0c2A1+bLr2E1Ufbl1R3/aslwPDY+Qdgo/04K0F+EQnqHqUFhbJaE09hTYfulk0Om+wPsfe56NhVE0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975950; c=relaxed/simple;
	bh=URyBNehh5FHPeA708CvC5QL2Y4pAndNBi/OFiiEv+is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et4whXCWuYftb9nuFi8eVsrAUpN6smemTzQBmTaTk1dwVxlWPb6s2sz9dYmdq+IoP2eJ05TP7jT75xUxuLuV2D1Gpk1KownF/yfxXGIDlIZfQAu5e/3N+OlL4UWb1wv4W/EObCscZ3Hm3JGncPv5kkslLi8dR1t6JFHBpfGTBrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwXzGZgt; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc236729a2bso313217276.0
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2024 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710975948; x=1711580748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5eTt7UUDllSUVmKD/yHguOkA5EaAJt6qoyfAGitCm0U=;
        b=OwXzGZgtDQ15N+go5OvQVpXddVg1UPjcvNlvNnX/nLo+Th+DxlK64hkX7SMnE5TMgV
         WpF9k33SW0thFiKJljenpROu1k84sdTXEHOeqdMeiESSeHY86BhrHEPN7FFDcq/iXXVL
         Kosf9awn4G4GLGe304omJvtlGMT9x7QxQLmwxtXblrqHoXL3eGoKPAXwQPfXXLe2xgsk
         cBDY9W9eiwLpnuF1TKzFwYt8sLv7uWkYrfWmOxf+GNYoxX//GZWN2vAZzWY5cq7nY4Ll
         wBSOICIYw4tudlIshgW8HYn4J9y6a8QvKICdjGQaEG4c5xpIqnb/y/c+1OTD6wVfUW/t
         8RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710975948; x=1711580748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eTt7UUDllSUVmKD/yHguOkA5EaAJt6qoyfAGitCm0U=;
        b=KEXVdVvpOaQnu8prGSdlJKAUXzk/aqa05Hku6/3XjSj+QXnO8SPvUznIb2y/Mb9PBU
         yYmf5UtPuqSPR7PQjC9RdETxhqL/Jk6piAj9nkrf3mWoNuDS+D+K8U2C8yt6wsMj+6Gq
         LDS13dQei7mdDAHyKPftkZlAh9xDRHLFmSeNLXmFE2ZUpi9WThogoSq0QFzes8p0C0eD
         HH5tSujmbTxRM2GCaY2rjcEcYE8dEE2+HeLUHwGUcJsulWY7lV3xlEnDVeGYJ9l3rS//
         7ANhF0FQdlsRliXc2QfRYHEkGbKtALwboW4Bh2W4ovkRImrMc1qD3h1srbZEZrWinB/Z
         CvNg==
X-Forwarded-Encrypted: i=1; AJvYcCW7yf74+uc42Z0TgG2W453H2A80nvDwxAryHxcFPKdfx2/kQXbnA0cSuT9Tkrr26YQ/+6rM9vcldr86E1fgfS9tTLCb0ebx2b7NAJU=
X-Gm-Message-State: AOJu0YzoBIp7WKVZ2gGSjInSGg3y5ZQOybjsYT6wuZperNm2wGtfjmLW
	z8XDz62RODeHEdaMdaA0LIFBtHpvp7iYGpiltMuCSKqejjY9BOBLj+Ht2l0d
X-Google-Smtp-Source: AGHT+IFQTPJqcPR8a0zg2ePxpabCXTVdgsEwrlCwy+wMkqfDQmLe97PK2YSs2eeIzJzJtO3puIfcDQ==
X-Received: by 2002:a05:6a21:9209:b0:1a3:4204:2529 with SMTP id tl9-20020a056a21920900b001a342042529mr20912400pzb.31.1710975577795;
        Wed, 20 Mar 2024 15:59:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902f68300b001dd9090a37bsm11946137plg.197.2024.03.20.15.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 15:59:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b61ce2b5-c291-4f99-a459-1f9a056ccca1@roeck-us.net>
Date: Wed, 20 Mar 2024 15:59:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/39] dm vdo: add the MurmurHash3 fast hashing
 algorithm
Content-Language: en-US
To: Matthew Sakai <msakai@redhat.com>, Kenneth Raeburn <raeburn@redhat.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org
References: <20231026214136.1067410-1-msakai@redhat.com>
 <20231026214136.1067410-3-msakai@redhat.com>
 <ea57f231-f78e-4a55-bf85-c5d50e17237e@roeck-us.net>
 <CAK1Ur38jAmWo35HTNrDDAaN5Awiie9wRiPDMVrNUg6+ZM8mJ7A@mail.gmail.com>
 <28a88525-6b06-4215-9e78-2b3d8c0d8657@roeck-us.net>
 <cee6169f-f635-e3fb-29a7-e68829cdf1db@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <cee6169f-f635-e3fb-29a7-e68829cdf1db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/24 14:44, Matthew Sakai wrote:
> 
> On 3/18/24 16:54, Guenter Roeck wrote:
>> On 3/18/24 13:37, Kenneth Raeburn wrote:
>>> (resend because of accidental HTML lossage)
>>>
>>> On Thu, Mar 14, 2024 at 7:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On sparc64, with gcc 11.4, the above code results in:
>>>>
>>>> ERROR: modpost: "__bswapdi2" [drivers/md/dm-vdo/dm-vdo.ko] undefined!
>>>>
>>>> Guenter
>>>
>>> Thanks for catching that. I don't think our team has any sparc
>>> machines readily available for testing.
>>> This is an artifact of our having imported user-mode code to use in
>>> the kernel. We should probably be using le64_to_cpup and friends, as
>>> we do elsewhere, so it doesn't try to pull in libgcc support routines.
>>>
>>
>> I am kind of getting wary about reporting such issues. Should I drop
>> building dm-vdo images for sparc ? Would it be possible to add
>> "depends on BROKEN if SPARC" configuration option to indicate that
>> the code isn't expected to be buildable on sparc, much less work ?
>>
>> Thanks,
>> Guenter
>>
> 
> Could you try out the patch I just sent to see if it fixes your build problem?
> 
Sure, will do.

Guenter



