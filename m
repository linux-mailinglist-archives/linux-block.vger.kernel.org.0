Return-Path: <linux-block+bounces-9189-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A9791182E
	for <lists+linux-block@lfdr.de>; Fri, 21 Jun 2024 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C91BB21DD6
	for <lists+linux-block@lfdr.de>; Fri, 21 Jun 2024 01:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAF082492;
	Fri, 21 Jun 2024 01:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UskBQ7lt"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B042052
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 01:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934512; cv=none; b=d1z12L/2IWcq4QUeyooieZx0ZWHVvYYE4dAsKG+hR5j17bgkbj+EkqcKECog5Wf/x0SETRAMdqyVP+3aCltP1sxRYm0e7ToJHZOnqN1ich8PGIC+vzE4SlYCIcRQ6ocVHz/4XJRpt4aMye/ikjm0OER8Qsux6wFsqbCnW77Mn7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934512; c=relaxed/simple;
	bh=C20k3nH7o9hsCsIoyQnvr1uaLaVR8FrP/lZwuxvZwY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHxzpNTxXaOoMThA6B5xDXohUOOpfVHmIf5DBwNwYYo/tA/ck/JC3dis8mfNCGLkYgBBOunZ2nEiFJ5k4YPnsSB9aQWPFLZfwnWb0aClHeOcP96daFcTMRGzcUjML9cjVaxtFhDTciesEMKVWlxDBAEy+wsv9tSUZ8yz/qUyVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UskBQ7lt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718934509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSuWI+jlhsZNGl6NhEeeUG2215lkvYbokyYh4ORxFeM=;
	b=UskBQ7ltUQNdMpiW9z7n5wRfDS5XtgUW8bmZRGpCZgWzbQkOMpbgi+JASG3A3Djd6tq3DL
	Xbf4gHfXN5hnYjoasoppCJ7DTvzPGyyAsg713M4lfX/hdQEELFETyKcZxpiVdpEAmd6S3q
	1CcZ/Nljcg1mZGR1qeK9xbJKpaV/brU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-VMi9FT0aNNGD-M8cDcxcXA-1; Thu,
 20 Jun 2024 21:48:25 -0400
X-MC-Unique: VMi9FT0aNNGD-M8cDcxcXA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C439E195608B;
	Fri, 21 Jun 2024 01:48:23 +0000 (UTC)
Received: from fedora (unknown [10.72.112.135])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A65119560B6;
	Fri, 21 Jun 2024 01:48:16 +0000 (UTC)
Date: Fri, 21 Jun 2024 09:48:11 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>,
	Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, ming.lei@redhat.com
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <ZnTb25qQxSi+tNOk@fedora>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <20240620153050.GA26369@lst.de>
 <hehodpowajdsfscwf7y3yaqsu2byhzkwpsiaesj5sz722efzg4@gwnod5qe7ed4>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hehodpowajdsfscwf7y3yaqsu2byhzkwpsiaesj5sz722efzg4@gwnod5qe7ed4>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 20, 2024 at 11:43:44AM -0400, Kent Overstreet wrote:
> On Thu, Jun 20, 2024 at 05:30:50PM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 20, 2024 at 02:54:09PM +0100, Matthew Wilcox wrote:
> > > I'm against it.  Block devices only do sector-aligned IO and we should
> > > not pretend otherwise.
> > 
> > While I agree with that, the bvec_iter is actually used in a few other
> > places and could be used in more, and the 512-byte sector unit bi_sector
> > is the only weird thing that's not useful elsewhere.  So turning that
> > into a
> > 
> > 	u64 bi_addr;
> > 
> > that is byte based where the meaning is specific to the user would
> > actually be kinda nice.  For traditional block users we'd need a
> > bio_sector() helpers similar to the existing bio_sectors() one,
> > but a lot of non-trivial drivers actually need to translated to
> > a variable LBA-based addressing, which would be (a tiny little bit)
> > simpler with the byte address.   As bi_size is already in bytes
> > it would also fit in pretty naturally with that.
> > 
> > The only thing that is really off putting is the amount of churn that
> > this would cause.
> 
> I'm being imprecise when I just say 'struct bio'; there's things in
> there that are block layer specific but there are also things in there
> you want that aren't block layer specific (completion callback, write
> flags, s/bi_bdev/bi_inode and that as well, perhaps). It's not at all
> clear to me we'd want to deal with the churn to split that up or make
> bio itself less block layer specific (although, but when I say 'aiming
> for commality with struct bio' that sort of thing is what I have in
> mind.
> 
> But more immediately, yes - bi_addr as all we need for this, and like
> you said I think it'd be a worthwhile change.

Still not clear why you need unaligned bi_addr for bio, if this bio needs
to call submit_bio(), it has to be aligned. Otherwise, you could invent any
structure for this purpose, and the structure can be payload of bio for
avoiding extra allocation, even it can be FS generic structure.


Thanks,
Ming


