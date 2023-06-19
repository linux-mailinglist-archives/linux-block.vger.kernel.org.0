Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98993734B33
	for <lists+linux-block@lfdr.de>; Mon, 19 Jun 2023 07:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjFSFAU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Jun 2023 01:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFSFAT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2023 01:00:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC461E44;
        Sun, 18 Jun 2023 22:00:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 38AE06732A; Mon, 19 Jun 2023 07:00:16 +0200 (CEST)
Date:   Mon, 19 Jun 2023 07:00:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] md: use mddev->external to select holder in
 export_rdev()
Message-ID: <20230619050015.GB10741@lst.de>
References: <20230617052405.305871-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617052405.305871-1-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 16, 2023 at 10:24:04PM -0700, Song Liu wrote:
> This means export_rdev() calls blkdev_put with a different holder than the
> one used by blkdev_get_by_dev(). This is because mddev->major_version == -2
> is not a good check for external metadata. Fix this by using
> mddev->external instead.
> 
> Also, do not clear mddev->external in md_clean(), as the flag might be used
> later in export_rdev().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
