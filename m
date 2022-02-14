Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337DB4B52B4
	for <lists+linux-block@lfdr.de>; Mon, 14 Feb 2022 15:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbiBNOFF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Feb 2022 09:05:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiBNOFF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 09:05:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB99B7
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 06:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=R/6knWH8VmlLE1FIm25uXQKQAY
        O1lEI/AcnSVPi5xwGHccdXiqu+YItoG6r1OEm1QAyOcVJSjXH4E8mzkHMKlXTkeSeqaf8Y/yN8Q87
        LLbPqPd/dMBEpSIVgKCoqxA9hj0ssT9vX7DoFuSCknteg0F0TSnoS1Mhj7GPEubMFxbIiozWoJxiN
        fgFWeWBl13BxyLVPZWBOmA+/CzDoIeenudR03bCj/xQDXFoEKhXkaqXe4OOLyDQ+MZruropCAdMcJ
        n2yIfDqO1mVrkrhpqCo/CRXBBazXNeLkOwVGohSY+30bRbn8Bv+l5VY9MTm+v8LHMNEsBTVghA8hd
        Aro7+nXw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJbyL-00FZPt-Bq; Mon, 14 Feb 2022 14:04:57 +0000
Date:   Mon, 14 Feb 2022 06:04:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 14/14] dm: move duplicate code in callers of alloc_tio
 into alloc_tio
Message-ID: <YgphictFE2qgXBPy@infradead.org>
References: <20220211214057.40612-1-snitzer@redhat.com>
 <20220211214057.40612-15-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211214057.40612-15-snitzer@redhat.com>
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
