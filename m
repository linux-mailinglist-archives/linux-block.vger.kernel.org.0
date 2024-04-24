Return-Path: <linux-block+bounces-6489-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3648AFD6C
	for <lists+linux-block@lfdr.de>; Wed, 24 Apr 2024 02:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704EB1F2318D
	for <lists+linux-block@lfdr.de>; Wed, 24 Apr 2024 00:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A946BF;
	Wed, 24 Apr 2024 00:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3JlSK1/"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6084A23
	for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 00:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713919615; cv=none; b=hM56gkYT2LKoxFHlXothxxkXIelC9RkLOwVjj94/iIohl0csh669LvjmtIaFSK8DE1FdE3t8H/vNeIeQSHsenNvXasYaaNDUUyJ96Pl8LvTLrzcPVLwPFaKhpjfNGoz3VlvUBBXFOw9w/UaEZRdz67+2WlXpzzuI8d8MY2oALvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713919615; c=relaxed/simple;
	bh=tYlbw/pKwD/r8Gw5MGbGl8jMwfpelqNv+nZ80pbXq88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebalnJ/Hu2PpPLK6rTykGWRC/Xun2mceMdSCCwlNe7TEveKnRIEgZr1Lq0m9FbPh8pDmSVkqAT8WPxfOC+wehKRmdfh+Odm4o0Pc0j71/Llv6dNxseXWSvKCX8t9YplHhmdQtsWjU6DDnxJAo8IvjNSoYUvKsjLXmuaRxHcocc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W3JlSK1/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713919613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3j5Urzh+140KLZbwLI03YxQoR4KLY5IJrkFu8L5hfkg=;
	b=W3JlSK1/UtNzN1a1Lsu7NLZ6Un156LIxs7+CBHNDC6AQICc+qPgFz9okmmMdCMcQDB179L
	HVJJMiv66eY7V48/uOIs3gMEsSI5cgxMc9Z4PVqYpJUCUL5nRj3grL/ThCNVq2c5yzPMoT
	WRX8avSgAj3q7fMmE6374fzY/6tqR7w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-rImn7pH6MKayPPuZ6_dZ_g-1; Tue,
 23 Apr 2024 20:46:49 -0400
X-MC-Unique: rImn7pH6MKayPPuZ6_dZ_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E32103C0008F;
	Wed, 24 Apr 2024 00:46:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E9CEF3543A;
	Wed, 24 Apr 2024 00:46:45 +0000 (UTC)
Date: Wed, 24 Apr 2024 08:46:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 5/9] io_uring: support SQE group
Message-ID: <ZihWcV8+3rfyYxGI@fedora>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
 <20240408010322.4104395-6-ming.lei@redhat.com>
 <e36cc8de-3726-4479-8fbd-f54fd21465a2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e36cc8de-3726-4479-8fbd-f54fd21465a2@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, Apr 22, 2024 at 12:27:28PM -0600, Jens Axboe wrote:
> On 4/7/24 7:03 PM, Ming Lei wrote:
> > SQE group is defined as one chain of SQEs starting with the first sqe that
> > has IOSQE_EXT_SQE_GROUP set, and ending with the first subsequent sqe that
> > doesn't have it set, and it is similar with chain of linked sqes.
> > 
> > The 1st SQE is group leader, and the other SQEs are group member. The group
> > leader is always freed after all members are completed. Group members
> > aren't submitted until the group leader is completed, and there isn't any
> > dependency among group members, and IOSQE_IO_LINK can't be set for group
> > members, same with IOSQE_IO_DRAIN.
> > 
> > Typically the group leader provides or makes resource, and the other members
> > consume the resource, such as scenario of multiple backup, the 1st SQE is to
> > read data from source file into fixed buffer, the other SQEs write data from
> > the same buffer into other destination files. SQE group provides very
> > efficient way to complete this task: 1) fs write SQEs and fs read SQE can be
> > submitted in single syscall, no need to submit fs read SQE first, and wait
> > until read SQE is completed, 2) no need to link all write SQEs together, then
> > write SQEs can be submitted to files concurrently. Meantime application is
> > simplified a lot in this way.
> > 
> > Another use case is to for supporting generic device zero copy:
> > 
> > - the lead SQE is for providing device buffer, which is owned by device or
> >   kernel, can't be cross userspace, otherwise easy to cause leak for devil
> >   application or panic
> > 
> > - member SQEs reads or writes concurrently against the buffer provided by lead
> >   SQE
> 
> In concept, this looks very similar to "sqe bundles" that I played with
> in the past:
> 
> https://git.kernel.dk/cgit/linux/log/?h=io_uring-bundle

Indeed, so looks it is something which io_uring needs.

> 
> Didn't look too closely yet at the implementation, but in spirit it's
> about the same in that the first entry is processed first, and there's
> no ordering implied between the test of the members of the bundle /
> group.

Yeah.

> 
> I do think that's a flexible thing to support, particularly if:
> 
> 1) We can do it more efficiently than links, which are pretty horrible.

Agree, link is hard to use in async/.await of modern language per my
experience.

Also sqe group won't break link, and the group is thought as a whole
wrt. linking.

> 2) It enables new worthwhile use cases
> 3) It's done cleanly 
> 4) It's easily understandable and easy to document, so that users will
>    actually understand what this is and what use cases it enable. Part
>    of that is actually naming, it should be readily apparent what a
>    group is, what the lead is, and what the members are. Using your
>    terminology here, definitely worth spending some time on that to get
>    it just right and self evident.

All are nice suggestions, and I will follow above and make them in V2.


Thanks,
Ming


