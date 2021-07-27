Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD033D818F
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhG0VTY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 17:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhG0VQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:16:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600CC06179B
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:16:54 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso1132745pjo.1
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP4OyANmlGcmztFWqw/dgo2DQckUAHhybqKwZBENvis=;
        b=LCA95eGQPuDryGp7EbL19tEBN1vZX/DV2Ru999TrrBIWyGTxCgkLiQwMnWVaK3dqpk
         60QOsc5jmDPjJIsota7QsQXAPPxE36dJdfR+Ydl1pbfvgmM6HMxLTyilm0vGV2trPRqk
         qPStf78RsWs4Jdx6SvJZesYZLDr/2M1lshLlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP4OyANmlGcmztFWqw/dgo2DQckUAHhybqKwZBENvis=;
        b=cFTTphE+i+syqGoeaDOHrNTsNMga3UxVJnzz7VE4x3EWRVO8AJURQ9aQ/n0LvedUEE
         XBz1gTtGFjYbFR5Z+3F/b9hUGvQ7ce62dGq1ZhEcOVNnjkc2GJV87AP58dxSY5qt17LX
         jINMi5HFJ9mAD0/8EG0pOnDaUj9DMqClaWA+ZlSLwi31cMr3h7aoTp63OjqvwdAS7hJt
         GQQpJXHlYqI9mREFOVqSV8SY8tykzZ9h2HfexnzFXA6SxUCXpvVe/tfe+wcRnFPw6zmI
         XR4RFCA1O4x7ULuui/FibtuTfL7slDdL6HNYQtHUleiLQJrzcnlSDu8It7Fu9CyChpir
         KL5A==
X-Gm-Message-State: AOAM531lxiHRDHHob1xy2Lt7e/lly6w5vkcWFtwHRopYgQ8ThyC8nu8h
        KkALdUM/uWzByT27Bu8xx6u07A==
X-Google-Smtp-Source: ABdhPJxnDJcYqdBzy28fe0pM7iN+zbksS85dJ1SqWH/meLyEzdRT3xN+44Z+ArcWYMJYdepJ2zZ1uQ==
X-Received: by 2002:a17:90a:c902:: with SMTP id v2mr6116581pjt.136.1627420613728;
        Tue, 27 Jul 2021 14:16:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m6sm4511294pfc.151.2021.07.27.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:16:50 -0700 (PDT)
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
Subject: [PATCH 62/64] netlink: Avoid false-positive memcpy() warning
Date:   Tue, 27 Jul 2021 13:58:53 -0700
Message-Id: <20210727205855.411487-63-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1678; h=from:subject; bh=vs/nNFIrJxwpI5nY+xgEPX6hqzmriBWLvM3b/eZbMbo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOOsotWr+xLgDAagynSwACfihlJOnm7qN9/Mu92 bGzCtbGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjgAKCRCJcvTf3G3AJj/ZD/ 9ntjJhpq8fBwkjGH+dUg05xTxsNzIOuiH2+WA92AhYmbos7FaDGTm1g+GjbS9tYtH4WO2HSlLQe7LQ FBHmUbu6aiUm0Adb7gUZE3muL85N91x3mnnmxIoo2J/A/2tV0zkQyLUOckCj8VK+SR9BfW61OwCULU 7dXUvxZG2bCfldSz9FFpeTg6B3n38v7ZsFzE0Z+OKqNG5B6gy6nq9hQDiK5eWY7jsHwu6TaCX2KdWP ox3h/ObmvzejD4r5bqMjjhvU16eLjApW1M3mdaJGfxBeiC7Hn4U7R0R/a57zPmDRTbz/MhdWbOOFDp ABNXWuprZfW5V1fn74AOyo4Qdi0fWAhH4ttZZuPFnGp39cUNy/oe1zMgHhD+XjhBS0RMucpc7gNElk gk4SaMhbgnC4Ou6wBhA+yQfDvMUjqtRWUuRYmsFZ5Llmrlr/jWnsbjlt39vSdTBC9vTKSqnxgt1omQ fQi/9qcta+kyf71Lx1H+c1m8ve+vz4yBPxEJ5ztsLmSYk+J3LMojiNObOTsmlTFbCj4ZoDBFSpnQga mYRnTFbLCAQHQtPXM2pa7+qmWPgSz70szWlbF1IDWFBmyv8JppWdlZQu+0ThYGXTdnhi+QLNwm/WxH Zw293JAH5hVEyNiT/+/fkkV4VjclpW+bzGJvvMPBwvfpxzJKDGLjwSx2fyMw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

Add a flexible array member to mark the end of struct nlmsghdr, and
split the memcpy() to avoid false positive memcpy() warning:

memcpy: detected field-spanning write (size 32) of single field (size 16)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/uapi/linux/netlink.h | 1 +
 net/netlink/af_netlink.c     | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index 4c0cde075c27..ddeaa748df5e 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -47,6 +47,7 @@ struct nlmsghdr {
 	__u16		nlmsg_flags;	/* Additional flags */
 	__u32		nlmsg_seq;	/* Sequence number */
 	__u32		nlmsg_pid;	/* Sending process port ID */
+	__u8		contents[];
 };
 
 /* Flags values */
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 24b7cf447bc5..f2dd99e96822 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2447,7 +2447,9 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 			  NLMSG_ERROR, payload, flags);
 	errmsg = nlmsg_data(rep);
 	errmsg->error = err;
-	memcpy(&errmsg->msg, nlh, payload > sizeof(*errmsg) ? nlh->nlmsg_len : sizeof(*nlh));
+	memcpy(&errmsg->msg, nlh, sizeof(*nlh));
+	if (payload > sizeof(*errmsg))
+		memcpy(errmsg->msg.contents, nlh->contents, nlh->nlmsg_len - sizeof(*nlh));
 
 	if (nlk_has_extack && extack) {
 		if (extack->_msg) {
-- 
2.30.2

