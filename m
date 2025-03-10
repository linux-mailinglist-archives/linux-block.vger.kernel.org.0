Return-Path: <linux-block+bounces-18139-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C50A58A5B
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 03:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4018618877F1
	for <lists+linux-block@lfdr.de>; Mon, 10 Mar 2025 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F23A8528E;
	Mon, 10 Mar 2025 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTaDtf15"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178324C98
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573027; cv=none; b=h6jf9hZyM3D5WVMMLDmU3xnJ9ofPGAntfM1/9dAz0ondDlgBMA/PTp3gNsNXtS3wl1/LMGd8zzC3SjxwgAQXeMzcFksD4P1h9dQEznANPdaFUNwaeQRIH77LMWP0w5jafxBhEBIOs3neDWmlczWg7eg2t7L+PaT+lygWf5HzOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573027; c=relaxed/simple;
	bh=M0I9e+37iGKDtZoDzeO5pmsFG0Bsth0P4d1lDUCl/nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdyi+TLihHvM/WKf/L1UJr9VUkb0/zclPiInFnW10Zwaqs0qNyDXf/5mYg0JkfDSWeI6B5H2dkRQ76bjsh4GYaxTD8QR726+I9XOjjNetQWpQ6sTKv5yiipVevZAim3pccR3225x/8xYMH32IuEM8jeONQzfYeYcr4hJ2Eob7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTaDtf15; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741573023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uSDm5RqDvPpOOOzQzCbG2887sb5kw+SbviHpW34eBvQ=;
	b=DTaDtf15V7gbpzpkvHqy23zq7BgYNjgE1JBYougIXqP6UGIUMyiQTZ/3d1pn99Dni+uRs5
	GNnXKAalgc0CJID3QXwaCvynhOjK6etgt6u6Q60jwag63ehsfDUXLbDJ/GlMgwL5Qr7cq6
	KUpJDg87KVOzHPLPttVpaU6FMyq5BUU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-axi359iXM9W26bB6PfSCBQ-1; Sun,
 09 Mar 2025 22:17:02 -0400
X-MC-Unique: axi359iXM9W26bB6PfSCBQ-1
X-Mimecast-MFC-AGG-ID: axi359iXM9W26bB6PfSCBQ_1741573020
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31CB2180025A;
	Mon, 10 Mar 2025 02:17:00 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66E9218009BC;
	Mon, 10 Mar 2025 02:16:51 +0000 (UTC)
Date: Mon, 10 Mar 2025 10:16:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, axboe@kernel.dk, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: support io merge over iops_limit
Message-ID: <Z85LjhvkCzlqBVZy@fedora>
References: <20250307090152.4095551-1-yukuai1@huaweicloud.com>
 <Z8sZyElaHQQwKqpB@slm.duckdns.org>
 <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fc124c9-e202-99ca-418d-0f52d027640f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Mar 10, 2025 at 09:58:57AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/03/08 0:07, Tejun Heo 写道:
> > Hello,
> > 
> > On Fri, Mar 07, 2025 at 05:01:52PM +0800, Yu Kuai wrote:
> > > From: Yu Kuai <yukuai3@huawei.com>
> > > 
> > > Commit 9f5ede3c01f9 ("block: throttle split bio in case of iops limit")
> > > support to account split IO for iops limit, because block layer provides
> > > io accounting against split bio.
> > > 
> > > However, io merge is still not handled, while block layer doesn't
> > > account merged io for iops. Fix this problem by decreasing io_disp
> > > if bio is merged, and following IO can use the extra budget. If io merge
> > > concurrent with iops throttling, it's not handled if one more or one
> > > less bio is dispatched, this is fine because as long as new slice is not
> > > started, blk-throttle already preserve one extra slice for deviation,
> > > and it's not worth it to handle the case that iops_limit rate is less than
> > > one per slice.
> > > 
> > > A regression test will be added for this case [1], before this patch,
> > > the test will fail:
> > > 
> > > +++ /root/blktests-mainline/results/nodev/throtl/007.out.bad
> > > @@ -1,4 +1,4 @@
> > >   Running throtl/007
> > >   1
> > > -1
> > > +11
> > >   Test complete
> > > 
> > > [1] https://lore.kernel.org/all/20250307080318.3860858-2-yukuai1@huaweicloud.com/
> > 
> > For blk-throtl, iops limit has meant the number of bios issued. I'm not
> 
> Yes, but it's a litter hard to explain to users the differece between IO
> split and IO merge, they just think IO split is the numer of IOs issued
> to disk, and IO merge is the number of IOs issued from user.

Here it is really one trouble.

a) Sometimes people think IOs wrt. IOPS means that the read/write IO
submitted from application, one typical example is `fio`.

b) Sometimes people think it is the data observed from `iostat`.

In a), io merge/split isn't taken into account, but b) does cover io
merge and split.

So question is that what is the correct way for user to observe IOPS
wrt. iops throttle?


Thanks,
Ming


