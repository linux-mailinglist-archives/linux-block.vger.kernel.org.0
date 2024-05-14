Return-Path: <linux-block+bounces-7356-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6135F8C5A9F
	for <lists+linux-block@lfdr.de>; Tue, 14 May 2024 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934341C20BBF
	for <lists+linux-block@lfdr.de>; Tue, 14 May 2024 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F9C1802BA;
	Tue, 14 May 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/D3Rd/5"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A981802B6
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709221; cv=none; b=g61C1JXo3IXdE6qPI0tboIDLH0abrR9+24Li0VKPsEFONxcFSmBBr7HMw27IIO+akDkZjeqFTFNmbB9TKAn/wTKNI9lLUBmZ5HYyc/qqmMeFLM+OG5g019T/y7/58pWRr06CSCY8UzVwDhE+gbSEkrp+fvlhQ+mMfAJuxVrZ6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709221; c=relaxed/simple;
	bh=b6e8Dnh3maUD9lwtp1+zI5BEIk5U7b2o4S0cX74JYYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=lsvNFyj/9vd/hipvu4FJg/HBYhfKM+1b5Px/OLJmnviTvRcPZlj3I7YDSTHCIYCfyuhwebue+wxFTdKZkTmqN0x8g9mmBagfca9pGH5S2rrZO706dwSdSZPPgoN1TTBgssRRGGpBuMkXR5HAmRhBEMrih+xXdF3c9wSU8v2nl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/D3Rd/5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFxooJ/Wd2kSlfPg0r+rfS28FX2xdaR0dGl5yZTVUZc=;
	b=T/D3Rd/5LQpfHwEcl/xjHJTyf2KdUtDDlWaxH0qUWoopoHnAPEoUzBGbvgpHow7OLVKoTx
	i3j5sLFF0xUXF8QG+4KbKWJ6esTOxXa8GD/SemFo+49JPDIbyT4sUSyZjJjuktnEEiXBJB
	i/Wm/Rjw6I2ANW2E+t2BUZDnxu9M5ao=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-cAwzDMOuML6LGk8vAbX-0g-1; Tue, 14 May 2024 13:53:32 -0400
X-MC-Unique: cAwzDMOuML6LGk8vAbX-0g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 118E08001F7;
	Tue, 14 May 2024 17:53:32 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E87CC400059;
	Tue, 14 May 2024 17:53:30 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 3/6] nvme: multipath: Invalidate current_path when changing iopolicy
Date: Tue, 14 May 2024 13:53:19 -0400
Message-Id: <20240514175322.19073-4-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: "Ewan D. Milne" <emilne@redhat.com>

When switching back to numa from round-robin, current_path may refer to
a different path than the one numa would have selected, and it is desirable
to have consistent behavior.

Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1e9338543ded..8702a40a1971 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -861,6 +861,7 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 	mutex_lock(&nvme_subsystems_lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		atomic_set(&ctrl->nr_active, 0);
+		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
 }
-- 
2.39.3


