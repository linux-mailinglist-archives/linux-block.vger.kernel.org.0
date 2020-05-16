Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB4B1D5D22
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgEPAT2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 May 2020 20:19:28 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38294 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPAT1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 20:19:27 -0400
Received: by mail-pj1-f66.google.com with SMTP id t40so1722669pjb.3
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 17:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+iEOLJNLRChWrcFNcnBke7Z7LdizF1azgU6mRbPdXE=;
        b=frlqHxNPxIUB1fw22nbbJXvNAPkLh1nJ6qViwms40mwwsAXWTT9ZDiU1Uh0KmcOEpV
         RcD5A5CukZFis0TBz21IqEGJ+P8h1ahK7IKK/xiN7GAFSgGrFfO4VQZnX+s1vRts9+kl
         d16EvZYJsQt/MiEX3vjh0zeCuGWmTTttuGURio9/vOZcHRY+4u/f7C4iqgyueL6m4JnK
         4okiTZMdW7g/DLvjvk8X58IC2jzX3zCX4tgAQ9Giq7hG0gER2BtTbIWawQ3Qaws/yc6t
         C16DCvv90Mn9DHoBLaDWDjiFnbi7r02euuUIlv+5GpZXY7UE7rHB3sc25DterBH12/ly
         EPhw==
X-Gm-Message-State: AOAM531fZOQcufoEm7AA8TZ2fAWxHy8c12kVJ9tjdgwKUrPr9uOCM7cI
        YPL0jXpCfNAaQbN3FHKwThs=
X-Google-Smtp-Source: ABdhPJzAI2X3XNxcYZska8/awIgRdxkddIz2kTOSE04S7/N6wwssNMvHEpuqP368+My8NEnq03RqXg==
X-Received: by 2002:a17:902:ac89:: with SMTP id h9mr6092707plr.266.1589588365871;
        Fri, 15 May 2020 17:19:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4000:d7:f99a:ee92:9332:42a])
        by smtp.gmail.com with ESMTPSA id 30sm2542383pgp.38.2020.05.15.17.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 17:19:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 3/5] block: Document the bio_vec properties
Date:   Fri, 15 May 2020 17:19:12 -0700
Message-Id: <20200516001914.17138-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200516001914.17138-1-bvanassche@acm.org>
References: <20200516001914.17138-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since it is nontrivial that nth_page() does not have to be used for a
bio_vec, document this.

CC: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/bvec.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a81c13ac1972..25295c11b164 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -12,8 +12,22 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 
-/*
- * was unsigned short, but we might as well be ready for > 64kB I/O pages
+/**
+ * struct bio_vec - a contiguous range of physical memory addresses
+ * @bv_page:   First page associated with the address range.
+ * @bv_len:    Number of bytes in the address range.
+ * @bv_offset: Start of the address range relative to the start of @bv_page.
+ *
+ * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
+ *
+ *   nth_page(@bv_page, n) == @bv_page + n
+ *
+ * From the description of commit 52d52d1c98a9 ("block: only allow contiguous
+ * page structs in a bio_vec"): "We currently have to call nth_page when
+ * iterating over pages inside a bio_vec.  Jens complained a while ago that
+ * this is fairly expensive. To mitigate this we can check that that the
+ * actual page structures are contiguous when adding them to the bio, and just
+ * do check pointer arithmetics later on." See also page_is_mergeable().
  */
 struct bio_vec {
 	struct page	*bv_page;
