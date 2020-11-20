Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987412BB358
	for <lists+linux-block@lfdr.de>; Fri, 20 Nov 2020 19:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgKTScz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Nov 2020 13:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730480AbgKTScx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 13:32:53 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38B524197;
        Fri, 20 Nov 2020 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897173;
        bh=GZOB0IrDdnCJYoRPlfA0gPLtj77XQYyYZviKM6e//7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxwEEcwauxahs/YS06KosdG+kfU0QYX/CNXJsLjFY/I/IEeXbs3S6BntDjjFzARac
         ehmJRMC3REHriA8zRE/J/MIeGvJ2lsg9FlcRz6tF5irxnVizR03hvPO8OiHUmwm6qr
         ZjzUvYeaIBKuXmmG1X82Jc6XpGzzMvcigHSA+hYc=
Date:   Fri, 20 Nov 2020 12:32:58 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 058/141] xen-blkfront: Fix fall-through warnings for Clang
Message-ID: <33057688012c34dd60315ad765ff63f070e98c0c.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/block/xen-blkfront.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 48629d3433b4..34b028be78ab 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2462,6 +2462,7 @@ static void blkback_changed(struct xenbus_device *dev,
 			break;
 		if (talk_to_blkback(dev, info))
 			break;
+		break;
 	case XenbusStateInitialising:
 	case XenbusStateInitialised:
 	case XenbusStateReconfiguring:
-- 
2.27.0

