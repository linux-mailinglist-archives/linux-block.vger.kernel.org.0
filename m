Return-Path: <linux-block+bounces-26886-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F16B49A6A
	for <lists+linux-block@lfdr.de>; Mon,  8 Sep 2025 21:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA6175BA3
	for <lists+linux-block@lfdr.de>; Mon,  8 Sep 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777712D3756;
	Mon,  8 Sep 2025 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iA4vBWei"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBEA2D3EDF
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361400; cv=none; b=oumBX7UfceXfjQ2XPc/lZlgIEOQ98egEbDgsGRwWshvKE2oA8s9W08ywq0km9YRwDFvc+sssryZYGMcbVUv1gzxSpHHmjdLyS3cgcb9ddCFnT4sJur9NJmNDQTGfJIOngmNjSKB+DKS7onKAIn1YFncuL9DvRYJOFWdS1VkbNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361400; c=relaxed/simple;
	bh=sbZybV29u2DWqRr9/YXrowS7kOTLtnGQSha3w1VeSa8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ApYwJ+QK3PdMduIcgLl3RekYRmofMfaLWnfpTWJLsskli0JTIbQ9qA+ZKNmpa5AoYsHqnPNdrIGAkRNKC1kK6+x692cfbNSlAPQ1hdwWRyPYu6IJwAQJoIG6VemKPJWbv5E3U/dzD5ygVVsCgV8l41upAT/KFiY36v03ffXitfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iA4vBWei; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757361397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DegGJ8xXjQPz3acawpv8Ry25yrfvvhgmx9pI+ATfe/g=;
	b=iA4vBWei0Em6O//8/7Zr1NFbFMLIgTh3nla9jQ6kLewpPxVD8lxzYJ3lHgO+WiycsK+Khe
	IzgXebgfpN+fvmSEQ/uMuFSp+JSEY0u2Tc9MuIX2Od+BrEzYnp32WYiwisNEnEfVIeFUi9
	9C5M3Bsspz9fW5i20YAXq/nel1RxKyU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-h6Q5alkJOaOxIvFiCIx8uA-1; Mon,
 08 Sep 2025 15:56:34 -0400
X-MC-Unique: h6Q5alkJOaOxIvFiCIx8uA-1
X-Mimecast-MFC-AGG-ID: h6Q5alkJOaOxIvFiCIx8uA_1757361393
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B4F51800447;
	Mon,  8 Sep 2025 19:56:33 +0000 (UTC)
Received: from [10.44.32.12] (unknown [10.44.32.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A77C519560A2;
	Mon,  8 Sep 2025 19:56:31 +0000 (UTC)
Date: Mon, 8 Sep 2025 21:56:23 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Robert Beckett <bob.beckett@collabora.com>
cc: dm-devel <dm-devel@lists.linux.dev>, 
    linux-block <linux-block@vger.kernel.org>, kernel <kernel@collabora.com>
Subject: Re: deadlock when swapping to encrypted swapfile
In-Reply-To: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com>
Message-ID: <cfdb2d15-70b8-1f44-853f-3d0a315d28d3@redhat.com>
References: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12



On Mon, 8 Sep 2025, Robert Beckett wrote:

> Hi,
> 
> While testing resiliency of encrypted swap using dmcrypt we encounter easily reproducible deadlocks.
> The setup is a simple 1GB encrypted swap file [1] with a little mem chewer program [2] to consume all ram.
> 
> Usually the first run will oomkill the memchewer successfully.
> However, after 1-3 runs typically, it will deadlock the machine.
> 
> Using softdog and the lockup detectors it looks like [3] it looks like the dmcrypt_write thread
> is stuck for over 2 minutes while everything else is waiting on the swap bio limiter [4]
> 
> I wondered whether it might be hitting tag exhaustion in blk_mq_get_tag, but adding trace debug and
> enabling the block trace events seems to suggest that generally progress is being made [5].
> 
> Also note lockdep doesn't complain.
> 
> Looks to me like a soft lockup possibly due to swap out hitting similar or same issue as [4] but
> not self inflicted this time. However, once general memory exhaustion occurs, it seems to result
> in the same issue.
> 
> I'm not intimately familiar with the dm and block-mq code, so I'd appreciate any help in
> debugging it further or a fix.
> I guess the main question is: why doesn't it oomkill? oomkill seems like a
> sensible action in this scenario. Any advice on making oomkill more reliable here?
> Would [4] need to be tweaked in any way for swap files vs partition?
> 
> Thanks
> 
> Bob

Hi

What happens if you lower /sys/module/dm_mod/parameters/swap_bios? Does it 
help?

The general problem with swapping to encrypted device is that for each 
swapped-out page, the dm-crypt driver needs to allocate another page that 
holds the encrypted data. So, the harder it tries to swap, the more memory 
it consumes. The device mapper stack uses mempools, so that it should work 
in case of total memory exhaustion, but perhaps some kernel part doesn't 
use them and deadlocks. I could try to reproduce it.

Mikulas


