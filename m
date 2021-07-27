Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BCB3D814E
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhG0VRU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbhG0VRD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:17:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B970AC0617A1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:17:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso1175110pjs.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pTss2I65Q2CWQl0zMLaa8H82eOPPoCY8oMnTRENSqR4=;
        b=YAUu+p5PRv4m9It5HWgaxQc7eZqBkPBSZLDjvBQJVq7VcgxFhGvoVLyoLJ8N4i8Jfl
         V1tiBwQXzIjaRpT/6KU3bsvSRWIl+Ed1WJZU8t8lYPaguXMnM+sHAZ9PNM1FRuzeOZ6x
         1w/S3Lji8xVrapNny1sSSoyKLZ2A+Kc5xxrVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pTss2I65Q2CWQl0zMLaa8H82eOPPoCY8oMnTRENSqR4=;
        b=UbEfxjx4iGUwLtCdBxzUNnOZ7Qk03LnSj+8BIJTtpF12dD6jPTvz4IxkwnjAN4E0kk
         0np7HLPPoxNt3MVlmJp8XdTCTPc/jwOXffPExSxdXM6d1By2AHWHTMZ+BAjr1AaRLwV8
         MOuSlOuiEEoWEWmzhgWOykToHIGpDHeComzkmp29mBLKtM8s0DbzjeQdKxEqjY3ScB1N
         vfMJU5KIW9j/iUFzE/lTNjdk4Gof+NDhneXBRu5st3pM0lw79IrGyD+Q8/JscDlVWEux
         tHPiCOa2AT1aPZ9bPAGvbkcuULQOilqG7sQpGFYXPArmcFODMYDLb2mdpDU2JsE4ko77
         RxNA==
X-Gm-Message-State: AOAM530DNlBoDnXUA34tmzjhIyur4BGhzhE1fCIFDkMC56x0rYdmjGk8
        Hu7Kzv2E2xLSI3wRYYDH3UQ75A==
X-Google-Smtp-Source: ABdhPJzbDPYt/21lhtnaWr0tImee3BF99wlkjaOxZG/zklC2IjLrFJ3c7AoHcvzezPw5M6d3+zm/bg==
X-Received: by 2002:a17:90a:d301:: with SMTP id p1mr5932205pju.220.1627420621296;
        Tue, 27 Jul 2021 14:17:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z124sm5174413pgb.6.2021.07.27.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:58 -0700 (PDT)
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
Subject: [PATCH 33/64] lib: Introduce CONFIG_TEST_MEMCPY
Date:   Tue, 27 Jul 2021 13:58:24 -0700
Message-Id: <20210727205855.411487-34-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9613; h=from:subject; bh=vMvyiyYe9K9D2gND/ltuxCZWuPzQBox4RoUvXlZiiJg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOHMVso80UVr0RhQnwYElca8D+4vYHNyJyis1bc atW3oFGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhwAKCRCJcvTf3G3AJjllD/ 9XMGR1In5NUDFOfmtBe5obH+PZnVXYS7aCsaC9BBl36zVbpB9g3hy9o9954IL44Q2M2X8l/iP0Mdt9 Fprd6vbL7wO+hDD4ywgbQtQaW4EbO1b99AS/E4opV8walRqK+MZ1ssZ9th1mYU1Yryl3nNwXH80K5z cHnVH/c6qUM1l7u4iPrktSMcqi0uxY+WT4tJT2QpEzBS2uA2Z++Pg0QAuabvzcMJLD36XlzH1dMGHF QsjWHoq3OpB7JI9BFoibODlYeQfe0vH+O4ZMR0CdC9+uqqaXOGvYga3tfXZzEFjKmWYLSbRiO/mRRb CiyxwZtmj156O9vH2uplTEipL2Mfks1IS1tv2wMc6e1Uc36ZTXbZ+ZDpYJHijeW4Kff8vdOt/zCO6H muSBMvvv8ZNOdnqmeHtRo5TJNWctfJSbnn4+sNRiDBQn7X6UuwmNmMhxRUt+l9Pjt5J1qx0T9lAmLn 0YWwa+kC7zviH7HJgzmVAbq7+flzYb9RAM0a927c5isRD+tKPj1F6yCfYw+B22p8x1p/BgLIibuR8G 83lZvdFsnQZvJgeK1txkG4sB66fQousphoaJGgD4py+IHG1KtnDuFiq/fwlscSFVTgiEGImI+xoQCE yfbM7YDkZxoxwyj7Q+KKDvxwFASZkIBYQ4AxZh75JAJqW2RHNpzsVKTFNVHw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before changing anything about memcpy(), memmove(), and memset(), add
run-time tests to check basic behaviors for any regressions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Kconfig.debug |   3 +
 lib/Makefile      |   1 +
 lib/test_memcpy.c | 285 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 lib/test_memcpy.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 4654e838d68b..d315db9702de 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2220,6 +2220,9 @@ config TEST_XARRAY
 config TEST_OVERFLOW
 	tristate "Test check_*_overflow() functions at runtime"
 
+config TEST_MEMCPY
+	tristate "Test memcpy*(), memmove*(), and memset*() functions at runtime"
+
 config TEST_RHASHTABLE
 	tristate "Perform selftest on resizable hash table"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 40b4bf0bc847..083a19336e20 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_TEST_MIN_HEAP) += test_min_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
+obj-$(CONFIG_TEST_MEMCPY) += test_memcpy.o
 obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
