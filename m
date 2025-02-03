Return-Path: <linux-block+bounces-16792-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04668A25442
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2025 09:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0660A165793
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63407214805;
	Mon,  3 Feb 2025 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A+W9ZJ1a"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C0214816
	for <linux-block@vger.kernel.org>; Mon,  3 Feb 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738570620; cv=none; b=epzumlLkjvL7wTHfGdNAZvvu5U9UgJGkx2dq5I7e/d/lCUaBigtFGU0KeU2vUrn0YUIX49DfWYRaIjcsrQXw89XIm2WttxEJ86So/4KOKvFKtpG1B0WF5YHleizbjbr87JwLMqLCRdQDBlS6tZ9Ha7yb3syivAPX7igj4QmI1rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738570620; c=relaxed/simple;
	bh=Ek7BFD9fxViLcbJ9csG6smGPrD3v64CdOkxwycij5s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEcBq6oGAKp6OiUb5dMN8Fk7RQPxHpq8Wx/BX7cLiGQ6TXe6ea969duN3/50B3qZS+V52OFWFlxN4+K0wWjGV1z+28ocqxzSso73ltolHlrscQzbGKd8/21meFFJnaC79mj1DV9JT915KtkfDlr3XRPqD5DTEI/tWPfaEBsEVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A+W9ZJ1a; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso31251755e9.0
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2025 00:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738570616; x=1739175416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u2SugA0o1F88d3VAFVMSjXMPwJGnAMdayAnCulnyeyo=;
        b=A+W9ZJ1atHWUwmef0SToKOrLv4IZ8S/A66iwBB9k3HITAefjmtLBSJf+6Ug8OttsWt
         uP5PEp9sX8tSCXq0Lu7LI8ypEReYpPSYvGyxd2n1IvclylXIcFBgUugpYdQ2ZhKVzqQ5
         vk5bTwcAjUH53GxPCp5XsKYTt/1ganOd0FD3pDCJhH6OOXVyNXwXnyu9ifc3erMKvJ4N
         E/ELlASxkHReZBpD8jzVLOj/k2LGADvtGjlyHF7GHVmwMHKKGkEQ0oZTcth158z1a7zi
         q6/zpRu+1QeklgtCtcE4pUWM5R7g5obaVwVRFoaLwMda26NSPcStoVeuQ3InevsKxg7n
         zjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738570616; x=1739175416;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2SugA0o1F88d3VAFVMSjXMPwJGnAMdayAnCulnyeyo=;
        b=igjdWAC80OwZffAxngHuQSHp1GIwXLFsUNuw1VjTllcmYi/FCLJF/R1R2XvbZuPzMW
         4s9saOS++G4Glj6AP1BmB1n+RBDFA5zpaAWDiMKnT4Fntn2GIkpg4zS19iPLrPbHzQFN
         VFbi9Jd8EARAkx4EPLDlEoC3gi9xVnX+/h1wTnv4Tn62xM15KNgKIrbqPxWY5GyUOIVK
         AsJdevbAwp9UmDhiS8ah/D9OuntMtwqTXIOoF8Jx+ETg+LW0st2z2/4I16tDJrgm0/7m
         uoMqmQRgRjWpMnP8hyYMXpUqGJhBcsBSfqFcReiM9vWe/rXitpauvk8MEmnIIzsSf0nW
         XhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuGpFLwaBuU8PtiZg4Pk0ZUU5FtVi6U5Ko5ZZXwO+qlsPrPLrl5mSYjkPxJuxi7XaqYL3Cv6JJLKXz3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf45mES57QJhfMJGu4D/RTGe0hq2wZL6aCPAHtvzaLN2M02JtG
	IB8tfOPkzgsAtHJ9h84i+KtNksYz5gL91Ei9dVLhfXDA8b1rBirb93Zr/1pC+n4/M90JdGhWFYq
	x4Ww=
