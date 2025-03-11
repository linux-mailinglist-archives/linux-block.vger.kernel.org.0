Return-Path: <linux-block+bounces-18239-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D361AA5CE50
	for <lists+linux-block@lfdr.de>; Tue, 11 Mar 2025 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EB40189F2DF
	for <lists+linux-block@lfdr.de>; Tue, 11 Mar 2025 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4098263C75;
	Tue, 11 Mar 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NnaOIMSd"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9F26158C
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719392; cv=none; b=otHUTjtKoobN8twblzi/86huhPLqNQaHBHachRJY6PWZ6MKhVlhDqg2z5wBXIQ7bNP54rErR1Gsuqgha9OSTHfKq7LbkD9PnH25SJkGN6n1zj10QVW2pCxoM6M1trV/wUJ4agbM57+Vq20CWTrhinVJcGZcUR/Wn7x4SWT5Dm0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719392; c=relaxed/simple;
	bh=lNBjEgxta7oq4TwKBSAROy6ISAN/Tq6iYeWcKE4Vv/0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uyrz3kOvoFGjLzQ5XH6IAQOLijP9jxFmjzM0xjIVmQC9r6jFyAJsDebdJdXL9gWt6abmS+I4fi0Otqd8VJ7h48JKTW7DLsK7p+rtuO6YOPlVmOLBvIwCkgAeCMPN+UCl7qgwa+CtQUEq2AWqPe19O4oN5NhGZwwZal6Wc+/XH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NnaOIMSd; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d442a77a03so13309095ab.1
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 11:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741719389; x=1742324189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=NnaOIMSddEPHT8Qo1YzHCECi55a8B5zU7qb0NLMcOe01u/v3w/iNulIeG1JuPW0UNy
         /rb1+5kltBqg60TmY8Bz6/9ajmJYAOCmcQnPy0v2K/gWA7l7rh2l9X/UAAf8zHJ4oM9l
         6RoNW/z35MtTPNGzjeNPt+nxZRZpIhQjAHkAfSzw//XVlc25z2oXL2Zixzpe5qRnoFYd
         5THe5/7EDTSfX+eU6+np5F5WsQ6cz5nbf0unICwVfwdpVJ771ofp+Pl9fnNhGlErQG2f
         1+DDW5DkPSDCCAdW21fZnpey9nZiWZvNwemBtuemnmsJoaTHQI2WCN8mbATBeyQOh2QN
         EipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719389; x=1742324189;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s1YRjMruou9Tx5jtWPInc60tJt2gIen0DOp7oUm6XP0=;
        b=KXpxdVdyvqCZsXbrzMdHbl97WOUY2Put8mTx0ntejs7wfUkhxixo9dSdXiU7N/jMNF
         WLHBpQyEtX1CTcmaQVHQ6wYSQnw2RcRMsOqFtDZuQ/ywochW3N+UDZxttwHdRQ8o8UBK
         PfJXcE5hhlnSYul0JXc8QGrbUaJZaLZa387VlgWlb+w+AKxHIPrxebtRjGRlhARduw9e
         xRV1bPHTJBX62fFmLm/dpzS+ECpCiUTjrlnxrpvl6crkVcViPt2t6EqST1S/FFQy6+HN
         0LNVLIUlQTfo/Tl3ObcJF5K4Nk5A+8C8KU6Vfp3A2KtJR3roSR7pvHkBx6ne9n7HEOML
         nx0w==
X-Forwarded-Encrypted: i=1; AJvYcCW+v2d0W/nxWGFZ5WqEGnea2Y2+ouTYwxalVYG8fZTYkKE9/2ByVTB0IuBvbIvTtxApdWC9QJDr5p87jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRBva7KUzE1y5+oJJZWpxcu4YWrl+77v8ePBF9DycOqKU6BAxO
	YzpEmSW4XBcY30sSbLHkjuoET9+jV4JpYwJSSc9Wbc57GU9d0MBcDBcjOlnDuO0=
X-Gm-Gg: ASbGncsz5PB6mR1SLKRutL0ARdCfPe3LRatoKB5HQp7hEkY3HMwNuN03s8bz41P3lHM
	EyWF/KKbppe0A6NcWO9S2rXZtFteIowYFa7rFBTqZ6cLx0bvGz9xqSBcsiBLe4LnP4nCyTk3VDc
	a7eOtCCSV0cDBLhkoItBE7gZlTM77303szi4akBPVgxKU4Fs1k+5RyEZyzC+81FDwN44rqvxtw+
	TmC1O3HoOUgOxEH32deldLS1Js4NugyikKeehJzLtFltMEgouCIMcUFnSKRSGUwzn5DOwvzvZAA
	d98f/qM+BFKuVROS/zhkeWAJZtAMii1KxK3YMUSw
X-Google-Smtp-Source: AGHT+IF6QEvMgNWs9dedBUfcF2UZXbN6XsW8AZipdiC80ycaj5jlFprQu0VmRz6Jjl/szbD7bbMzQQ==
X-Received: by 2002:a05:6e02:1c0b:b0:3a7:87f2:b010 with SMTP id e9e14a558f8ab-3d4419712a9mr212361315ab.5.1741719388965;
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f23abbf42csm1034856173.105.2025.03.11.11.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:56:28 -0700 (PDT)
Message-ID: <32c6f6fb-d75e-45a1-b050-4c078a757a50@kernel.dk>
Date: Tue, 11 Mar 2025 12:56:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 00/11] cgroup v1 deprecation messages
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, Waiman Long <longman@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
Content-Language: en-US
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Memory controller had begun to print warning messages when using some
> attributes that do no have a counterpart in its cgroup v2
> implementation. This is informative to users who run (unwittingly) on v1
> or to distros that run v1 (they can learn about such users or prepare
> for disabling v1 configs).
>
> I consider the deprecated files in three categories:
>   - RE) replacement exists,
>   - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
>   - NE) not evaluated (yet).
>
> For RE, I added the replacement into the warning message, DN have only a
> plain deprecation message and I marked the commits with NE as RFC.
> Also I'd be happy if you would point out some forgotten knobs that'd
> deserve similar warnings.
>
> The level of messages is info to avoid too much noise (may be increased
> in future when there are fewer users). Some knobs from DN have warn
> level.
>
> The net_cls and net_prio controllers that only exist on v1 hierarchies
> have no straightforward action for users (replacement would rely on net
> NS or eBPF), so messages for their usage are omitted, although it'd be
> good to eventually retire that code in favor of aforementioned.
>
> At the end are some cleanup patches I encountered en route.

For the block related parts, as I'm assuming Tejun will pick this up:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


