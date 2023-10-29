Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F657DAE25
	for <lists+linux-block@lfdr.de>; Sun, 29 Oct 2023 21:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjJ2ULs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Oct 2023 16:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJ2ULr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Oct 2023 16:11:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A13AC;
        Sun, 29 Oct 2023 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NHrqX2dC2lEhCtw3IxHryPs6MHyo/+ZGBHAb3HIxQc4=; b=H4Yk/YOzLJ3l9KWC52qtmtxpFo
        dJ57w9BQ35z8V72QCTvP1nJSapmZxeQDHMsiAyzO/EtGniTRnuI5D7z5QoG6PmWimkfRDSxnuM5H6
        lbjX0G8iBUW3ct7sl/MxKhuLLSMo3HLSB953r48DiSFyz2IImBg/sYyWH4bB8Inq0v601G9jpihOU
        5/PMxD0OQiymEXQ8dRl8bHgQ5rlFpE7zqOBnmL6IySER6oUs1o2/IQn6GNMcnj3vtZf6eZpLjDVyy
        sElUCa6DvWTJOlYziHJcF97elZewKiEP1ZSZ0o7x6MYB0T5px8sC1LDii5bIA5E50oMAh2TOGZ2/R
        2xX+w1NA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxC8C-00HTDK-E7; Sun, 29 Oct 2023 20:11:32 +0000
Date:   Sun, 29 Oct 2023 20:11:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Gomez <da.gomez@samsung.com>
Cc:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC PATCH 01/11] XArray: add cmpxchg order test
Message-ID: <ZT68dBiJKNLXLRZA@casper.infradead.org>
References: <20230919135536.2165715-1-da.gomez@samsung.com>
 <20231028211518.3424020-1-da.gomez@samsung.com>
 <CGME20231028211538eucas1p186e33f92dbea7030f14f7f79aa1b8d54@eucas1p1.samsung.com>
 <20231028211518.3424020-2-da.gomez@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028211518.3424020-2-da.gomez@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Oct 28, 2023 at 09:15:35PM +0000, Daniel Gomez wrote:
> +static noinline void check_cmpxchg_order(struct xarray *xa)
> +{
> +	void *FIVE = xa_mk_value(5);
> +	unsigned int order = IS_ENABLED(CONFIG_XARRAY_MULTI) ? 15 : 1;

... have you tried this with CONFIG_XARRAY_MULTI deselected?
I suspect it will BUG() because orders greater than 0 are not allowed.

> +	XA_BUG_ON(xa, !xa_empty(xa));
> +	XA_BUG_ON(xa, xa_store_index(xa, 5, GFP_KERNEL) != NULL);
> +	XA_BUG_ON(xa, xa_insert(xa, 5, FIVE, GFP_KERNEL) != -EBUSY);
> +	XA_BUG_ON(xa, xa_store_order(xa, 5, order, FIVE, GFP_KERNEL));
> +	XA_BUG_ON(xa, xa_get_order(xa, 5) != order);
> +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) != order);
> +	old = xa_cmpxchg(xa, 5, FIVE, NULL, GFP_KERNEL);
> +	XA_BUG_ON(xa, old != FIVE);
> +	XA_BUG_ON(xa, xa_get_order(xa, 5) != 0);
> +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(FIVE)) != 0);
> +	XA_BUG_ON(xa, xa_get_order(xa, xa_to_value(old)) != 0);
> +	XA_BUG_ON(xa, !xa_empty(xa));

I'm not sure this is a great test.  It definitely does do what you claim
it will, but for example, it's possible that we might keep that
information for other orders.  So maybe we should have another entry at
(1 << order) that keeps the node around and could theoretically keep
the order information around for the now-NULL entry?
