Return-Path: <linux-block+bounces-6847-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FC8B9C31
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 16:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582CB1C2143E
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF713C801;
	Thu,  2 May 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr7f5yTs"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B76A83A1D;
	Thu,  2 May 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659719; cv=none; b=pHolIwnDo+IJdLSZ8+09KG33MHjmsuGZD3Kt0L881AMbrf1bL9ikPEeTqZ+Md5RobIR1jsgcYeb6ryiAj0iRBCsrexlc+6O0PoiafFVITlnbSZQ6dfeTiNzehlbQ/z3ypVoGsQE2CJMR00KtgE7jdzjWEJM4lTZ0IrLc5FaVHug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659719; c=relaxed/simple;
	bh=ivQhvR+6JiJtCcpLvq5Nr6NXWPQKqQYud5PQSkBuZsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC6vlaHGLI9C83XtolpK0gq6ZQJ0LImt7XIighutolSyi8wFDIEnmOw7mq9fg8qqev2Yxv24oiT2p24cbVMRBs7oWGcXVjlAq9Jj/AVn/9Vw+NcRuiFKSnOEIE8h4ZMAS/fipn2JICdXV69C2/sLWuFcrcGTBYlGv8K92q9Kb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr7f5yTs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a58d0aea14cso872674566b.2;
        Thu, 02 May 2024 07:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714659715; x=1715264515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wJ/GjiQAle3PfwuqSi0VOm4CZ+cGCbFhtyyW3KWjW0=;
        b=Gr7f5yTsWD8KUXwqEf4Br/Z0Bidz45sfGi5ms9FgBSFpRBvxj7NWzcvfbDufVK5Crj
         NiyGJThCBVjSnGrBy4FKX5iOoUCR9TWKKoTa+oeZ2AQ0UbkB+JUUR/OubcHl4H6QPhxJ
         ZHoAB/hYuTLNlnT3YEyBdaWXurQKc4jjOX255wnbLlNxB5EAGTu5mkrxsloX1QOL6j/X
         kUkV0Gmm/CW/rH6AblYELTrbncnF50lAwtP1Wg52ZT3BelYXE+WNXGo22N1KxAWi1I3x
         4eRZmmsdSjQHxtoV2SRKQI6nAIW8beTHIOwfHOVCjlHHKdq9fubjHT1SqrVeZDkRP7tv
         nmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659715; x=1715264515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wJ/GjiQAle3PfwuqSi0VOm4CZ+cGCbFhtyyW3KWjW0=;
        b=iBIAj+wU63Ow9+Y+o1vMp+hRql7JoOKaj2oAN4HqCCxdgFajNXrH1uhq2/Pv2/MtSD
         KxdQ+2FYLqP4wLhj+BXrmSgoIGCQ/RT05yN51SWw/vPzdzd2ZeCt0JkzRuPbDo3+Z7h0
         NTLSevM1CyQX4yb3VQ8yk4pzLQ7+JeIizVxR7Z+2bOnZ0imUKiaisITYqoZAt/AWQcAq
         TB6HMnxJsR5bfAYAQ55HAdVCooO7lOZi0tpH2WLWQuHmYFLmrPIu50FJ8wLvkXmcLRxj
         SM2ei72bqYfpmG7Db1IRMlJ7kQtcjM99y5wCSUI0bQXT5Oh2JdsQK3VZqkb81VDgViM4
         xgJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4X1YS9oXApY6scKZ17Ol0iPZlA17m1uXCkgmnXNvZfNtSw6lvP6eXYFQBpoT4uPqEo7zbMqlkQpMV3EqjzXllkk6InHC54p+Au7021WpGMTTFwhTXRL1yQ6FwxqvcyF2UCRsLFw==
X-Gm-Message-State: AOJu0Yx1Jz9xgK9Csy2bCMf0YtxutvNSQ6eouIFeu08JuzXZBVwc2tap
	Mt2oz9T9lT2wUicLcNixeXmtrI8Xzx/FQdpO/JvlMINyUVA3Ba+r