diff --git a/lib/test_memcpy.c b/lib/test_memcpy.c
new file mode 100644
index 000000000000..7c64120a68a9
--- /dev/null
+++ b/lib/test_memcpy.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for memcpy(), memmove(), and memset().
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/overflow.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+
+struct some_bytes {
+	union {
+		u8 data[32];
+		struct {
+			u32 one;
+			u16 two;
+			u8  three;
+			/* 1 byte hole */
+			u32 four[4];
+		};
+	};
+};
+
+#define check(instance, v) do {	\
+	int i;	\
+	BUILD_BUG_ON(sizeof(instance.data) != 32);	\
+	for (i = 0; i < sizeof(instance.data); i++) {	\
+		if (instance.data[i] != v) {	\
+			pr_err("line %d: '%s' not initialized to 0x%02x @ %d (saw 0x%02x)\n", \
+				__LINE__, #instance, v, i, instance.data[i]);	\
+			return 1;	\
+		}	\
+	}	\
+} while (0)
+
+#define compare(name, one, two) do { \
+	int i; \
+	BUILD_BUG_ON(sizeof(one) != sizeof(two)); \
+	for (i = 0; i < sizeof(one); i++) {	\
+		if (one.data[i] != two.data[i]) {	\
+			pr_err("line %d: %s.data[%d] (0x%02x) != %s.data[%d] (0x%02x)\n", \
+				__LINE__, #one, i, one.data[i], \
+				#two, i, two.data[i]);	\
+			return 1;	\
+		}	\
+	}	\
+	pr_info("ok: " TEST_OP "() " name "\n");	\
+} while (0)
+
+static int __init test_memcpy(void)
+{
+#define TEST_OP "memcpy"
+	struct some_bytes control = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes zero = { };
+	struct some_bytes middle = {
+		.data = { 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x00, 0x00, 0x00, 0x00,
+			  0x00, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes three = {
+		.data = { 0x00, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x00, 0x00, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			  0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+			},
+	};
+	struct some_bytes dest = { };
+	int count;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x20);
+	check(zero, 0);
+	compare("static initializers", dest, zero);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memcpy(dest.data, zero.data, sizeof(dest.data));
+	compare("complete overwrite", dest, zero);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memcpy(dest.data + 12, zero.data, 7);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	count = 1;
+	memcpy(ptr++, zero.data, count++);
+	ptr += 8;
+	memcpy(ptr++, zero.data, count++);
+	compare("argument side-effects", dest, three);
+
+	return 0;
+#undef TEST_OP
+}
+
+static int __init test_memmove(void)
+{
+#define TEST_OP "memmove"
+	struct some_bytes control = {
+		.data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes zero = { };
+	struct some_bytes middle = {
+		.data = { 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x00, 0x00, 0x00, 0x00,
+			  0x00, 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes five = {
+		.data = { 0x00, 0x00, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x00, 0x00, 0x00, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes overlap = {
+		.data = { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes overlap_expected = {
+		.data = { 0x00, 0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x07,
+			  0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			  0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99, 0x99,
+			},
+	};
+	struct some_bytes dest = { };
+	int count;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x99);
+	check(zero, 0);
+	compare("static initializers", zero, dest);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memmove(dest.data, zero.data, sizeof(dest.data));
+	compare("complete overwrite", dest, zero);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memmove(dest.data + 12, zero.data, 7);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	count = 2;
+	memmove(ptr++, zero.data, count++);
+	ptr += 9;
+	memmove(ptr++, zero.data, count++);
+	compare("argument side-effects", dest, five);
+
+	/* Verify overlapping overwrite is correct. */
+	ptr = &overlap.data[2];
+	memmove(ptr, overlap.data, 5);
+	compare("overlapping write", overlap, overlap_expected);
+
+	return 0;
+#undef TEST_OP
+}
+
+static int __init test_memset(void)
+{
+#define TEST_OP "memset"
+	struct some_bytes control = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes complete = {
+		.data = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			  0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+			},
+	};
+	struct some_bytes middle = {
+		.data = { 0x30, 0x30, 0x30, 0x30, 0x31, 0x31, 0x31, 0x31,
+			  0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31, 0x31,
+			  0x31, 0x31, 0x31, 0x31, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes three = {
+		.data = { 0x60, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x61, 0x61, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			  0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30, 0x30,
+			},
+	};
+	struct some_bytes dest = { };
+	int count, value;
+	u8 *ptr;
+
+	/* Verify static initializers. */
+	check(control, 0x30);
+	check(dest, 0);
+
+	/* Verify assignment. */
+	dest = control;
+	compare("direct assignment", dest, control);
+
+	/* Verify complete overwrite. */
+	memset(dest.data, 0xff, sizeof(dest.data));
+	compare("complete overwrite", dest, complete);
+
+	/* Verify middle overwrite. */
+	dest = control;
+	memset(dest.data + 4, 0x31, 16);
+	compare("middle overwrite", dest, middle);
+
+	/* Verify argument side-effects aren't repeated. */
+	dest = control;
+	ptr = dest.data;
+	value = 0x60;
+	count = 1;
+	memset(ptr++, value++, count++);
+	ptr += 8;
+	memset(ptr++, value++, count++);
+	compare("argument side-effects", dest, three);
+
+	return 0;
+#undef TEST_OP
+}
+
+
+static int __init test_memcpy_init(void)
+{
+	int err = 0;
+
+	err |= test_memcpy();
+	err |= test_memmove();
+	err |= test_memset();
+
+	if (err) {
+		pr_warn("FAIL!\n");
+		err = -EINVAL;
+	} else {
+		pr_info("all tests passed\n");
+	}
+
+	return err;
+}
+
+static void __exit test_memcpy_exit(void)
+{ }
+
+module_init(test_memcpy_init);
+module_exit(test_memcpy_exit);
+MODULE_LICENSE("GPL");
-- 
2.30.2

