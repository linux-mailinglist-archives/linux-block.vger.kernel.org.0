Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA4749C08
	for <lists+linux-block@lfdr.de>; Thu,  6 Jul 2023 14:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGFMlS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jul 2023 08:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGFMlR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 08:41:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CAE171A;
        Thu,  6 Jul 2023 05:41:17 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CF8468AFE; Thu,  6 Jul 2023 14:41:14 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:41:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/5] block: nullblk: Set zone limits before
 revalidating zones
Message-ID: <20230706124114.GC12545@lst.de>
References: <20230630083935.433334-1-dlemoal@kernel.org> <20230630083935.433334-4-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630083935.433334-4-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 30, 2023 at 05:39:33PM +0900, Damien Le Moal wrote:
> +	if (queue_is_mq(q))
> +		return blk_revalidate_disk_zones(nullb->disk, NULL);
> +
>  	return 0;

I'd write this as:

	if (!queue_is_mq(q)))
		return 0;
	return blk_revalidate_disk_zones(nullb->disk, NULL);

but that's just cosmetic.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
