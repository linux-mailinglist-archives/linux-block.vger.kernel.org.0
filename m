Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125E166978F
	for <lists+linux-block@lfdr.de>; Fri, 13 Jan 2023 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbjAMMnc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Jan 2023 07:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbjAMMnF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:43:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B6D8793B
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:35:46 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mp20so5393352ejc.7
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=G5XERQe1fAt3Kb9rlbCJGlE/89ixGm3qrHLrpxM52o9W/0TyCmxSK8KQYB+DUYZTCl
         AY4qBORSFTisRda10PDMY+5R4iuPQsg9ejNoGN0oAsC0KmmDTingntoX093fWxIcrj+l
         UCE5EExAVjAxNtM0FNgYMtoLw/XQgmXjT6fiMaAgJz92EOyw+9QhW40mYzZl3TtoVTnG
         xTq+RBQHqeDUbXoAayRw0mInjrPtl8dXWHZBcCLRPNTqRIel4A3i1BVADEN1KuHalqpG
         rDbDh9YTvY3a008v1wbhhbnxzKGt+Z/U9hhC072Jib9MCA5BUVcpEzd1sOxgmJ3eCboL
         /rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGS8p58llTH0j/JtmBIf8IcqQNNb3dOfgpZWMO+4qxc=;
        b=MzvN3bj6W6yfL43DHPeAbpEh9qzmTjONtvAVhJJShYsbg+H3rOoTbwxTgSqhT7tXoO
         4KORXYc/PoyJH7uCdW2/HDc5ihpc70N33bV9nxQ+7NqjyEboODEeUED3AX8v0BItVp4u
         hEKeW0z55wWQ6+n3VaCuB4B1c+DRHBm0GbTbOcKLapBupplzb1xapWC8lTT8CTgn3oFN
         yDWF1Dsf9d3rso04BmB0wIYWOhTWqnzbBrnT2AULITmj1KZ4OAKYMduU6Nukr6ClxpLm
         l37XQtTUrAAr/KKkQVrQIVK2SgwTTLkAoq7OKPvMoNEeqWY3q7LNEvHY42+YGzahDIEL
         WhBg==
X-Gm-Message-State: AFqh2kpaIgkMJJ2dYrwyI/PIxs8z66JjJZRKnOjAtylr0sQRDEADEjH9
        5L/CFqikXBRao821f+yRXsntsgwShDnNWH6nDcg=
X-Google-Smtp-Source: AMrXdXt9Y/gN9hPS5KrmX/hHe2LMLmsSTU6vMBSp1QqWDvsKO+j0a8BW8SZ67KSgwDQIo/CICV+jqA==
X-Received: by 2002:a17:906:a18c:b0:7c1:5467:39b1 with SMTP id s12-20020a170906a18c00b007c1546739b1mr70848155ejy.72.1673613318750;
        Fri, 13 Jan 2023 04:35:18 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906201200b00846734faa9asm8386323ejo.164.2023.01.13.04.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:18 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [RESEND PATCH 0/3] DRBD file structure reorganization
Date:   Fri, 13 Jan 2023 13:35:03 +0100
Message-Id: <20230113123506.144082-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

To make our lives easier when sending future, more complex patches,
we want to align the file structure as best as possible with what we
have in the out-of-tree module.

Christoph Böhmwalder (3):
  drbd: split off drbd_buildtag into separate file
  drbd: drop API_VERSION define
  drbd: split off drbd_config into separate file

 drivers/block/drbd/Makefile        |  2 +-
 drivers/block/drbd/drbd_buildtag.c | 22 ++++++++++++++++++++++
 drivers/block/drbd/drbd_debugfs.c  |  2 +-
 drivers/block/drbd/drbd_int.h      |  1 +
 drivers/block/drbd/drbd_main.c     | 20 +-------------------
 drivers/block/drbd/drbd_proc.c     |  2 +-
 include/linux/drbd.h               |  7 -------
 include/linux/drbd_config.h        | 16 ++++++++++++++++
 include/linux/drbd_genl_api.h      |  2 +-
 9 files changed, 44 insertions(+), 30 deletions(-)
 create mode 100644 drivers/block/drbd/drbd_buildtag.c
 create mode 100644 include/linux/drbd_config.h


base-commit: f596da3efaf4130ff61cd029558845808df9bf99
-- 
2.38.1

