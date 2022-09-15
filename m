Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5796B5B9FF4
	for <lists+linux-block@lfdr.de>; Thu, 15 Sep 2022 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiIOQtq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Sep 2022 12:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiIOQtZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2022 12:49:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FEA9E6A6
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:55 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 78so17797451pgb.13
        for <linux-block@vger.kernel.org>; Thu, 15 Sep 2022 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lepBsWytyJc7odlmE2pOVLJDHfEg/6nqSBO25R2FRqw=;
        b=dRYPidNB4qr/PThCP2DZvS52KW2vSmy9pm3afLiJJETIx42RmwEKAGSyFrbhz878PJ
         PbszA/tTAvFSMGbxN2kh3CFn+XIu17dnVbAV4wFsI8NNGMYygeWgn2PXa/4BJeXuIQVZ
         mJ498MmM/GTV3SCimynfUDHw4QKdTRpYJKfNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lepBsWytyJc7odlmE2pOVLJDHfEg/6nqSBO25R2FRqw=;
        b=Tqtuz5XcScpQQMCqkl6K1BT12SeO7YCIRTe91Po2AV7pJFTFhHibbezmSYTGjau7qb
         kkR+qz68+pN7R08sY38ja+tFZcrYvvdB5Dq0b58xx9YU5uEcmi6jDzCJOSSFmKJS5wkU
         /iQ54Tgll8V33Ae1Q/FbdT6vo2cpyGCRtYUy/GnGQiRiv5Le+pDBz3/6KulXONSwaqPd
         YHvCqZ742AvKTKmdKO7fhj7NcCCxM6c3t+bx/CsUKkYv8ErWl7burRTT/US3OWt1y1EX
         c//qzMSmM6inPKoLD+DHzMLneqKJHu8LKXSqTXx8rYNq8/RX7vkE1XMr9sojvjvgUEph
         CMUA==
X-Gm-Message-State: ACrzQf3SoEqL4eRWYoS+mxpnfvM4Xprw+UBQYxU5aOvLbcMER+kfEBnQ
        Ga+yH0j0Ufc+l44sjoSpQ0FOyQ==
X-Google-Smtp-Source: AMsMyM4mYzeO6kY8V14FHKZ6sRCrfG/b2+9U/J91HawWbKAVnfznpfZpifb9zuLeuSrNWkeoxFzUpA==
X-Received: by 2002:aa7:9f0c:0:b0:546:c556:ac86 with SMTP id g12-20020aa79f0c000000b00546c556ac86mr327926pfr.55.1663260535338;
        Thu, 15 Sep 2022 09:48:55 -0700 (PDT)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:3af2:34b2:a98a:a652])
        by smtp.gmail.com with ESMTPSA id o4-20020a170902bcc400b00177ee563b6dsm13174970pls.33.2022.09.15.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:48:54 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
X-Google-Original-From: Sarthak Kukreti <sarthakkukreti@google.com>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH RFC 7/8] ext4: Add mount option for provisioning blocks during allocations
Date:   Thu, 15 Sep 2022 09:48:25 -0700
Message-Id: <20220915164826.1396245-8-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915164826.1396245-1-sarthakkukreti@google.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sarthak Kukreti <sarthakkukreti@chromium.org>

Add a mount option that sets the default provisioning mode for
all files within the filesystem.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 7 +++++++
 fs/ext4/super.c   | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ec0871e687c1..75f6e7f2f90b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1271,6 +1271,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
 						    * scanning in mballoc
 						    */
+#define EXT4_MOUNT2_PROVISION		0x00000100 /* Provision while allocating file blocks */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 7a096144b7f8..746213b5ec3d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4437,6 +4437,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	unsigned int credits;
 	loff_t epos;
 
+	/*
+	 * Attempt to provision file blocks if the mount is mounted with
+	 * provision.
+	 */
+	if (test_opt2(inode->i_sb, PROVISION))
+		flags |= EXT4_GET_BLOCKS_PROVISION;
+
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
 	map.m_len = len;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a66abcca1a8..5ece1868f332 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1596,6 +1596,7 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
+	Opt_provision, Opt_noprovision,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1744,6 +1745,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
 	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("discard",		Opt_provision),
+	fsparam_flag	("noprovision",		Opt_noprovision),
 	{}
 };
 
@@ -1840,6 +1843,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_provision, EXT4_MOUNT2_PROVISION, MOPT_SET | MOPT_2},
+	{Opt_noprovision, EXT4_MOUNT2_PROVISION, MOPT_CLEAR | MOPT_2},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -3010,6 +3015,8 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PUTS("dax=never");
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
+	} else if (test_opt2(sb, PROVISION)) {
+		SEQ_OPTS_PUTS("provision");
 	}
 
 	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
-- 
2.31.0

