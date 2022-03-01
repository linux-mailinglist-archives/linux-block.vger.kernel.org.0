Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBD4C8CA8
	for <lists+linux-block@lfdr.de>; Tue,  1 Mar 2022 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiCANb0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Mar 2022 08:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCANbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:31:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB3D8A6C2
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qdZCnva8tVIXJlJ7NHdPQHW3ikx+B8KwlGVASTf92jA=; b=j3HodTijfrd7Vzqen8Y/bUq3FJ
        jaZFxgTCvtidyW5R4d32wOE95FZitYfVW/EUP207G13kYlCWiwqNwod4qvhPp4xlfmYXLt0MRO0pG
        bvDxl/StdqxmMlwx8AXrlqGLjkSeryP+7btVnYBEp49XQYAEWp/jFSwXgnpyjQrJIBMgOQxqTNvW6
        E2JKuV7pM0XH2KFen11U/4BlOArmZ2cdJ1+uCw6luyi0fQNW+cjTsmKvFITi7USdh1fcb03rG75Tw
        1jpR1arZDAiLzewcEvkuILFQoHQOKo3UvpQSaIG05aD2WBBSf0LJtNkjtNaHuRlqn17IWWc1swI2U
        yT/80gdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2aS-00GujT-7G; Tue, 01 Mar 2022 13:30:44 +0000
Date:   Tue, 1 Mar 2022 05:30:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/6] blk-mq: simplify reallocation of hw ctxs a bit
Message-ID: <Yh4gBHgCxNncU6KF@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-3-ming.lei@redhat.com>
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

On Mon, Feb 28, 2022 at 05:04:26PM +0800, Ming Lei wrote:
> blk_mq_alloc_and_init_hctx() has already taken reuse into account, so
> no need to do it outside, then we can simplify blk_mq_realloc_hw_ctxs().

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