X-Google-Smtp-Source: AGHT+IH/qobgDg0tYt8AIdannits2iJ/fsA0QpqeBbsjKcdIlPQsXZc1HUtHzYApAbo7kLw3icLD7g==
X-Received: by 2002:a50:d5db:0:b0:572:32e4:daca with SMTP id g27-20020a50d5db000000b0057232e4dacamr3282137edj.25.1714659715265;
        Thu, 02 May 2024 07:21:55 -0700 (PDT)
Received: from [192.168.42.210] ([163.114.131.65])
        by smtp.gmail.com with ESMTPSA id dh27-20020a0564021d3b00b00571bc3bb70csm583332edb.87.2024.05.02.07.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 07:21:54 -0700 (PDT)
Message-ID: <e6f4e83d-3369-48ea-ab8d-615a3cbe6619@gmail.com>
Date: Thu, 2 May 2024 15:22:10 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] io_uring: support user sqe ext flags
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
 <20240408010322.4104395-3-ming.lei@redhat.com>
 <89dac454-6521-4bd8-b8aa-ad329b887396@kernel.dk> <Zie+RlbtckZJVE2J@fedora>
 <e0d52e3f-f599-42c8-b9f0-8242961291d0@gmail.com> <ZjBozhXCCs46OeWK@fedora>
 <81bc860f-0801-478b-adba-ea2a90cfe69e@gmail.com> <ZjDqb80OTfb6WzBp@fedora>
 <1b5007d4-2cac-4bbb-beb5-a1bad8be918e@gmail.com> <ZjESSsaDQ7aOploz@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZjESSsaDQ7aOploz@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 16:46, Ming Lei wrote:
> On Tue, Apr 30, 2024 at 03:10:01PM +0100, Pavel Begunkov wrote:
>> On 4/30/24 13:56, Ming Lei wrote:
>>> On Tue, Apr 30, 2024 at 01:00:30PM +0100, Pavel Begunkov wrote:
>>>> On 4/30/24 04:43, Ming Lei wrote:
>>>>> On Mon, Apr 29, 2024 at 04:24:54PM +0100, Pavel Begunkov wrote:
>>>>>> On 4/23/24 14:57, Ming Lei wrote:
>>>>>>> On Mon, Apr 22, 2024 at 12:16:12PM -0600, Jens Axboe wrote:
>>>>>>>> On 4/7/24 7:03 PM, Ming Lei wrote:
>>>>>>>>> sqe->flags is u8, and now we have used 7 bits, so take the last one for
>>>>>>>>> extending purpose.
>>>>>>>>>
>>>>>>>>> If bit7(IOSQE_HAS_EXT_FLAGS_BIT) is 1, it means this sqe carries ext flags
>>>>>>>>> from the last byte(.ext_flags), or bit23~bit16 of sqe->uring_cmd_flags for
>>>>>>>>> IORING_OP_URING_CMD.
>>>>>>>>>
>>>>>>>>> io_slot_flags() return value is converted to `ULL` because the affected bits
>>>>>>>>> are beyond 32bit now.
>>>>>>>>
>>>>>>>> If we're extending flags, which is something we arguably need to do at
>>>>>>>> some point, I think we should have them be generic and not spread out.
>>>>>>>
>>>>>>> Sorry, maybe I don't get your idea, and the ext_flag itself is always
>>>>>>> initialized in io_init_req(), like normal sqe->flags, same with its
>>>>>>> usage.
>>>>>>>
>>>>>>>> If uring_cmd needs specific flags and don't have them, then we should
>>>>>>>> add it just for that.
>>>>>>>
>>>>>>> The only difference is that bit23~bit16 of sqe->uring_cmd_flags is
>>>>>>> borrowed for uring_cmd's ext flags, because sqe byte0~47 have been taken,
>>>>>>> and can't be reused for generic flag. If we want to use byte48~63, it has
>>>>>>> to be overlapped with uring_cmd's payload, and it is one generic sqe
>>>>>>> flag, which is applied on uring_cmd too.
>>>>>>
>>>>>> Which is exactly the mess nobody would want to see. And I'd also
>>>>>
>>>>> The trouble is introduced by supporting uring_cmd, and solving it by setting
>>>>> ext flags for uring_cmd specially by liburing helper is still reasonable or
>>>>> understandable, IMO.
>>>>>
>>>>>> argue 8 extra bits is not enough anyway, otherwise the history will
>>>>>> repeat itself pretty soon
>>>>>
>>>>> It is started with 8 bits, now doubled when io_uring is basically
>>>>> mature, even though history might repeat, it will take much longer time
>>>>
>>>> You're mistaken, only 7 bits are taken not because there haven't been
>>>> ideas and need to use them, but because we're out of space and we've
>>>> been saving it for something that might be absolutely necessary.
>>>>
>>>> POLL_FIRST IMHO should've been a generic feature, but it worked around
>>>> being a send/recv specific flag, same goes for the use of registered
>>>> buffers, not to mention ideas for which we haven't had enough flag space.
>>>
>>> OK, but I am wondering why not extend flags a bit so that io_uring can
>>> become extendable, just like this patch.
>>
>> That would be great if can be done cleanly. Even having it
>> non contig with the first 8bits is fine, but not conditional
>> depending on opcode is too much.
> 
> byte56~63 is used for uring_cmd payload, and it can't be done without
> depending on uring_cmd op.
> 
> The patch is simple, and this usage can be well-documented. In
> userspace, just one special helper is needed for setting uring_cmd
> ext_flags only.

