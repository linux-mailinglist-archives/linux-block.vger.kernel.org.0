Return-Path: <linux-block+bounces-16989-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F60A2A279
	for <lists+linux-block@lfdr.de>; Thu,  6 Feb 2025 08:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01951888CB0
	for <lists+linux-block@lfdr.de>; Thu,  6 Feb 2025 07:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE45225776;
	Thu,  6 Feb 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8Fdh7oK"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098BB225760;
	Thu,  6 Feb 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738827625; cv=none; b=hBGjimlBevOgVpGhW95P3jIZLaXxzmnEUuyNxZvMTZWzyMfWzZL+8cu4LHc+scfbWe+u3z0pHKh71tcR8cPgTD9teLXI3ldI1zmF5FC1MnYXWP2gd52S9QOMd/pOigchIwI6vnudEVQz0ySwYmn9gU6bajV3CvKsoO04rK+/i+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738827625; c=relaxed/simple;
	bh=JjTcGv6JFi5QB2fvlGgNljq3qF7LReWoVWgMOSNQuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLLJBipU1+9yiygXZ/riKZEtTpN8e0UwrDIuwrVwoiRb5VoN/sCZGmSl+aVcL+C0XrnhVPZD7nGOi0zukASAKMuLOXikH8XvVWaqg/tFpYw/arpyH9QGl0mRAey4dcG/040c1KEBx1nFH5EZ8fmYi/UrID/qA1VzHBcHSCOvz24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8Fdh7oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0343C4CEE2;
	Thu,  6 Feb 2025 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738827624;
	bh=JjTcGv6JFi5QB2fvlGgNljq3qF7LReWoVWgMOSNQuDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8Fdh7oKnW3blIJWXet/YvAZYXlPtdp5YMB1RSBBZMxs+P1oViDPSAEXeLqz1kh+h
	 Fah+PDnf3MHM2dP7V61h6G+JXvsMwOHbwiuYaJlmgo/StuLaQORks7NKBbnI1+NwqP
	 EZ2/XbE1OlGdVKexIHgqkgf7UR+VRy4cIo8eIpOBQSK9bASG1yxM+sUlr3S1Hf8quy
	 E1G8C0KYUSf3HEOe5tz75d7p3EdjRkq0Pf6puGaLqLdX5lgEPJ6vVcc5vykOk2Lcux
	 CRIHc3e331Zp9K01TOus7xJkDpBz/P3qW9wGNuY1JYCBXoFNAJC4kyeuzloHveUEVV
	 0ymkmdkkFTudw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	x86@kernel.org,
	linux-block@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v3 5/6] x86/crc-t10dif: implement crc_t10dif using new template
Date: Wed,  5 Feb 2025 23:39:47 -0800
Message-ID: <20250206073948.181792-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206073948.181792-1-ebiggers@kernel.org>
References: <20250206073948.181792-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Instantiate crc-pclmul-template.S for crc_t10dif and delete the original
PCLMULQDQ optimized implementation.  This has the following advantages:

- Less CRC-variant-specific code.
- VPCLMULQDQ support, greatly improving performance on sufficiently long
  messages on newer CPUs.
- A faster reduction from 128 bits to the final CRC.
- Support for i386.

Benchmark results on AMD Ryzen 9 9950X (Zen 5) using crc_kunit:

        Length     Before        After
	------     ------        -----
	     1     440 MB/s      386 MB/s
	    16    1865 MB/s     2008 MB/s
	    64    4343 MB/s     6917 MB/s
	   127    5440 MB/s     8909 MB/s
	   128    5533 MB/s    12150 MB/s
	   200    5908 MB/s    14423 MB/s
	   256   15870 MB/s    21288 MB/s
	   511   14219 MB/s    25840 MB/s
	   512   18361 MB/s    37797 MB/s
	  1024   19941 MB/s    61374 MB/s
	  3173   20461 MB/s    74909 MB/s
	  4096   21310 MB/s    78919 MB/s
	 16384   21663 MB/s    85012 MB/s

Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/x86/Kconfig                    |   2 +-
 arch/x86/lib/Makefile               |   2 +-
 arch/x86/lib/crc-pclmul-consts.h    |  48 +++-
 arch/x86/lib/crc-t10dif-glue.c      |  23 +-
 arch/x86/lib/crc16-msb-pclmul.S     |   6 +
 arch/x86/lib/crct10dif-pcl-asm_64.S | 332 ----------------------------
 6 files changed, 64 insertions(+), 349 deletions(-)
 create mode 100644 arch/x86/lib/crc16-msb-pclmul.S
 delete mode 100644 arch/x86/lib/crct10dif-pcl-asm_64.S

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d957e2f1..7f59d73201ce7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -75,11 +75,11 @@ config X86
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
 	select ARCH_HAS_CRC32
