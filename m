Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAC1532566
	for <lists+linux-block@lfdr.de>; Tue, 24 May 2022 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiEXIgl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 May 2022 04:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiEXIgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 04:36:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1490714D16;
        Tue, 24 May 2022 01:36:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DDB668AFE; Tue, 24 May 2022 10:36:35 +0200 (CEST)
Date:   Tue, 24 May 2022 10:36:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] block: document BLK_STS_AGAIN usage
Message-ID: <20220524083635.GA27749@lst.de>
References: <20220524055631.85480-1-hare@suse.de> <20220524055631.85480-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524055631.85480-2-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 07:56:30AM +0200, Hannes Reinecke wrote:
> BLK_STS_AGAIN should only be used if RQF_NOWAIT is set and the bio
> would block. So we'd better document that to avoid accidental misuse.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

given that nothing in patch 2 depends on this it would be good to just
get this into the block tree ASAP.
