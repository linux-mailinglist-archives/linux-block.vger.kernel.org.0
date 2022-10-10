Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1125F9ADB
	for <lists+linux-block@lfdr.de>; Mon, 10 Oct 2022 10:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJJITI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Oct 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJJITG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 04:19:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC255850C
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 01:19:06 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D669768AA6; Mon, 10 Oct 2022 10:19:02 +0200 (CEST)
Date:   Mon, 10 Oct 2022 10:19:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Message-ID: <20221010081902.GA23270@lst.de>
References: <20221007193825.4058951-1-kbusch@meta.com> <Y0PLerK6pBp9UC2G@infradead.org> <20221010080218.uqhkvryiipybxidd@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010080218.uqhkvryiipybxidd@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 10:02:18AM +0200, Daniel Wagner wrote:
> Doesn't give me the same consistent result as with Keith's version:

That's because it is broken..  Try this version:

diff --git a/block/genhd.c b/block/genhd.c
index 514395361d7c5..2296ad422523a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -507,6 +507,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+	} else {
+		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
 	}
 
 	disk_update_readahead(disk);
