Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BF7D075E
	for <lists+linux-block@lfdr.de>; Fri, 20 Oct 2023 06:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjJTEmG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Oct 2023 00:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJTEmF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 00:42:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872A11AE
        for <linux-block@vger.kernel.org>; Thu, 19 Oct 2023 21:42:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9CFB867373; Fri, 20 Oct 2023 06:41:59 +0200 (CEST)
Date:   Fri, 20 Oct 2023 06:41:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
Subject: Re: [PATCH] block: Improve shared tag set performance
Message-ID: <20231020044159.GB11984@lst.de>
References: <20231018180056.2151711-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180056.2151711-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 18, 2023 at 11:00:56AM -0700, Bart Van Assche wrote:
> Note: it has been attempted to rework this algorithm. See also "[PATCH
> RFC 0/7] blk-mq: improve tag fair sharing"
> (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
> Given the complexity of that patch series, I do not expect that patch
> series to be merged.

Work is hard, so let's skip it?  That's not really the most convincing
argument.  Hey, I'm the biggest advocate for code improvement by code
removal, but you better have a really good argument why it doesn't hurt
anyone.
