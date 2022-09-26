Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5F5EABA2
	for <lists+linux-block@lfdr.de>; Mon, 26 Sep 2022 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiIZPu5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Sep 2022 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiIZPuf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 11:50:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17DC46233
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ielCqWcu80m/nKgdHwuN9KyCfIsy3ISc9bScaGgI/JY=; b=y7WI9y7BQBzrBWC2K8O73Kcfok
        bnp4tCg2uc/aSYMig6euud2h6osWk7BnvnN2db9FhHgQu9DAq3RR0vbz8TXWnlQoWcVwr7S7sQgfz
        SdZR8MZs+HmDN0gfPKAKmhuecX9UtXMy+p5OSwyLMO/HQ+cruVyVQ7SnKgTGsHK93tKQdL0NsUxkZ
        qY37emyaU0L5zSB9BWPLQTII5NFcDwpJJe2QCey6PHL9lpiyzdfx1wmnSP/pB7zIreL4wdLjidggG
        Q9m29WBrICUQAypW3RPagnf/JYH62B3OWTuuY3XzlxM8PCg6lMmxxlukRCOii4FdRTNujMVjyXNv/
        Z65PAQ4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocpF8-005NQZ-O8; Mon, 26 Sep 2022 14:37:58 +0000
Date:   Mon, 26 Sep 2022 07:37:58 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, gost.dev@samsung.com
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Message-ID: <YzG5RgmWSsH6rX08@infradead.org>
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220925185348.120964-2-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 25, 2022 at 08:53:46PM +0200, Pankaj Raghav wrote:
> Modify blk_mq_plug() to allow plugging only for read operations in zoned
> block devices as there are alternative IO paths in the linux block
> layer which can end up doing a write via driver private requests in
> sequential write zones.

We should be able to plug for all operations that are not
REQ_OP_ZONE_APPEND just fine.

I also really can't parse your commit log at all, what alternative
paths are you talking about here?
