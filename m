Return-Path: <linux-block+bounces-11185-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C899E96A7BE
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2024 21:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C971F254C5
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF6E1DC735;
	Tue,  3 Sep 2024 19:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0Yb+LDL"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475C1DC720
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725392894; cv=none; b=arLhZ8hTvWbUSC4/ir+Nlpy4ekS2DfeDUYfQcNGHRxhuLca7bqCNwPXwUeBMCRONKF0W01v3ATwIUqiNebI25nycgV3T2552qkIgVaKdGGN09kVETHHfmxo67NLOIthSJhWW4c9ND8cKEzUEidcAIZqQVpAj5rMWqwBzu71nGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725392894; c=relaxed/simple;
	bh=5w1MdU87kfmFhemU47nWHUKj584aIGRPwOl3SBx1hrE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=no9Ahn2M/bk5PYhEo9oGbty5ZRSa4vO3CTbkEQ2OGw9HiLum5fi8gAcg+iGeQLO4tmSmrxq7cjDZoG6XPrmV/WUbg9faA8AE3KAG8td2pfzCg6d8RYoqXz+RPChRvu9b4FZ7bqeGITR12z/o48BT+sVrgvly4tiHbzm9QDj1LCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0Yb+LDL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725392891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bSTLusuXmFQd65kQGYZ1qnrT0q7wEzKGyedDbsG7eqw=;
	b=B0Yb+LDLwD2fClhBXXTq1glTABv6zupyVW044RtYiTyGdUYlssmAr00YJJFukkFRs+fnJV
	5K8ninRzUxwh1nljJRtptj0Y1cVEgbCrCqezMbXgWT+cOsxShagUArEbKA0FakuEds8tTK
	EmF0/x8QsrfBbrR9YqhYrr4icnRfUWk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-1UR2zS6-OKybRe2ml9oEdw-1; Tue,
 03 Sep 2024 15:48:08 -0400
X-MC-Unique: 1UR2zS6-OKybRe2ml9oEdw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FDE71978F64;
	Tue,  3 Sep 2024 19:48:06 +0000 (UTC)
Received: from [10.45.224.222] (unknown [10.45.224.222])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F419219560A3;
	Tue,  3 Sep 2024 19:48:03 +0000 (UTC)
Date: Tue, 3 Sep 2024 21:47:59 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Jinyoung Choi <j-young.choi@samsung.com>, Christoph Hellwig <hch@lst.de>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev
Subject: [PATCH] bio-integrity: don't restrict the size of integrity
 metadata
Message-ID: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Jens

I added dm-integrity inline mode in the 6.11 merge window. I've found out
that it doesn't work with large bios - the reason is that the function
bio_integrity_add_page refuses to add more metadata than
queue_max_hw_sectors(q). This restriction is no longer needed, because
big bios are split automatically. I'd like to ask you if you could send
this commit to Linus before 6.11 comes out, so that the bug is fixed
before the final release.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>

bio_integrity_add_page restricts the size of the integrity metadata to
queue_max_hw_sectors(q). This restriction is not needed because oversized
bios are split automatically. This restriction causes problems with
dm-integrity 'inline' mode - if we send a large bio to dm-integrity and
the bio's metadata are larger than queue_max_hw_sectors(q),
bio_integrity_add_page fails and the bio is ended with BLK_STS_RESOURCE
error.

An example that triggers it:

# modprobe brd rd_size=1048576
# dmsetup create in1 --table '0 1847320 integrity /dev/ram0 0 64 D 1 fix_padding'
# dmsetup create in2 --table '0 1847312 integrity /dev/mapper/in1 0 64 I 1 internal_hash:sha512'
# dd if=/dev/zero of=/dev/mapper/in2 bs=1M oflag=direct status=progress
dd: error writing '/dev/mapper/in2': Cannot allocate memory
1+0 records in
0+0 records out
0 bytes copied, 0.00169291 s, 0.0 kB/s

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
Fixes: 0ece1d649b6d ("bio-integrity: create multi-page bvecs in bio_integrity_add_page()")

---
 block/bio-integrity.c |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6/block/bio-integrity.c
===================================================================
--- linux-2.6.orig/block/bio-integrity.c	2024-07-30 14:06:55.000000000 +0200
+++ linux-2.6/block/bio-integrity.c	2024-09-03 15:49:49.000000000 +0200
@@ -167,10 +167,6 @@ int bio_integrity_add_page(struct bio *b
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 
-	if (((bip->bip_iter.bi_size + len) >> SECTOR_SHIFT) >
-	    queue_max_hw_sectors(q))
-		return 0;
-
 	if (bip->bip_vcnt > 0) {
 		struct bio_vec *bv = &bip->bip_vec[bip->bip_vcnt - 1];
 		bool same_page = false;


