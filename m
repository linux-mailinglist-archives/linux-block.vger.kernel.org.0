Return-Path: <linux-block+bounces-852-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE02808449
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 10:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D2C2814D1
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48A1E4A7;
	Thu,  7 Dec 2023 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OoHjjWe/"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D810DC
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701940866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ulM/k9z2Xc0T/IgjvujAJtC3o8xY8lvh/r5EkFOpXVU=;
	b=OoHjjWe/M1fNA6pEWb6XGGewJux/UN9VhPvIbZscCwtj5YjNklNzzuYTAAXkY+304o+kfi
	K7awaczC7ZI7Yq+1rjcc/4Bs58tcVAvVpiHfAXZo8O71zfnjVarKsx+WoCs8hU7jxm3Fry
	NaoB9CEtBNkv8PVMaURXpZM2X2Sdvao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-BGZO2DhoMY6xxwK_Xk63vQ-1; Thu, 07 Dec 2023 04:21:00 -0500
X-MC-Unique: BGZO2DhoMY6xxwK_Xk63vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC1CB101A551;
	Thu,  7 Dec 2023 09:20:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 633461C060AF;
	Thu,  7 Dec 2023 09:20:55 +0000 (UTC)
Date: Thu, 7 Dec 2023 17:20:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Message-ID: <ZXGOc8HnUV2Q58SE@fedora>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-1-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
> This patch reworks bio_for_each_segment_all() to be more inline with how
> the other bio iterators work:
> 
>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>    one in the iterator and pass a pointer to it - bad. This way makes it
>    clearer what's a constructed value vs. a reference to something
>    pre-existing, and it also will help with cleaning up and
>    consolidating code with bio_for_each_folio_all().
> 
>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>    this makes their code clearer.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Phillip Lougher <phillip@squashfs.org.uk>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

The original way was just for avoiding tree-wide change and keep bvec
pointer, and peek & advance is more cleaner, for the block layer change:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming


