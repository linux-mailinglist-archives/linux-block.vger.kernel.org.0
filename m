Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966314BFE14
	for <lists+linux-block@lfdr.de>; Tue, 22 Feb 2022 17:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiBVQHC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 11:07:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiBVQHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 11:07:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C785E4B
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 08:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=CjIhe58k/TuKVGFg3O8oYoljKo
        AjtdpmS7tPiERgft3SEvwIulp16yW2dPBoFXzTvz6zkMQTuc+Llge82Y4saUq9Web543SHvJws1nW
        PqDtWUpC3tAsjZFKws11dceK8CZdR7awRUgZTTlxzg+GPns8HhTQ/3qidgdllxh5R5x4pLG05w4zc
        txPz4OztZxlS4ibH3IjVZDUIAo9cPWhoruD22EBs8323QhnEH0OjLPXGda9pqnXWXAaubucQ2ulAb
        kgKCyTUJhul6yuDKeQGwvje4br8psg3tu+EijqIV8pzQahViEz2RRg5DxeeRVbYQCypIZJBcR95rU
        rxwFLpyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMXgQ-00AWr2-BM; Tue, 22 Feb 2022 16:06:34 +0000
Date:   Tue, 22 Feb 2022 08:06:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com,
        damien.lemoal@wdc.com, shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH 1/2] null_blk: remove hardcoded null_alloc_page() param
Message-ID: <YhUKCtV7LhMYTvb5@infradead.org>
References: <20220222152852.26043-1-kch@nvidia.com>
 <20220222152852.26043-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222152852.26043-2-kch@nvidia.com>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
