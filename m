Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B9394FEF
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2019 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfHSVdQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Aug 2019 17:33:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:53841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHSVdQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:33:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="377562866"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2019 14:33:15 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
Subject: [PATCH v2 0/3] block: sed-opal: Code Cleanup Patches
Date:   Mon, 19 Aug 2019 15:35:03 -0600
Message-Id: <20190819213506.14788-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patch is a cleanup for sed-opal in kernel 5.4. It
1. Adds/removes spaces.
2. Removes an always false conditional statement.
3. Removes duplicate OPAL_METHOD_LENGTH definition.

These cleanup patches are submitted with the intend to submit a new feature
after this.

Revanth Rajashekar (3):
  block: sed-opal: Add/remove spaces
  block: sed-opal: Remove always false conditional statement
  block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition

 block/opal_proto.h |  5 +----
 block/sed-opal.c   | 49 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 12 deletions(-)

--
2.17.1

