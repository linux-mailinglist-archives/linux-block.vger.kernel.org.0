Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B392FE531
	for <lists+linux-block@lfdr.de>; Thu, 21 Jan 2021 09:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbhAUIjm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jan 2021 03:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbhAUIYA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jan 2021 03:24:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5143623975;
        Thu, 21 Jan 2021 08:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611217399;
        bh=8MbQghIX86lQQEjetS0v6+wqvTD+XqNx7AqMICVjUUo=;
        h=From:To:Cc:Subject:Date:From;
        b=cD/nIccHVUpxYlT/doTCy28hAKnMi055BFw66/LnGPW7iZtQNEM8Y+yeC3F+Cb6yP
         IrO1hVthr5e0zQhKvNHuOjSIWD6myPhgCFN1m4g7n6gHxt0wvkUG2/Uzbnz/XgR28P
         btt+Cr1J2YDLw28cFHZ7t2YwagNHnsLgEC10TNEHBE64jU/WqaRPlcUuT1lXf5PvdM
         yMU/8OM7/fVceA/i0kesPwBJDGM9+vEf10DHhAlM/byWHoOW1+QowDH5deXaiKXo+p
         53kEhUoJeim2lX76qJzvEbLXLxuqq7XaNyD7r1uJIstNKQ4YXSRtc42rWhRDrG7lBQ
         nl2K6POFXuVIQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] Resource-managed blk_ksm_init()
Date:   Thu, 21 Jan 2021 00:21:53 -0800
Message-Id: <20210121082155.111333-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patchset adds a resource-managed variant of blk_ksm_init() so that
drivers don't have to worry about calling blk_ksm_destroy().

This was suggested during review of my patchset which adds eMMC inline
encryption support
(https://lkml.kernel.org/linux-mmc/20210104184542.4616-1-ebiggers@kernel.org/T/#u).
That patchset proposes a second caller of blk_ksm_init().  But it can
instead use the resource-managed variant, as can the UFS driver.

My preference is that patch #1 be taken through the MMC tree together
with my MMC patchset, so that we don't have to wait an extra cycle for
the MMC changes.  Patch #2 can then go in later.

Eric Biggers (2):
  block/keyslot-manager: introduce devm_blk_ksm_init()
  scsi: ufs: use devm_blk_ksm_init()

 Documentation/block/inline-encryption.rst | 12 +++++-----
 block/keyslot-manager.c                   | 29 +++++++++++++++++++++++
 drivers/scsi/ufs/ufshcd-crypto.c          |  9 ++-----
 drivers/scsi/ufs/ufshcd-crypto.h          |  5 ----
 drivers/scsi/ufs/ufshcd.c                 |  1 -
 include/linux/keyslot-manager.h           |  3 +++
 6 files changed, 40 insertions(+), 19 deletions(-)

-- 
2.30.0

