Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E4697698
	for <lists+linux-block@lfdr.de>; Wed, 15 Feb 2023 07:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBOGr3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Feb 2023 01:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBOGr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2023 01:47:28 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5497F2A6E0
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 22:47:27 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D78667373; Wed, 15 Feb 2023 07:47:24 +0100 (CET)
Date:   Wed, 15 Feb 2023 07:47:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, hch@lst.de,
        mcgrof@kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <20230215064723.GA30472@lst.de>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com> <20230203103005.31290-1-p.raghav@samsung.com> <Y+Gsu0PiXBIf8fFU@T590> <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com> <Y+nwh7V5xehxMWDR@T590> <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95506a88-c89c-0f41-3ab4-eb5741410c02@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 14, 2023 at 08:18:54PM +0530, Pankaj Raghav wrote:
> Should we add a module parameter to switch between bio and blk-mq back-end
> in brd, similar to null_blk? The default option would be bio to avoid
> regression on existing workloads.

No.  Duplicate code paths are alaways a bad idea.  Please drill in further
what causes the differences.
