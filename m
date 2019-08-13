Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10EF8C3DC
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2019 23:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHMVlz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Aug 2019 17:41:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:61614 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfHMVlz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 17:41:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="176328284"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2019 14:41:54 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>
Subject: [PATCH 0/3] block: sed-opal: Code Cleanup Patches
Date:   Tue, 13 Aug 2019 15:43:37 -0600
Message-Id: <20190813214340.15533-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series of patch is a cleanup for sed-opal in kernel 5.4. It
1. Adds/removes spaces.
2. Eliminates dead error condition.
3. Eliminates definition defined twice.

These cleanup patches are submitted with the intend to submit a new feature
after this.

Revanth Rajashekar (3):
  block: sed-opal: Add/remove spaces
  block: sed-opal: Eliminating the dead error
  block: sed-opal: OPAL_METHOD_LENGTH defined twice

 block/opal_proto.h |  5 +----
 block/sed-opal.c   | 49 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 42 insertions(+), 12 deletions(-)

--
2.17.1