-	select ARCH_HAS_CRC_T10DIF		if X86_64
+	select ARCH_HAS_CRC_T10DIF
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8a59c61624c2f..08496e221a7d1 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -41,11 +41,11 @@ lib-$(CONFIG_MITIGATION_RETPOLINE) += retpoline.o
 obj-$(CONFIG_CRC32_ARCH) += crc32-x86.o
 crc32-x86-y := crc32-glue.o crc32-pclmul.o
 crc32-x86-$(CONFIG_64BIT) += crc32c-3way.o
 
 obj-$(CONFIG_CRC_T10DIF_ARCH) += crc-t10dif-x86.o
-crc-t10dif-x86-y := crc-t10dif-glue.o crct10dif-pcl-asm_64.o
+crc-t10dif-x86-y := crc-t10dif-glue.o crc16-msb-pclmul.o
 
 obj-y += msr.o msr-reg.o msr-reg-export.o hweight.o
 obj-y += iomem.o
 
 ifeq ($(CONFIG_X86_32),y)
diff --git a/arch/x86/lib/crc-pclmul-consts.h b/arch/x86/lib/crc-pclmul-consts.h
index 34fdcb0446b03..089954988f977 100644
--- a/arch/x86/lib/crc-pclmul-consts.h
+++ b/arch/x86/lib/crc-pclmul-consts.h
@@ -1,14 +1,60 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * CRC constants generated by:
  *
- *	./scripts/gen-crc-consts.py x86_pclmul crc32_lsb_0xedb88320
+ *	./scripts/gen-crc-consts.py x86_pclmul crc16_msb_0x8bb7,crc32_lsb_0xedb88320
  *
  * Do not edit manually.
  */
 
