Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B943657E69
	for <lists+linux-block@lfdr.de>; Wed, 28 Dec 2022 16:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiL1Pxa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Dec 2022 10:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiL1PxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Dec 2022 10:53:22 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D8F15F29
        for <linux-block@vger.kernel.org>; Wed, 28 Dec 2022 07:53:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EB23F68C7B; Wed, 28 Dec 2022 16:53:17 +0100 (CET)
Date:   Wed, 28 Dec 2022 16:53:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Message-ID: <20221228155317.GB388@lst.de>
References: <20221227191009.2277326-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221227191009.2277326-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  enum blk_default_limits {
>  	BLK_MAX_SEGMENTS	= 128,
>  	BLK_SAFE_MAX_SECTORS	= 255,
> -	BLK_DEF_MAX_SECTORS	= 2560,
>  	BLK_MAX_SEGMENT_SIZE	= 65536,
>  	BLK_SEG_BOUNDARY_MASK	= 0xFFFFFFFFUL,
>  };

Looking at the enum all these really should be unsigned values anyway,
so we might as well keep the enum.

Either way this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
