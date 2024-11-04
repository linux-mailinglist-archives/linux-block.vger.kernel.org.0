Return-Path: <linux-block+bounces-13484-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81979BB64C
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2024 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 263451C21FA2
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2024 13:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CC8139CE3;
	Mon,  4 Nov 2024 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFPsr4AC"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083C28E37
	for <linux-block@vger.kernel.org>; Mon,  4 Nov 2024 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727354; cv=none; b=mBsJbqLrH6D3xSrDcDuo5KUVYKrmoaFefs/y4sEdJM7d0YoSImHUmiESeZwhY/60XKhTTCnI2+nVLqBI0gcQQjuA577t7ogz+sD5yTp63EPBp/tcAHBBT4XO5zgFUGgMZUphnA5XISObykzHTj3M1QgI1mUcOR/HAcQIOUjEMIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727354; c=relaxed/simple;
	bh=YEK5pwU5KWMl96LHESzPshET/RQ5gM3YQ0JYQ3EgjX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw8nfSaWciCPLQFBkC5OKA9Ck/fa5pqvwTYsAkSNXAfnlOE1e6VtPvc3RnNd8p/S5jYyMdbyU7JgBmPUqQ/5hCC9dncf9Q22vA5L1c3W30r3QFzeN3Rl/MLhYD2rFkv6rsFvGZws7+E5HrsQR8eJuqhEQF6M4+c4e+ex4L/5ZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PFPsr4AC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730727351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SXzq02D5y5fpTR05r71dRc1+lQvGNJmTrdWBezDDR14=;
	b=PFPsr4AC1hE+vA+kLq/HNgKELJ28KK1zD2vz5szU8no1Krg2FJrvHDiFhefuRgjIDpIuQs
	9Dy/Q3zMTrbBCD6AkGmLHV+n+O90ql9B5Lam4o9gBlWh78WNP2nKP+Y2TjManQ9xNzZj5b
	1Kq1OqUkXK/hdsl6Nl4nfvAyYdCrYew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-uI2Sae98P3uR7Zd_sc916A-1; Mon,
 04 Nov 2024 08:35:50 -0500
X-MC-Unique: uI2Sae98P3uR7Zd_sc916A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 931711955D4B;
	Mon,  4 Nov 2024 13:35:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.2])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E053D19560AD;
	Mon,  4 Nov 2024 13:35:44 +0000 (UTC)
Date: Mon, 4 Nov 2024 21:35:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>
Subject: Re: [PATCH V8 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZyjNq92M8qhJFEKm@fedora>
References: <ZyGURQ-LgIY9DOmh@fedora>
 <40107636-651f-47ea-8086-58953351c462@gmail.com>
 <ZyQpH8ttWAhS9C5G@fedora>
 <4802ef4c-84ca-4588-aa34-6f1ffa31ac49@gmail.com>
 <ZygSWB08t1PPyPyv@fedora>
 <0cd7e62b-3e5d-46f2-926b-5e3c3f65c7dd@gmail.com>
 <ZyghmwcI1U4WizyX@fedora>
 <74d8d323-789c-4b4d-8ce6-ada6a567b552@gmail.com>
 <ZyjHQN9VITpOlyPA@fedora>
 <8fc4d419-5d16-4f58-ae66-8267edaff6ef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fc4d419-5d16-4f58-ae66-8267edaff6ef@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Nov 04, 2024 at 01:24:09PM +0000, Pavel Begunkov wrote:
> On 11/4/24 13:08, Ming Lei wrote:
> > On Mon, Nov 04, 2024 at 12:23:04PM +0000, Pavel Begunkov wrote:
> > > On 11/4/24 01:21, Ming Lei wrote:
> ...>>>> 3. The lease ends, and we copy full 4K back to user space with the
> > > > > unitialised chunk.
> > > > > 
> > > > > You can correct me on ublk specifics, I assume 3. is not a copy and
> > > > > the user in 3 is the one using a ublk block device, but the point I'm
> > > > > making is that if something similar is possible, then just zeroing is not
> > > > > enough, the user can skip the step filling the buffer. If it can't leak
> > > > 
> > > > Can you explain how user skips the step given read IO is member of one group?
> > > 
> > > (2) Illustrates it, it can also be a nop with no read/recv
> > 
> > As I explained before, the application has to be trusted, and it must
> > have the permission to open the device & call into the buffer lease
> > uring_cmd.
> 
> It might be trusted to read some data of the process using the
> device, but obviously it can't be trusted to read random kernel data.
> I'm trying to understand which one is that.

For example of ublk, one READ IO is coming on /dev/ublkbN, and the IO command
is forwarded to userspace for handling:

- the application(ublk server) read data from another file/socket into
the kernel buffer of the IO command via io_uring io group for handling
the READ IO

- the leader uring_cmd leases kernel buffer to io_uring

- member OPs read from FS or socket to the leased kernel buffer, and
zeroing the remained part in case of short read/recv

And how can one application read random kernel data? That is definitely one
security problem.

> 
> > It is in same situation with any user emulated storage, such as qemu,
> > fuse, and the application has to do things right.
> > 
> > > 
> > > > > any private data, then the buffer should've already been initialised by
> > > > > the time it was lease. Initialised is in the sense that it contains no
> > > > 
> > > > For block IO the practice is to zero the remainder after short read, please
> > > > see example of loop, lo_complete_rq() & lo_read_simple().
> > > 
> > > It's more important for me to understand what it tries to fix, whether
> > > we can leak kernel data without the patch, and whether it can be exploited
> > > even with the change. We can then decide if it's nicer to zero or not.
> > > 
> > > I can also ask it in a different way, can you tell is there some security
> > > concern if there is no zeroing? And if so, can you describe what's the exact
> > > way it can be triggered?
> > 
> > Firstly the zeroing follows loop's handling for short read
> 
> > Secondly, if the remainder part of one page cache buffer isn't zeroed, it might
> > be leaked to userspace via another read() or mmap() on same page.
> 
> What kind of data this leaked buffer can contain? Is it uninitialised
> kernel memory like a freshly kmalloc'ed chunk would have? Or is it private
> data of some user process?

Yes, the page may be uninitialized, and might contain random kernel data.


Thanks,
Ming


