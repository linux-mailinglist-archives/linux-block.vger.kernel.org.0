Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E359EACE
	for <lists+linux-block@lfdr.de>; Tue, 23 Aug 2022 20:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiHWSTn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Aug 2022 14:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiHWSTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 14:19:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A8958B
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 09:35:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC86868AA6; Tue, 23 Aug 2022 18:35:41 +0200 (CEST)
Date:   Tue, 23 Aug 2022 18:35:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: don't add partitions if GD_SUPPRESS_PART_SCAN
 is set
Message-ID: <20220823163541.GA22113@lst.de>
References: <20220823103819.395776-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823103819.395776-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23, 2022 at 06:38:19PM +0800, Ming Lei wrote:
> Commit b9684a71fca7 ("block, loop: support partitions without scanning")
> adds GD_SUPPRESS_PART_SCAN for replacing part function of
> GENHD_FL_NO_PART. But looks blk_add_partitions() is missed, since
> loop doesn't want to add partitions if GENHD_FL_NO_PART was set.
> And it causes regression on libblockdev (as called from udisks) which
> operates with the LO_FLAGS_PARTSCAN.
> 
> Fixes the issue by not adding partitions if GD_SUPPRESS_PART_SCAN is
> set.
> 
> Fixes: b9684a71fca7 ("block, loop: support partitions without scanning")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
