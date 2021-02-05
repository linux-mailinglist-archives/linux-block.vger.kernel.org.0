Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71953103E0
	for <lists+linux-block@lfdr.de>; Fri,  5 Feb 2021 04:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBEDwR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Feb 2021 22:52:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:47376 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhBEDwR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 22:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612497356; x=1644033356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwgzSfysxAnsV/PwmEDbkBo+3nnTrLiXXNuavPj2YT4=;
  b=FDGvGI5v8WgniGLzXofrs6b0RwOMWckBoV/HULoW/uHafXfw3XquIKUw
   xNyc2I5NvOg7gRTAum3Mq26OS+1ycY4JUx/1tE9S2zDYjapRn5TgLpaRU
   X+ItAB3fGpO4v3xj7tb7TIvMwPDT4xQqvhDpkcwPZwXZzQBfU5npjPuIP
   wfD7oDELJeeGQudIV/xouJZet8wnFidrYCQiNr3WpazUbtbpGRq8S5oZ8
   Wpo5b9GgdiRMczDvwejH3PJmLyH28KMO5SzLKOs0XhbEGOu6igtXaHY44
   7//y4yRgxcdjyb80xazsK24g4Lsh8NV0tIu1G5qN/0bZuU1QpkzI3K7eq
   g==;
IronPort-SDR: xx87rwkN9reRyCu0GqsAJardMPl/7VuaNQevoRDaYH5lJ1xNmKSonq2wAnmbJcyotAQbPgHGZ6
 GO6wWiR9JX5otYJDzs+q5YeWEL6ezGpSrCx3yovXyyd3XPNfpnDuIfG5B8vHeKQNFuwbeDEC1g
 2fg0qXl7HXVQP6NDDeSHebDyl0T5xbtuwwWm0U76OhXvdZEbArS0xYHkS5JEHvArchEPLp5135
 QZAOGha86ICzUMkDQD/hoAG/2qLFIpG5X312UOr0vFEZJwH5hCRBhCmjjBjyFU63zLZha6YiIy
 F0o=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="263300861"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 11:54:16 +0800
IronPort-SDR: J47+agh5kYZASikXTDfhdaDK96z0TdF5yk6tvqyfiuYgeVkelj4Mz+O/Eyi2IkeR+43Wkjp95Z
 mHAKV2J73hiW/FG8Y/M8s140HGHA5oyklsppEbtHZEH+DLVqy62LrXhEIAreQpnqO+zXhTbHnl
 4VzdCrJ45/O7eX3nRyGn/AdOpf+Yqs9Xvnzc/fnETaDgAG0qhcR2j5BBhswkxrFT42Hl5alVgw
 ixcHf7VtYwxP5sfg2fPEJbdTqADywdcRpStEp2TTVHQZQ6guw7/e1nmLTjJxc5+i2it8QJb8Mz
 QX3By8t6UD7Sarr+wfhAhvcU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 19:33:13 -0800
IronPort-SDR: y0orts6v3OSiNNsoJEURzGib9GzTrueBFFil8RGP0kbEG6h1dMa+ZY/6ULMrVPhWb1T12qFOfg
 vFftqs/wE/kMKNMwqtOmHP34vdrMlQ1LyafQijLBsHDz/L3wiC+VjXPmHWkTuoeRKP3CkxsTVo
 CNyQfvCl2SvfI/hdJibUG7zbh0jXs523W7RoGURwr1NDUjJ+YxKNaHvU7RsO51B4boEa8x9boG
 Y17KlJ64sUIAwvphtz/fmWTVxokgqJXOYhmN2aobLv/5rvZ/GjivRi4VbqPcc1YiF9O1m09949
 Ct0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 19:51:11 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     paolo.valente@linaro.org, axboe@kernel.dk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        akpm@linux-foundation.org, aravind.ramesh@wdc.com,
        joshi.k@samsung.com, niklas.cassel@wdc.com, hare@suse.de,
        colyli@suse.de, tj@kernel.org, rdunlap@infradead.org, jack@suse.cz,
        hch@lst.de
Subject: [PATCH V2 3/5] blktrace: fix blk_rq_issue documentation
Date:   Thu,  4 Feb 2021 19:50:42 -0800
Message-Id: <20210205035044.5645-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The commit 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
added the comment for blk_rq_issue() tracepoint. Remove the duplicate
word from the tracepoint documentation.

Fixes: 881245dcff29 ("Add DocBook documentation for the block tracepoints.")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/trace/events/block.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 879cba8bdfca..004cfe34ef37 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -196,7 +196,7 @@ DEFINE_EVENT(block_rq, block_rq_insert,
 
 /**
  * block_rq_issue - issue pending block IO request operation to device driver
- * @rq: block IO operation operation request
+ * @rq: block IO operation request
  *
  * Called when block operation request @rq from queue @q is sent to a
  * device driver for processing.
-- 
2.22.1

