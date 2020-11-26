Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEE82C500F
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 09:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388698AbgKZIQY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 03:16:24 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34448 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbgKZIQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UGaAtDU_1606378580;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UGaAtDU_1606378580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 Nov 2020 16:16:20 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Some cleanups and improvements for blk-iocost
Date:   Thu, 26 Nov 2020 16:16:10 +0800
Message-Id: <cover.1606378475.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch set did some cleanups and improvements for blk-iocost, and
no big functional changes. Please help to review. Thanks.

Changes from v1:
 - Add acked-by tag from Tejun.
 - Drop 2 unnecessary patches.
 - Move the related variable declarations inside the block together
 with the code in patch 3.
 - Move the commit_weights() into ioc_check_iocgs().
 - Move more related logics of adjusting base vrate into the
 ioc_adjust_base_vrate().
 - Rename the new functions.

Baolin Wang (5):
  blk-iocost: Fix some typos in comments
  blk-iocost: Remove unnecessary advance declaration
  blk-iocost: Move the usage ratio calculation to the correct place
  blk-iocost: Factor out the active iocgs' state check into a separate
    function
  blk-iocost: Factor out the base vrate change into a separate function

 block/blk-iocost.c | 251 +++++++++++++++++++++++++++++------------------------
 1 file changed, 137 insertions(+), 114 deletions(-)

-- 
1.8.3.1

