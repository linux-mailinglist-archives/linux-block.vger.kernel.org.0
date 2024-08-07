Return-Path: <linux-block+bounces-10364-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4D949E45
	for <lists+linux-block@lfdr.de>; Wed,  7 Aug 2024 05:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1134B238BA
	for <lists+linux-block@lfdr.de>; Wed,  7 Aug 2024 03:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493B1DFEB;
	Wed,  7 Aug 2024 03:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJtCuqP9"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1545D1C3D
	for <linux-block@vger.kernel.org>; Wed,  7 Aug 2024 03:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001194; cv=none; b=YQwSzrElaYrDL2m5Rxoy+GP7IhfKsjbuhpY5tps4hdjyyBOwtHJo4Gd9oSFK/9qy6ETleKyqX4RKs73hmu05d9yD1WnaWL40m6G3HMmJS50jsKEiupQTTK0+D3Ewa0SD+PnUcnoDmzcohqmCNWjs6fh+BuLrL7i5m+587oKoNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001194; c=relaxed/simple;
	bh=1l34040akgDNhA0MPqyRJin1rk9XrjEMhPDOAr2jRNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbuAO3V8fhTNkDtd3HhRowAXEoa3PF6pu1T7BbydClidOXkbONa1UeeHcZR/8zJEUl+lU8PcYHAEhYtQoqbaC9Vomes7miLv2FdoVvRFxUkX4ZqxcZnFVYOm9S5TUiL6acHsWtvC2bEEPhg3yNKJlm/uXfDkq3Xu7BcXR1vhlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJtCuqP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723001192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/dinE0U3DXgNF3It9WDdE2sY9Vm7epHjtCAMrzNLFo=;
	b=FJtCuqP90vdXkXR/fW6JzkoLlpwsLJCtzKeUL0rmEBPOqL6UZxekYeM1tL/A5URj8oBii/
	ofrGgy5zSanNbQb5/+oS5khDLArS0GRwHY7HQ5RWy6unGiPLx6pJvaWkt71P+hbE4TdM77
	8IUCddIPxUW0mbnVFZI2R86Kt4ZpdTA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-V2oa1_0DMp6eo3kUr37_yQ-1; Tue,
 06 Aug 2024 23:26:28 -0400
X-MC-Unique: V2oa1_0DMp6eo3kUr37_yQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CD9A1955D44;
	Wed,  7 Aug 2024 03:26:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.110])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA0873001D8E;
	Wed,  7 Aug 2024 03:26:22 +0000 (UTC)
Date: Wed, 7 Aug 2024 11:26:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH V4 4/8] io_uring: support SQE group
Message-ID: <ZrLpWT/sBGll1OmS@fedora>
References: <20240706031000.310430-1-ming.lei@redhat.com>
 <20240706031000.310430-5-ming.lei@redhat.com>
 <fa5e8098-f72f-43c1-90c1-c3eaebfea3d5@gmail.com>
 <Zp+/hBwCBmKSGy5K@fedora>
 <0fa0c9b9-cfb9-4710-85d0-2f6b4398603c@gmail.com>
 <ZqIp7/Ci+abGcZLG@fedora>
 <5fd602d8-0c0b-418a-82bc-955ab0444b1e@gmail.com>
 <ZrHg8LUOeM23318x@fedora>
 <ZrIyqrnc15PSRrCz@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrIyqrnc15PSRrCz@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Aug 06, 2024 at 10:26:50PM +0800, Ming Lei wrote:
> On Tue, Aug 06, 2024 at 04:38:08PM +0800, Ming Lei wrote:
> > On Mon, Jul 29, 2024 at 02:58:58PM +0100, Pavel Begunkov wrote:
> > > On 7/25/24 11:33, Ming Lei wrote:
> > > > On Wed, Jul 24, 2024 at 02:41:38PM +0100, Pavel Begunkov wrote:
> > > > > On 7/23/24 15:34, Ming Lei wrote:
> > > ...
> > > > > > But grp_refs is dropped after io-wq request reference drops to
> > > > > > zero, then both io-wq and nor-io-wq code path can be unified
> > > > > > wrt. dealing with grp_refs, meantime it needn't to be updated
> > > > > > in extra(io-wq) context.
> > > > > 
> > > > > Let's try to describe how it can work. First, I'm only describing
> > > > > the dep mode for simplicity. And for the argument's sake we can say
> > > > > that all CQEs are posted via io_submit_flush_completions.
> > > > > 
> > > > > io_req_complete_post() {
> > > > > 	if (flags & GROUP) {
> > > > > 		req->io_task_work.func = io_req_task_complete;
> > > > > 		io_req_task_work_add(req);
> > > > > 		return;
> > > > > 	}
> > > > > 	...
> > > > > }
> > > > 
> > > > OK.
> > > > 
> > > > io_wq_free_work() still need to change to not deal with
> > > > next link & ignoring skip_cqe, because group handling(
> > > 
> > > No, it doesn't need to know about all that.
> > > 
> > > > cqe posting, link advance) is completely moved into
> > > > io_submit_flush_completions().
> > > 
> > > It has never been guaranteed that io_req_complete_post()
> > > will be the one completing the request,
> > > io_submit_flush_completions() can always happen.
> > > 
> > > 
> > > struct io_wq_work *io_wq_free_work(struct io_wq_work *work)
> > > {
> > > 	...
> > > 	if (req_ref_put_and_test(req)) {
> > > 		nxt = io_req_find_next(req);
> > > 		io_free_req();
> > > 	}
> > > }
> > > 
> > > We queue linked requests only when all refs are dropped, and
> > > the group handling in my snippet is done before we drop the
> > > owner's reference.
> > > 
> > > IOW, you won't hit io_free_req() in io_wq_free_work() for a
> > > leader unless all members in its group got completed and
> > > the leader already went through the code dropping those shared
> > > ublk buffers.
> > 
> > If io_free_req() won't be called for leader, leader won't be added
> > to ->compl_reqs, and it has to be generated when all members are
> > completed in __io_submit_flush_completions().
> > 
> > For !io_wq, we can align to this way by not completing leader in
> > io_req_complete_defer().
> > 
> > The above implementation looks simpler, and more readable.
> 
> Thinking of this issue further, looks the above is still not doable:
> 
> 1) for avoiding to hit io_free_req(), extra req->refs has to be grabbed,
> then the leader's completion may not be notified.
> 
> 2) 1) may be avoided by holding one leader's refcount for each member,
> and call req_ref_put_and_test(leader) when leader or member is
> completed, and post leader's CQE when leader's refs drops to zero.
> But there are other issues:
> 
> 	- other req_ref_inc_not_zero() or req_ref_get() may cause leader's
> 	CQE post missed
> 
> 	- the req_ref_put_and_test() in io_free_batch_list() can be called
> 	on group leader unexpectedly.
> 
> both 1) and 2) need to touch io_req_complete_defer() for completing group
> leader

oops, looks I missed the point of completing request from
io_req_complete_post() directly in the following link:

https://lore.kernel.org/linux-block/0fa0c9b9-cfb9-4710-85d0-2f6b4398603c@gmail.com/

Please ignore yesterday's replies, and now I should get the whole
picture of your point.

Thanks,
Ming


