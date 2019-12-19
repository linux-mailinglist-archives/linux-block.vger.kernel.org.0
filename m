Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1282D1265C6
	for <lists+linux-block@lfdr.de>; Thu, 19 Dec 2019 16:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfLSPao (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Dec 2019 10:30:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:44600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfLSPao (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Dec 2019 10:30:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86451B1AD;
        Thu, 19 Dec 2019 15:30:42 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add lists to cdrom driver
Date:   Thu, 19 Dec 2019 16:30:34 +0100
Message-Id: <20191219153034.22344-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kernel maintainers are wondering why people don't send cdrom patches to
any lists they follow.

It is because they added no lists to the cdrom entry in MAINTAINERS,
obviously.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a049abccaa26..9e4eff21ef02 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16923,6 +16923,8 @@ F:	scripts/unifdef.c
 UNIFORM CDROM DRIVER
 M:	Jens Axboe <axboe@kernel.dk>
 W:	http://www.kernel.dk
+L:	linux-scsi@vger.kernel.org
+L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/cdrom/
 F:	drivers/cdrom/cdrom.c
-- 
2.23.0

