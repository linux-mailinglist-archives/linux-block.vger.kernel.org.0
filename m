Return-Path: <linux-block+bounces-18408-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF6A605D1
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 00:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA79421B71
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 23:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D052063C5;
	Thu, 13 Mar 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1p53myr"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8D205E12
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 23:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908928; cv=none; b=JpiVp1ZS6EWOiTEYwTJlWokRi3EnbN8obLFA1pCPveWpN2koSEKy66MYjq78ljilFt4jGZ7o/BO1PuXiPwQEpWZMDFWVAo6c/aTYvsxfE3TYpfx+qg39ZCYfZHqHFwf1wloFZdVeM0/+kKmRXTJzp57JXLWNJT4UnZm+j8yS6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908928; c=relaxed/simple;
	bh=WXrY3C4aBoCZOlpcPVhTK2SK1Y40kISeIyz7iYk66Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doTjy8SuPWjWtBQDOGRaoaPNciIIG0rp3n3QOXM7pffYfJHPWfkD/99C8h1p9L6kniT0boYpYewQxZR/v5tpaxQqCFN3cDcT3pM83rfl0tNt7z957rQ9z3er0+8y5tM22AfIvQLBJNlM7ZubQYOK928vUmHDmQ0MsxOxpSx1U6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d1p53myr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmqeGbTSvYMVxLKr2hdetvu52z+vdNBfpZpodP6P95c=;
	b=d1p53myr06YUVbgdsYZmRIh1xabIVpnpShmCM8iaPXsPDpSg7RCP7hn2/ImLzztN44GYrK
	duWhVKYJS8qLmRA9sOT3hHC5HwJtqEYvmD7Mhpb/tpn2YXEhywBG+eQn4fLhwAuS94gaDV
	RD+1RuMwj4zUjCd/Pkd47rUI7kcqU3g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-jolOU4DDPX2zQ91cDEmtFg-1; Thu,
 13 Mar 2025 19:35:24 -0400
X-MC-Unique: jolOU4DDPX2zQ91cDEmtFg-1
X-Mimecast-MFC-AGG-ID: jolOU4DDPX2zQ91cDEmtFg_1741908923
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19D0E180025B;
	Thu, 13 Mar 2025 23:35:23 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CA7971800268;
	Thu, 13 Mar 2025 23:35:20 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 25/35] ceph: Wrap POSIX_FADV_WILLNEED to get caps
Date: Thu, 13 Mar 2025 23:33:17 +0000
Message-ID: <20250313233341.1675324-26-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Wrap the handling of fadvise(POSIX_FADV_WILLNEED) so that we get the
appropriate caps needed to do it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/file.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ffd36e00b0de..b876cecbaba5 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -13,6 +13,7 @@
 #include <linux/iversion.h>
 #include <linux/ktime.h>
 #include <linux/splice.h>
+#include <linux/fadvise.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -3150,6 +3151,49 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+/*
+ * If the user wants to manually trigger readahead, we have to get a cap to
+ * allow that.
+ */
+static int ceph_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
+{
+	struct inode *inode = file_inode(file);
+	struct ceph_file_info *fi = file->private_data;
+	struct ceph_client *cl = ceph_inode_to_client(inode);
+	int want = CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO, got = 0;
+	int ret;
+
+	if (advice != POSIX_FADV_WILLNEED)
+		return generic_fadvise(file, offset, len, advice);
+
+	if (!(fi->flags & CEPH_F_SYNC))
+		return -EACCES;
+	if (fi->fmode & CEPH_FILE_MODE_LAZY)
+		return -EACCES;
+
+	ret = ceph_get_caps(file, CEPH_CAP_FILE_RD, want, -1, &got);
+	if (ret < 0) {
+		doutc(cl, "%llx.%llx, error getting cap\n", ceph_vinop(inode));
+		goto out;
+	}
+
+	if ((got & want) == want) {
+		doutc(cl, "fadvise(WILLNEED) %p %llx.%llx %llu~%llu got cap refs on %s\n",
+		      inode, ceph_vinop(inode), offset, len,
+		      ceph_cap_string(got));
+		ret = generic_fadvise(file, offset, len, advice);
+	} else {
+		doutc(cl, "%llx.%llx, no cache cap\n", ceph_vinop(inode));
+		ret = -EACCES;
+	}
+
+	doutc(cl, "%p %llx.%llx dropping cap refs on %s = %d\n",
+	      inode, ceph_vinop(inode), ceph_cap_string(got), ret);
+	ceph_put_cap_refs(ceph_inode(inode), got);
+out:
+	return ret;
+}
+
 const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
@@ -3167,4 +3211,5 @@ const struct file_operations ceph_file_fops = {
 	.compat_ioctl = compat_ptr_ioctl,
 	.fallocate	= ceph_fallocate,
 	.copy_file_range = ceph_copy_file_range,
+	.fadvise	= ceph_fadvise,
 };


