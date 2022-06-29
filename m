Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C324C55F5A6
	for <lists+linux-block@lfdr.de>; Wed, 29 Jun 2022 07:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiF2FUR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 01:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiF2FUR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 01:20:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C671A3123F
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 22:20:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 730BA67373; Wed, 29 Jun 2022 07:20:11 +0200 (CEST)
Date:   Wed, 29 Jun 2022 07:20:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tj@kernel.org, jack@suse.cz, hch@lst.de, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] blk-cgroup: factor out blkcg_iostat_update()
Message-ID: <20220629052011.GA16113@lst.de>
References: <20220629015022.2667445-1-yanaijie@huawei.com> <20220629015022.2667445-2-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629015022.2667445-2-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 29, 2022 at 09:50:21AM +0800, Jason Yan wrote:
> +static void blkcg_iostat_update(struct blkcg_gq *blkg,
> +	struct blkg_iostat *cur, struct blkg_iostat *last)

Incorrect indentation.  Continuing prototype lines are indented either
using two tabs or after the opening brace.

The rest looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
