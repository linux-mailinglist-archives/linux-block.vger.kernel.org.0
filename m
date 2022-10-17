Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CB4601068
	for <lists+linux-block@lfdr.de>; Mon, 17 Oct 2022 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJQNnk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Oct 2022 09:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJQNnj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Oct 2022 09:43:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02E22ED71
        for <linux-block@vger.kernel.org>; Mon, 17 Oct 2022 06:43:38 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 28E0E68BFE; Mon, 17 Oct 2022 15:43:36 +0200 (CEST)
Date:   Mon, 17 Oct 2022 15:43:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221017134335.GA24959@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 13, 2022 at 01:28:37PM +0300, Sagi Grimberg wrote:
>> Because some queues never need to be quiesced(e.g. nvme connect_q).
>> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
>> skip the queue.
>
> I wouldn't say it never nor will ever quiesce, we just don't happen to
> quiesce it today...

Yes.  It really is a QUEUE_FLAG_SKIP_TAGSET_QUIESCE.

