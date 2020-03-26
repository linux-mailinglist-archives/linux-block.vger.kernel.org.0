Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7205F193669
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 04:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCZDIb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 23:08:31 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44158 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgCZDIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 23:08:30 -0400
Received: by mail-pf1-f202.google.com with SMTP id b204so4011493pfb.11
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2020 20:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
        b=X3USqXR4qL98zoBR5xm+r5Iwa8B7XKg984qzqZUkzeS1r3XKmdcWL9n1SgvI9HghUg
         nM8y2dYeRcEviKJjMBvmdiOP1aLGK4HVl0FuTl7SS5gwdoicJBrE5nU+5T8si6fpwKaL
         Pq2J6FlR6VjJQjL40Ew3CkSMLuaYGSEO+ESNDhAkZjjWKGbWtNCtMOdYNRrN46eBHN6o
         RzVNmzzi9/0AKhFVuWRe+DrZKodOlN8Dsv+LrnR1WFteaMcrajtDGhf/gnb2Ie0WVl1q
         /xPclDdF1ylxfkyQpubwsHb5lYmzOnNcSQrPbfoGClrnii8UPWG7EKZ8yHC4qXoA9hsW
         ASMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5Pqv0B5ke8kbkLCKzahA1ADTWdbJkwiiM3DJVPre+r0=;
        b=KPEsXJdHxrTPiQ7QeJYGlwcaDBRpYqukJWIH9zeYLhwgAljpJC1+7VCDyj2kuC+Tkt
         WDGKnclmWWo0o5dsmEFr4I7AEry5r9lYOaAeA5kE8ghgI9leNUyOJ96x7/qPj93u6nPK
         Z9xUJa1kDKYzorkJoOwbctK++1zozAKCUCif/i/+R65bZNBbEFobMke+MY/VDCa0KGzr
         2+k3SamEBlrYfLCHl4+d9KRJpRq96LVAlADC9GgRvRY7/GUdrE6hwcA53KYeO6yVGIVo
         sgnu+V28HRc2ubQPCsdy3d8XaT3S6s2zcdB2OX3PkZXQaMT+CFlyLptym/5om5GR9BjT
         yA+g==
X-Gm-Message-State: ANhLgQ1lCXlDeCPIWGZcQI2gbw12PraX+N+A7AGoYVddc+pF5MufRgFt
        4ns6zj1bJi2fHfe4+SnpV6pre7M/Itm1uYprxdLgKMtrFh5U3VyWuxPDYuQJZb39PCesoNhujIp
        wRAxxVB9omW7wWVQjMPWOzkCkc2Es8U7Atzh5mCBXuGALYcsZp1qjE3X4Pi/6AjJJn6Qs
X-Google-Smtp-Source: ADFU+vvhE8/SSERvu33TE10DeCwz8+fW0QlS4JPaKhBx2Csq6iMcHH1qpy7Lzsv9wgwCkHL4I3oJP3dAAhY=
X-Received: by 2002:a17:90a:9501:: with SMTP id t1mr777236pjo.108.1585192108842;
 Wed, 25 Mar 2020 20:08:28 -0700 (PDT)
Date:   Wed, 25 Mar 2020 20:06:59 -0700
In-Reply-To: <20200326030702.223233-1-satyat@google.com>
Message-Id: <20200326030702.223233-9-satyat@google.com>
Mime-Version: 1.0
References: <20200326030702.223233-1-satyat@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v9 08/11] fs: introduce SB_INLINECRYPT
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
index 273ee82d8aa97..8bf195d3bda69 100644
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
index abedbffe2c9e4..5c758a765923d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1371,6 +1371,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.25.1.696.g5e7596f4ac-goog

