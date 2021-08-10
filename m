Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70213D81DE
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 23:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhG0Vgw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 17:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbhG0Vgv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:36:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52723C061765
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:36:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso6813328pjb.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gc78Dn8NNh7IeWRGDgsdS+K6425aXZKh7I0yDMS23WM=;
        b=jixat3RPLLPRbxs71hxd4oCBxkRZeah1sKJ5Pxm3GeOwwF7vY8kGW67oHrU0zefouy
         WyLqJsPaUgzcAvxbVMTSI4TeMD/Mao7JC2nnG0LeGyA5Q5WHwJ59RQtcTz5z+y6+jj80
         TGrP2rH2/sRn/VHF7ByJT/X89kG7wOH3TvXzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gc78Dn8NNh7IeWRGDgsdS+K6425aXZKh7I0yDMS23WM=;
        b=J+lJ8uGaMePrSBYy/NaiSdi0XM9RGzgzL/wZgAcL9AZrDfaYZ3CqVzP/jzkatvVTfx
         N1WDx9/X8oxDsMYb7WMb+lWlDZMrQ60+cFxKAJeqhW9tZwwFsVjo/i1dAMhhr+PFRjpp
         8xt/hxw2MSb4AlFB/3ELeVw2pOKtqgELs+LRQIOQxY2UXtq0Q8StiHXAtvGWpAQ8/Fey
         NVoqhI5iZwp3jSyAq3acNNhFEmJ7DAREkHabdWs9u8AEcdI6nhkFc30pWl6QRrvyalkR
         0ihyNiS5KH4hieAutkcWOAVC2o958ZL6KfjoW48B23zPBl0JBGuGFK17KDv7xRNOg2bo
         GQFA==
X-Gm-Message-State: AOAM533UnS9FQHuEpra53/FCgzuE0XGU4A/Uczl4gDrk3F2lCNzONeYU
        UpCc2dPfQSnKpCFFPL5kikXu9Q==
X-Google-Smtp-Source: ABdhPJwzcm70LUJEYs4pukHqyokiwz2n0LXQBkV6ywdO41+JEjDUGqpk/L4ZHO751w6AfRr8f6jppA==
X-Received: by 2002:a63:4c53:: with SMTP id m19mr707522pgl.226.1627421810804;
        Tue, 27 Jul 2021 14:36:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k1sm5323404pga.70.2021.07.27.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:36:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 59/64] fortify: Detect struct member overflows in memset() at compile-time
Date:   Tue, 27 Jul 2021 13:58:50 -0700
Message-Id: <20210727205855.411487-60-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3639; h=from:subject; bh=8zP6zQoAqqqGG8HMfjFP4w1KGnbp2hqGXaP0Hbd76y4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHON3fO1CHh8uvdaQO6AN9FBZe6nYDGm5e9VLXU1 qyRUNQmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjQAKCRCJcvTf3G3AJqP1EA CVSH0wpqbxZ3IE5MoFsr86U7Yah0Hg+0c1Z0WseIk4zQvGBt5+jFc3XcFlXK0ePD9t1SEiUdtsmdTk f1ieawudX3fOXtTF+cENRebLnsBwHqJvcXhqWYybCiJZ5svrL/RhkKPjsZTl6p5Z09OONrfhkbCqOY ay2thxGsYWVYDMmGGQNm6DiY+eqdfIMpHIvddl9XbfH5zi6U1bthLezg2Y4qm0wOu/5ef45dfAvYyF oCnwD8HMnm/UEESuw5A1lfsDFrsjRjZvhke7e0iXTG1/CdsxQCbJdTGbmj/FbSwwxOIKvnAolZyJ1N Ytjm2RsjqaNYCBv3huLAScFJY0tonJLIjHFH/qNLF8HruT9cRTzhO1gRYqgMQ+klJaTJpljcvscTr/ V2vtj25ws/lTocXKXlKMHBDJvSYFfmuK5cOpt0DBPuNPdLyfE/QNCMFYDuE3D84/ghfuxMdMhh5IAD jcvjTg10ak7Kw9gd5dxLgqM3Jh3xlYuwUJ3NGRv3QnXsSMvCWQ4AA0SOp+ObPI+gAm9AdLedDedwyU jEhSXCZOIlnkATKds9+upOvmJWe7tDk7TJC9vK3pRhO7XoQV9FTH569mha1nU31WBCq88G6VlP5pfR MVMjAFcoVy2UbuarVe6jUsybzWsznx5I5wLnLraRpEfhYsvyhOtL0DVWQmVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As done for memcpy(), also update memset() to use the same tightened
compile-time bounds checking under CONFIG_FORTIFY_SOURCE.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h                | 54 ++++++++++++++++---
 .../write_overflow_field-memset.c             |  5 ++
 2 files changed, 51 insertions(+), 8 deletions(-)
 create mode 100644 lib/test_fortify/write_overflow_field-memset.c

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 2ffa5224aaac..718325331021 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -175,17 +175,56 @@ __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
 	return p;
 }
 
