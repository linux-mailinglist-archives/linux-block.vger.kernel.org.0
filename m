Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B55408293
	for <lists+linux-block@lfdr.de>; Mon, 13 Sep 2021 03:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbhIMBgm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 12 Sep 2021 21:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233133AbhIMBgl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 21:36:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0EB660FDA;
        Mon, 13 Sep 2021 01:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631496927;
        bh=mgWJDoM3z3cQEudIafZmHLOAdu7ULEXI+JcYrJjwpiU=;
        h=From:To:Cc:Subject:Date:From;
        b=PFUcFBQ3/btssDE7iEgpMLPk6x7vmw7PHATSeUYZ0g9i3ENs5PjLN6txy953GjTBE
         Hmg765VoEe+Pdcf/1q+DBdcR+zNN0GJI8Jx7NcSU+lAew++pNHaHxbR5YkR/FuBRzI
         7JJDrLOZLH8qbXE4zoPSQIs9J723DX1ZFJ5hJuXWjPaFSNF4kMFa6FK47vRIuj8hxW
         8aCChUAGr9AwSqU5M6oTuSptxRfc0aPEqbYqwrF8SFxvlIAhJtWrHtSpe6Estu1+Xo
         V3+ZM0QS/D+h4isfD7zLF5i7IXplTvkeCrjCwwOZbVp+ar4OEbmUzRsdhG4Pei3Yo/
         CASX7DaAssPig==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, Satya Tangirala <satyaprateek2357@gmail.com>
Subject: [PATCH 0/5] blk-crypto cleanups
Date:   Sun, 12 Sep 2021 18:31:30 -0700
Message-Id: <20210913013135.102404-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series renames struct blk_keyslot_manager to struct
blk_crypto_profile, as it is misnamed; it doesn't always manage
keyslots.  It's much more logical to think of it as the
"blk-crypto profile" of a device, similar to blk_integrity_profile.

This series also improves the inline-encryption.rst documentation file,
and cleans up blk-crypto-fallback a bit.

This series applies to v5.15-rc1.

Eric Biggers (5):
  blk-crypto-fallback: properly prefix function and struct names
  blk-crypto-fallback: consolidate static variables
  blk-crypto: rename keyslot-manager files to blk-crypto-profile
  blk-crypto: rename blk_keyslot_manager to blk_crypto_profile
  blk-crypto: update inline encryption documentation

 Documentation/block/inline-encryption.rst | 439 ++++++++--------
 block/Makefile                            |   2 +-
 block/blk-crypto-fallback.c               | 330 ++++++------
 block/blk-crypto-profile.c                | 564 +++++++++++++++++++++
 block/blk-crypto.c                        |  27 +-
 block/blk-integrity.c                     |   2 +-
 block/keyslot-manager.c                   | 578 ----------------------
 drivers/md/dm-core.h                      |   4 +-
 drivers/md/dm-table.c                     | 168 +++----
 drivers/md/dm.c                           |  10 +-
 drivers/mmc/core/crypto.c                 |  11 +-
 drivers/mmc/host/cqhci-crypto.c           |  33 +-
 drivers/scsi/ufs/ufshcd-crypto.c          |  32 +-
 drivers/scsi/ufs/ufshcd-crypto.h          |   9 +-
 drivers/scsi/ufs/ufshcd.c                 |   2 +-
 drivers/scsi/ufs/ufshcd.h                 |   6 +-
 include/linux/blk-crypto-profile.h        | 166 +++++++
 include/linux/blkdev.h                    |  18 +-
 include/linux/device-mapper.h             |   4 +-
 include/linux/keyslot-manager.h           | 120 -----
 include/linux/mmc/host.h                  |   4 +-
 21 files changed, 1310 insertions(+), 1219 deletions(-)
 create mode 100644 block/blk-crypto-profile.c
 delete mode 100644 block/keyslot-manager.c
 create mode 100644 include/linux/blk-crypto-profile.h
 delete mode 100644 include/linux/keyslot-manager.h

-- 
2.33.0

