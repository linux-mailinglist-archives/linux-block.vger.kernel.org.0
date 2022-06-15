Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092654C71B
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbiFOLDd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 07:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348743AbiFOLBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 07:01:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5B53B6A
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 04:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=92hQL4SWd28WtMWG+YjgiqTETBuP/O/qLVEtLptAqdc=; b=2N8dXFI7POSKPx0JLqa2q+nugK
        x67jbb5nz5U56jWU0qQMDGn7Bw7KDpYXPbhyvHWDf5Oe++h8heS8sE9LWtFnBAdJfFUS9PEl2kq0E
        QzUfGLPCl6GKUIgMgA2Y9AsX6ZKP36bl0UdZqcqz4C1j+SdZNpwEDpGyP/CFZkFkljNmKsCeRUiJC
        zuaJOOYTB6wIrxWEtHagHqOlLLxtfUVe+6TP7ZLylcg+por7FP046NubAhiwY4es578hnriDW2nxu
        xEA0bYZQiMxRnu/FfDUCKlSKbuFeCTnZimcREmSChimrCohaeBnSPEP8dIohz5ks31tt0SD3tVuMf
        BnPW4TWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1QmB-00E2dS-NW; Wed, 15 Jun 2022 11:01:31 +0000
Date:   Wed, 15 Jun 2022 04:01:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: adjust the judgment order in submit_bio
Message-ID: <Yqm8C+W+/8ZRyM3m@infradead.org>
References: <1655286442-104784-1-git-send-email-liusong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655286442-104784-1-git-send-email-liusong@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 15, 2022 at 05:47:22PM +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> BIO_WORKINGSET is rarer than read, so adjust to the first one to judge.

Can you explain how this matters at all?  The right thing is of course
to get rid of this check and I need to finish the series to do that.
