Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D56C54C197
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346002AbiFOF7H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 01:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiFOF7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 01:59:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCF35A9A
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 22:59:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACC3567373; Wed, 15 Jun 2022 07:58:58 +0200 (CEST)
Date:   Wed, 15 Jun 2022 07:58:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] block: Rename a blk_mq_map_queue() argument
Message-ID: <20220615055858.GB22115@lst.de>
References: <20220614175725.612878-1-bvanassche@acm.org> <20220614175725.612878-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614175725.612878-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:24AM -0700, Bart Van Assche wrote:
> Before the introduction of blk_mq_get_hctx_type(), blk_mq_map_queue()
> only used the flags from its second argument. Since the introduction of
> blk_mq_get_hctx_type(), blk_mq_map_queue() uses both the operation and
> the flags encoded in that argument. Rename the second argument of
> blk_mq_map_queue() to make this clear.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
