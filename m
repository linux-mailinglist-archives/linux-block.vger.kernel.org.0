Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1ECC716536
	for <lists+linux-block@lfdr.de>; Tue, 30 May 2023 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjE3OzV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 May 2023 10:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjE3OzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 May 2023 10:55:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAC98F
        for <linux-block@vger.kernel.org>; Tue, 30 May 2023 07:55:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 67BE968B05; Tue, 30 May 2023 16:55:16 +0200 (CEST)
Date:   Tue, 30 May 2023 16:55:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Message-ID: <20230530145516.GA11237@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de> <d2e12e08-3a5f-2f5b-e3d1-2c1ea39d716b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e12e08-3a5f-2f5b-e3d1-2c1ea39d716b@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 28, 2023 at 01:50:50PM -0700, Bart Van Assche wrote:
> On 5/23/23 22:53, Christoph Hellwig wrote:
>> I turns out this causes some kind of hang I haven't been able to
>> debug yet in blktests' hotplug test.   Can you drop this and the
>> subsequent patches for now?
>
> Hi Christoph,
>
> Are you perhaps referring to test block/027? It passes in my test-VM
> with Jens' for-next branch and the following blktests config file:

No, I mean block/001
