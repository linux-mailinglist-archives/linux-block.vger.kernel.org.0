Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C138C2485D4
	for <lists+linux-block@lfdr.de>; Tue, 18 Aug 2020 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgHRNNy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Aug 2020 09:13:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:33698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHRNNk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 09:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 811D9B178;
        Tue, 18 Aug 2020 13:14:04 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v7 6/6] libceph: use sendpage_ok() in ceph_tcp_sendpage()
Date:   Tue, 18 Aug 2020 21:12:27 +0800
Message-Id: <20200818131227.37020-7-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818131227.37020-1-colyli@suse.de>
References: <20200818131227.37020-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In libceph, ceph_tcp_sendpage() does the following checks before handle
the page by network layer's zero copy sendpage method,
	if (page_count(page) >= 1 && !PageSlab(page))

This check is exactly what sendpage_ok() does. This patch replace the
open coded checks by sendpage_ok() as a code cleanup.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 27d6ab11f9ee..6a349da7f013 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -575,7 +575,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
 	 * coalescing neighboring slab objects into a single frag which
 	 * triggers one of hardened usercopy checks.
 	 */
-	if (page_count(page) >= 1 && !PageSlab(page))
+	if (sendpage_ok(page))
 		sendpage = sock->ops->sendpage;
 	else
 		sendpage = sock_no_sendpage;
-- 
2.26.2

