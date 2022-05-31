Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D4538B5E
	for <lists+linux-block@lfdr.de>; Tue, 31 May 2022 08:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244256AbiEaG0B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 May 2022 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbiEaG0B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 02:26:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03A29345C;
        Mon, 30 May 2022 23:26:00 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1F1B68AFE; Tue, 31 May 2022 08:25:56 +0200 (CEST)
Date:   Tue, 31 May 2022 08:25:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        ebiggers@kernel.org, pankydev8@gmail.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 6/9] block/merge: count bytes instead of sectors
Message-ID: <20220531062556.GC21098@lst.de>
References: <20220526010613.4016118-1-kbusch@fb.com> <20220526010613.4016118-7-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-7-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 25, 2022 at 06:06:10PM -0700, Keith Busch wrote:
> +	/*
> +	 * Individual bvecs may not be logical block aligned, so round down to
> +	 * that size to ensure both sides of the split bio are appropriately
> +	 * sized.
> +	 */

Maybe I'd word this as:

	/*
	 * Individual bvecs may not be logical block aligned.  Round down
	 * the split size so that each bio is properly sector size aligned,
	 * even if we do not use the full hardware limits.
	 */

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
