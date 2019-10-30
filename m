Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92D5CEA62A
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2019 23:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJ3W2p (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Oct 2019 18:28:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3W2p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:28:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id DA75D28FF50
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests v2 3/3] Documentation: Add information about `--config` argument
Date:   Wed, 30 Oct 2019 19:27:07 -0300
Message-Id: <20191030222707.10142-4-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030222707.10142-1-andrealmeid@collabora.com>
References: <20191030222707.10142-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add information about how to use the argument `--config`.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/running-tests.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 675dac7..2f71e18 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -21,7 +21,9 @@ will run all tests in the `loop` group and the `block/002` test.
 
 Test configuration goes in the `config` file at the top-level directory of the
 blktests repository. Test configuration options can also be set as environment
-variables instead of in the `config` file.
+variables instead of in the `config` file. It is also possible to use a
+different file for configuration, using `--config=<file_name>`. Note that, for
+multiple uses of this option, all files will be loaded.
 
 ### Test Devices
 
-- 
2.23.0

