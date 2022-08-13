Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA759190D
	for <lists+linux-block@lfdr.de>; Sat, 13 Aug 2022 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiHMGor (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 13 Aug 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMGoq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 02:44:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705C51031
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 23:44:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0EC3268AA6; Sat, 13 Aug 2022 08:44:42 +0200 (CEST)
Date:   Sat, 13 Aug 2022 08:44:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 0/6] Make blk_mq_map_queues() return void
Message-ID: <20220813064441.GA10835@lst.de>
References: <20220812210800.2253972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812210800.2253972-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The only block driver for which the .map_queues() callback can fail is null_blk. Since

Please fix your mailer to avoid overly long lines.

Otherwise the changes themselves look fine, but I think it would be
way easier to review as a single patch that changes both the method
signature and the common helpers.
