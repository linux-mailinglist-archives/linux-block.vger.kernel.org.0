Return-Path: <linux-block+bounces-13614-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 017349BE8C8
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 13:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC94D1F21AEF
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC311DF251;
	Wed,  6 Nov 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIjC7/rD"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698381DFD87
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896053; cv=none; b=uWhaBdz419LJFQ6DDPIBCMboPA4K033eA5PKgfx0I5t/1WN8vomuOHtSnaI+QFR0AjYncrFCea7VeRVKSoEoBcFFd42oAaxqbocBXl5EXt8lPjb8+c4lnL/qEPbr8J1QIwfuY6nXe737M7lCzBBedd37I/UnRwOVgXWwFazBYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896053; c=relaxed/simple;
	bh=R0hor+AGXWJQ+b6eCKSSwPBAK1nbOUeit79ZDkEKo3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM+x4gbbF7EDcqGMTqsVj+3hb3sK2XaR986uet6gQ1xJxhQ77etWwCbX+92D+AW4CoWatk2KhFPvtC89sG5/NIh/UWKvQobViWqHnyc3/R6/0Y77cvI7y0nVylMHkgoyZFApmUIlSL6ajzLaJTDPCGdhG+KYx7BNjsWBxtgWBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIjC7/rD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bkn+1zjp+r+Ic/txbig//oiVTK8s22E84dBS34JjeY=;
	b=iIjC7/rDT9Q3NGxO24Wa64aNbkrKFtUoFpPoX03wMNH5hROzcqKfwJWNH2NuPecodhCKlc
	lt8jdlF5zt6BT2iJQQxBLa+Z8MwJp5RuR25wGd+LinOXI75bHKJnKI9wCou4hGoEXrS1qC
	Q0iqa3V6KBSiSqqleip/yZyyiHit8FQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-exft2KXlNOapteNZjSRhrQ-1; Wed,
 06 Nov 2024 07:27:25 -0500
X-MC-Unique: exft2KXlNOapteNZjSRhrQ-1
X-Mimecast-MFC-AGG-ID: exft2KXlNOapteNZjSRhrQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ECBE1944D2B;
	Wed,  6 Nov 2024 12:27:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.107])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E342619560AA;
	Wed,  6 Nov 2024 12:27:22 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Akilesh Kailash <akailash@google.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V9 3/7] io_uring: shrink io_mapped_buf
Date: Wed,  6 Nov 2024 20:26:52 +0800
Message-ID: <20241106122659.730712-4-ming.lei@redhat.com>
In-Reply-To: <20241106122659.730712-1-ming.lei@redhat.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

`struct io_mapped_buf` will be extended to cover kernel buffer which
may be in fast IO path, and `struct io_mapped_buf` needs to be per-IO.

So shrink sizeof(struct io_mapped_buf) by the following ways:

- folio_shift is < 64, so 6bits are enough to hold it, the remained bits
  can be used for the coming kernel buffer

- define `acct_pages` as 'unsigned int', which is big enough for
  accounting pages in the buffer

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.c | 2 ++
 io_uring/rsrc.h | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 9b8827c72230..16f5abe03d10 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -685,6 +685,8 @@ static bool io_try_coalesce_buffer(struct page ***pages, int *nr_pages,
 		return false;
 
 	data->folio_shift = folio_shift(folio);
+	WARN_ON_ONCE(data->folio_shift >= 64);
+
 	/*
 	 * Check if pages are contiguous inside a folio, and all folios have
 	 * the same page count except for the head and tail.
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 887699400e29..255ec94ea172 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -30,9 +30,9 @@ struct io_mapped_buf {
 	u64		start;
 	unsigned int	len;
 	unsigned int	nr_bvecs;
-	unsigned int    folio_shift;
 	refcount_t	refs;
-	unsigned long	acct_pages;
+	unsigned int	acct_pages;
+	unsigned int	folio_shift:6;
 	struct bio_vec	bvec[] __counted_by(nr_bvecs);
 };
 
@@ -41,7 +41,7 @@ struct io_imu_folio_data {
 	unsigned int	nr_pages_head;
 	/* For non-head/tail folios, has to be fully included */
 	unsigned int	nr_pages_mid;
-	unsigned int	folio_shift;
+	unsigned char	folio_shift;
 };
 
 struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx, int type);
-- 
2.47.0


