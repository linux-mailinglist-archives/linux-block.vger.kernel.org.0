Return-Path: <linux-block+bounces-17571-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED40A43309
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 03:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCDD177C82
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401714831C;
	Tue, 25 Feb 2025 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZhJFRJOg"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E713B29F
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740450516; cv=none; b=I5b5e5+NWpfBcvgXfbRKlrbcE6YwsOjJ6qgo3smTmc2QJVTU9xi2qQ0TkEk8hOg+hPPJt9CRLFCOUW8mCd+Ljn1Z4gvwi0j6IUG51CLu/Y2wVmISvA5soh6WhG55KfnQFSoKwt57BYCQhIb/Eb0rJ2bRdgTp0mN1DQ6DaZYnTxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740450516; c=relaxed/simple;
	bh=uMcY4G3651ZFYEbBk3k62ogT1HEqLUJ1RFlcVnUn5mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGf9GrS00MVz1ecypWqQreYNLzkNyrkCyzftvev26IS0LrCKEgqFMB8IU83apRslm/SuAZeMMTJ2OGh/SAAyYtJr/9HGanHkmu9Y00xdsMZkC30Eevj9xmbcs6WEXYJuFd0zU8IsemMOLOdUtbkMKX28S5vFAlWOL4JYRcKuZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZhJFRJOg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740450514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2giTZHStMn+eSIeoZsooVzDmKiBSO2mDY/bn03jyBAQ=;
	b=ZhJFRJOgXgWFX4KAbazL5LuA6wHDSfa3hgGd8gAAF4qhcCtzdxLFZlP7/QnPT04l+mdG5D
	O4jAdnVpMU379tkl0RQ52lLeRTIgHLvTd3Nnb4doDyzOC0nfFpN8U17HfPbb8pBqCgJfQb
	dUYEY43dH0u+ELuKTxaknzI7BYyDVgM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-qI7JLcOwOdCDMw59u4ccWA-1; Mon,
 24 Feb 2025 21:28:28 -0500
X-MC-Unique: qI7JLcOwOdCDMw59u4ccWA-1
X-Mimecast-MFC-AGG-ID: qI7JLcOwOdCDMw59u4ccWA_1740450507
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B24E180087B;
	Tue, 25 Feb 2025 02:28:27 +0000 (UTC)
Received: from fedora (unknown [10.72.120.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D2931800357;
	Tue, 25 Feb 2025 02:28:18 +0000 (UTC)
Date: Tue, 25 Feb 2025 10:28:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] blk-throttle: fix off-by-one jiffies wait_time
Message-ID: <Z70qvZEBdq6L3-Yb@fedora>
References: <20250222092823.210318-1-yukuai1@huaweicloud.com>
 <20250222092823.210318-3-yukuai1@huaweicloud.com>
 <Z7nAJSKGANoC0Glb@fedora>
 <f2f54206-b5c0-7486-d607-337d29e9c145@huaweicloud.com>
 <Z7vnTyk6Y6X4JWQB@fedora>
 <e6a29a6a-f5ec-7953-14e9-2550a549f955@huaweicloud.com>
 <Z7w0P8ImJiZhRsPD@fedora>
 <611f02a8-8430-16cf-46e5-e9417982b077@huaweicloud.com>
 <Z70btzRaN83FbTJp@fedora>
 <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8473fca2-16ab-b2a6-ede7-d1449aa7d463@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Feb 25, 2025 at 10:07:06AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/25 9:24, Ming Lei 写道:
> > > -       if (!time_elapsed)
> > > +       /* don't trim slice until at least 2 slice is used */
> > > +       if (time_elapsed < tg->td->throtl_slice * 2)
> > >                  return;
> > 
> > If you just want to fix throtl/001, the above patch might
> > work(sometimes, it might not, and timer may expire by 2 jiffies), but it
> > is easy to fail other tests, such as, reduce the bps limit a bit, and
> > increase BS a bit to make the IO cross exactly two slices.
> 
> That's fine, the key point is the following code, above code is
> just to make sure there is still at least one slice to trim after
> removing the last slice.
> 
> +       /* dispite the last slice, trim previous slice */
> +       time_elapsed -= tg->td->throtl_slice;
> 
> In this case, if one BIO cross 1+ slices, the rate is the same as
> expected in the previous slices, we can trim them without any negative
> impact.

Can you explain in details why it signals that the rate is expected now?

If rate isn't expected, it will cause trouble to trim, even just the
previous part.


Thanks,
Ming


