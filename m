Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2462619A8B4
	for <lists+linux-block@lfdr.de>; Wed,  1 Apr 2020 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgDAJeH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Apr 2020 05:34:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45654 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAJeG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Apr 2020 05:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=NhvFolaEwkHGrHTWa7q2A/KaeI
        K3EZRhF5CpUV+qxnE3X8p3k/mle6wlsdzdIAsZiYTHFcaiC7V9maCNXvuzW+YnpbH/396M+7JtZ9x
        1ZPXYm/M6PrsHYH3ZJwpuheTvwpA4R84g3zqJrCNGaAsIEbroipi/d4w36VtHzVVKcUvvL2b5F79K
        AvRFZ5Fyvo+QFBur9dO6n3tYwVrCy3xgumjFmw5FZCX8qzKk/X5hNNXkhkfhf+XdXCTKTvV/2f7WA
        2OVvdAWtNcTHo/j0hyrRXnTsNcg/kY76ULQRmeL+W+8kyPStH5Tz04g7FVAqrahZgPFM7HbKVa4+9
        3DH1LC+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJZl8-0002c4-I2; Wed, 01 Apr 2020 09:34:06 +0000
Date:   Wed, 1 Apr 2020 02:34:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/2] block: null_blk: Fix zoned command handling
Message-ID: <20200401093406.GA823@infradead.org>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
 <20200401010728.800937-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401010728.800937-2-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
