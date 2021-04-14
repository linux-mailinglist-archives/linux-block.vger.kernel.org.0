Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2535F39D
	for <lists+linux-block@lfdr.de>; Wed, 14 Apr 2021 14:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhDNMYg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Apr 2021 08:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbhDNMYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Apr 2021 08:24:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A824C06175F
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:12 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e7so23405735edu.10
        for <linux-block@vger.kernel.org>; Wed, 14 Apr 2021 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=C4MivO8Revzq2yABPsu2Tg+Z4787SAkCWyt/Q9JZdPMTuAHGRNW6fM8vMD6XSOg1IG
         cfPBvDhw47SsqljK4569TKakFieHDvDGgM8yCfSlk+XiXvUpLaui42a8gsJsJ+PER0Uq
         YMCb8mcz1sVLD0NHZz+gWQVofm30Vib2rpwG5qr6Z/B2h7uxjUQO0kFbHOjkGZVkWZv/
         ShsFPmMa9ndyDZcVHRtatqHAWMN2us7b/Kgo81BW5R+fH50a4N2EvBFdyCWgfmCYwXGY
         vK9HlWjguzFWrQAUzaW8C4NfHUQgA3SmCVGsRHsW8QsHx4ZMf/PK3ppQYsGxRAmjcMRt
         UQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kipd4FaBQ5PXB3dpojcZn5niu7bqNibIYxBeruWL79Q=;
        b=Xv68ynkcaVVyPVePi72Kg2T2XoS/Ooxlx2iWgO9J98PEgqxEx3YD9XpBk4Uwq4Is2X
         PwkR/DlndLoB4U0Z0rirvH98iqIFe3VA7/P7tbxPNHxNtIbvLtnhrOMfmVtZg2IiiajN
         JaUM1ctbXVz7tkpTo1MOTGEVEznyi7sDnBDcJhYyE5z1F9GGFXrCYak/m8ycoB0FpDgO
         BINnuOkR647C3lZ69BfJRWxMMuOAKfM/+j+nYaQ1UclEQu9ZfmCu0BIhQJVmKSFcvoVf
         l6YNmgA2eWtUaF4cJ1kNXmAmd/k7Y5eiOqEjRlitycXn5CnM80dfqOd7X6Sxzb/AYFIL
         2bzQ==
X-Gm-Message-State: AOAM530/BX0aZ62aqQh6F2DS+tm9pkiXtxhkQvPpTRrvqW0sOhNfPhyt
        hqh3bMnyqiI4B78JIHVgZV7poZpYrs88AA==
X-Google-Smtp-Source: ABdhPJyEsqyv/vD8Eg1C2j6ljfdSB7ypqLcpEX3tq03FlR63+PGWhrHAnDKhsDhEwrPo6Umsi7Srew==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr40382467edd.134.1618403050898;
        Wed, 14 Apr 2021 05:24:10 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id y26sm6201306ejj.98.2021.04.14.05.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:24:10 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv4 for-next 02/19] Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
Date:   Wed, 14 Apr 2021 14:23:45 +0200
Message-Id: <20210414122402.203388-3-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414122402.203388-1-gi-oh.kim@ionos.com>
References: <20210414122402.203388-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Two sysfs entries, remap_device and resize, are missing.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-block-rnbd | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-rnbd b/Documentation/ABI/testing/sysfs-block-rnbd
index 14a6fe9422b3..ec716e1c31a8 100644
--- a/Documentation/ABI/testing/sysfs-block-rnbd
+++ b/Documentation/ABI/testing/sysfs-block-rnbd
@@ -44,3 +44,15 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	Contains the device access mode: ro, rw or migration.
+
+What:		/sys/block/rnbd<N>/rnbd/resize
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Write the number of sectors to change the size of the disk.
+
+What:		/sys/block/rnbd<N>/rnbd/remap_device
+Date:		Feb 2020
+KernelVersion:	5.7
+Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
+Description:	Remap the disconnected device if the session is not destroyed yet.
-- 
2.25.1

