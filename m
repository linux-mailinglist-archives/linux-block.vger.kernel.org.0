Return-Path: <linux-block+bounces-28946-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3942C02383
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 17:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D333A23D4
	for <lists+linux-block@lfdr.de>; Thu, 23 Oct 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD31218AD4;
	Thu, 23 Oct 2025 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxPW51e9"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09951FC7C5
	for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234348; cv=none; b=VCavJm9t05vYG5MPpsmzdfek6Vwg7QmR0/UqNqaHT7Ge+gPaYty5QvGkF/VgaL1Y9gWk2tmSKe2Dmph/pcpoEklX2u26YTH26yzgUu5m+EVpKUTCRRI9DVw9jAkJbuk+QCYLIzj9rCQ18PpQU8arGBYzBxGKLxcamXMp9uqEojE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234348; c=relaxed/simple;
	bh=WpbcaF8x2sasj+ApAXCwoMuJpqNIfGogMerrRKXqC4s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gteGWsq3HU2PtBwIy8BPTCaQEmNlSt7d0UmnfyVikmLA3jYBsA6X6eOMbF/1q+BeKvOtw8s+a0FqntiyU+OVhbQFbNoTpuPWuof/pvtqPSjdEIHvIpkqX8DORspaXesafwE6Tk6GtJ3pYrtVjcdHF3ceczwG5gmn6BU0anBddMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxPW51e9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761234345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=50SfSxS4nKgs8hxb+bOC3hzEIaH0AgAoPcaR+jSb2yk=;
	b=XxPW51e91+UKRec3aRTDz3TEGRt0gPYkHgSt/6l6h5HIu+wgrWd5Rdop6Iq/EtB85EE8MJ
	pOj1sMi0dfvfV09IRgG+1QYhsgfKcWZh/YcH/E6q7H34oTMR8WIUdhsVVCtCxYMWtvCkz/
	ZHrmBWqLefVYWy0etwQQ5PJje6rh230=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-s2OZmkxiPtaMpI0YyHHYDg-1; Thu, 23 Oct 2025 11:45:44 -0400
X-MC-Unique: s2OZmkxiPtaMpI0YyHHYDg-1
X-Mimecast-MFC-AGG-ID: s2OZmkxiPtaMpI0YyHHYDg_1761234343
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-470fd49f185so9519075e9.2
        for <linux-block@vger.kernel.org>; Thu, 23 Oct 2025 08:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761234343; x=1761839143;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=50SfSxS4nKgs8hxb+bOC3hzEIaH0AgAoPcaR+jSb2yk=;
        b=n9HPTkzaWCbuDhzF4K7nsRoylJYShBNscTF9GWHxYsfdRpfHYRzoJ9Mz6rDFuod4K+
         6+CUI8LXx1rqWUkOPMkSd7QtHoC8TrJB7behPNRhoD9Kq1Bo8jWdZhq6rocm+7AhZHpx
         D5ZygxCsul+nVgdYzgORpHJGY7OuduPTj3uY+dNtPA079VXdNxc5jGuW8kxI2g2CohfG
         s06/c8Kr2k1N+tn+JDw++DtQr8QLR45EXvbZFljZX/Fje22b+OpvEcfTnQsqJ3bre51F
         kYI/fC4Iu8n8BawCTo2bNSblEvPvlU8AXpBSJlN/vxcAm7rrWxfeugGMvSY+KGcV6oxJ
         OieQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlkVm084Dh2EY9Mw367Rdws5jjZyGs1SVoqj8HRExqli+4iIPQHgljp3rsPrIhBpBx0YZMJOYC0n4/MA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+COHa1LEmaLIiPGIQmbYLDAMjGRdRSE+2FYexbjo/KDNNUL3c
	eleAr/Y2Wt2Qo2cvLYzyrrYaBwNLW32i0qCwFTIW4BYmmZ6jf9BvWNymj4wzEhtm54Vz3XvwPxh
	O2GJtfXC3X2sCWrykXbvgFmtacVYLxapOJmj2U5+HZNSFawomujla3xhP4JYXyGgN