One simple helper here, one simple helper there, one line in man
in some other place, in the end it'll turn to be a horrible mess.

It's not even a question when we'd see people asking "I used
set_ext_flags but why it doesn't work" from people missing a
separate cmd flag. Or just to be sure they would call both,
such things happen even with more straightforward APIs, and it's
just one problem.

> Except for this simple way, I don't see other approaches to extend sqe flags.

Well, that's why I described below how exactly it can be done
cleanly in a long run.

>>>>>>> That is the only way I thought of, or any other suggestion for extending sqe
>>>>>>> flags generically?
>>>>>>
>>>>>> idea 1: just use the last bit. When we need another one it'd be time
>>>>>> to think about a long overdue SQE layout v2, this way we can try
>>>>>> to make flags u32 and clean up other problems.
>>>>>
>>>>> It looks over-kill to invent SQE v2 just for solving the trouble in
>>>>> uring_cmd, and supporting two layouts can be new trouble for io_uring.
>>>>
>>>> Sounds too uring_cmd centric, it's not specifically for uring_cmd, it's
>>>> just one of reasons. As for overkill, that's why I'm not telling you
>>>> to change the layour, but suggesting to take the last bit for the
>>>> group flag and leave future problems for the future.
>>>
>>> You mentioned 8bit flag is designed from beginning just for saving
>>> space, so SQE V2 may not help us at all.
>>
>> Not sure what you mean. Retrospectively speaking, u8 for flags was
>> an oversight
> 
> You mentioned that:
> 
> 	You're mistaken, only 7 bits are taken not because there haven't been
> 	ideas and need to use them, but because we're out of space and we've
> 	been saving it for something that might be absolutely necessary.
> 
> Nothing is changed since then, so where to find more free space from
> 64 bytes for sqe flags now?

ditto

>>> If the last bit can be reserved for extend flag, it is still possible
>>> to extend sqe flags a bit, such as this patch. Otherwise, we just lose
>>> chance to extend sqe flags in future.
>>
>> That's why I mentioned SQE layout v2, i.e. a ctx flag which reshuffles
>> sqe fields in a better way. Surely there will be a lot of headache with
>> such a migration, but you can make flags a u32 then if you find space
>> and wouldn't even need and extending flag.
> 
> It is one hard problem, and it may not be answered in short time, cause all
> use cases need to be covered, meantime 3 extra bytes are saved from the
> reshuffling, with alignment respected meantime.
> 
> Also it isn't worth of layout v2 just for extending sqe flags.

Not just, by opting to the pain of migration to a new SQE layout
we can revise more API decisions. It's a separate topic for
discussion, and the latter it's done the better because we'd
collect more design mistakes that can be fixed.

