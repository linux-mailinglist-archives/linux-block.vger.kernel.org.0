Return-Path: <linux-block+bounces-869-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 525CE808F2D
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6619B20B91
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A045978;
	Thu,  7 Dec 2023 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oCp3QZwY"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD11BD1
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 09:57:27 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b05e65e784so5705539f.1
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 09:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701971847; x=1702576647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6xukYdaEg+7AgrkqFUV08DxqRqShB6xWeUsZJHylKDA=;
        b=oCp3QZwYxCelNgvRdODIaG4SzoyXYhi0X1PsTMUZHQ36pHy6IHnwbGEpUwebfbBXA3
         rBHTEla7T3rx6hLu5vTcuh6Ao29Ku8nHlDffYjiy+TaD4Pj+Bkr23MdocJDXOuwCmLkM
         UEYLopV2C8uGjOKVfVLq5NDgqA96AygAMj0xACSJ/xGGldkeRsrLjv8k2di/Ql9l0AkJ
         3biaFM8mCpB1on+TKNkPAndC3ogeFRWu3qKCPPxe8uPj/CWS1UIPmOq6RzyyJXLQ7SN1
         I2g6vcQQtWC64nX49R01JVE3wopqcF+n1Ib3/3N6gakBAYfPuWva6lHPhihTmQeZk1ah
         B6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971847; x=1702576647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6xukYdaEg+7AgrkqFUV08DxqRqShB6xWeUsZJHylKDA=;
        b=t2GECO3BESFnLwkJHBen+UjnZnT1sU7thaElJKK8XLGQJ8GCdyywizH5cX5XpD6wXY
         jjPyGSt/B8pKnU3as0YrQrfEv9NWsKEE3pcf5Ksoo2AmICmDnv8FfQREDfW+MPzL54nI
         pTHlmKAYxYqXdx8QMzGHQ6Emo61GRaHF3zdjdXMFLo63vzH8EeeGYbxebeMdyFMoGezH
         CrD25KULEb7UfOLccf0bYKvgOl2ISN+AD3g8VwYgK+Y5vD4A3VRCv/01BFI/DH+3Lp99
         63dlUqTMVjmx+4C+nTlC2zWVTB7gqnEnI5S0JLBj7ovQi7p58aO0SZBgv80PKrdQdPDq
         tUFA==
X-Gm-Message-State: AOJu0YzEf9eMmjpu0sSQw0xqW2jY1xijauR9T5YUiXihrUVAJsmWPIF8
	2TPaWDMhWT+CYcRrNfhYS5Y6tmEVxqKdD2NuCzv9Sw==
X-Google-Smtp-Source: AGHT+IEvupG9g4K4YhZozjneU3R2IrjL6kYvxStcQ9wjGMda06lCIWT3amYXKlxF1ndhB1G35NcW2w==
X-Received: by 2002:a6b:5004:0:b0:7b3:5be5:fa55 with SMTP id e4-20020a6b5004000000b007b35be5fa55mr5597585iob.2.1701971847021;
        Thu, 07 Dec 2023 09:57:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id m15-20020a02c88f000000b00466bb42cb4bsm46689jao.166.2023.12.07.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:57:26 -0800 (PST)
Message-ID: <4d8504f9-9136-40b1-b625-52981764bd69@kernel.dk>
Date: Thu, 7 Dec 2023 10:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
 <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
 <20231206232724.hitl4u7ih7juzxev@moria.home.lan>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231206232724.hitl4u7ih7juzxev@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/23 4:27 PM, Kent Overstreet wrote:
> On Wed, Dec 06, 2023 at 03:40:38PM -0700, Jens Axboe wrote:
>> On 12/6/23 2:34 PM, Kent Overstreet wrote:
>>> On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
>>>> This patch reworks bio_for_each_segment_all() to be more inline with how
>>>> the other bio iterators work:
>>>>
>>>>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>>>>    one in the iterator and pass a pointer to it - bad. This way makes it
>>>>    clearer what's a constructed value vs. a reference to something
>>>>    pre-existing, and it also will help with cleaning up and
>>>>    consolidating code with bio_for_each_folio_all().
>>>>
>>>>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>>>>    this makes their code clearer.
>>>
>>> Jens, can we _please_ get this series merged so bcachefs isn't reaching
>>> into bio/bvec internals?
>>
>> Haven't gotten around to review it fully yet, and nobody else has either
>> fwiw. Would be nice with some reviews.
> 
> Well, there was quite a bit of back and forth before, mainly over code
> size - which was addressed; and the only tricky parts were to squashfs
> which Phillip looked at and tested.

Would be nice to have that reflected in the commit, and would also be
really nice to have the ext4 and iomap folks at least take a gander at
patch 2 as well and ack it.

-- 
Jens Axboe


