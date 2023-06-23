Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1700B73B055
	for <lists+linux-block@lfdr.de>; Fri, 23 Jun 2023 07:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjFWFvK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Jun 2023 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFWFu5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 01:50:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE940E7D
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 22:50:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CF1267373; Fri, 23 Jun 2023 07:50:53 +0200 (CEST)
Date:   Fri, 23 Jun 2023 07:50:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 5/7] block: Preserve the order of requeued requests
Message-ID: <20230623055053.GE9085@lst.de>
References: <20230621201237.796902-1-bvanassche@acm.org> <20230621201237.796902-6-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-6-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	blk_mq_process_requeue_list(hctx);

Should this do list_empty_careful checks on ->requeue_list and
->flush_list so that we can avoid taking the requeue lock when
these conditions aren't met before calling into
blk_mq_process_requeue_list?
