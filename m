Return-Path: <linux-block+bounces-7671-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430008CD8C1
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729F81C211E8
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF13BB4D;
	Thu, 23 May 2024 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crIgUEfm"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04512381C6
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483295; cv=none; b=SBYar302I/eAidx7RHTMBzIEdToqqoTqJGYUy7cH1FzfIPwMaDDJQIPo39bF6LNVSAPuX6seo0uYFrfx9IFIac3vrcc+wVRHmhIet8IMiUmYZ0st56YfSZ/482tZaW9S9lzDHl7scRE2Lf/2jK9dtBdjaB+yIO9Pl37pKB6sT7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483295; c=relaxed/simple;
	bh=FDPMweyJrIo2XlV7st38fC/4nJUh6W1fhDZKjl4Py5A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yy22CP+yWmIPRxYYn3zvaWxe5N7XoV6Mb+HhBO94+GLKOEFtJViuMH8BY50tGILEy7W3htzH0eCvStI8B9dhM0HTTWSEW4ZDYOU025fHC5Vq91Wq4xpynLPyG1THQXkO4vLdeZ1UaPnfiA2pDb+23/7Cpxz2L7dDdQBDcT1sR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crIgUEfm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716483292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iXaZo+W/cx1Ln+efj2mhYyn0/F4SZI+f7sm23Xt9OxU=;
	b=crIgUEfmYSqlX3YHTgnJhbmuxM9PDHNOx7fABmSCtSJkhgpvVQU/w14Ii3SohmZv4VjJpH
	Kj48O6oZPdFoN6Sonau3ijNwLfUkaww0/1jAXqvdSAhuhnj5bDkU24xPIEuFaO6P0L/1kP
	B9T8XILMa7gcpqC0qx6XbXHBCpvtn+w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-pqYiqwKrO9iKrWN0j5xqLw-1; Thu,
 23 May 2024 12:54:47 -0400
X-MC-Unique: pqYiqwKrO9iKrWN0j5xqLw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53F1B1C0C641;
	Thu, 23 May 2024 16:54:47 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC96200A35C;
	Thu, 23 May 2024 16:54:47 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 4305E30C1C33; Thu, 23 May 2024 16:54:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 4238C3FB52;
	Thu, 23 May 2024 18:54:47 +0200 (CEST)
Date: Thu, 23 May 2024 18:54:47 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 1/2 v3] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com>
Message-ID: <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com>
References: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

If we allocate a bio that is larger than NVMe maximum request size, attach
integrity metadata to it and send it to the NVMe subsystem, the integrity
metadata will be corrupted.

Splitting the bio works correctly. The function bio_split will clone the
bio, trim the iterator of the first bio and advance the iterator of the
second bio.

However, the function rq_integrity_vec has a bug - it returns the first
vector of the bio's metadata and completely disregards the metadata
iterator that was advanced when the bio was split. Thus, the second bio
uses the same metadata as the first bio and this leads to metadata
corruption.

This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
instead of returning the first vector. mp_bvec_iter_bvec reads the
iterator and advances the vector by the iterator.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/pci.c       |    6 +++---
 include/linux/blk-integrity.h |   10 ++++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/nvme/host/pci.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/pci.c
+++ linux-2.6/drivers/nvme/host/pci.c
@@ -825,9 +825,9 @@ static blk_status_t nvme_map_metadata(st
 		struct nvme_command *cmnd)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio_vec bv = rq_integrity_vec(req);
 
-	iod->meta_dma = dma_map_bvec(dev->dev, rq_integrity_vec(req),
-			rq_dma_dir(req), 0);
+	iod->meta_dma = dma_map_bvec(dev->dev, &bv, rq_dma_dir(req), 0);
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
@@ -966,7 +966,7 @@ static __always_inline void nvme_pci_unm
 	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 		dma_unmap_page(dev->dev, iod->meta_dma,
-			       rq_integrity_vec(req)->bv_len, rq_dma_dir(req));
+			       rq_integrity_vec(req).bv_len, rq_dma_dir(req));
 	}
 
 	if (blk_rq_nr_phys_segments(req))
Index: linux-2.6/include/linux/blk-integrity.h
===================================================================
--- linux-2.6.orig/include/linux/blk-integrity.h
+++ linux-2.6/include/linux/blk-integrity.h
@@ -109,11 +109,12 @@ static inline bool blk_integrity_rq(stru
  * Return the first bvec that contains integrity data.  Only drivers that are
  * limited to a single integrity segment should use this helper.
  */
-static inline struct bio_vec *rq_integrity_vec(struct request *rq)
+static inline struct bio_vec rq_integrity_vec(struct request *rq)
 {
 	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
-		return NULL;
-	return rq->bio->bi_integrity->bip_vec;
+		return (struct bio_vec){ };
+	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
+				 rq->bio->bi_integrity->bip_iter);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
 static inline int blk_rq_count_integrity_sg(struct request_queue *q,
@@ -179,7 +180,8 @@ static inline int blk_integrity_rq(struc
 
 static inline struct bio_vec *rq_integrity_vec(struct request *rq)
 {
-	return NULL;
+	/* the optimizer will remove all calls to this function */
+	return (struct bio_vec){ };
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 #endif /* _LINUX_BLK_INTEGRITY_H */


