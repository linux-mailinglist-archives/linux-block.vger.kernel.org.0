Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10815341B7
	for <lists+linux-block@lfdr.de>; Wed, 25 May 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245416AbiEYQvt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 May 2022 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238797AbiEYQvs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 12:51:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1579D29CBE;
        Wed, 25 May 2022 09:51:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DB1FD67373; Wed, 25 May 2022 18:51:44 +0200 (CEST)
Date:   Wed, 25 May 2022 18:51:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 11/14] block: remove GENHD_FL_EXT_DEVT
Message-ID: <20220525165144.GB2750@lst.de>
References: <20211122130625.1136848-1-hch@lst.de> <20211122130625.1136848-12-hch@lst.de> <Yo4+zEnrBTnoEMCz@T590> <20220525165114.GA2750@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525165114.GA2750@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 25, 2022 at 06:51:14PM +0200, Christoph Hellwig wrote:
>  #define GD_ADDED			4
> +#define GD_SUPPRESS_PART_SCAN		4

.. and this should be 5 obviously.
