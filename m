Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471A723B73C
	for <lists+linux-block@lfdr.de>; Tue,  4 Aug 2020 11:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHDJHI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Aug 2020 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730049AbgHDJHH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 05:07:07 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD2AC061756
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 02:07:07 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so37769794qkb.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7ipA/IlQatApYEM6CWHUis7/rZFA1N/FZqRKGyOdhk=;
        b=NEOfFQwKtVgdkP9/2Lc5zq3FXFv37uCru5EHyXV7aaOAtRSUHQxlYQyDaDEa03euac
         IgVxg30STWVReF2vz9fOXLp72/WeH9AD7tkQhpXlzVYtptAVcAaFwUFYyMxdNBjN9By+
         3e41RzA+C0KLbGqc71Et1vKELKI0Ts3llVH0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7ipA/IlQatApYEM6CWHUis7/rZFA1N/FZqRKGyOdhk=;
        b=YaH5px3ScmSJ4A4hjmS2Y+KvaeU6GOIh4+Ol66LBzs5yJOHy0ezlJu3fx3JvzXO+Ji
         XRVJKFOD1e9Y1MWxz7deFaJt/GqWLfWAyWmJlhyD7nbk20SR6Ni91V3I0Rwtu19kyqBt
         lQWoqoSy3fMw0iG4Mmfgjv3YUFtI6JJKJRD1Qa/UfXvzHv0UUgWD38a+J6Y3BVLG/vz2
         7kT/M02bVwUHJw+VeFkF8V3nfZn3nhB3inugoaBUW+cn+M0NU/C8mwWdjzCM9l4nUZlA
         eIYieCuLWnPULU9xb+IsdVDb5pc5CzkzJcbcPPox7tLONXUue8LKE+fgpeHwocpPGSl2
         r0Ag==
X-Gm-Message-State: AOAM532uIlg0f2HvyVPf0kBCi+43YUG078Bw7EX3svBhJSn5Q5MyzFCf
        5J+us5BnCN8tiuP4BCLAWWzfDFs5JhlFuyfrsA/Sde3Qp6cLPaNnuZxluQELXni5JJRf/q2Dw1f
        73rSQ4lq4nqAjWpJTn56Wqp/0Nvo6GcK4JvjFw/5R1cPmCUulKNBx0gdsm1c9qjBAav3laM/iIx
        iuFgOZw/M=
X-Google-Smtp-Source: ABdhPJyt/uahtwbDp0cMYoGWSCBI3OdKGjdbt56EOIBnwRIOt2y+gzVZEunlQWUFzjyzPDnhRBvERQ==
X-Received: by 2002:a37:97c5:: with SMTP id z188mr19648713qkd.185.1596532026333;
        Tue, 04 Aug 2020 02:07:06 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 65sm19989407qkn.103.2020.08.04.02.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 02:07:05 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC 01/16] blkcg:Introduce blkio.app_identifier knob to blkio controller
Date:   Tue,  4 Aug 2020 07:43:01 +0530
Message-Id: <1596507196-27417-2-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This Patch added a unique application identifier i.e
blkio.app_identifier knob to  blkio controller which
allows identification of traffic sources at an
individual cgroup based Applications
(ex:virtual machine (VM))level in both host and
fabric infrastructure.

Also provided an interface blkcg_get_app_identifier to
grab the app identifier associated with a bio.

Added a sysfs interface blkio.app_identifier to get/set the appid.

This capability can be utilized by multiple block transport infrastructure
like fc,iscsi,roce ..

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
---
 block/blk-cgroup.c         | 32 ++++++++++++++++++++++++++++++++
 include/linux/blk-cgroup.h | 19 +++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 0ecc897b225c..697eccb3ba7a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -492,6 +492,33 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+static int blkcg_read_appid(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+
+	seq_printf(sf, "%s\n", blkcg->app_identifier);
+	return 0;
+}
+
+static ssize_t blkcg_write_appid(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
+	int i;
+
+	buf = strstrip(buf);
+	if (blkcg) {
+		if (nbytes < APPID_LEN)
+			strlcpy(blkcg->app_identifier, buf, nbytes);
+		else
+			return -EINVAL;
+	}
+	return nbytes;
+}
+
+
 const char *blkg_dev_name(struct blkcg_gq *blkg)
 {
 	/* some drivers (floppy) instantiate a queue w/o disk registered */
@@ -844,6 +871,11 @@ static struct cftype blkcg_legacy_files[] = {
 		.name = "reset_stats",
 		.write_u64 = blkcg_reset_stats,
 	},
+	{
+		.name = "app_identifier",
+		.write = blkcg_write_appid,
+		.seq_show = blkcg_read_appid,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index a57ebe2f00ab..3676d7ebb19f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -30,6 +30,7 @@
 
 /* Max limits for throttle policy */
 #define THROTL_IOPS_MAX		UINT_MAX
+#define APPID_LEN		128
 
 #ifdef CONFIG_BLK_CGROUP
 
@@ -55,6 +56,7 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+	char				app_identifier[APPID_LEN];
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
 #endif
@@ -239,6 +241,23 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 	return css ? container_of(css, struct blkcg, css) : NULL;
 }
 
+/**
+ * blkcg_get_app_identifier - grab the app identifier associated with a bio
+ * @bio: target bio
+ *
+ * This returns the app identifier associated with a bio,
+ * %NULL if not associated.
+ * Callers are expected to either handle %NULL or know association has been
+ * done prior to calling this.
+ */
+static inline char *blkcg_get_app_identifier(struct bio *bio)
+{
+	if (bio && (bio->bi_blkg) &&
+			(strlen(bio->bi_blkg->blkcg->app_identifier)))
+		return bio->bi_blkg->blkcg->app_identifier;
+	return NULL;
+}
+
 /**
  * __bio_blkcg - internal, inconsistent version to get blkcg
  *
-- 
2.18.2

