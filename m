Return-Path: <linux-block+bounces-7788-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C98D0665
	for <lists+linux-block@lfdr.de>; Mon, 27 May 2024 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7792C2837EA
	for <lists+linux-block@lfdr.de>; Mon, 27 May 2024 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0417E91F;
	Mon, 27 May 2024 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRaWQJEG"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B63079E1
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824461; cv=none; b=ttN7Q8YZkZT8Gm3RSUjlrJb82wpWWPrmgm1gF41zmfrkqHXiFLN23LsiMyYLC+DDoxmn/3vA/aXHXITXE980ytPlY4m/0IL2e93yXSm7zTUHII1P5l82i6Z6cmR58Ip+rnpCFxjcR/ncMHVdqKq8av2EBCxmKcya6ghNPq8PJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824461; c=relaxed/simple;
	bh=Y2dUptPR7/UauwrUWZleYH0sJ0qxAwedDWvtXJDF0Zw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aO5WO1dwNV9CWx3uoSM3UvQ9J2p8drQKmlLRMfWaoURJrOVFWbvzK5O0AQatLXPBzcvo2zijyiCfbY+CszGiT/3E1dKwNCxJ7LJD+3L1bOXrZCXyMXnVtR8LnD+oEEFuUCE5BNR57yKeGkAYxqHiJevr4vk4Y10JL5Lz/l9EbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRaWQJEG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716824458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H38NVgfvrbz9f47culVI5M8RadbOZLjlujcosBHOdmc=;
	b=QRaWQJEGIeifIMbD59GBUJrrsLPgUacxeyJj4d/PhrmuMGGhTiYjfwSDfT9NuM0+42u1NO
	quM7xC6jheaqUQJyVGvmEmtBLsE8nXJrlEyWWPlHyxOgou4OKbgZOBeeEPUxiR6mgW1Yq2
	UAdNXSkslN0OVXoJbyYeyAXE6cJnObc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-PBTryCivNz6QEgtw8iAMuA-1; Mon, 27 May 2024 11:40:51 -0400
X-MC-Unique: PBTryCivNz6QEgtw8iAMuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9273800169;
	Mon, 27 May 2024 15:40:50 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF037200A381;
	Mon, 27 May 2024 15:40:50 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id C73A930C1C33; Mon, 27 May 2024 15:40:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id C61963C542;
	Mon, 27 May 2024 17:40:50 +0200 (CEST)
Date: Mon, 27 May 2024 17:40:50 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 2/2 v4] dm-crypt: support for per-sector NVMe metadata
In-Reply-To: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Message-ID: <4bf719bb-e389-4fb1-b98-83ba427ceeb0@redhat.com>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Support per-sector NVMe metadata in dm-crypt.

This commit changes dm-crypt, so that it can use NVMe metadata to store
authentication information. We can put dm-crypt directly on the top of
NVMe device, without using dm-integrity.

This commit improves write throughput twice, becase the will be no writes
to the dm-integrity journal.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/md/dm-crypt.c |   53 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