Reiterating again, you're not blocked by it.

>>> Jens, can you share your idea/option wrt. extending sqe flags?
>>>
>>>>
>>>>
>>>>> Also I doubt the problem can be solved in layout v2:
>>>>>
>>>>> - 64 byte is small enough to support everything, same for v2
>>>>>
>>>>> - uring_cmd has only 16 bytes payload, taking any byte from
>>>>> the payload may cause trouble for drivers
>>>>>
>>>>> - the only possible change could still be to suppress bytes for OP
>>>>> specific flags, but it might cause trouble for some OPs, such as
>>>>> network.
>>>>
>>>> Look up sqe's __pad1, for example
>>>
>>> Suppose it is just for uring_cmd, '__pad1' is shared with cmd_op, which is aligned
>>> with ioctl cmd and is supposed to be 32bit.
>>
>> It's not shared with cmd_op, it's in a struct with it, unless you
>> use a u32 part of ->addr2/off, it's just that, a completely
>> unnecessary created padding. There was also another field left,
>> at least in case for nvme.
> 
> OK, __pad1 is available for uring_cmd, and it could be better to use
> __pad1 for uring_cmd ext flags, but it still depends on uring_cmd, and
> now ext_flags can be u16 or more, :-)
> 
> Thanks for sharing this point.
> 
>>
>>> Same with 'off' which is used in rw at least, if sqe group is to be
>>> generic flag.
>>>
>>>>
>>>>
>>>>>> idea 2: the group assembling flag can move into cmds. Very roughly:
>>>>>>
>>>>>> io_cmd_init() {
>>>>>> 	ublk_cmd_init();
>>>>>> }
>>>>>>
>>>>>> ublk_cmd_init() {
>>>>>> 	io_uring_start_grouping(ctx, cmd);
>>>>>> }
>>>>>>
>>>>>> io_uring_start_grouping(ctx, cmd) {
>>>>>> 	ctx->grouping = true;
>>>>>> 	ctx->group_head = cmd->req;
>>>>>> }
>>>>>
>>>>> How can you know one group is starting without any flag? Or you still
>>>>> suggest the approach taken in fused command?
>>>>
>>>> That would be ublk's business, e.g. ublk or cmds specific flag
>>>
>>> Then it becomes dedicated fused command actually, and last year's main
>>> concern is that the approach isn't generic.
>>
>> My concern is anything leaking into hot paths, even if it's a
>> generic feature (and I wouldn't call it that). The question is
>> rather at what degree. I wouldn't call groups in isolation
>> without zc exciting, and making it to look like a generic feature
>> just for the sake of it might even be worse than having it opcode
>> specific.
>>
>> Regardless, this approach doesn't forbid some other opcode from
>> doing ctx->grouping = true based on some other opcode specific
>> flag, doesn't necessarily binds it to cmds/ublk.
> 
> Yes.
> 
>>
>>>>>> submit_sqe() {
>>>>>> 	if (ctx->grouping) {
>>>>>> 		link_to_group(req, ctx->group_head);
>>>>>> 		if (!(req->flags & REQ_F_LINK))
>>>>>> 			ctx->grouping = false;
>>>>>> 	}
>>>>>> }
>>>>>
>>>>> The group needs to be linked to existed link chain, so reusing REQ_F_LINK may
>>>>> not doable.
>>>>
>>>> Would it break zero copy feature if you cant?
>>>
>>> The whole sqe group needs to be linked to existed link chain, so we
>>> can't reuse REQ_F_LINK here.
>>
>> Why though? You're passing a buffer from the head to all group-linked
>> requests, how do normal links come into the picture?
> 
> For example of ublk-nbd, tcp send requests have to be linked, and each
> send request belongs to one group in case of zero copy.

"Linked" like in "add to a group"? Or in terms of traditional
IOSQE_IO_LINK links? Because if it's about groups you don't need
IOSQE_IO_LINK. And if it's IOSQE_IO_LINK linking, then same
is supposedly can be done in userspace.

> Meantime linking is one generic feature, and it can be used everywhere, so
> not good to disallow it in application

-- 
Pavel Begunkov

