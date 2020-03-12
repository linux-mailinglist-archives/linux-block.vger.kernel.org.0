Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3CC182A43
	for <lists+linux-block@lfdr.de>; Thu, 12 Mar 2020 09:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgCLIDU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Mar 2020 04:03:20 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:36319 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388096AbgCLIDU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 04:03:20 -0400
Received: by mail-pl1-f202.google.com with SMTP id y4so2853088plk.3
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 01:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y1s6MQhHqkVnqFsukeC5Awzp5ivr6jiv6hUkDCpLIsA=;
        b=KzIl0HFRPFDpD4RamPtkjTfVB+xlCCtT2LraTA/0B61n8m3pmGmHCmX//ov5FQWva1
         iYJlQp482tSC5I2bo99tpHHJ83S7G8ADGOz7zWIcbKo61d/pzYzpgAtx/XF3B40tTB2L
         08Buyphz0C7bGnN/8BNgIoGFuzOzPNTT1lNpCXWLEaTeYsLCr5NkvsomPH32QHvETm2e
         cbx2fvY1WsWGae2mbukMCmTFpDWExMCaGZs+GkpgZdHEHCGohcjNdY8UPWueJDnqYTOq
         YPmE8xd4qMF2HvQ8st4aUTOgFO8ZFisWbqW0TuVW8QMV51Kx78cclESONoHGqC55LBtz
         gTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y1s6MQhHqkVnqFsukeC5Awzp5ivr6jiv6hUkDCpLIsA=;
        b=T+sjZ2CDUFw27nJQIUSSxl/6mGq7+EiQsMGAKmSDUssnXZrU8m35I9R/p3W7z0F7zx
         cj7SdGvw66M4TgPUSsXgCVrlxM+ny3nSRcCpe2XNEs4pzRmdQZbbd0u0paTBZVRzCY2h
         hUkXf5tgK0ESZm1rfTgm4FcCcO4Dg/5D3svVkWy/YTn5QrZFPxK7g1JFHaXM+x/CfKo4
         SFFtN7pbGhi7+obM1Q88FdYh/RuDXIZdueOvzcO1PwSPtc5XcR3jZndJY80BlgwVB0+1
         Hd1ebr+fZ3SWxVzWdbk374I149scpzhDhv36jubkAQGWPN4SZqrOM1jEI8O4dDabbfmE
         vagg==
X-Gm-Message-State: ANhLgQ0niMUakug32Y1hEBHNY/e9USECI+0NXJTXVEfAIqL+nEsttNcs
        9L51bOw/msiw12/nl742kO/YSLpiy4z0qy8kymGsydOuaxzKeE/Gl1Qq2uykMKPWiT3RQlxZUU3
        ORZxHAkF//oWFCj9McndAu6tv3EIrChCHA7e+Rp+y/NMz2PgMCNdY1kbYOy3lxP6s8hgy
X-Google-Smtp-Source: ADFU+vuXOMA8mZEN+vMh9qFbvN0gW4bbscIe10bvEJpl4bpEIDzYzV5f0sZE06RcCDamrRg4MYFMPmlFhx0=
X-Received: by 2002:a17:90a:c687:: with SMTP id n7mr2803267pjt.159.1584000198723;
 Thu, 12 Mar 2020 01:03:18 -0700 (PDT)
Date:   Thu, 12 Mar 2020 01:02:50 -0700
In-Reply-To: <20200312080253.3667-1-satyat@google.com>
Message-Id: <20200312080253.3667-9-satyat@google.com>
Mime-Version: 1.0
References: <20200312080253.3667-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v8 08/11] fs: introduce SB_INLINECRYPT
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
blk-crypto for file content en/decryption.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/proc_namespace.c | 1 +
 include/linux/fs.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..8bf195d3bda6 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -49,6 +49,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
+		{ SB_INLINECRYPT, ",inlinecrypt" },
 		{ 0, NULL }
 	};
 	const struct proc_fs_info *fs_infop;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..08a0395674dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1370,6 +1370,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* inodes in SB use blk-crypto */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.25.1.481.gfbce0eb801-goog

