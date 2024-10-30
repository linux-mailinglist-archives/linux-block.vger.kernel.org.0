Return-Path: <linux-block+bounces-13198-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 240F19B5A9C
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 05:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2C41C20FCA
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2024 04:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB533E7;
	Wed, 30 Oct 2024 04:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OutDP1Ds"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57997125DF
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 04:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261490; cv=none; b=YCjCVn/x/TKT2e7yrWQKHybmn77Eh/3KWeLzpvYEVCVU/g0VG9LOwU5Qdd+v4clBkmIRgQ/j+lRZiMUXfYqocVpFu4ax7dytJMx4ju6Z8wgJaTiZSRYkBl8zF119nM4ARpPguNNRErdDoJHb26UZCtvvVhYy7KsxpryzJlbcn/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261490; c=relaxed/simple;
	bh=KfSmvBYq+xaNY7BxHc4uMlmJklrJv/l+lMd009vbhyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcV645Z2yTEFsvZv4UpRIh3//UMLS91ZlYxbITNbz9nn6mJZPpaT9KuoeQPzpiAt9i1jGjz0zAamfZwy5x+3KLkB0Ertfpq0eNYnxdG2zFcWVTU+07fPRHu5pRyuIcGbkZc6m0qt6SiGTDeh8vdw8+2VioA4jWx78OOwRXMGkok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OutDP1Ds; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730261487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLYSYXpb7RguVtdWGdRNP6OWFD7CQmS+fcD1OXN5Krw=;
	b=OutDP1DsWqvG3sPclXW34bHfxZxfUfRuJhw7lPx0c4/WnRoNHP5FbRDXDSdam8UBpK141u
	/7TP3bmidaZstQinM4p72cgVwU+K3+0lPcHBxMrXGOtpw8CZHJftrsGmdAOduFpRAixGMa
	ZUHn3/MgXNR2BLIDEtE3LjYWDxrbvbA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-4SdumlcJPmuvcFkLWuPXqw-1; Wed,
 30 Oct 2024 00:11:23 -0400
X-MC-Unique: 4SdumlcJPmuvcFkLWuPXqw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4863D195608C;
	Wed, 30 Oct 2024 04:11:22 +0000 (UTC)
Received: from fedora (unknown [10.72.116.45])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF63C1956054;
	Wed, 30 Oct 2024 04:11:17 +0000 (UTC)
Date: Wed, 30 Oct 2024 12:11:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 0/8] io_uring: support sqe group and leased group kbuf
Message-ID: <ZyGx4JBPdU4VlxlZ@fedora>
References: <20241025122247.3709133-1-ming.lei@redhat.com>
 <15b9b1e0-d961-4174-96ed-5a6287e4b38b@gmail.com>
 <d859c85c-b7bf-4673-8c77-9d7113f19dbb@kernel.dk>
 <bc44d3c0-41e8-425c-957f-bad70aedcc50@kernel.dk>
 <e76d9742-5693-4057-b925-3917943c7441@kernel.dk>
 <f51e50c8-271e-49b6-b3e1-a63bf61d7451@kernel.dk>
 <ZyGT3h5jNsKB0mrZ@fedora>
 <674e8c3c-1f2c-464a-ad59-da3d00104383@kernel.dk>
 <ZyGjID-17REc9X3e@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyGjID-17REc9X3e@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Wed, Oct 30, 2024 at 11:08:16AM +0800, Ming Lei wrote:
> On Tue, Oct 29, 2024 at 08:43:39PM -0600, Jens Axboe wrote:

...

> > You could avoid the OP dependency with just a flag, if you really wanted
> > to. But I'm not sure it makes a lot of sense. And it's a hell of a lot
> 
> Yes, IO_LINK won't work for submitting multiple IOs concurrently, extra
> syscall makes application too complicated, and IO latency is increased.
> 
> > simpler than the sqe group scheme, which I'm a bit worried about as it's
> > a bit complicated in how deep it needs to go in the code. This one
> > stands alone, so I'd strongly encourage we pursue this a bit further and
> > iron out the kinks. Maybe it won't work in the end, I don't know, but it
> > seems pretty promising and it's soooo much simpler.
> 
> If buffer register and lookup are always done in ->prep(), OP dependency
> may be avoided.

Even all buffer register and lookup are done in ->prep(), OP dependency
still can't be avoided completely, such as:

1) two local buffers for sending to two sockets

2) group 1: IORING_OP_LOCAL_KBUF1 & [send(sock1), send(sock2)]  

3) group 2: IORING_OP_LOCAL_KBUF2 & [send(sock1), send(sock2)]

group 1 and group 2 needs to be linked, but inside each group, the two
sends may be submitted in parallel.


Thanks,
Ming


