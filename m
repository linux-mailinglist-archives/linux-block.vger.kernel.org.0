Return-Path: <linux-block+bounces-6720-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FEF8B6825
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 05:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E528211A
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2024 03:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40A6DDA6;
	Tue, 30 Apr 2024 03:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5ePrwrT"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BEDDC1
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446487; cv=none; b=kTqq/wd0uSLVpjKJlU1at5PrjzQsvtosYc2MSmdLPDQ3uh+RBMUr/BUooR+OD5jRBg68bsH00kGJDyeCU2Si4ChfFxXT3T7z+mwPKICf0rP89AYv7h7Hp+xXbuyFDoodx3cIg22t2t1hQHVtyd6jN2SReM0uLauqlVqAvqSHRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446487; c=relaxed/simple;
	bh=G2Wa4nH5qmVDa+jWc96sERXEeuhyDQw8VYrZm5O0BL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiSk+Gao6fsm0z6qm337KBdyPdNV+mXmc8RITYgBy9Lgy1yVJde7tePgSMBTVnG7Z7Z3TS3j4+OgEjG5GyRX3DzSGiJGnK6Hzd0ckqqjy8MAs0jsczaQXg4VQqkn8XWY38xXww8BsldjjASO8kyIWc+8IrlU4QToqzSaRB/BY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a5ePrwrT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714446484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ie/2/LkuQOK0CUcI8po+IT/1I81d/gzln3tpPp230GA=;
	b=a5ePrwrTasLCvM5o/NIR/3ZMkxcW2cXMz93uX+QosAz+7vl+LaG5gOpQk1Gyq7whtIMYPx
	PgkudN5GvrIrhM4bMb8XnImvdfNhQcoDAaI10izsCf1HXOANgAd2nwsbL/Bs3BL+tBVNp1
	/AuZ6UiBuitJAvgFMI7j3ghPKsuubOs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-oyLuO66yMXGwmHv68QORBA-1; Mon,
 29 Apr 2024 23:07:59 -0400
X-MC-Unique: oyLuO66yMXGwmHv68QORBA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7DA81C05AA8;
	Tue, 30 Apr 2024 03:07:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.42])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 31DCB40ED4B;
	Tue, 30 Apr 2024 03:07:54 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:07:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 5/9] io_uring: support SQE group
Message-ID: <ZjBgh+W3T5TDae6F@fedora>
References: <20240408010322.4104395-1-ming.lei@redhat.com>
 <20240408010322.4104395-6-ming.lei@redhat.com>
 <e36cc8de-3726-4479-8fbd-f54fd21465a2@kernel.dk>
 <Ziey53aADgxDrXZw@redhat.com>
 <Zihi3nDAJg1s7Cws@fedora>
 <19de460c-ac83-40ff-8113-3bb7e75f194a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19de460c-ac83-40ff-8113-3bb7e75f194a@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Mon, Apr 29, 2024 at 04:48:37PM +0100, Pavel Begunkov wrote:
