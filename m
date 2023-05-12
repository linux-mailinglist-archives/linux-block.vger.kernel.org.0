Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5263F7008FB
	for <lists+linux-block@lfdr.de>; Fri, 12 May 2023 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240667AbjELNS7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 May 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbjELNS5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 09:18:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA2173C
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=i9BwSRy2OgnBjppUbjDUwJ3lki
        DhR2A/61pFFSNOezKNAhujhdeFv8mHnA4yqfArL36XyH2k8Y0jkwpL83CrYKsPgYcAlNMIdEAJIAB
        MhD0sdM/ZP0w5s6omFHiIPOIbr9Isce8QqkaNwa1pyuc/3PHRExFfb64lJC2TGocx581mfyv20SWZ
        7o/GFY88hc39JBfbBLh1yNY2pejp+DupG2z4BBEXW3WROqr8IFNfRV+UlEfHcmznDDApkfOkAwCTm
        pWwCvAPTYfy8irB6eg2QR1zCtGYaMx7sI5tEc+rWooOxkHXZ/DyhG+hlyDD+WsMjScEuJicNrgR+X
        LEq7upvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pxSfc-00C0fR-1T;
        Fri, 12 May 2023 13:18:52 +0000
Date:   Fri, 12 May 2023 06:18:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        hch@infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] block/rnbd: replace REQ_OP_FLUSH with REQ_OP_WRITE
Message-ID: <ZF48vOtOHCeQxXHd@infradead.org>
References: <20230512034631.28686-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512034631.28686-1-guoqing.jiang@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