-__FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
+__FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
+					 const size_t p_size,
+					 const size_t p_size_field)
 {
-	size_t p_size = __builtin_object_size(p, 0);
+	if (__builtin_constant_p(size)) {
+		/*
+		 * Length argument is a constant expression, so we
+		 * can perform compile-time bounds checking where
+		 * buffer sizes are known.
+		 */
 
-	if (__builtin_constant_p(size) && p_size < size)
-		__write_overflow();
-	if (p_size < size)
-		fortify_panic(__func__);
-	return __underlying_memset(p, c, size);
+		/* Error when size is larger than enclosing struct. */
+		if (p_size > p_size_field && p_size < size)
+			__write_overflow();
+
+		/* Warn when write size is larger than dest field. */
+		if (p_size_field < size)
+			__write_overflow_field();
+	}
+	/*
+	 * At this point, length argument may not be a constant expression,
+	 * so run-time bounds checking can be done where buffer sizes are
+	 * known. (This is not an "else" because the above checks may only
+	 * be compile-time warnings, and we want to still warn for run-time
+	 * overflows.)
+	 */
+
+	/*
+	 * Always stop accesses beyond the struct that contains the
+	 * field, when the buffer's remaining size is known.
+	 * (The -1 test is to optimize away checks where the buffer
+	 * lengths are unknown.)
+	 */
+	if (p_size != (size_t)(-1) && p_size < size)
+		fortify_panic("memset");
 }
 
+#define __fortify_memset_chk(p, c, size, p_size, p_size_field) ({	\
+	size_t __fortify_size = (size_t)(size);				\
+	fortify_memset_chk(__fortify_size, p_size, p_size_field),	\
+	__underlying_memset(p, c, __fortify_size);			\
+})
+
+/*
+ * __builtin_object_size() must be captured here to avoid evaluating argument
+ * side-effects further into the macro layers.
+ */
+#define memset(p, c, s) __fortify_memset_chk(p, c, s,			\
+		__builtin_object_size(p, 0), __builtin_object_size(p, 1))
+
 /*
  * To make sure the compiler can enforce protection against buffer overflows,
  * memcpy(), memmove(), and memset() must not be used beyond individual
@@ -373,7 +412,6 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
 /* Don't use these outside the FORITFY_SOURCE implementation */
 #undef __underlying_memchr
 #undef __underlying_memcmp
-#undef __underlying_memset
 #undef __underlying_strcat
 #undef __underlying_strcpy
 #undef __underlying_strlen
diff --git a/lib/test_fortify/write_overflow_field-memset.c b/lib/test_fortify/write_overflow_field-memset.c
new file mode 100644
index 000000000000..2331da26909e
--- /dev/null
+++ b/lib/test_fortify/write_overflow_field-memset.c
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define TEST	\
+	memset(instance.buf, 0x42, sizeof(instance.buf) + 1)
+
+#include "test_fortify.h"
-- 
2.30.2

