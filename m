Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6109353C4B2
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 07:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiFCF5P (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 01:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiFCF5O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 01:57:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EE6DE89
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 22:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gGQSDRFGU7z352K5ARnv6bby15JteI7qrXgy/gO3goE=; b=nCxO/0dcML/HU7uHvqlopDmRo7
        lDQuAWpgTvNrj8UG6KHDvWGXDXyLbaYbFDoDsYWBpX2EEcoJTjZ44pD+Gsv1p3qfoF3yPNNsqGl5d
        DzUIYe5Xx5FlGzdjk9WMBIKKu2I8E9SUsgHBUNoXqVLg3bkE+ttcgHKGtEHYa+loRiqH8oMC7P+yz
        1pE49JpN+p2otITLtH1rCsfMARpNtO23+lCv7beZNUUK9tctGBS8LYjTvnZ4btJNvFbNClyXkK3kP
        HD6z6JHtoyrBp47ks2owpytfLkSzHedWXDYDqR7Ag2NhQ2ArqLe5tBiTnoH5oyqn2GgqeWW5PO7FL
        /cLlVXQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nx0J5-005yBx-5C; Fri, 03 Jun 2022 05:57:11 +0000
Date:   Thu, 2 Jun 2022 22:57:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove queue from struct
 blk_independent_access_range
Message-ID: <Ypmit+JI0QDVbeJX@infradead.org>
References: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603053529.76405-1-damien.lemoal@opensource.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 03, 2022 at 02:35:29PM +0900, Damien Le Moal wrote:
> The request queue pointer in struct blk_independent_access_range is
> unused. Remove it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

As does the original fix, I actually had a patch doing both in one in
one of my queues for the next merge window..
