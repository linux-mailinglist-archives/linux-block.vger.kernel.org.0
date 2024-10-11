Return-Path: <linux-block+bounces-12441-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D200999AA5
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2024 04:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6061F24560
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2024 02:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758711F471B;
	Fri, 11 Oct 2024 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z3FiN4hZ"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3333617BA9
	for <linux-block@vger.kernel.org>; Fri, 11 Oct 2024 02:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614360; cv=none; b=WaMx3Lf0upA5S9sICfYJzGcQi2FYfTiY0OXVknhJCc5XusmfqpAtbR5xXGN0WMvr44TBg3qIlxQKTRPMSVTkG/+VjUtD+JX4JsT9yStQ1X3cmrtL9MrS0QAvjSdD/+UKQWbaRoYWFx+cqlqhS24sO7DGRmwfb1dG1hD/zN6RYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614360; c=relaxed/simple;
	bh=/DuE0hba1mPTKIRvQcF9ppF/olIKm/Rm43mgRqQ6l+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BB2ti9ciFjPSVdomG9YUD2Yljg6JXg/8K0IPK6Gz7LAFQelAlZ+ImCIvMT3DGo3MZT0/g8BGYR+4rH3pkVkQGvHTMbnH8OgoyLSCQxdB+vY1+Doc0Xy0C5oIuyNZAwO7R4eqBdowPRDRBpBspp2TUqg+QQsIv6pGQZKFNR5b2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z3FiN4hZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20bc506347dso12818725ad.0
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2024 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728614356; x=1729219156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E8su4FrT7eRJxtDlnjhDDwKwHF3STzqynjnPDLfwqQg=;
        b=Z3FiN4hZZ+1iI9GNywmGsPvEOf/CFVdscu6q/Yyrj3Yb8mmgweAX1ZiicrZZ/NqJdW
         uU9capAAgeZ2Yb/MKAjz+Th/4FQq1zPam2skcQrHvtFAcYm0qIi6YEwtdzDOAGMEhaMa
         Q0lNTu3qfSDRKpE0swbMLQ03UL54bHdwSSLrcsDokfJdZS2k4Quyu7rAGKFjYuXs3ufw
         +l5+nTcqKiy3uCXuEBm+o3dbiFaPOH/4AGd+MePoGoNWRqXddRmYywhSeEVR8sUEC9/x
         0AglKmxsgzdvRKMorxi3yeZkaWInqBQ52H3bSF9ZKKQbklZn1KPS+tkNiV8nsbrijqbK
         9u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728614356; x=1729219156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8su4FrT7eRJxtDlnjhDDwKwHF3STzqynjnPDLfwqQg=;
        b=Ev00XhQL7gA9h5xopA27CnCe47ZtfsRSWu/it6KqFa2WLj9Mjf+ltETroHyjLtbcuk
         R3sgQIp+E7Ew8N2Lr02Zw2KIuD9z77ZDVaJaxT0M12BIVg/VWATyJmccT4mKmw+jer/w
         plz0xVTU3Z/DWytdRZKZ9UlHAM4o+EhrkX/yLu+4wUO/BLHz6cFN9Yk/AOGcwVfHqsvp
         t4vHJPYxR+fErDUwQcJNFYz248WKqjOYu+QSQYDQ/PJrLKuVT9AcguaLl7QI/rqNaykx
         Xp4tEeeaRxl2ajezGIy62QoV/0N18uBOBoxlL91qgrzBtdpOitg2gtmNeliBv5X7cWQ/
         OQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc6uFIBTAwqyFvsr8/wkzpqt+ocRQ+1BhUpAVBSVKbFi16qOvmpggjaehrJofFZP883qZ9okN/cXd8cA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2XIkGwHffMwRJhXCJsCDEvrCp35CoURFoMobVCwjFQJRUx+GE
	IiuZXIJMp/niZH0/sOPcsTbcufqZpTXMdfyfsk6bV4NkBjoYaPobijrCPF5folU=
X-Google-Smtp-Source: AGHT+IGTtnpxqYbgJRVQEo9KWdw0vegatXU58cqdw720j3BvrF4GjFelccaesxABnh5ucuTuP51Uog==
X-Received: by 2002:a17:902:dad2:b0:20b:a5b5:b89 with SMTP id d9443c01a7336-20ca1677ef1mr12477655ad.35.1728614356195;
        Thu, 10 Oct 2024 19:39:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8badc3b2sm15773135ad.12.2024.10.10.19.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 19:39:14 -0700 (PDT)
Message-ID: <44028492-3681-4cd4-8ae2-ef7139ad50ad@kernel.dk>
Date: Thu, 10 Oct 2024 20:39:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 7/8] io_uring/uring_cmd: support provide group kernel
 buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20240912104933.1875409-1-ming.lei@redhat.com>
 <20240912104933.1875409-8-ming.lei@redhat.com>
 <b232fa58-1255-44b2-92c9-f8eb4f70e2c9@gmail.com> <ZwJObC6mzetw4goe@fedora>
 <38ad4c05-6ee3-4839-8d61-f8e1b5219556@gmail.com> <ZwdJ7sDuHhWT61FR@fedora>
 <4b40eff1-a848-4742-9cb3-541bf8ed606e@gmail.com>
 <655b3348-27a1-4bc7-ade7-4d958a692d0b@kernel.dk> <ZwiN0Ioy2Y7cfnTI@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwiN0Ioy2Y7cfnTI@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 8:30 PM, Ming Lei wrote:
> Hi Jens,
> 
> On Thu, Oct 10, 2024 at 01:31:21PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Discussed this with Pavel, and on his suggestion, I tried prototyping a
>> "buffer update" opcode. Basically it works like
>> IORING_REGISTER_BUFFERS_UPDATE in that it can update an existing buffer
>> registration. But it works as an sqe rather than being a sync opcode.
>>
>> The idea here is that you could do that upfront, or as part of a chain,
>> and have it be generically available, just like any other buffer that
>> was registered upfront. You do need an empty table registered first,
>> which can just be sparse. And since you can pick the slot it goes into,
>> you can rely on that slot afterwards (either as a link, or just the
>> following sqe).
>>
>> Quick'n dirty obviously, but I did write a quick test case too to verify
>> that:
>>
>> 1) It actually works (it seems to)
> 
> It doesn't work for ublk zc since ublk needs to provide one kernel buffer
> for fs rw & net send/recv to consume, and the kernel buffer is invisible
> to userspace. But  __io_register_rsrc_update() only can register userspace
> buffer.

I'd be surprised if this simple one was enough! In terms of user vs
kernel buffer, you could certainly use the same mechanism, and just
ensure that buffers are tagged appropriately. I need to think about that
a little bit.

There are certainly many different ways that can get propagated which
would not entail a complicated mechanism. I really like the aspect of
having the identifier being the same thing that we already use, and
hence not needing to be something new on the side.

> Also multiple OPs may consume the buffer concurrently, which can't be
> supported by buffer select.

Why not? You can certainly have multiple ops using the same registered
buffer concurrently right now.

-- 
Jens Axboe

