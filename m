Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30423198E40
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCaIZj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 04:25:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCaIZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 04:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6REFC0VXeCEFVv/usDeXTLYD9YHZ9HT76/8Yzro4Jew=; b=KTuH+GZiYWMVNbv7qVnGJ/OutS
        mcSQouDTwIbOCsKYXDMruDrtpmG1SYQdKTrF9d85gXyjA/8PkNa4TTHm8AVhSRTGKi6Ovt1UFdAFV
        TJQ9CNsIG7LQtVYMaq6OgCeuckV0azHi1n5T6OKvmLlf4nWSrgWOPMW2o90YYmvmqoy1n1dmVmY+0
        NghIkQrIBFaS2VMo+l5eziJ4dnmoXTFa4+DVEHr3ce9tZ7DmTKlztXgEaYMmd8PMtp/bySdw0WtG7
        LueV7M1TzQm1ks0FfFrUykah8coLeTeoc/y65P3GASO3zXRfyiBYDHyy4Zm9qwRNorZtuaZF35pJa
        VY/u2n7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJCDL-0005QG-2g; Tue, 31 Mar 2020 08:25:39 +0000
Date:   Tue, 31 Mar 2020 01:25:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 1/2] null_blk: Cleanup zoned device initialization
Message-ID: <20200331082539.GB14655@infradead.org>
References: <20200330040116.178731-1-damien.lemoal@wdc.com>
 <20200330040116.178731-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330040116.178731-2-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Doesn't this belong after the actual bug fix?
