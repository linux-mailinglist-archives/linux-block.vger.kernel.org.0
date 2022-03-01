Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCC24C8CB5
	for <lists+linux-block@lfdr.de>; Tue,  1 Mar 2022 14:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiCANeX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Mar 2022 08:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiCANeX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:34:23 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F82D3A198
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tn/nLN2fVX8hQQtb8m8eTnc16H3mHY5+ywpgWKTQ8yo=; b=ZV6cjkjgwhetl01//Bl0aCRrhF
        ZxVIfHvJvqI4ZZWGU/QGb0Sw9gyJm+LAzMC02cDnx2UqP7LZUMqG73bQgHskliQKSRyDluBtgZPoS
        vIa502rVA0AAk0ogHPZW5JWHKsTkGC5r+pEgUBxS/w72oJv1+mnYqrYZgsGpc/n4DUUGDVmp72sUr
        8bXCTPo5ifpBMS6PkZ87b2VeYL26tVNFSAaS15kpn2zN/2XNTTitk5dlvjzXfVBEbio8YXbtG9Ar2
        hmXpJrZWZUIiAJFiB+6o90vdllDNXnqy9Zcffa0Rf77lIOx3mFkpZYsD+YqcNZM9Hq7qaYoJaXxBi
        aQG1w90g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2dI-00Gv6V-KI; Tue, 01 Mar 2022 13:33:40 +0000
Date:   Tue, 1 Mar 2022 05:33:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 5/6] blk-mq: add helper of blk_mq_get_hctx to retrieve
 hctx via its index
Message-ID: <Yh4gtAr9mk7r4UtP@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-6-ming.lei@redhat.com>
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

On Mon, Feb 28, 2022 at 05:04:29PM +0800, Ming Lei wrote:
> Prepare for managing hctx mapping via xarray by adding one helper of
> blk_mq_get_hctx().

I'd rather merge this into the next patch for reason I'll explain there.
