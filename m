Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47741B3917
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 09:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgDVHjE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 03:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVHjE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB0C03C1A6;
        Wed, 22 Apr 2020 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WtcH9W9UJR7zIdoPQnBUNprDw0gzdRhH+V87MBmxzmA=; b=KOZVBoF7MIc4arL1LFgotKDaNl
        CGgqIxdSvJ5C+lxlXZBTKlsMAothNUd0o7cmku6oxxZCctumxAIphVrtha/+AgGevK2uOw5vO69u4
        TSPFNEbgwMuwUysdBSO+0PQKLZNNl+IqZENDFOwTAs+TcU7rLkjh2GtEgkgwBewqBi4qSoXPBFJKD
        sVzUoeR52ym7SiUPFf+UuZpHOZUXZt3fHlutzQNem9EAnfe2no5bGOsLfL35ikjjOJjeSEqcBoxqK
        9eVZTYj3w7DLYxpNNKyEphCUipl2dpLbRQg82zUz+OIhxVdc5uoA0LBXF4v4xm0WV3V375l+7RlCs
        dzjF/Wmw==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yB-00008a-Vb; Wed, 22 Apr 2020 07:38:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] vboxsf: don't use the source name in the bdi name
Date:   Wed, 22 Apr 2020 09:38:43 +0200
Message-Id: <20200422073851.303714-2-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify the bdi name to mirror what we are doing elsewhere, and
drop them name in favor of just using a number.  This avoids a
potentially very long bdi name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/vboxsf/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 675e26989376..8fe03b4a0d2b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -164,7 +164,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto fail_free;
 	}
 
-	err = super_setup_bdi_name(sb, "vboxsf-%s.%d", fc->source, sbi->bdi_id);
+	err = super_setup_bdi_name(sb, "vboxsf-%d", sbi->bdi_id);
 	if (err)
 		goto fail_free;
 
-- 
2.26.1

