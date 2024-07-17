Return-Path: <linux-block+bounces-10067-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5C934275
	for <lists+linux-block@lfdr.de>; Wed, 17 Jul 2024 20:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F401F228E8
	for <lists+linux-block@lfdr.de>; Wed, 17 Jul 2024 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B2D18412D;
	Wed, 17 Jul 2024 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfqRwq9q"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8618410A
	for <linux-block@vger.kernel.org>; Wed, 17 Jul 2024 18:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242558; cv=none; b=utDO/5AdQegi598YWjB0V5jVv2BHiYKZWP7ZX9gphO7+sWW1xdXk/73XDo1vbInAtdk0+6p4CBHuPzQ3LnPEiW5RNiNDIVkG4J6uyO0isQPM22wV9OyE3QxMYnaKMLh1jphGejGbIyf3TdPZeghN+mkxBHnFQdLV1bdkC5FnM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242558; c=relaxed/simple;
	bh=1ypNYqyJd5+/3wMS25bBg2wSCYkGAoz3khgoCCUzXvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pAhoRMorWZPnrRlQeTWlCNQbU6+Ks/JWoIOI8YAUIQKBvVhiplCNAEor75m+54U8qYQG5IBBO6cZzPTp4xjv6izy4ZAfZU7ST30tOEWiOKHowwWA20M69tK8sUabRt64yo52JrpSkPMzhmJH0RGU05jSv5o9CdTs7pJ4EHG0hJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AfqRwq9q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721242555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42DJEZQ1MdHTtg7QJxt70aly4kDVOHsjcs6e6lW7JWQ=;
	b=AfqRwq9qtQwe5Wttu+GOAio7iV/1zpIc5PQBqfAh0Cb1+tlwtM/D/SOW6ykU3cb4eAtbmC
	8gbfcAtqVNDTf9XDq8pG5o3U+h3Bi6yYf39eB5CI5aLJpylM1SN9blrTzJ8xh1Lsqw/RnX
	DpEiUl7D4ZXGJwKxNkWPcxGhheWKGQI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-GJ8a38dFOd6eX2lsh8TOXQ-1; Wed,
 17 Jul 2024 14:55:48 -0400
X-MC-Unique: GJ8a38dFOd6eX2lsh8TOXQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 899E01979058;
	Wed, 17 Jul 2024 18:55:41 +0000 (UTC)
Received: from [10.22.16.209] (unknown [10.22.16.209])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 696931955F21;
	Wed, 17 Jul 2024 18:55:38 +0000 (UTC)
Message-ID: <48fa8bc9-9f8d-4406-9137-88a555883ea2@redhat.com>
Date: Wed, 17 Jul 2024 14:55:37 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] blk-cgroup: Replace u64 sync with spinlock for iostat
 update
To: "tj@kernel.org" <tj@kernel.org>
Cc: =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>,
 "boris@bur.io" <boris@bur.io>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240716075206.23121-1-boy.wu@mediatek.com>
 <Zpbify32lel9J-5I@slm.duckdns.org>
 <c5bcbcbaeacdb805adc75c26f92ec69f26ad7706.camel@mediatek.com>
 <5560c690cc6de67139a9b2e45c7a11938b70fc58.camel@mediatek.com>
 <1b19b68adb34410bf6dc8fd3f50e4b82c1a014e4.camel@mediatek.com>
 <Zpf3ks2drDZ7ULTa@slm.duckdns.org>
 <f448f66b-7a91-4281-8f77-159541cbacff@redhat.com>
 <ZpgB9kCAxAAXAtSi@slm.duckdns.org>
 <134fc34c-10b8-4d00-aaca-8285efce9899@redhat.com>
 <ZpgMajKn2O521H2s@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZpgMajKn2O521H2s@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 7/17/24 14:24, tj@kernel.org wrote:
> Hello,
>
> On Wed, Jul 17, 2024 at 02:18:39PM -0400, Waiman Long wrote:
>> Well, it can be confusing whether we are dealing with blkg->iostat or
>> blkg->iostat_cpu. In many cases, we are dealing with iostat_cpu instead of
>> iostat like __blkcg_rstat_flush() and blkg_clear_stat(). So we can't
>> eliminate the use of u64_stats_update_begin_irqsave() in those cases.
> I mean, we need to distinguish them. For 32bits, blkg->iostat has multiple
> updaters, so we can't use u64_sync; however, blkg->iostat_cpu has only one
> updater (except blkg_clear_stat() which I don't think we need to worry too
> much about), so u64_sync is fine.

I was wrong about __blkcg_rstat_flush(). Right, the main updater of 
iostat_cpu is  blk_cgroup_bio_start(). We do need to drop down some 
comment on what is protected by u64_sync and what is by blkg_stat_lock 
though. It can be confusing.

Cheers,
Longman