+/*
+ * CRC folding constants generated for most-significant-bit-first CRC-16 using
+ * G(x) = x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + x^0
+ */
+static const struct {
+	u8 bswap_mask[16];
+	u64 fold_across_2048_bits_consts[2];
+	u64 fold_across_1024_bits_consts[2];
+	u64 fold_across_512_bits_consts[2];
+	u64 fold_across_256_bits_consts[2];
+	u64 fold_across_128_bits_consts[2];
+	u8 shuf_table[48];
+	u64 barrett_reduction_consts[2];
+} crc16_msb_0x8bb7_consts ____cacheline_aligned __maybe_unused = {
+	.bswap_mask = {15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
+	.fold_across_2048_bits_consts = {
+		0xdccf000000000000,	/* LO64_TERMS: (x^2000 mod G) * x^48 */
+		0x4b0b000000000000,	/* HI64_TERMS: (x^2064 mod G) * x^48 */
+	},
+	.fold_across_1024_bits_consts = {
+		0x9d9d000000000000,	/* LO64_TERMS: (x^976 mod G) * x^48 */
+		0x7cf5000000000000,	/* HI64_TERMS: (x^1040 mod G) * x^48 */
+	},
+	.fold_across_512_bits_consts = {
+		0x044c000000000000,	/* LO64_TERMS: (x^464 mod G) * x^48 */
+		0xe658000000000000,	/* HI64_TERMS: (x^528 mod G) * x^48 */
+	},
+	.fold_across_256_bits_consts = {
+		0x6ee3000000000000,	/* LO64_TERMS: (x^208 mod G) * x^48 */
+		0xe7b5000000000000,	/* HI64_TERMS: (x^272 mod G) * x^48 */
+	},
+	.fold_across_128_bits_consts = {
+		0x2d56000000000000,	/* LO64_TERMS: (x^80 mod G) * x^48 */
+		0x06df000000000000,	/* HI64_TERMS: (x^144 mod G) * x^48 */
+	},
+	.shuf_table = {
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
+	},
+	.barrett_reduction_consts = {
+		0x8bb7000000000000,	/* LO64_TERMS: (G - x^16) * x^48 */
+		0xf65a57f81d33a48a,	/* HI64_TERMS: (floor(x^79 / G) * x) - x^64 */
+	},
+};
+
 /*
  * CRC folding constants generated for least-significant-bit-first CRC-32 using
  * G(x) = x^32 + x^26 + x^23 + x^22 + x^16 + x^12 + x^11 + x^10 + x^8 + x^7 +
  *        x^5 + x^4 + x^2 + x^1 + x^0
  */
diff --git a/arch/x86/lib/crc-t10dif-glue.c b/arch/x86/lib/crc-t10dif-glue.c
index 13f07ddc9122c..6b09374b83558 100644
--- a/arch/x86/lib/crc-t10dif-glue.c
+++ b/arch/x86/lib/crc-t10dif-glue.c
@@ -1,39 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * CRC-T10DIF using PCLMULQDQ instructions
+ * CRC-T10DIF using [V]PCLMULQDQ instructions
  *
  * Copyright 2024 Google LLC
  */
 
-#include <asm/cpufeatures.h>
-#include <asm/simd.h>
-#include <crypto/internal/simd.h>
 #include <linux/crc-t10dif.h>
 #include <linux/module.h>
+#include "crc-pclmul-template.h"
 
 static DEFINE_STATIC_KEY_FALSE(have_pclmulqdq);
 
-asmlinkage u16 crc_t10dif_pcl(u16 init_crc, const u8 *buf, size_t len);
+DECLARE_CRC_PCLMUL_FUNCS(crc16_msb, u16);
 
 u16 crc_t10dif_arch(u16 crc, const u8 *p, size_t len)
 {
-	if (len >= 16 &&
-	    static_key_enabled(&have_pclmulqdq) && crypto_simd_usable()) {
-		kernel_fpu_begin();
-		crc = crc_t10dif_pcl(crc, p, len);
-		kernel_fpu_end();
-		return crc;
-	}
+	CRC_PCLMUL(crc, p, len, crc16_msb, crc16_msb_0x8bb7_consts,
+		   have_pclmulqdq);
 	return crc_t10dif_generic(crc, p, len);
 }
 EXPORT_SYMBOL(crc_t10dif_arch);
 
 static int __init crc_t10dif_x86_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ))
+	if (boot_cpu_has(X86_FEATURE_PCLMULQDQ)) {
 		static_branch_enable(&have_pclmulqdq);
+		INIT_CRC_PCLMUL(crc16_msb);
+	}
 	return 0;
 }
 arch_initcall(crc_t10dif_x86_init);
 
 static void __exit crc_t10dif_x86_exit(void)
@@ -45,7 +40,7 @@ bool crc_t10dif_is_optimized(void)
 {
 	return static_key_enabled(&have_pclmulqdq);
 }
 EXPORT_SYMBOL(crc_t10dif_is_optimized);
 
-MODULE_DESCRIPTION("CRC-T10DIF using PCLMULQDQ instructions");
+MODULE_DESCRIPTION("CRC-T10DIF using [V]PCLMULQDQ instructions");
 MODULE_LICENSE("GPL");
