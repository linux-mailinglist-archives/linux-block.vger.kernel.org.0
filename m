Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5203B6E724F
	for <lists+linux-block@lfdr.de>; Wed, 19 Apr 2023 06:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjDSEau (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Apr 2023 00:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDSEat (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 00:30:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F2D61A9
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 21:30:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D05F6732D; Wed, 19 Apr 2023 06:30:44 +0200 (CEST)
Date:   Wed, 19 Apr 2023 06:30:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2 06/11] block: mq-deadline: Disable head insertion
 for zoned writes
Message-ID: <20230419043044.GC25329@lst.de>
References: <20230418224002.1195163-1-bvanassche@acm.org> <20230418224002.1195163-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418224002.1195163-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 03:39:57PM -0700, Bart Van Assche wrote:
> Make sure that zoned writes (REQ_OP_WRITE and REQ_OP_WRITE_ZEROES) are
> submitted in LBA order. This patch does not affect REQ_OP_WRITE_APPEND
> requests.

As said before this is not correct.  What we need to instead is to
support proper patch insertation when the at_head flag is set so
that the requests get inserted before the existing requests, but
in ordered they are passed to the I/O scheduler.

This also needs to be done for the other two I/O schedulers.
