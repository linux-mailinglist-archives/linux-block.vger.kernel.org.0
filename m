Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB85C4AF379
	for <lists+linux-block@lfdr.de>; Wed,  9 Feb 2022 15:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbiBIOBO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Feb 2022 09:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbiBIOBN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Feb 2022 09:01:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA8CC0613C9
        for <linux-block@vger.kernel.org>; Wed,  9 Feb 2022 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=AMtIJ5aEh+Yk0NI4JGnEVfvq2O
        jB34tjYW1I6ePhLzvNFEGBi1j1cyyUgcCqIhq1HsrHJE6989ESkg25VBpKRn/BJ2QjHi9PrWBmOH6
        GrIsRSL4HhcotzV4Bq/Ma6YNIeyy7oUzXa/dwkd9rA4AfoIWjFkYgrbEmHzeiRdTDHZD70DFznDnv
        H4rE5Bt03oahdFG9QVDDFccd2HbdSvUn+gjTm9uPRlU3lql8L0NkxMK2tUGsMjfq4zWyS9hB+M/Rj
        fbZ8kKlAvMNRh+Mg3LchWH/GnWalk9rra7+ls/VH4/Tq4mFRManQcMbSfAZNfPtoMrV8tZvVb1ifK
        ubOn4IMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHnWq-000HWN-DD; Wed, 09 Feb 2022 14:01:04 +0000
Date:   Wed, 9 Feb 2022 06:01:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Li Ning <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH V2 1/7] block: move submit_bio_checks() into
 submit_bio_noacct
Message-ID: <YgPJIE2zFTi2ZP3d@infradead.org>
References: <20220209091429.1929728-1-ming.lei@redhat.com>
 <20220209091429.1929728-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209091429.1929728-2-ming.lei@redhat.com>
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
