Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05CB5329E3
	for <lists+linux-block@lfdr.de>; Tue, 24 May 2022 14:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiEXMBj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 May 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiEXMBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 08:01:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593E289B4
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:01:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A4E8068AFE; Tue, 24 May 2022 14:01:34 +0200 (CEST)
Date:   Tue, 24 May 2022 14:01:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <20220524120134.GB17563@lst.de>
References: <20220524083325.833981-1-hch@lst.de> <YozFt0qFCvZVt67m@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozFt0qFCvZVt67m@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 07:47:03PM +0800, Ming Lei wrote:
> Not look into details yet, but as one blk-mq debugfs user, I don't like
> the idea, since I often see io hang issue when calling
> blk_mq_freeze_queue_wait(), and blk-mq debugfs is very helpful for
> investigating this kind of issue.
> 
> But now blk-mq debugfs is gone with this patch __before__ draining IO in
> del_gendisk, and it becomes not useful as before.

This is the way hot it is set up, so in doubt I want it to be torn down
synchronously.  There might be a way to move the teardown later, but
that will require a very careful audit.
