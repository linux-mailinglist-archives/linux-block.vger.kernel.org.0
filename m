Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 513DD13EFE6
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2020 19:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392809AbgAPSSE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jan 2020 13:18:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392671AbgAPR2w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 12:28:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E645D246F5;
        Thu, 16 Jan 2020 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195731;
        bh=9yyQQVA6frsX5edDqRbDHmocrB5LvBeeEjEnffYRiJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pHkaatHLrXnZCH/XrbIL17IakZ5ONLXzZnVpHbgaIYQM7NrMMF7LH2Yy4Vm2QZ29n
         2arjihZvoR/ODa0EVZ55GDrmAjYY+2zRcYeOed80IAvx7/0tX45N5FkKxdFceZdUPG
         RBVRDrZ9SOfWLO3UTfO94rMtykNQCprSV3J2YiHw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Steve French <smfrench@gmail.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Sasha Levin <sashal@kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 4.14 270/371] signal: Allow cifs and drbd to receive their terminating signals
Date:   Thu, 16 Jan 2020 12:22:22 -0500
Message-Id: <20200116172403.18149-213-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 33da8e7c814f77310250bb54a9db36a44c5de784 ]

My recent to change to only use force_sig for a synchronous events
wound up breaking signal reception cifs and drbd.  I had overlooked
the fact that by default kthreads start out with all signals set to
SIG_IGN.  So a change I thought was safe turned out to have made it
impossible for those kernel thread to catch their signals.

Reverting the work on force_sig is a bad idea because what the code
was doing was very much a misuse of force_sig.  As the way force_sig
ultimately allowed the signal to happen was to change the signal
handler to SIG_DFL.  Which after the first signal will allow userspace
to send signals to these kernel threads.  At least for
wake_ack_receiver in drbd that does not appear actively wrong.

So correct this problem by adding allow_kernel_signal that will allow
signals whose siginfo reports they were sent by the kernel through,
but will not allow userspace generated signals, and update cifs and
drbd to call allow_kernel_signal in an appropriate place so that their
thread can receive this signal.

Fixing things this way ensures that userspace won't be able to send
signals and cause problems, that it is clear which signals the
threads are expecting to receive, and it guarantees that nothing
else in the system will be affected.

This change was partly inspired by similar cifs and drbd patches that
added allow_signal.

Reported-by: ronnie sahlberg <ronniesahlberg@gmail.com>
Reported-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Tested-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: Steve French <smfrench@gmail.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Fixes: 247bc9470b1e ("cifs: fix rmmod regression in cifs.ko caused by force_sig changes")
Fixes: 72abe3bcf091 ("signal/cifs: Fix cifs_put_tcp_session to call send_sig instead of force_sig")
Fixes: fee109901f39 ("signal/drbd: Use send_sig not force_sig")
Fixes: 3cf5d076fb4d ("signal: Remove task parameter from force_sig")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_main.c |  2 ++
 fs/cifs/connect.c              |  2 +-
 include/linux/signal.h         | 15 ++++++++++++++-
 kernel/signal.c                |  5 +++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 7ea13b5497fd..b998e3abca7a 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -334,6 +334,8 @@ static int drbd_thread_setup(void *arg)
 		 thi->name[0],
 		 resource->name);
 
+	allow_kernel_signal(DRBD_SIGKILL);
+	allow_kernel_signal(SIGXCPU);
 restart:
 	retval = thi->function(thi);
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index ed4a0352ea90..f0b1279a7de6 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -921,7 +921,7 @@ cifs_demultiplex_thread(void *p)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
 
 	set_freezable();
-	allow_signal(SIGKILL);
+	allow_kernel_signal(SIGKILL);
 	while (server->tcpStatus != CifsExiting) {
 		if (try_to_freeze())
 			continue;
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 843bd62b1ead..c4e3eb89a622 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -268,6 +268,9 @@ extern void signal_setup_done(int failed, struct ksignal *ksig, int stepping);
 extern void exit_signals(struct task_struct *tsk);
 extern void kernel_sigaction(int, __sighandler_t);
 
+#define SIG_KTHREAD ((__force __sighandler_t)2)
+#define SIG_KTHREAD_KERNEL ((__force __sighandler_t)3)
+
 static inline void allow_signal(int sig)
 {
 	/*
@@ -275,7 +278,17 @@ static inline void allow_signal(int sig)
 	 * know it'll be handled, so that they don't get converted to
 	 * SIGKILL or just silently dropped.
 	 */
-	kernel_sigaction(sig, (__force __sighandler_t)2);
+	kernel_sigaction(sig, SIG_KTHREAD);
+}
+
+static inline void allow_kernel_signal(int sig)
+{
+	/*
+	 * Kernel threads handle their own signals. Let the signal code
+	 * know signals sent by the kernel will be handled, so that they
+	 * don't get silently dropped.
+	 */
+	kernel_sigaction(sig, SIG_KTHREAD_KERNEL);
 }
 
 static inline void disallow_signal(int sig)
diff --git a/kernel/signal.c b/kernel/signal.c
index c9b203875001..8fee1f2eba2f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -85,6 +85,11 @@ static int sig_task_ignored(struct task_struct *t, int sig, bool force)
 	    handler == SIG_DFL && !(force && sig_kernel_only(sig)))
 		return 1;
 
+	/* Only allow kernel generated signals to this kthread */
+	if (unlikely((t->flags & PF_KTHREAD) &&
+		     (handler == SIG_KTHREAD_KERNEL) && !force))
+		return true;
+
 	return sig_handler_ignored(handler, sig);
 }
 
-- 
2.20.1