X-Gm-Gg: ASbGncskDKJLS1F0IPh1fDHLLivQdif4UB6Hc9D1FHCq6sb3NdVpYUgJ5JhkvngrQhN
	ozhICRFCU8eWu7Er5Bb73+iy0BiaqGaMHrRb0PDLtfqdYswhaYqOAs7xK0jEqeuqjbrqiB6bmFb
	TcQthGalYATz02/M0ieOluoREUP8EeRWrw4iM/zDij5yGl7xiuctLDKElr+OIDrVxoO9JrHq+Kv
	NafQD6EYbLgwb2i3vglgT2pZLc6X7igm5YqUEgywm1unTO7EKVM62hdEnOxWK00rfLhnS43/+le
	XhJcJ7yWcRlSB/aNywXCaIGzMw+LHgRc6C0U9rLsuPBB+qduQ9PSr2idmC5pD1nNafAgS3Y+RTO
	dbYuKMo9Yau3UJobl7lIpluy011o3Woz4gIIaQ4XwLzB3nQvMZpO53sIneelG
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr173963685e9.12.1761234342945;
        Thu, 23 Oct 2025 08:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENvjJfnRqlEPVbQJG/5+2SRFe/+XvUSWY4e9vS8wIYZ+gnFtpWxD3L8rMa8r5ek+Ptfbuv2w==
X-Received: by 2002:a05:600c:548a:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4711787a2cdmr173963305e9.12.1761234342435;
        Thu, 23 Oct 2025 08:45:42 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cad4c81dsm44883515e9.0.2025.10.23.08.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 08:45:41 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Michal =?utf-8?Q?Koutn?=
 =?utf-8?Q?=C3=BD?=
 <mkoutny@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Danilo Krummrich <dakr@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gabriele Monaco
 <gmonaco@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Lai
 Jiangshan <jiangshanlai@gmail.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Michal Hocko <mhocko@suse.com>, Muchun Song
 <muchun.song@linux.dev>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Shakeel
 Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Vlastimil Babka
 <vbabka@suse.cz>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 05/33] sched/isolation: Save boot defined domain flags
In-Reply-To: <20251013203146.10162-6-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-6-frederic@kernel.org>
Date: Thu, 23 Oct 2025 17:45:40 +0200
Message-ID: <xhsmhecqtoc4b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 13/10/25 22:31, Frederic Weisbecker wrote:
> HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
> but also cpuset isolated partitions.
>
> Housekeeping still needs a way to record what was initially passed
> to isolcpus= in order to keep these CPUs isolated after a cpuset
> isolated partition is modified or destroyed while containing some of
> them.
>
> Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>  include/linux/sched/isolation.h | 1 +
>  kernel/sched/isolation.c        | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index d8501f4709b5..da22b038942a 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -7,6 +7,7 @@
>  #include <linux/tick.h>
>
>  enum hk_type {
> +	HK_TYPE_DOMAIN_BOOT,
>       HK_TYPE_DOMAIN,
>       HK_TYPE_MANAGED_IRQ,
>       HK_TYPE_KERNEL_NOISE,
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index a4cf17b1fab0..8690fb705089 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -11,6 +11,7 @@
>  #include "sched.h"
>
>  enum hk_flags {
> +	HK_FLAG_DOMAIN_BOOT	= BIT(HK_TYPE_DOMAIN_BOOT),
>       HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>       HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>       HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
> @@ -216,7 +217,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>
>               if (!strncmp(str, "domain,", 7)) {
>                       str += 7;
> -			flags |= HK_FLAG_DOMAIN;
> +			flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;
>                       continue;
>               }
>
> @@ -246,7 +247,7 @@ static int __init housekeeping_isolcpus_setup(char *str)
>
>       /* Default behaviour for isolcpus without flags */
>       if (!flags)
> -		flags |= HK_FLAG_DOMAIN;
> +		flags |= HK_FLAG_DOMAIN | HK_FLAG_DOMAIN_BOOT;

I got stupidly confused by the cpumask_andnot() used later on since these
are housekeeping cpumasks and not isolated ones; AFAICT HK_FLAG_DOMAIN_BOOT
is meant to be a superset of HK_FLAG_DOMAIN - or, put in a way my brain
comprehends, NOT(HK_FLAG_DOMAIN) (i.e. runtime isolated cpumask) is a
superset of NOT(HK_FLAG_DOMAIN_BOOT) (i.e. boottime isolated cpumask),
thus the final shape of cpu_is_isolated() makes sense:

  static inline bool cpu_is_isolated(int cpu)
  {
          return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
  }

Could we document that to make it a bit more explicit? Maybe something like

  enum hk_type {
        /* Set at boot-time via the isolcpus= cmdline argument */
        HK_TYPE_DOMAIN_BOOT,
        /*
         * Updated at runtime via isolated cpusets; strict subset of
         * HK_TYPE_DOMAIN_BOOT as it accounts for boot-time isolated CPUs.
         */
        HK_TYPE_DOMAIN,
        ...
  }