> On 4/24/24 02:39, Ming Lei wrote:
> > On Tue, Apr 23, 2024 at 03:08:55PM +0200, Kevin Wolf wrote:
> > > Am 22.04.2024 um 20:27 hat Jens Axboe geschrieben:
> > > > On 4/7/24 7:03 PM, Ming Lei wrote:
> > > > > SQE group is defined as one chain of SQEs starting with the first sqe that
> > > > > has IOSQE_EXT_SQE_GROUP set, and ending with the first subsequent sqe that
> > > > > doesn't have it set, and it is similar with chain of linked sqes.
> > > > > 
> > > > > The 1st SQE is group leader, and the other SQEs are group member. The group
> > > > > leader is always freed after all members are completed. Group members
> > > > > aren't submitted until the group leader is completed, and there isn't any
> > > > > dependency among group members, and IOSQE_IO_LINK can't be set for group
> > > > > members, same with IOSQE_IO_DRAIN.
> > > > > 
> > > > > Typically the group leader provides or makes resource, and the other members
> > > > > consume the resource, such as scenario of multiple backup, the 1st SQE is to
> > > > > read data from source file into fixed buffer, the other SQEs write data from
> > > > > the same buffer into other destination files. SQE group provides very
> > > > > efficient way to complete this task: 1) fs write SQEs and fs read SQE can be
> > > > > submitted in single syscall, no need to submit fs read SQE first, and wait
> > > > > until read SQE is completed, 2) no need to link all write SQEs together, then
> > > > > write SQEs can be submitted to files concurrently. Meantime application is
> > > > > simplified a lot in this way.
> > > > > 
> > > > > Another use case is to for supporting generic device zero copy:
> > > > > 
> > > > > - the lead SQE is for providing device buffer, which is owned by device or
> > > > >    kernel, can't be cross userspace, otherwise easy to cause leak for devil
> > > > >    application or panic
> > > > > 
> > > > > - member SQEs reads or writes concurrently against the buffer provided by lead
> > > > >    SQE
> > > > 
> > > > In concept, this looks very similar to "sqe bundles" that I played with
> > > > in the past:
> > > > 
> > > > https://git.kernel.dk/cgit/linux/log/?h=io_uring-bundle
> > > > 
> > > > Didn't look too closely yet at the implementation, but in spirit it's
> > > > about the same in that the first entry is processed first, and there's
> > > > no ordering implied between the test of the members of the bundle /
> > > > group.
> > > 
> > > When I first read this patch, I wondered if it wouldn't make sense to
> > > allow linking a group with subsequent requests, e.g. first having a few
> > > requests that run in parallel and once all of them have completed
> > > continue with the next linked one sequentially.
> > > 
> > > For SQE bundles, you reused the LINK flag, which doesn't easily allow
> > > this. Ming's patch uses a new flag for groups, so the interface would be
> > > more obvious, you simply set the LINK flag on the last member of the
> > > group (or on the leader, doesn't really matter). Of course, this doesn't
> > > mean it has to be implemented now, but there is a clear way forward if
> > > it's wanted.
> > 
> > Reusing LINK for bundle breaks existed link chains(BUNDLE linked to existed
> > link chain), so I think it may not work.
> > 
> > The link rule is explicit for sqe group:
> > 
> > - only group leader can set link flag, which is applied on the whole
> > group: the next sqe in the link chain won't be started until the
> > previous linked sqe group is completed
> > 
> > - link flag can't be set for group members
> > 
> > Also sqe group doesn't limit async for both group leader and member.
> > 
> > sqe group vs link & async is covered in the last liburing test code.
> > 
> > > 
> > > The part that looks a bit arbitrary in Ming's patch is that the group
> > > leader is always completed before the rest starts. It makes perfect
> > > sense in the context that this series is really after (enabling zero
> > > copy for ublk), but it doesn't really allow the case you mention in the
> > > SQE bundle commit message, running everything in parallel and getting a
> > > single CQE for the whole group.
> > 
> > I think it should be easy to cover bundle in this way, such as add one new
> > op IORING_OP_BUNDLE as Jens did, and implement the single CQE for whole group/bundle.
> > 
> > > 
> > > I suppose you could hack around the sequential nature of the first
> > > request by using an extra NOP as the group leader - which isn't any
> > > worse than having an IORING_OP_BUNDLE really, just looks a bit odd - but
> > > the group completion would still be missing. (Of course, removing the
> > > sequential first operation would mean that ublk wouldn't have the buffer
> > > ready any more when the other requests try to use it, so that would
> > > defeat the purpose of the series...)
> > > 
> > > I wonder if we can still combine both approaches and create some
> > > generally useful infrastructure and not something where it's visible
> > > that it was designed mostly for ublk's special case and other use cases
> > > just happened to be enabled as a side effect.
> > 
> > sqe group is actually one generic interface, please see the multiple copy(
> > copy one file to multiple destinations in single syscall for one range) example
> > in the last patch, and it can support generic device zero copy: any device internal
> > buffer can be linked with io_uring operations in this way, which can't
> > be done by traditional splice/pipe.
> > 
> > I guess it can be used in network Rx zero copy too, but may depend on actual
> > network Rx use case.
> 
> I doubt. With storage same data can be read twice. Socket recv consumes

No, we don't depend on read twice of storage.

> data. Locking a buffer over the duration of another IO doesn't really sound
> plausible, same we returning a buffer back. It'd be different if you can
> read the buffer into the userspace if something goes wrong, but perhaps
> you remember the fused discussion.

As I mentioned, it depends on actual use case. If the received data can
be consumed by following io_uring OPs, such as be sent to network or
FS, this way works just fine, but if data needs to live longer or
further processing, the data can still be saved to userpsace by io_uring
OPs linked to the sqe group.


Thanks,
Ming


