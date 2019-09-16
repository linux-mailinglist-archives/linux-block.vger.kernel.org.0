Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ABFB3C31
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 16:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388451AbfIPOJO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Sep 2019 10:09:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57158 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387788AbfIPOJO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 10:09:14 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:d32a:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id AB57C28D44A;
        Mon, 16 Sep 2019 15:09:10 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v3 0/3] null_blk: fixes around nr_devices and log improvements
Date:   Mon, 16 Sep 2019 11:07:56 -0300
Message-Id: <20190916140759.52491-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series address feedback for a previous patch series sent by
me "docs: block: null_blk: enhance document style"[1].

First patch removes a restriction that prevents null_blk to load with
(nr_devices == 0). This restriction breaks applications, so it's a bug. I
have tested it running the kernel with `null_blk.nr_devices=0`.

In the previous series I have changed the type of var nr_devices, but I
forgot to change the type at module_param(). The second patch fix that.

The third patch uses a cleaver approach to make log messages consistent
using pr_fmt and the last one add a note on how to do that at the
coding style documentation.

Thanks,
	André

Changes since v2:
- Add "Reviewed-by: Chaitanya Kulkarni" (thanks!)
- Drop "[v2,4/4] coding-style: add explanation about pr_fmt macro"
from this series

Changes since v1:
 - Add "Fixes" tag at [2/4]
 - No more headers reordering at [3/4]
 - Use #undef pr_fmt and KBUILD_MODNAME at [3/4] and [4/4]
 - Replace "printk.h" for "kernel.h" at [4/4]

 More details are provided at each patch changelog

[1] https://patchwork.kernel.org/project/linux-block/list/?series=172853

André Almeida (3):
  null_blk: do not fail the module load with zero devices
  null_blk: match the type of parameter nr_devices
  null_blk: format pr_* logs with pr_fmt

 drivers/block/null_blk.h       |  5 ++++-
 drivers/block/null_blk_main.c  | 22 +++++++++-------------
 drivers/block/null_blk_zoned.c |  4 ++--
 3 files changed, 15 insertions(+), 16 deletions(-)

-- 
2.23.0

