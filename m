Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428AA431334
	for <lists+linux-block@lfdr.de>; Mon, 18 Oct 2021 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJRJYE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Oct 2021 05:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJYD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:24:03 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F518C06161C
        for <linux-block@vger.kernel.org>; Mon, 18 Oct 2021 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=poPw+/3gNac+owHpCR8E0cjHaH
        nxNEl7aXxovHo5gktuJNw0CgyIep4vAvOHcDWzXPf5MDRgsm8pANzYPx2cSVjlgOGbDkR+/n/V0YM
        uAIUFdcTiByKu8BiWvmQTt3AiK/EV9OgKKtewDQ8Yh0WyEpC73TpHr1YqWTlCadKt1x8T4gawN5AE
        g7MKufBRGRZYE/qozRdFW7p+UC55/mNZ/ahxDiSpk+hS8X+h6uVHpX51mUflFiA35f9i5yivXDMOS
        tqsoIKVenSmPTdpMK1aWpMt0otfcKpAa2xXNL4PlIyUSb3UCChM7fSzY0RLpzWrURkn61/NUCDZ1R
        uULN5OGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcOq7-00En0B-Q5; Mon, 18 Oct 2021 09:21:51 +0000
Date:   Mon, 18 Oct 2021 02:21:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] block: remove debugfs blk_mq_ctx
 dispatched/merged/completed attributes
Message-ID: <YW08r87bD2a+fkDp@infradead.org>
References: <20211017013748.76461-1-axboe@kernel.dk>
 <20211017013748.76461-14-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017013748.76461-14-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
