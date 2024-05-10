Return-Path: <linux-block+bounces-7235-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCE48C263D
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9821F211D8
	for <lists+linux-block@lfdr.de>; Fri, 10 May 2024 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4C64C7D;
	Fri, 10 May 2024 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9WUhkr3"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AF127B69
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349745; cv=none; b=PZmEFwvNNWnR4Ov3qG1/Ki5lYWvneC8towGRAvCDfIfqIA21AbktqOxnE6+ymyYb95B1rMA/w1jxnVaos3IJ8R1sMNWV3mpE7DKzDPcVz2i+GIR0+xuUBEjnAynZYStVH/e5Qk4vqpEMNGSI+2Hm76k2OXRfSDVNMRe1RRv3VR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349745; c=relaxed/simple;
	bh=qNrQblarQm/eAKeHXbimZo9JwH2CpESovcKUE0JuP/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGAfEg7XzLCeZoxaAWxxqN9yUfVSkI3KLDzIeBfARAs/AuRKATjjupMqqHhtS5Jccz1ua5GZ5Lf4wn/KX5jAg8SRg6NXmQSWHMbB5QfsQ6tz62pI6jqka3e36Ax9GueyGuSvgFBr726jQZw0jo1rEVeCv23rjxymHxNgqthZnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9WUhkr3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715349742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1dqZxcbBRaFgQ3CYFJI1laffgSrUenXWyya9D4bc6s=;
	b=S9WUhkr3DhNm3tM1MxXz0WoBai+gYBeUESm9VBoieXKNQyPjNQJ3jCMW/Yp8kagzDGNX2Z
	WNAZKwgbd7pYqG07DsGuY62RTTdNeHNC4/xHxGC5TmbG1qMi/hw5bt05RroH41dPyEfKVs
	YrtuE5pLjf7Nof5omfCbItLiAGvx/xY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-_mDPlR_MNkaHfJKcasvu6w-1; Fri, 10 May 2024 10:02:19 -0400
X-MC-Unique: _mDPlR_MNkaHfJKcasvu6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BD578016FA;
	Fri, 10 May 2024 14:02:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.93])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A1641D6946B;
	Fri, 10 May 2024 14:02:15 +0000 (UTC)
Date: Fri, 10 May 2024 22:02:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>
Subject: Re: [RFC PATCH V2 0/9] io_uring: support sqe group and provide group
 kbuf
Message-ID: <Zj4o5LjuLo6fGeDd@fedora>
References: <20240506162251.3853781-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506162251.3853781-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, May 07, 2024 at 12:22:36AM +0800, Ming Lei wrote:
> Hello,
> 
> The 1st 4 patches are cleanup, and prepare for adding sqe group.
> 
> The 5th patch supports generic sqe group which is like link chain, but
> allows each sqe in group to be issued in parallel, so N:M dependency can be
> supported with sqe group & io link together.
> 
> The 6th patch supports one variant of sqe group: allow members to depend
> on group leader, so that kernel resource lifetime can be aligned with
> group leader or group, then any kernel resource can be shared in this
> sqe group, and can be used in generic device zero copy.
> 
> The 7th & 8th patches supports providing sqe group buffer via the sqe
> group variant.
> 
> The 9th patch supports ublk zero copy based on io_uring providing sqe
> group buffer.
> 
> Tests:
> 
> 1) pass liburing test
> - make runtests
> 
> 2) write/pass two sqe group test cases:
> 
> https://github.com/axboe/liburing/compare/master...ming1:liburing:sqe_group_v2
> 
> covers related sqe flags combination and linking groups, both nop and
> one multi-destination file copy.
> 
> 3) ublksrv zero copy:
> 
> ublksrv userspace implements zero copy by sqe group & provide group
> kbuf:
> 
> 	git clone https://github.com/ublk-org/ublksrv.git -b group-provide-buf_v2
> 	make test T=loop/009:nbd/061:nbd/062	#ublk zc tests
> 
> When running 64KB block size test on ublk-loop('ublk add -t loop --buffered_io -f $backing'),
> it is observed that perf can be doubled.
> 
> Any comments are welcome!
> 
> V2:
> 	- add generic sqe group, suggested by Kevin Wolf
> 	- add REQ_F_SQE_GROUP_DEP which is based on IOSQE_SQE_GROUP, for sharing
> 	  kernel resource in group wide, suggested by Kevin Wolf
> 	- remove sqe ext flag, and use the last bit for IOSQE_SQE_GROUP(Pavel),
> 	in future we still can extend sqe flags with one uring context flag
> 	- initialize group requests via submit state pattern, suggested by Pavel
> 	- all kinds of cleanup & bug fixes

Please ignore V2, and will send V3 with simplification & cleanup, and
many fixes on error handling code path.


Thanks,
Ming


