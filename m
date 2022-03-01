Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D454C8C8A
	for <lists+linux-block@lfdr.de>; Tue,  1 Mar 2022 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiCANXl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Mar 2022 08:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiCANXk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:23:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F664D262
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2pNR4V55maPhGGqOX//D2F//bBrL3vmbz2vl/toWaNk=; b=NvmdBEDVy6Fhn8I7yuXsZI9dvx
        84QLRMRmZIcKCLC8CktGO6+mRYZbHIjbJnME0w8fyfL3bA1S4eZXSqQBtLyhmOyNr27JA8/kzmC0N
        tAKfipkvmXBf7QLmm5pZDl6NR8z3rlD1uRrBVtTKYVjiECT+dcKtAwRNR6jGUBpo2P+lIbD3j0wsi
        I6y1quVX93iI71z3qTmyU557mDgSrygJcSum8RJ9N1K2GbdpUH/Y7SOmevIOokThgJky2blUhz7dn
        UI0q4tjkE4ohwQyCay/QhL2TI1kXyX6D4xRZa/k3ufOAbbeTArJ4LO4TJg91b3G8KcbAExq7qWbvL
        thh0+6hA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2Sx-00Gt0Z-59; Tue, 01 Mar 2022 13:22:59 +0000
Date:   Tue, 1 Mar 2022 05:22:59 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] blk-mq: kill warning when building
 block/blk-mq-debugfs-zoned.c
Message-ID: <Yh4eM7e8vm6Rh0wR@infradead.org>
References: <20220301091055.1215013-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220301091055.1215013-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 01, 2022 at 05:10:55PM +0800, Ming Lei wrote:
> Fix the following warning when building block/blk-mq-debugfs-zoned.c:
> 
> In file included from block/blk-mq-debugfs-zoned.c:7:
> block/blk-mq-debugfs.h:24:14: warning: ‘struct blk_mq_hw_ctx’ declared inside parameter list will not be visible outside of this definition or declaration
>    24 |       struct blk_mq_hw_ctx *hctx);
>       |              ^~~~~~~~~~~~~

I think a forard eclaration of struct blk_mq_hw_ctx is all we need here,
no need to pull the full header in.
