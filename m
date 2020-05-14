Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F561D23EE
	for <lists+linux-block@lfdr.de>; Thu, 14 May 2020 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgENAiF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733281AbgENAhw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 20:37:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFB7C05BD0E
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 17:37:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q16so812277ybg.18
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 17:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=55QkT4XKq8mxRSoFTXYC1SQTqi8PeYRTuEggeVVcKMg=;
        b=FSAR9aVsI4Fqie7/PXkkDI8Y5GUjTkPwa4yPhNhy081BetakXjp2/T+HFhP7i1+jje
         E+77VaVI8DExiI50gAzT+1sVBifCQAsD4Iuj7Vx4k3eLChOi3L0EEOkG/ctWNZDFmosz
         dincGlPfrOyQ2hvnuusxDe81Gvr09ObdELXbyZRT59AQP1askJ5J0y93drtA7pgYfPqK
         58BqOlAMvpPVvsB380SSrFExwEf+FXA0+3cxjhFZkS/tyewv7/tymBXeCjcfXEdWaawb
         MXslNYJD3F0lPpZKrL4FBdhG80RKUgs4aLPHmixHtsc75/nDy6pOADX/NqjUV9XdyGN3
         BtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=55QkT4XKq8mxRSoFTXYC1SQTqi8PeYRTuEggeVVcKMg=;
        b=KWZWy7wOUkIpcY8YFvx2JLpfOsVuUZOj60N5C3RNCfvy1CxYmyQso+gx+lZQP2Ihlt
         9Ne29N+7vLoCTfxr3EcMXeY6fLeUFRUQ1kllib3z31w2qJxDc4vVR/9ZzRHYPmcitN4q
         byyjHICw9q52v3RuMnTNoA8CVuUQU2mLGY2O6JM8blkpKU4Ov4wLtrGcCJGhZg6WB0H/
         IuIxctsMubPZcmyZThiqyPWeHJRhOjeq00VJt1BDA1L/0C0wYwETeg8uc7+IlY895LkH
         iunu84qdDrScGLOSI0qwj/BbEIHIXD2xMnPkf7eVNmIOlGlFIYmvQljrgP2wGKzT9jjm
         IYSA==
X-Gm-Message-State: AOAM532mWA0eQ9sV7rl9kkoUOBXoAgxmNz1u+By+U2/qPff+Khjg1XxR
        +GKusPHINE/pX0rKXN2Dp/N6NYVPeFOrG/7Fg3CYSF55IXARjTq+TDw2pbit8bpUrXyChv6GjtM
        jjomA/pOH6RgnfXmhyRYuyTE20iEgH0Pet5kkJKKT6lVCX2CLYijEunu0Xh2JctlCZEwS
X-Google-Smtp-Source: ABdhPJzYcXxCqDOzC/K2ZR7nIKEHI38RLh83qXdlxtWE7t4EU9eemainBQhkiuOi2LGdK5129XlL1c7RPiI=
X-Received: by 2002:a25:3044:: with SMTP id w65mr2908668ybw.207.1589416669011;
 Wed, 13 May 2020 17:37:49 -0700 (PDT)
Date:   Thu, 14 May 2020 00:37:24 +0000
In-Reply-To: <20200514003727.69001-1-satyat@google.com>
Message-Id: <20200514003727.69001-10-satyat@google.com>
Mime-Version: 1.0
References: <20200514003727.69001-1-satyat@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v13 09/12] fs: introduce SB_INLINECRYPT
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
blk-crypto for file content en/decryption. This flag maps to the
'-o inlinecrypt' mount option which multiple filesystems will implement,
and code in fs/crypto/ needs to be able to check for this mount option
in a filesystem-independent way.

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
index d3ebb49189df2..da6551c8d96fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1376,6 +1376,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_NODIRATIME	2048	/* Do not update directory access times */
 #define SB_SILENT	32768
 #define SB_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define SB_INLINECRYPT	(1<<17)	/* Use blk-crypto for encrypted files */
 #define SB_KERNMOUNT	(1<<22) /* this is a kern_mount call */
 #define SB_I_VERSION	(1<<23) /* Update inode I_version field */
 #define SB_LAZYTIME	(1<<25) /* Update the on-disk [acm]times lazily */
-- 
2.26.2.645.ge9eca65c58-goog

