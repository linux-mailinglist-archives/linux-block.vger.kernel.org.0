Return-Path: <linux-block+bounces-17012-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86308A2B8AA
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 03:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208F2166F2E
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 02:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7DF1632F3;
	Fri,  7 Feb 2025 02:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aavz9zM0"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99911865E2
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738894000; cv=none; b=WT6JuaLjJR19fdn5auhn6vOfNqwvVDms8cvFardoruTpFB1j8AiCj+SLBKrUp4nlSvdB23NtVLZG5I56hZhp6nam0SghKC3Tz0A8pP97jCBFWC4pL+teUYj8ZIIMvQvkFw4M3GV2bhoydw30ZqweZ39EkdHkZnOeDE0TUY7R6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738894000; c=relaxed/simple;
	bh=SGdG/+0IvAUv2FDUjmYnZFVktwf4JG9Gz6Yqo168NDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpP7NjgC/H7g4ObDavtpnpc5RcRl8ZQUzV0U8+Rt2HmGcaJHf/INUxW6/M77D0TEmGggi/kjxlqgZrMtHsbDUoyFkECOWXW9x5R6SeTl6xSYRQKO5Yxs9HA10aR9G7ykpPKRIHmgZu1Cse6jFXcL+aqs02SrLOkj7FnWkiYA+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aavz9zM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738893997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=negwGvhk8J88UWnuNmaVTE7IbofbqrpwT5PQuf4vr3w=;
	b=aavz9zM0ORRqY2Tm6pDyCLytZ848zSPPfSaJOIO951OzzHNFrWyUYQY5CcmQTvKVPoT4Ru
	ZbdiP/El51q/R8esDLMQIu63Qk3PbWLC+AYQ4uai051NOh2exgIiPBnnZ06erD1JzXNnad
	LdHwY7GTRogfoR3fov4IDNniWJcjNkY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-Jkp7JE85NRmyHey07Jqnsw-1; Thu,
 06 Feb 2025 21:06:34 -0500
X-MC-Unique: Jkp7JE85NRmyHey07Jqnsw-1
X-Mimecast-MFC-AGG-ID: Jkp7JE85NRmyHey07Jqnsw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C91E19560B7;
	Fri,  7 Feb 2025 02:06:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 190281955BD4;
	Fri,  7 Feb 2025 02:06:20 +0000 (UTC)
Date: Fri, 7 Feb 2025 10:06:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Vishnu ks <ksvishnu56@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Song Liu via Lsf-pc <lsf-pc@lists.linux-foundation.org>,
	hch@infradead.org, yanjun.zhu@linux.dev,
	linux-block@vger.kernel.org, bpf@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints
 for Next-Generation Backup Systems
Message-ID: <Z6Vqlo3s3sK6d0ng@fedora>
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
 <CAPhsuW7+ORExwn5fkRykEmEp-wm0YE788Tkd39rK5cZ-Q3dfUw@mail.gmail.com>
 <CAJHDoJYESDzDf9KJgfSfGGit6JPyxtf3miNbnM7BzNfjOi7CQw@mail.gmail.com>
 <CAPhsuW6W=08Vf=W6GZ9DCzwu4wq_AgNOayo50vxvqFMr9CcDcg@mail.gmail.com>
 <677c56994576b_f58f29445@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHDoJZ5rFhgu-R_N6e82bqkY43S-sXKVs2khnnnZrqJH1vcHw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Jan 13, 2025 at 11:01:30PM +0530, Vishnu ks wrote:
> Thanks everyone for the detailed technical feedback and clarifications
> - they've been extremely valuable in understanding the fundamental
> challenges and existing solutions.
> 
> I appreciate the points about md-cluster and DRBD's network RAID
> capabilities. While these are robust solutions for network-based
> replication, I'm particularly interested in the point-in-time recovery
> capability for scenarios like ransomware recovery, where being able to
> roll back to a specific point before encryption occurred would be
> valuable.
> 
> Regarding blk_filter - I've been exploring it since it was mentioned,
> and it indeed seems to be the right approach for what we're trying to
> achieve. However, I've found that many of our current requirements can
> actually be implemented using eBPF without additional kernel modules.
> I plan to create a detailed demonstration video to share my findings
> with this thread. Additionally, I'll be cleaning up and open-sourcing
> our replicator utility implementation for community feedback.
> 
> I would very much like to attend the LSF/MM/BPF summit to discuss
> these ideas in person and learn more about blk_filter and proper block
> layer fundamentals. Would it be possible for someone to help me with
> an invitation?

If one pair of bpf struct_ops are added for attaching to submit_bio()
and ->bi_end_io() in bio_endio(), lots of cases can be covered:

- blk filter

- bio interposer

- blk-snap

- easier IO trace

...

Then both bio and request based devices can be covered.

It shouldn't be hard to figure out generic bio/bvec kfuncs for helping block IO
bpf prog to do more valuable things & fun.

Thanks, 
Ming


