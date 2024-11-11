Return-Path: <linux-block+bounces-13828-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1D9C393B
	for <lists+linux-block@lfdr.de>; Mon, 11 Nov 2024 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF7B280A98
	for <lists+linux-block@lfdr.de>; Mon, 11 Nov 2024 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92486158A1F;
	Mon, 11 Nov 2024 07:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGvZi/XC"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1A7158A19
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311442; cv=none; b=L7Uzu8DXsk5rqKlIw/gFHbH/QbROFV39NQExVC2fkzq7UPmL8SiUy2sj6euJGyHq/s0c7jC7d3TXdsPgRnIQouQrqaxYk7P4lRMCJxgDC8znLpELdNQM7GE7rH2XUh8stTZRg2S3HTm0w+wDOMFuSl9xWw1BpuZMh9VvyAF0UUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311442; c=relaxed/simple;
	bh=KZSjBeT1ZHBaAyAbh0LLbXDmCBqjEme68FBdwfk+sMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/4E+Iic5oVCBwMTkLULcE5kKVz88UbjYGPgzk9m0ewjF3sJW3QQhLGB/d8sn86cSYOHbEh1C4OLPBSA+j/lqNYHSGp79I1Rd7MgeLWIphPOPJV0VqAS68VbSVuhA1/YwvOX0twXCVjMArwjIJFAJ/Nb8/hEjpYdKi2diJlqPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OGvZi/XC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731311439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EPSykUk6CFamnrhj8Yt4+NDgP3nB3bb2Rqcfo0R9xWk=;
	b=OGvZi/XCFzolPNxtmjiX28fhHqvbJbWh+EmgNcWKkWV2EeapduQnL8Ly1P6to4UTXxLHmO
	Cgj30x4gCcGvlI5fCyF4faDh+97ahwHQVgNQMwDjAlEEXf2BLBMdP9EYfG46nZEf+sNJUs
	kLpgg4P0J8eqj0DSYpn3KNfUy5Pde7U=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-UFlmMrouMzi-4Pw2F8AAkQ-1; Mon,
 11 Nov 2024 02:50:35 -0500
X-MC-Unique: UFlmMrouMzi-4Pw2F8AAkQ-1
X-Mimecast-MFC-AGG-ID: UFlmMrouMzi-4Pw2F8AAkQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0900319792F0;
	Mon, 11 Nov 2024 07:50:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6F4219560A3;
	Mon, 11 Nov 2024 07:50:31 +0000 (UTC)
Date: Mon, 11 Nov 2024 15:50:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Guangwu Zhang <guazhang@redhat.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [bug report] fio failed with --fixedbufs
Message-ID: <ZzG3Qk0wvKR67CoU@fedora>
References: <CAGS2=YqYbvNi6zu8e9e=R+gZMKwY_LegK2vi2MSgdsL1pMyDLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS2=YqYbvNi6zu8e9e=R+gZMKwY_LegK2vi2MSgdsL1pMyDLA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Guangwu,

On Mon, Nov 11, 2024 at 03:20:22PM +0800, Guangwu Zhang wrote:
> Hi,
> 
> Get the fio error like below, please have a look if something wrong  here,
> can not reproduce it if remove "--fixedbufs".
> 
> Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
> Commit: 51b3526f50cf5526b73d06bd44a0f5e3f936fb01
> 

The issue should be fixed by the following patch:

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index e7723759cb23..401c861ebc8e 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -221,6 +221,7 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
                struct io_ring_ctx *ctx = req->ctx;
                struct io_rsrc_node *node;

+               req->buf_index = READ_ONCE(sqe->buf_index);
                node = io_rsrc_node_lookup(&ctx->buf_table, req->buf_index);
                if (unlikely(!node))
                        return -EFAULT;



Thanks,
Ming