Index: linux-2.6/drivers/md/dm-crypt.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-crypt.c
+++ linux-2.6/drivers/md/dm-crypt.c
@@ -211,7 +211,8 @@ struct crypt_config {
 
 	unsigned int integrity_tag_size;
 	unsigned int integrity_iv_size;
-	unsigned int on_disk_tag_size;
+	unsigned int used_tag_size;
+	unsigned int tuple_size;
 
 	/*
 	 * pool for per bio private data, crypto requests,
@@ -1148,14 +1149,14 @@ static int dm_crypt_integrity_io_alloc(s
 	unsigned int tag_len;
 	int ret;
 
-	if (!bio_sectors(bio) || !io->cc->on_disk_tag_size)
+	if (!bio_sectors(bio) || !io->cc->tuple_size)
 		return 0;
 
 	bip = bio_integrity_alloc(bio, GFP_NOIO, 1);
 	if (IS_ERR(bip))
 		return PTR_ERR(bip);
 
-	tag_len = io->cc->on_disk_tag_size * (bio_sectors(bio) >> io->cc->sector_shift);
+	tag_len = io->cc->tuple_size * (bio_sectors(bio) >> io->cc->sector_shift);
 
 	bip->bip_iter.bi_sector = io->cc->start + io->sector;
 
@@ -1173,24 +1174,30 @@ static int crypt_integrity_ctr(struct cr
 	struct blk_integrity *bi = blk_get_integrity(cc->dev->bdev->bd_disk);
 	struct mapped_device *md = dm_table_get_md(ti->table);
 
+	if (!bi) {
+		ti->error = "No integrity profile.";
+		return -EINVAL;
+	}
+
 	/* From now we require underlying device with our integrity profile */
-	if (!bi || strcasecmp(bi->profile->name, "DM-DIF-EXT-TAG")) {
+	if (strcasecmp(bi->profile->name, "DM-DIF-EXT-TAG") &&
+	    strcasecmp(bi->profile->name, "nop")) {
 		ti->error = "Integrity profile not supported.";
 		return -EINVAL;
 	}
 
-	if (bi->tag_size != cc->on_disk_tag_size ||
-	    bi->tuple_size != cc->on_disk_tag_size) {
+	if (bi->tuple_size < cc->used_tag_size) {
 		ti->error = "Integrity profile tag size mismatch.";
 		return -EINVAL;
 	}
+	cc->tuple_size = bi->tuple_size;
 	if (1 << bi->interval_exp != cc->sector_size) {
 		ti->error = "Integrity profile sector size mismatch.";
 		return -EINVAL;
 	}
 
 	if (crypt_integrity_aead(cc)) {
-		cc->integrity_tag_size = cc->on_disk_tag_size - cc->integrity_iv_size;
+		cc->integrity_tag_size = cc->used_tag_size - cc->integrity_iv_size;
 		DMDEBUG("%s: Integrity AEAD, tag size %u, IV size %u.", dm_device_name(md),
 		       cc->integrity_tag_size, cc->integrity_iv_size);
 
@@ -1202,7 +1209,7 @@ static int crypt_integrity_ctr(struct cr
 		DMDEBUG("%s: Additional per-sector space %u bytes for IV.", dm_device_name(md),
 		       cc->integrity_iv_size);
 
-	if ((cc->integrity_tag_size + cc->integrity_iv_size) != bi->tag_size) {
+	if ((cc->integrity_tag_size + cc->integrity_iv_size) > cc->tuple_size) {
 		ti->error = "Not enough space for integrity tag in the profile.";
 		return -EINVAL;
 	}
@@ -1281,7 +1288,7 @@ static void *tag_from_dmreq(struct crypt
 	struct dm_crypt_io *io = container_of(ctx, struct dm_crypt_io, ctx);
 
 	return &io->integrity_metadata[*org_tag_of_dmreq(cc, dmreq) *
-		cc->on_disk_tag_size];
+		cc->tuple_size];
 }
 
 static void *iv_tag_from_dmreq(struct crypt_config *cc,
@@ -1362,9 +1369,9 @@ static int crypt_convert_block_aead(stru
 		aead_request_set_crypt(req, dmreq->sg_in, dmreq->sg_out,
 				       cc->sector_size, iv);
 		r = crypto_aead_encrypt(req);
-		if (cc->integrity_tag_size + cc->integrity_iv_size != cc->on_disk_tag_size)
+		if (cc->integrity_tag_size + cc->integrity_iv_size != cc->tuple_size)
 			memset(tag + cc->integrity_tag_size + cc->integrity_iv_size, 0,
-			       cc->on_disk_tag_size - (cc->integrity_tag_size + cc->integrity_iv_size));
+			       cc->tuple_size - (cc->integrity_tag_size + cc->integrity_iv_size));
 	} else {
 		aead_request_set_crypt(req, dmreq->sg_in, dmreq->sg_out,
 				       cc->sector_size + cc->integrity_tag_size, iv);
@@ -1794,7 +1801,7 @@ static void crypt_dec_pending(struct dm_
 		return;
 
 	if (likely(!io->ctx.aead_recheck) && unlikely(io->ctx.aead_failed) &&
-	    cc->on_disk_tag_size && bio_data_dir(base_bio) == READ) {
+	    cc->used_tag_size && bio_data_dir(base_bio) == READ) {
 		io->ctx.aead_recheck = true;
 		io->ctx.aead_failed = false;
 		io->error = 0;
@@ -3173,7 +3180,7 @@ static int crypt_ctr_optional(struct dm_
 				ti->error = "Invalid integrity arguments";
 				return -EINVAL;
 			}
-			cc->on_disk_tag_size = val;
+			cc->used_tag_size = val;
 			sval = strchr(opt_string + strlen("integrity:"), ':') + 1;
 			if (!strcasecmp(sval, "aead")) {
 				set_bit(CRYPT_MODE_INTEGRITY_AEAD, &cc->cipher_flags);
@@ -3384,12 +3391,12 @@ static int crypt_ctr(struct dm_target *t
 		if (ret)
 			goto bad;
 
-		cc->tag_pool_max_sectors = POOL_ENTRY_SIZE / cc->on_disk_tag_size;
+		cc->tag_pool_max_sectors = POOL_ENTRY_SIZE / cc->tuple_size;
 		if (!cc->tag_pool_max_sectors)
 			cc->tag_pool_max_sectors = 1;
 
 		ret = mempool_init_kmalloc_pool(&cc->tag_pool, MIN_IOS,
-			cc->tag_pool_max_sectors * cc->on_disk_tag_size);
+			cc->tag_pool_max_sectors * cc->tuple_size);
 		if (ret) {
 			ti->error = "Cannot allocate integrity tags mempool";
 			goto bad;
@@ -3464,7 +3471,7 @@ static int crypt_map(struct dm_target *t
 	 * Check if bio is too large, split as needed.
 	 */
 	if (unlikely(bio->bi_iter.bi_size > (BIO_MAX_VECS << PAGE_SHIFT)) &&
-	    (bio_data_dir(bio) == WRITE || cc->on_disk_tag_size))
+	    (bio_data_dir(bio) == WRITE || cc->used_tag_size))
 		dm_accept_partial_bio(bio, ((BIO_MAX_VECS << PAGE_SHIFT) >> SECTOR_SHIFT));
 
 	/*
@@ -3480,8 +3487,8 @@ static int crypt_map(struct dm_target *t
 	io = dm_per_bio_data(bio, cc->per_bio_data_size);
 	crypt_io_init(io, cc, bio, dm_target_offset(ti, bio->bi_iter.bi_sector));
 
-	if (cc->on_disk_tag_size) {
-		unsigned int tag_len = cc->on_disk_tag_size * (bio_sectors(bio) >> cc->sector_shift);
+	if (cc->tuple_size) {
+		unsigned int tag_len = cc->tuple_size * (bio_sectors(bio) >> cc->sector_shift);
 
 		if (unlikely(tag_len > KMALLOC_MAX_SIZE))
 			io->integrity_metadata = NULL;
@@ -3552,7 +3559,7 @@ static void crypt_status(struct dm_targe
 		num_feature_args += test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		num_feature_args += cc->sector_size != (1 << SECTOR_SHIFT);
 		num_feature_args += test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags);
-		if (cc->on_disk_tag_size)
+		if (cc->used_tag_size)
 			num_feature_args++;
 		if (num_feature_args) {
 			DMEMIT(" %d", num_feature_args);
@@ -3566,8 +3573,8 @@ static void crypt_status(struct dm_targe
 				DMEMIT(" no_read_workqueue");
 			if (test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))
 				DMEMIT(" no_write_workqueue");
-			if (cc->on_disk_tag_size)
-				DMEMIT(" integrity:%u:%s", cc->on_disk_tag_size, cc->cipher_auth);
+			if (cc->used_tag_size)
+				DMEMIT(" integrity:%u:%s", cc->used_tag_size, cc->cipher_auth);
 			if (cc->sector_size != (1 << SECTOR_SHIFT))
 				DMEMIT(" sector_size:%d", cc->sector_size);
 			if (test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags))
@@ -3588,9 +3595,9 @@ static void crypt_status(struct dm_targe
 		DMEMIT(",iv_large_sectors=%c", test_bit(CRYPT_IV_LARGE_SECTORS, &cc->cipher_flags) ?
 		       'y' : 'n');
 
-		if (cc->on_disk_tag_size)
+		if (cc->used_tag_size)
 			DMEMIT(",integrity_tag_size=%u,cipher_auth=%s",
-			       cc->on_disk_tag_size, cc->cipher_auth);
+			       cc->used_tag_size, cc->cipher_auth);
 		if (cc->sector_size != (1 << SECTOR_SHIFT))
 			DMEMIT(",sector_size=%d", cc->sector_size);
 		if (cc->cipher_string)


