Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2B1C8246
	for <lists+linux-block@lfdr.de>; Thu,  7 May 2020 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgEGGNW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 May 2020 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEGGNV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 02:13:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B61C061A0F
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 23:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GZwNjyrFE5hgn6pcNUo4vbqQHQA1jcumJpqmhWT3Iek=; b=mLI7GXyoAm2LIgXOiSoWEMG0YH
        svbC6DwC2qX9gRZUyvJIH1diwRnvlIGkjrFFU8eQPIFWEQx0FuzheLMyluJlg1SGZ9+Gyj77wRJvW
        U6uOR63YFqWmbeqo2bf68WWTIQjo/rr5NUtI+f/VZtyyR18/ezDXta1yGZodWMyrZHjTbfeXg2rT8
        76iEG4XrA1m1IIjS49H+BsVq413kStBZDF65rwGniHmWT14ONwTirx1Wsx3KpfwweMPSmubBYPzFZ
        o7srJM5ziD9cQoYP/2Ws9V7ZNQg9eLa1S5CTYTAf7UPDogeE9+ifanbF0hvkh1X4A/IZZbzi4al6V
        VXB5WqtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWZma-0002IB-SU; Thu, 07 May 2020 06:13:20 +0000
Date:   Wed, 6 May 2020 23:13:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, tom.leiming@gmail.com, bvanassche@acm.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v5 3/5] block: alloc map and request for new hardware
 queue
Message-ID: <20200507061320.GE23530@infradead.org>
References: <cover.1588660550.git.zhangweiping@didiglobal.com>
 <2a1eff382447d6e37e1803b1ef3e230c1091b0e5.1588660550.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a1eff382447d6e37e1803b1ef3e230c1091b0e5.1588660550.git.zhangweiping@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The patch looks good, although I'm not a fan of the long backtraces
in the commit log..

Reviewed-by: Christoph Hellwig <hch@lst.de>