diff --git a/arch/x86/lib/crc16-msb-pclmul.S b/arch/x86/lib/crc16-msb-pclmul.S
new file mode 100644
index 0000000000000..e9fe248093a88
--- /dev/null
+++ b/arch/x86/lib/crc16-msb-pclmul.S
@@ -0,0 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+// Copyright 2025 Google LLC
+
+#include "crc-pclmul-template.S"
+
+DEFINE_CRC_PCLMUL_FUNCS(crc16_msb, /* bits= */ 16, /* lsb= */ 0)
diff --git a/arch/x86/lib/crct10dif-pcl-asm_64.S b/arch/x86/lib/crct10dif-pcl-asm_64.S
deleted file mode 100644
index 5286db5b8165e..0000000000000
--- a/arch/x86/lib/crct10dif-pcl-asm_64.S
+++ /dev/null
@@ -1,332 +0,0 @@
-########################################################################
-# Implement fast CRC-T10DIF computation with SSE and PCLMULQDQ instructions
-#
-# Copyright (c) 2013, Intel Corporation
-#
-# Authors:
-#     Erdinc Ozturk <erdinc.ozturk@intel.com>
-#     Vinodh Gopal <vinodh.gopal@intel.com>
-#     James Guilford <james.guilford@intel.com>
-#     Tim Chen <tim.c.chen@linux.intel.com>
-#
-# This software is available to you under a choice of one of two
-# licenses.  You may choose to be licensed under the terms of the GNU
-# General Public License (GPL) Version 2, available from the file
-# COPYING in the main directory of this source tree, or the
-# OpenIB.org BSD license below:
-#
-# Redistribution and use in source and binary forms, with or without
-# modification, are permitted provided that the following conditions are
-# met:
-#
-# * Redistributions of source code must retain the above copyright
-#   notice, this list of conditions and the following disclaimer.
-#
-# * Redistributions in binary form must reproduce the above copyright
-#   notice, this list of conditions and the following disclaimer in the
-#   documentation and/or other materials provided with the
-#   distribution.
-#
-# * Neither the name of the Intel Corporation nor the names of its
-#   contributors may be used to endorse or promote products derived from
-#   this software without specific prior written permission.
-#
-#
-# THIS SOFTWARE IS PROVIDED BY INTEL CORPORATION ""AS IS"" AND ANY
-# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INTEL CORPORATION OR
-# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
-# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
-# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
-# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
-# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
-# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-#
-#       Reference paper titled "Fast CRC Computation for Generic
-#	Polynomials Using PCLMULQDQ Instruction"
-#       URL: http://www.intel.com/content/dam/www/public/us/en/documents
-#  /white-papers/fast-crc-computation-generic-polynomials-pclmulqdq-paper.pdf
-#
-
-#include <linux/linkage.h>
-
-.text
-
-#define		init_crc	%edi
-#define		buf		%rsi
-#define		len		%rdx
-
-#define		FOLD_CONSTS	%xmm10
-#define		BSWAP_MASK	%xmm11
-
-# Fold reg1, reg2 into the next 32 data bytes, storing the result back into
-# reg1, reg2.
-.macro	fold_32_bytes	offset, reg1, reg2
-	movdqu	\offset(buf), %xmm9
-	movdqu	\offset+16(buf), %xmm12
-	pshufb	BSWAP_MASK, %xmm9
-	pshufb	BSWAP_MASK, %xmm12
-	movdqa	\reg1, %xmm8
-	movdqa	\reg2, %xmm13
-	pclmulqdq	$0x00, FOLD_CONSTS, \reg1
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm8
-	pclmulqdq	$0x00, FOLD_CONSTS, \reg2
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm13
-	pxor	%xmm9 , \reg1
-	xorps	%xmm8 , \reg1
-	pxor	%xmm12, \reg2
-	xorps	%xmm13, \reg2
-.endm
-
-# Fold src_reg into dst_reg.
-.macro	fold_16_bytes	src_reg, dst_reg
-	movdqa	\src_reg, %xmm8
-	pclmulqdq	$0x11, FOLD_CONSTS, \src_reg
-	pclmulqdq	$0x00, FOLD_CONSTS, %xmm8
-	pxor	%xmm8, \dst_reg
-	xorps	\src_reg, \dst_reg
-.endm
-
-#
-# u16 crc_t10dif_pcl(u16 init_crc, const *u8 buf, size_t len);
-#
-# Assumes len >= 16.
-#
-SYM_FUNC_START(crc_t10dif_pcl)
-
-	movdqa	.Lbswap_mask(%rip), BSWAP_MASK
-
-	# For sizes less than 256 bytes, we can't fold 128 bytes at a time.
-	cmp	$256, len
-	jl	.Lless_than_256_bytes
-
-	# Load the first 128 data bytes.  Byte swapping is necessary to make the
-	# bit order match the polynomial coefficient order.
-	movdqu	16*0(buf), %xmm0
-	movdqu	16*1(buf), %xmm1
-	movdqu	16*2(buf), %xmm2
-	movdqu	16*3(buf), %xmm3
-	movdqu	16*4(buf), %xmm4
-	movdqu	16*5(buf), %xmm5
-	movdqu	16*6(buf), %xmm6
-	movdqu	16*7(buf), %xmm7
-	add	$128, buf
-	pshufb	BSWAP_MASK, %xmm0
-	pshufb	BSWAP_MASK, %xmm1
-	pshufb	BSWAP_MASK, %xmm2
-	pshufb	BSWAP_MASK, %xmm3
-	pshufb	BSWAP_MASK, %xmm4
-	pshufb	BSWAP_MASK, %xmm5
-	pshufb	BSWAP_MASK, %xmm6
-	pshufb	BSWAP_MASK, %xmm7
-
-	# XOR the first 16 data *bits* with the initial CRC value.
-	pxor	%xmm8, %xmm8
-	pinsrw	$7, init_crc, %xmm8
-	pxor	%xmm8, %xmm0
-
-	movdqa	.Lfold_across_128_bytes_consts(%rip), FOLD_CONSTS
-
-	# Subtract 128 for the 128 data bytes just consumed.  Subtract another
-	# 128 to simplify the termination condition of the following loop.
-	sub	$256, len
-
-	# While >= 128 data bytes remain (not counting xmm0-7), fold the 128
-	# bytes xmm0-7 into them, storing the result back into xmm0-7.
-.Lfold_128_bytes_loop:
-	fold_32_bytes	0, %xmm0, %xmm1
-	fold_32_bytes	32, %xmm2, %xmm3
-	fold_32_bytes	64, %xmm4, %xmm5
-	fold_32_bytes	96, %xmm6, %xmm7
-	add	$128, buf
-	sub	$128, len
-	jge	.Lfold_128_bytes_loop
-
-	# Now fold the 112 bytes in xmm0-xmm6 into the 16 bytes in xmm7.
-
-	# Fold across 64 bytes.
-	movdqa	.Lfold_across_64_bytes_consts(%rip), FOLD_CONSTS
-	fold_16_bytes	%xmm0, %xmm4
-	fold_16_bytes	%xmm1, %xmm5
-	fold_16_bytes	%xmm2, %xmm6
-	fold_16_bytes	%xmm3, %xmm7
-	# Fold across 32 bytes.
-	movdqa	.Lfold_across_32_bytes_consts(%rip), FOLD_CONSTS
-	fold_16_bytes	%xmm4, %xmm6
-	fold_16_bytes	%xmm5, %xmm7
-	# Fold across 16 bytes.
-	movdqa	.Lfold_across_16_bytes_consts(%rip), FOLD_CONSTS
-	fold_16_bytes	%xmm6, %xmm7
-
-	# Add 128 to get the correct number of data bytes remaining in 0...127
-	# (not counting xmm7), following the previous extra subtraction by 128.
-	# Then subtract 16 to simplify the termination condition of the
-	# following loop.
-	add	$128-16, len
-
-	# While >= 16 data bytes remain (not counting xmm7), fold the 16 bytes
-	# xmm7 into them, storing the result back into xmm7.
-	jl	.Lfold_16_bytes_loop_done
-.Lfold_16_bytes_loop:
-	movdqa	%xmm7, %xmm8
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm7
-	pclmulqdq	$0x00, FOLD_CONSTS, %xmm8
-	pxor	%xmm8, %xmm7
-	movdqu	(buf), %xmm0
-	pshufb	BSWAP_MASK, %xmm0
-	pxor	%xmm0 , %xmm7
-	add	$16, buf
-	sub	$16, len
-	jge	.Lfold_16_bytes_loop
-
-.Lfold_16_bytes_loop_done:
-	# Add 16 to get the correct number of data bytes remaining in 0...15
-	# (not counting xmm7), following the previous extra subtraction by 16.
-	add	$16, len
-	je	.Lreduce_final_16_bytes
-
-.Lhandle_partial_segment:
-	# Reduce the last '16 + len' bytes where 1 <= len <= 15 and the first 16
-	# bytes are in xmm7 and the rest are the remaining data in 'buf'.  To do
-	# this without needing a fold constant for each possible 'len', redivide
-	# the bytes into a first chunk of 'len' bytes and a second chunk of 16
-	# bytes, then fold the first chunk into the second.
-
-	movdqa	%xmm7, %xmm2
-
-	# xmm1 = last 16 original data bytes
-	movdqu	-16(buf, len), %xmm1
-	pshufb	BSWAP_MASK, %xmm1
-
-	# xmm2 = high order part of second chunk: xmm7 left-shifted by 'len' bytes.
-	lea	.Lbyteshift_table+16(%rip), %rax
-	sub	len, %rax
-	movdqu	(%rax), %xmm0
-	pshufb	%xmm0, %xmm2
-
-	# xmm7 = first chunk: xmm7 right-shifted by '16-len' bytes.
-	pxor	.Lmask1(%rip), %xmm0
-	pshufb	%xmm0, %xmm7
-
-	# xmm1 = second chunk: 'len' bytes from xmm1 (low-order bytes),
-	# then '16-len' bytes from xmm2 (high-order bytes).
-	pblendvb	%xmm2, %xmm1	#xmm0 is implicit
-
-	# Fold the first chunk into the second chunk, storing the result in xmm7.
-	movdqa	%xmm7, %xmm8
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm7
-	pclmulqdq	$0x00, FOLD_CONSTS, %xmm8
-	pxor	%xmm8, %xmm7
-	pxor	%xmm1, %xmm7
-
-.Lreduce_final_16_bytes:
-	# Reduce the 128-bit value M(x), stored in xmm7, to the final 16-bit CRC
-
-	# Load 'x^48 * (x^48 mod G(x))' and 'x^48 * (x^80 mod G(x))'.
-	movdqa	.Lfinal_fold_consts(%rip), FOLD_CONSTS
-
-	# Fold the high 64 bits into the low 64 bits, while also multiplying by
-	# x^64.  This produces a 128-bit value congruent to x^64 * M(x) and
-	# whose low 48 bits are 0.
-	movdqa	%xmm7, %xmm0
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm7 # high bits * x^48 * (x^80 mod G(x))
-	pslldq	$8, %xmm0
-	pxor	%xmm0, %xmm7			  # + low bits * x^64
-
-	# Fold the high 32 bits into the low 96 bits.  This produces a 96-bit
-	# value congruent to x^64 * M(x) and whose low 48 bits are 0.
-	movdqa	%xmm7, %xmm0
-	pand	.Lmask2(%rip), %xmm0		  # zero high 32 bits
-	psrldq	$12, %xmm7			  # extract high 32 bits
-	pclmulqdq	$0x00, FOLD_CONSTS, %xmm7 # high 32 bits * x^48 * (x^48 mod G(x))
-	pxor	%xmm0, %xmm7			  # + low bits
-
-	# Load G(x) and floor(x^48 / G(x)).
-	movdqa	.Lbarrett_reduction_consts(%rip), FOLD_CONSTS
-
-	# Use Barrett reduction to compute the final CRC value.
-	movdqa	%xmm7, %xmm0
-	pclmulqdq	$0x11, FOLD_CONSTS, %xmm7 # high 32 bits * floor(x^48 / G(x))
-	psrlq	$32, %xmm7			  # /= x^32
-	pclmulqdq	$0x00, FOLD_CONSTS, %xmm7 # *= G(x)
-	psrlq	$48, %xmm0
-	pxor	%xmm7, %xmm0		     # + low 16 nonzero bits
-	# Final CRC value (x^16 * M(x)) mod G(x) is in low 16 bits of xmm0.
-
-	pextrw	$0, %xmm0, %eax
-	RET
-
-.align 16
-.Lless_than_256_bytes:
-	# Checksumming a buffer of length 16...255 bytes
-
-	# Load the first 16 data bytes.
-	movdqu	(buf), %xmm7
-	pshufb	BSWAP_MASK, %xmm7
-	add	$16, buf
-
-	# XOR the first 16 data *bits* with the initial CRC value.
-	pxor	%xmm0, %xmm0
-	pinsrw	$7, init_crc, %xmm0
-	pxor	%xmm0, %xmm7
-
-	movdqa	.Lfold_across_16_bytes_consts(%rip), FOLD_CONSTS
-	cmp	$16, len
-	je	.Lreduce_final_16_bytes		# len == 16
-	sub	$32, len
-	jge	.Lfold_16_bytes_loop		# 32 <= len <= 255
-	add	$16, len
-	jmp	.Lhandle_partial_segment	# 17 <= len <= 31
-SYM_FUNC_END(crc_t10dif_pcl)
-
-.section	.rodata, "a", @progbits
-.align 16
-
-# Fold constants precomputed from the polynomial 0x18bb7
-# G(x) = x^16 + x^15 + x^11 + x^9 + x^8 + x^7 + x^5 + x^4 + x^2 + x^1 + x^0
-.Lfold_across_128_bytes_consts:
-	.quad		0x0000000000006123	# x^(8*128)	mod G(x)
-	.quad		0x0000000000002295	# x^(8*128+64)	mod G(x)
-.Lfold_across_64_bytes_consts:
-	.quad		0x0000000000001069	# x^(4*128)	mod G(x)
-	.quad		0x000000000000dd31	# x^(4*128+64)	mod G(x)
-.Lfold_across_32_bytes_consts:
-	.quad		0x000000000000857d	# x^(2*128)	mod G(x)
-	.quad		0x0000000000007acc	# x^(2*128+64)	mod G(x)
-.Lfold_across_16_bytes_consts:
-	.quad		0x000000000000a010	# x^(1*128)	mod G(x)
-	.quad		0x0000000000001faa	# x^(1*128+64)	mod G(x)
-.Lfinal_fold_consts:
-	.quad		0x1368000000000000	# x^48 * (x^48 mod G(x))
-	.quad		0x2d56000000000000	# x^48 * (x^80 mod G(x))
-.Lbarrett_reduction_consts:
-	.quad		0x0000000000018bb7	# G(x)
-	.quad		0x00000001f65a57f8	# floor(x^48 / G(x))
-
-.section	.rodata.cst16.mask1, "aM", @progbits, 16
-.align 16
-.Lmask1:
-	.octa	0x80808080808080808080808080808080
-
-.section	.rodata.cst16.mask2, "aM", @progbits, 16
-.align 16
-.Lmask2:
-	.octa	0x00000000FFFFFFFFFFFFFFFFFFFFFFFF
-
-.section	.rodata.cst16.bswap_mask, "aM", @progbits, 16
-.align 16
-.Lbswap_mask:
-	.octa	0x000102030405060708090A0B0C0D0E0F
-
-.section	.rodata.cst32.byteshift_table, "aM", @progbits, 32
-.align 16
-# For 1 <= len <= 15, the 16-byte vector beginning at &byteshift_table[16 - len]
-# is the index vector to shift left by 'len' bytes, and is also {0x80, ...,
-# 0x80} XOR the index vector to shift right by '16 - len' bytes.
-.Lbyteshift_table:
-	.byte		 0x0, 0x81, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87
-	.byte		0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f
-	.byte		 0x0,  0x1,  0x2,  0x3,  0x4,  0x5,  0x6,  0x7
-	.byte		 0x8,  0x9,  0xa,  0xb,  0xc,  0xd,  0xe , 0x0
-- 
2.48.1


