Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4485329E5
	for <lists+linux-block@lfdr.de>; Tue, 24 May 2022 14:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbiEXMAO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 May 2022 08:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiEXMAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 08:00:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0593E6339F
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:00:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9EC7368AFE; Tue, 24 May 2022 14:00:06 +0200 (CEST)
Date:   Tue, 24 May 2022 14:00:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <20220524120006.GA17563@lst.de>
References: <20220524083325.833981-1-hch@lst.de> <9f988597-77b7-de53-79f4-ed2e70a0eaab@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f988597-77b7-de53-79f4-ed2e70a0eaab@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 11:29:05AM +0200, Hannes Reinecke wrote:
> Calling debugfs_remove_recursive(q->debugfs_dir) for all queue types, but 
> setting q->debugfs_dir to NULL only for mq?
> Care to explain?

->debugfs_dir is never set to NULL, only q->sched_debugfs_dir and
q->rqos_debugfs_dir.  Both of those are only used for blk-mq (and
don't really need the reset either, but this is all existing code
and will be dealt with later instead of a minimalistic bug fix.