X-Gm-Gg: ASbGncvWG1yIDNN71WYLRbKLNn9Cyu2z/izqEsdHJOF8tcoFJ2e9o8Wd5MGTbEy5C+p
	IujcmcbmCC5Q3MkdU5myNEF1RjfpHk51sZcNkjyd9RvnrTT8SYlUuV4hkVxSCc3pVBdxg+t4r0/
	3siNRSU0zmM9gpSkDxVP9C4OeVXLx71rHzfsoOmsPZ8wGuLGOgOLuwke1rzQk5VhpuJDPP7jR7i
	bLpPANIH0Cy02/hXMwWGdzY4vE13c8SAJPlBoH2xGNdGle1Hf0lIA5+ce0J/v/6CfF1bN/CLQiO
	qZlNfBTTY8BuLAvqvpo/Q/PZB9nG05H88HmtC7Dd1Kc=
X-Google-Smtp-Source: AGHT+IH15pqPOTlDznwLl+zZgokUAfyKi5KnURZBIJbx7fPbd8BIuB0wt5BinEGGWyUnXHx/eQ7Duw==
X-Received: by 2002:a05:6000:1a8a:b0:38a:8d32:2707 with SMTP id ffacd0b85a97d-38c60f77922mr10619285f8f.26.1738570615935;
        Mon, 03 Feb 2025 00:16:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebddbb0e0sm7332278a12.12.2025.02.03.00.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:16:55 -0800 (PST)
Message-ID: <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
Date: Mon, 3 Feb 2025 18:46:49 +1030
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/3 18:34, Johannes Thumshirn 写道:
> On 03.02.25 08:56, Christoph Hellwig wrote:
>> On Mon, Feb 03, 2025 at 07:47:53AM +0000, Johannes Thumshirn wrote:
>>> The thing I don't like with the current RFC patchset is, it breaks
>>> scrub, repair and device error statistics. It nothing that can't be
>>> solved though. But as of now it just doesn't make any sense at all to
>>> me. We at least need the FS to look at the BLK_STS_PROTECTION return and
>>> handle accordingly in scrub, read repair and statistics.
>>>
>>> And that's only for feature parity. I'd also like to see some
>>> performance numbers and numbers of reduced WAF, if this is really worth
>>> the hassle.
>>
>> If we can store checksums in metadata / extended LBA that will help
>> WAF a lot, and also performance becaue you only need one write
>> instead of two dependent writes, and also just one read.
> 
> Well for the WAF part, it'll save us 32 Bytes per FS sector (typically
> 4k) in the btrfs case, that's ~0.8% of the space.

You forgot the csum tree COW part.

Updating csum tree is pretty COW heavy and that's going to cause quite 
some wearing.

Thus although I do not think the RFC patch makes much sense compared to 
just existing NODATASUM mount option, I'm interesting in the hardware 
csum handling.

> 
>> The checksums in the current PI formats (minus the new ones in NVMe)
>> aren't that good as Martin pointed out, but the biggest issue really
>> is that you need hardware that does support metadata or PI.  SATA
>> doesn't support it at all.  For NVMe PI support is generally a feature
>> that is supported by gold plated fully featured enterprise devices
>> but not the cheaper tiers.  I've heard some talks of customers asking
>> for plain non-PI metadata in certain cheaper tiers, but not much of
>> that has actually materialized yet.  If we ever get at least non-PI
>> metadata support on cheap NVMe drives the idea of storing checksums
>> there would become very, very useful.

The other pain point of btrfs' data checksum is related to Direct IO and 
the content change halfway.

It's pretty common to reproduce, just start a VM with an image on btrfs, 
set the VM cache mode to none (aka, using direct IO), and run XFS/EXT4 
inside the VM, run some fsstress it should cause btrfs to hit data csum 
mismatch false alerts.

The root cause is the content change during direct IO, and XFS/EXT4 
doesn't wait for folio writeback before dirtying the folio (if no 
AS_STABLE_WRITES set).
That's a valid optimization, but that will cause contents change.

(I know there is the AS_STABLE_WRITES, but I'm not sure if qemu will 
pass that flag to virtio block devices inside the VM)

And with btrfs' checksum calculation happening before submitting the 
real bio, it means if the contents changed after the csum calculation 
and before bio finished, we will got csum mismatch.

So if the csum can happening inside the hardware, it will solve the 
problem of direct IO and csum change.

Thanks,
Qu

>>
>> FYI, I'll post my hacky XFS data checksumming code to show how relatively
>> simple using the out of band metadata is for file system based
>> checksumming.
>>
> 


