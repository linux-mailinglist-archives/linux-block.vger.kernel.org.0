Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D462E6F7C94
	for <lists+linux-block@lfdr.de>; Fri,  5 May 2023 07:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjEEFwc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 May 2023 01:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEFwc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 01:52:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFEF2D56
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 22:52:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96BA968AA6; Fri,  5 May 2023 07:52:28 +0200 (CEST)
Date:   Fri, 5 May 2023 07:52:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v4 03/11] block: Introduce op_is_zoned_write()
Message-ID: <20230505055228.GB11748@lst.de>
References: <20230503225208.2439206-1-bvanassche@acm.org> <20230503225208.2439206-4-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503225208.2439206-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 03:52:00PM -0700, Bart Van Assche wrote:
> Introduce a helper function for checking whether write serialization is
> required if the operation will be sent to a zoned device. A second caller
> for op_is_zoned_write() will be introduced in the next patch in this
> series.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
