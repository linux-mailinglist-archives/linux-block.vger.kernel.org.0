Return-Path: <linux-block+bounces-16175-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8913A0782E
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B9FE3A5B1B
	for <lists+linux-block@lfdr.de>; Thu,  9 Jan 2025 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79034213E8F;
	Thu,  9 Jan 2025 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KMe2+WH5"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77C68472
	for <linux-block@vger.kernel.org>; Thu,  9 Jan 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430563; cv=none; b=pKWQ/mH2dXKm5KszLzmrwFv2Hc0MV51KNkS4ypHao7f0gAPn+p4mxbPVpfGnKn3EQnm9MPU51TMCHaMi4tzZyZuwBW0R8jjC50caWwNQwso9LKGY23zXd69cjf/QRqbp3jqz8EWXwgOe2tXZ8dJ1XxtR0QjNA4ONhmT30Iqp1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430563; c=relaxed/simple;
	bh=TzJOsxj0dkWiwAK+ED7JYMUThliDNRG/ikqiR7rZxSU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Gh8YGAxXTzjyqreweVxvigorCJiSh2CqA9fSJVMOP2AFNJwsx0IoN6XK2Am2sryA037Tqg0f+ywmdns3X0ehSQXt6Ce76wTQ3dF8ZNRYftCuOjKpTHcySsXZZzxUYifY5ml/MB75N8b0KXdHOXkpl9YktIvgqqMTUoOnFjMLQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KMe2+WH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736430560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7M6JmV1Z4Feo1qwBbf8wulQga1EBG//Hepfi2cQMJUA=;
	b=KMe2+WH51lM0VhFZcrl/e7ItOH8I41ENFASMEoACp/38K8KO37pZIy2UJCDd6t42pl8tfT
	ww7i/XIrnUVegRAua1brTPdW1dJ2/qJF55CSth+AuCTvzUlK4UbIS0cKMs/sqpUCaWo5or
	gXfPR5jZCiFFgYVwOn4PM8cEqoSjDkE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-gtXbp26SP-uj9ipmOh2KlQ-1; Thu,
 09 Jan 2025 08:49:17 -0500
X-MC-Unique: gtXbp26SP-uj9ipmOh2KlQ-1
X-Mimecast-MFC-AGG-ID: gtXbp26SP-uj9ipmOh2KlQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 669A01955F43;
	Thu,  9 Jan 2025 13:49:16 +0000 (UTC)
Received: from [10.45.224.27] (unknown [10.45.224.27])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD2BF19560AD;
	Thu,  9 Jan 2025 13:49:14 +0000 (UTC)
Date: Thu, 9 Jan 2025 14:49:11 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    Jens Axboe <axboe@kernel.dk>
cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Subject: [PATCH] dm: disable REQ_NOWAIT for flushes
Message-ID: <79cd51da-2546-de7e-86e1-be6a835721e2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

REQ_NOWAIT for flushes cannot be easily supported by device mapper
because it may allocate multiple bios and its impossible to undo if one
of those allocations wants to wait. So, this patch disables REQ_NOWAIT
flushes in device mapper and we always return EAGAIN.

Previously, the code accepted REQ_NOWAIT flushes, but the non-blocking
execution was not guaranteed.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/drivers/md/dm.c
===================================================================
--- linux-2.6.orig/drivers/md/dm.c	2025-01-08 17:26:52.000000000 +0100
+++ linux-2.6/drivers/md/dm.c	2025-01-08 17:44:59.000000000 +0100
@@ -1968,6 +1968,15 @@ static void dm_split_and_process_bio(str
 
 	/* Only support nowait for normal IO */
 	if (unlikely(bio->bi_opf & REQ_NOWAIT) && !is_abnormal) {
+		/*
+		 * Don't support NOWAIT for FLUSH because it may allocate
+		 * multiple bios and there's no easy way how to undo the
+		 * allocations.
+		 */
+		if (bio->bi_opf & REQ_PREFLUSH) {
+			bio_wouldblock_error(bio);
+			return;
+		}
 		io = alloc_io(md, bio, GFP_NOWAIT);
 		if (unlikely(!io)) {
 			/* Unable to do anything without dm_io. */


