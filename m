Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB05EEE25
	for <lists+linux-block@lfdr.de>; Thu, 29 Sep 2022 08:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiI2G4q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Sep 2022 02:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiI2G4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 02:56:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C742212B5D2
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 23:56:44 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01BE868BFE; Thu, 29 Sep 2022 08:56:41 +0200 (CEST)
Date:   Thu, 29 Sep 2022 08:56:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH v2 2/2] block: use blk_mq_plug() wrapper consistently
 in the block layer
Message-ID: <20220929065641.GB31325@lst.de>
References: <20220929062425.91254-1-p.raghav@samsung.com> <CGME20220929062429eucas1p24790a979fa780e8bff61d9fd5ec05f8e@eucas1p2.samsung.com> <20220929062425.91254-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929062425.91254-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 29, 2022 at 08:24:25AM +0200, Pankaj Raghav wrote:
> Use blk_mq_plug() wrapper to get the plug instead of directly accessing
> it in the block layer.

I think this should explain why that is useful (or maybe even a bug
fix?).
