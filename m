Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB57868B5DE
	for <lists+linux-block@lfdr.de>; Mon,  6 Feb 2023 07:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBFGxu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Feb 2023 01:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjBFGxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2023 01:53:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588A126EE
        for <linux-block@vger.kernel.org>; Sun,  5 Feb 2023 22:53:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2A30068C7B; Mon,  6 Feb 2023 07:53:44 +0100 (CET)
Date:   Mon, 6 Feb 2023 07:53:43 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [bug report] RIP: 0010:blkg_free+0xa/0xe0 observed on latest
 linux-block/for-next
Message-ID: <20230206065343.GA9951@lst.de>
References: <CAHj4cs-ZvyXKU9iAVKSkh2NfN5238rh-OaU8_uDBHVFtJb2ASQ@mail.gmail.com> <20230206062037.GA9567@lst.de> <CAHj4cs_HT+iqoPkRcAFr8A4o5C3TzDE6h2fA-ZUbhiek7-MwnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_HT+iqoPkRcAFr8A4o5C3TzDE6h2fA-ZUbhiek7-MwnA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This should fix it:

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8faeca6022bea0..c46778d1f3c27d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -383,7 +383,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 err_put_css:
 	css_put(&blkcg->css);
 err_free_blkg:
-	blkg_free(new_blkg);
+	if (new_blkg)
+		blkg_free(new_blkg);
 	return ERR_PTR(ret);
 }
 
