Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61328B2573
	for <lists+linux-block@lfdr.de>; Fri, 13 Sep 2019 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfIMS67 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Sep 2019 14:58:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59176 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMS66 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 14:58:58 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:c7f4:5bfc:5711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0D52728F197;
        Fri, 13 Sep 2019 19:58:53 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/4] null_blk: fixes around nr_devices and log improvements
Date:   Fri, 13 Sep 2019 15:57:42 -0300
Message-Id: <20190913185746.337429-1-andrealmeid@collabora.com>
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

[1] https://patchwork.kernel.org/project/linux-block/list/?series=172853

André Almeida (4):
  null_blk: do not fail the module load with zero devices
  null_blk: match the type of module parameter
  null_blk: format pr_* logs with pr_fmt
  coding-style: add explanation about pr_fmt macro

 Documentation/process/coding-style.rst | 10 +++++++++-
 drivers/block/null_blk.h               |  4 +++-
 drivers/block/null_blk_main.c          | 24 ++++++++++--------------
 drivers/block/null_blk_zoned.c         |  6 +++---
 4 files changed, 25 insertions(+), 19 deletions(-)

-- 
2.23.0

