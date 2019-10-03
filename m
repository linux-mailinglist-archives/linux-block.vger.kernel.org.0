Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D8BC96AD
	for <lists+linux-block@lfdr.de>; Thu,  3 Oct 2019 04:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfJCCXU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Oct 2019 22:23:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJCCXT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Oct 2019 22:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uukNNW7qQ6N5xxrju+6gv/tEnkqzO22XeDWjNJoQQyk=; b=KNa9Ylbt3z+0evDhHHqfRkcPk
        Dr4iulViWFd8oQEUgM4iQH04/RYHGag++8UgL+bSUseuSfX4attrv1ZIIZelb2vkFghAUS7MrDwPB
        aF06K0aGZeurhUe2h5HvQXjc4MdsHbdQ7Gj/QvMQaX1qJlYK3IhZbmhyRky57w7lg2K8RPxEETpyx
        1cqE5wCboCu1xz7oivx+2eqfyq1PcyKSOxLax/Hwz1b70vPNnauyoPw4Xu07DZ8bko0L2gLO9Y+Bv
        43Imof9Wwdey9osWGd6Zx0jNQF94MJDb4G4k7Kgc5FCLQ66oaQFo2BWAv+xJG7VinINPIM+LhoayE
        Mm5oc6TnQ==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFqlm-0007pt-49; Thu, 03 Oct 2019 02:23:06 +0000
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     axboe <axboe@kernel.dk>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        David Kozub <zub@linux.fjfi.cvut.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] block: sed-opal: fix sparse warning: obsolete array init.
Message-ID: <807d7b7f-623b-75f0-baab-13b1b0c02e9d@infradead.org>
Date:   Wed, 2 Oct 2019 19:23:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix sparse warning: (missing '=')
../block/sed-opal.c:133:17: warning: obsolete array initializer, use C99 syntax

Fixes: ff91064ea37c ("block: sed-opal: check size of shadow mbr")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: David Kozub <zub@linux.fjfi.cvut.cz>
---
 block/sed-opal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-54-rc1.orig/block/sed-opal.c
+++ lnx-54-rc1/block/sed-opal.c
@@ -129,7 +129,7 @@ static const u8 opaluid[][OPAL_UID_LENGT
 		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },
 
 	/* tables */
-	[OPAL_TABLE_TABLE]
+	[OPAL_TABLE_TABLE] =
 		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
 		{ 0x00, 0x00, 0x08, 0x02, 0x00, 0x00, 0x00, 0x01 },

