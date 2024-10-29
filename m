Return-Path: <linux-block+bounces-13166-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729349B500D
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2024 18:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2375B225B0
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2024 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0B17D355;
	Tue, 29 Oct 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2Edj1GAf"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6B19DF95
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221474; cv=none; b=pM1nXUDNL6Xu86Xn0h6+8pbjwxFPECxqkdKtUBK2oqBhf/o/pNHp+2n8eCi+yUgwWjtRrnv/gvnbewlxrwz8PizLt+zt1tQBRP161hFztNEpmXcUBdVuKjavCpZi+El6TB0LlEP0RIWwW2K23apsq4HWNfGN4zec8VaYRr/yQzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221474; c=relaxed/simple;
	bh=f33AX6vxDktnL1Q1WQZRpvc2rxalaMW8mJosg2XWBRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqVONqd6ljiKObnGT8ixjH6b3EOG/fvjnpmKBr48BCD18Pvqr+kuIURjpSt35GIK6f/Ak0R4x/gvb+x/lxYrx2+Nk4P8HPM2WNR+EyQRuFdTdTFy4zfI/Q1PX1OY3wgX4inJdVjhWqgQte6H/V5M+B+jhNFnlCZhi24rvo1eAd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2Edj1GAf; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a5075ed279so6387915ab.0
        for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730221470; x=1730826270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgtCGT/gnyeVQ7GMbFqDFyhmhGdCmgWHodfBuWQWmQM=;
        b=2Edj1GAfhPB+7Ih2U/PSW7IhO7zrdLpzwAych/SmWrpx0ilwYJT80EbIJ3049GTaez
         jLZHvenyqXq8m/o1Wq6mgZcScJJsZI2Pb6aWOhwRXccfA41g2JtCG57pnRLQSaTUW1cF
         u2OVubipji+9V9I6dZNHsnJmspwSq5ENjntba0ADXOn16ZefOGaozS/x4LyjVLS3Pno/
         tOt/raezI4nTBnyBqylQpD/HgVGQu55KaixEz6IeuvUrU3Js/9e29kpghm8npfyUCdAe
         /tQHUb7AEA20uKYoXwpsPyoX+RWwutCZLYb3J9RayOVoezHupoMFiJqzUwantom5iRbg
         X7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730221470; x=1730826270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgtCGT/gnyeVQ7GMbFqDFyhmhGdCmgWHodfBuWQWmQM=;
        b=aB5140kRj//a29MEkDXM0o2oNJ+3Anm8Fz7pEtk6tGVXHx7cOkQuaFBPt0hGGNMwf4
         IYDVm/FhCAkhjjT5wVZix/mIDRDMJNW36sp+6G+TYgIJ9gmkK2Ynop6ErW0AHu095+xh
         xBJ3sYtPFCMRcITzcVNiKwyyc3iU8zwkKxRhGN8nZA6wH5XyM4d9zbO8/W00/aYluYiS
         66nrASvof8eIVCsQ6pN/42d880vu5bS+u35Rb+GccKc/9KF29Oc+3i+V177NTum2JEnK
         Xi1SmDxBcQWBddKE1d0PzDE9usUJpaJ7O/77uArHZHzYrhf5IsZL10cTkCuL5D4IuJwH
         fOQQ==
X-Gm-Message-State: AOJu0YxZn7Jqto5XmcImcuApsZvKTLBjopJAOFizeR6ZoAsGriG7q/Nk
	18pkYgSPz22Ncq5mz3bEBOlNjKbqrmJcX9JJbFUtB/9YFvoq1/W3hcou9IstNC8=
X-Google-Smtp-Source: AGHT+IFRJ9SKURpxxdOfKf20+yezaTn+5AAlq9kf1IrEbHZgykDxjL1lAAu6f9r03kKlrdlvIubugQ==
X-Received: by 2002:a92:cdac:0:b0:3a0:933a:2a0a with SMTP id e9e14a558f8ab-3a4ed29bf3bmr105804775ab.7.1730221470435;
        Tue, 29 Oct 2024 10:04:30 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6dcfff7sm24248595ab.14.2024.10.29.10.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 10:04:29 -0700 (PDT)
Message-ID: <d859c85c-b7bf-4673-8c77-9d7113f19dbb@kernel.dk>
Date: Tue, 29 Oct 2024 11:04:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 11:01 AM, Pavel Begunkov wrote:
> On 10/25/24 13:22, Ming Lei wrote:
>> The 1st 3 patches are cleanup, and prepare for adding sqe group.
>>
>> The 4th patch supports generic sqe group which is like link chain, but
>> allows each sqe in group to be issued in parallel and the group shares
>> same IO_LINK & IO_DRAIN boundary, so N:M dependency can be supported with
>> sqe group & io link together.
>>
>> The 5th & 6th patches supports to lease other subsystem's kbuf to
>> io_uring for use in sqe group wide.
>>
>> The 7th patch supports ublk zero copy based on io_uring sqe group &
>> leased kbuf.
>>
>> Tests:
>>
>> 1) pass liburing test
>> - make runtests
>>
>> 2) write/pass sqe group test case and sqe provide buffer case:
>>
>> https://github.com/ming1/liburing/tree/uring_group
>>
>> - covers related sqe flags combination and linking groups, both nop and
>> one multi-destination file copy.
>>
>> - cover failure handling test: fail leader IO or member IO in both single
>>    group and linked groups, which is done in each sqe flags combination
>>    test
>>
>> - cover io_uring with leased group kbuf by adding ublk-loop-zc
> 
> To make my position clear, I think the table approach will turn
> much better API-wise if the performance suffices, and we can only know
> that experimentally. I tried that idea with sockets back then, and it
> was looking well. It'd be great if someone tries to implement and
> compare it, though I don't believe I should be trying it, so maybe Ming
> or Jens can, especially since Jens already posted a couple series for
> problems standing in the way, i.e global rsrc nodes and late buffer
> binding. In any case, I'm not opposing to the series if Jens decides to
> merge it.

With the rsrc node stuff sorted out, I was thinking last night that I
should take another look at this. While that work was (mostly) done
because of the lingering closes, it does nicely enable ephemeral buffers
too.

I'll take a stab at it... While I would love to make progress on this
feature proposed in this series, it's arguably more important to do it
in such a way that we can live with it, long term.

-- 
Jens Axboe

