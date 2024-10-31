Return-Path: <linux-block+bounces-13370-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB08B9B7CDA
	for <lists+linux-block@lfdr.de>; Thu, 31 Oct 2024 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1982E1C20AF6
	for <lists+linux-block@lfdr.de>; Thu, 31 Oct 2024 14:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AA619D07A;
	Thu, 31 Oct 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b50TbWbQ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D99385626
	for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384984; cv=none; b=VWMt2iis1CKRCvUExbLRZmspkFTRlYsL3vk+ERA36EPo2nQZHMQGJ9oW4LzJHJJit730ejy5vArOqU37bkN9woewRDCpLtPWzsJaqfZnQTthbB8unfMg4p97RaqkDQ5eHRHVsXWH+HwoKurJGBNnknbH9gvb/K4tgJFXkK0UJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384984; c=relaxed/simple;
	bh=u49cSX7b3/fFHX0ON/gf8wOYpcDLKuYCEEfD60UdoN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaBcO+L+cPGGmgVJNlSkk77u3tYkKP0iz5wQZK7/9G2q1im58wgoAvt0UbNcQaLySU97k7MxxKSeriRGQbrfXoLWMpouodTqZCSZeRi9Udcsa2q/1IPQa6hUjGo9bntfop09Optap27VLpaClE88c9LyIYsjC3Tg0755LX9rl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b50TbWbQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a4e5e57678so6879045ab.1
        for <linux-block@vger.kernel.org>; Thu, 31 Oct 2024 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730384979; x=1730989779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/yJrkIz9aRWJ1NBwFDDR53OmdsMlkLPtq2UKdxiMe4=;
        b=b50TbWbQ4bs6Fumi2deiDHrC9f0dIrvohz/fzlsAPhJhsigtY4q7n3GeDT4ZlbxbIl
         qV1/f1KOMSkgcnlxTXtTpPs3I4PbNqsqlFyBe+6IpTCHJQvQn1Nik6z6hyrjJgOirAiK
         8WCMulXMhuGzISAq+aL5BFbEJTG4HFrts6IoK+Qq/rS13LJ6KRVDTX/AbQxTBl9AV9Wb
         Qra39Rk/8+WVGKl/+lugrSKgmus3iO0f0sANHHSjui7JEEY895KQDe0YUhT46hdfv61V
         curW/yd6M2Au3xBOVU7d+9hnLyrMz5QTRu+SdOtC06Tv3FcTG+lXwoPqNPtH0DWbX8/d
         +HWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730384979; x=1730989779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/yJrkIz9aRWJ1NBwFDDR53OmdsMlkLPtq2UKdxiMe4=;
        b=WcVCCarJs10fevcLMRBLGVM58Qxdf13fhN3S215P1OHAnFy/0TWHsU3zCWs78gnOBM
         98LD+vT1lGTo4ACUdZD5yoUuWaSxf95s2+XrLKK782RyCIrTdAim/HLPwJ8nFU1mot0o
         qcdzen5Cwo/EI88yMALyrGYjJhPlh5eA4MRvpiEfiqNQIdY+Arc9KX2HzJWiKX9cBW/l
         +rxV5x40nfWsx+yRgDusAbNXC8mO8eAcjTMhx42Ujnw8Uvt1MDn1emthGjyA9LQjwpFN
         2JUnbx4hPr0oZxE0vnriVuPQ+Mb3mYzWqGhTH6B/Mmp7IkmKX2gBYpJqTsx315QIHjZ8
         HOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU28QlrCSm7Iy6B6tlRKyvHt7I+oMMmQTYFx23h+v9LKRnIPD4Xf1fjN2ISH3avHaMbAohPTYbGi7EsiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDus5FNLvhEf0mLhABSP0Z1BzacKbAnaEVQGaGGdI4Uz33jegE
	Gwgv0QQ1rAWfPi3Je7Ff2IlisvWCSBexNfGWS+RBgAsGA5uuV2GuXJhK9wSItZg=
X-Google-Smtp-Source: AGHT+IEpAXM4zy/1xQJVmdTL+LcbKfqknXbWPFfmBryc11Za5cHufm58HRrOEjZRsahSRhjJNDYbGQ==
X-Received: by 2002:a05:6e02:1387:b0:3a0:c8b8:1b0f with SMTP id e9e14a558f8ab-3a6afeb07f8mr2034165ab.2.1730384979224;
        Thu, 31 Oct 2024 07:29:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de0497794asm313429173.88.2024.10.31.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 07:29:38 -0700 (PDT)
Message-ID: <6e6893cd-890d-46b0-9164-01801a4145bc@kernel.dk>
Date: Thu, 31 Oct 2024 08:29:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
 <d859c85c-b7bf-4673-8c77-9d7113f19dbb@kernel.dk>
 <bc44d3c0-41e8-425c-957f-bad70aedcc50@kernel.dk>
 <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
 <f51e50c8-271e-49b6-b3e1-a63bf61d7451@kernel.dk> <ZyGT3h5jNsKB0mrZ@fedora>
 <674e8c3c-1f2c-464a-ad59-da3d00104383@kernel.dk>
 <1f40a907-9c53-408d-997e-da49e5751c66@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1f40a907-9c53-408d-997e-da49e5751c66@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 7:25 AM, Pavel Begunkov wrote:
> On 10/30/24 02:43, Jens Axboe wrote:
>> On 10/29/24 8:03 PM, Ming Lei wrote:
>>> On Tue, Oct 29, 2024 at 03:26:37PM -0600, Jens Axboe wrote:
>>>> On 10/29/24 2:06 PM, Jens Axboe wrote:
>>>>> On 10/29/24 1:18 PM, Jens Axboe wrote:
> ...
>>>> +    node->buf = imu;
>>>> +    node->kbuf_fn = kbuf_fn;
>>>> +    return node;
>>>
>>> Also this function needs to register the buffer to table with one
>>> pre-defined buf index, then the following request can use it by
>>> the way of io_prep_rw_fixed().
>>
>> It should not register it with the table, the whole point is to keep
>> this node only per-submission discoverable. If you're grabbing random
>> request pages, then it very much is a bit finicky 
> 
> Registering it into the table has enough of design and flexibility
> merits: error handling, allowing any type of dependencies of requests
> by handling it in the user space, etc.

Right, but it has to be a special table. See my lengthier reply to Ming.
The initial POC did install it into a table, it's just a one-slot table,
io_submit_state. I think the right approach is to have an actual struct
io_rsrc_data local_table in the ctx, with refs put at the end of submit.
Same kind of concept, just allows for more entries (potentially), with
the same requirement that nodes get put when submit ends. IOW, requests
need to find it within the same submit.

Obviously you would not NEED to do that, but if the use case is grabbing
bvecs out of a request, then it very much should not be discoverable
past the initial assignments within that submit scope.

>> and needs to be of
>> limited scope.
> 
> And I don't think we can force it, neither with limiting exposure to
> submission only nor with the Ming's group based approach. The user can
> always queue a request that will never complete and/or by using
> DEFER_TASKRUN and just not letting it run. In this sense it might be
> dangerous to block requests of an average system shared block device,
> but if it's fine with ublk it sounds like it should be fine for any of
> the aforementioned approaches.

As long as the resource remains valid until the last put of the node,
then it should be OK. Yes the application can mess things up in terms of
latency if it uses one of these bufs for eg a read on a pipe that never
gets any data, but the data will remain valid regardless. And that's
very much a "doctor it hurts when I..." case, it should not cause any
safety issues. It'll just prevent progress for the other requests that
are using that buffer, if they need the final put to happen before
making progress.

-- 
Jens Axboe

