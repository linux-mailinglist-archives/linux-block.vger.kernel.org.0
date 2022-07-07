Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9BD569975
	for <lists+linux-block@lfdr.de>; Thu,  7 Jul 2022 06:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbiGGEtX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 7 Jul 2022 00:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiGGEtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jul 2022 00:49:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C631DF7
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 21:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msiY5ulhhPfEaqSn9xyI2Cdraep9Ia+p0gPBkqmdojw=; b=BJQnsE8V877/GSIyFpX6h2bXQz
        SG+s17Lx4I1mbvkfx3efMlctsamFp3Ot+Z5FIXP+nAGNrBKqxws27fPkSsoKtl0iCJRSTWDMmP5j3
        OaQgxiuhKMsNFM+XX+x1vNa/EtiyFX9YPm8R4m5G0bKDLktqogA44xu3EGVVfsX3Kqf7eulPLxwGK
        +0+uBtF9c20l2HoHFQ7krkhcphZLfjVtaPJoaqJy8bKTaVL632rM+jn96VluvOCzepfKvVuFU1UzY
        +ODQbMbcJQVJNEIJ/h//paoJgxn4xXsibBQ23qI0dhT0VmLkRClZhXlSp9CHeZr0D86cwd8jpGy2Q
        wtZjTxaA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9JQ7-00DXvx-8t; Thu, 07 Jul 2022 04:47:19 +0000
Date:   Wed, 6 Jul 2022 21:47:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [5.20 PATCH v3 1/2] dm: add bio_rewind() API to DM core
Message-ID: <YsZlV9x6McVEEi64@infradead.org>
References: <20220706174403.79317-1-snitzer@kernel.org>
 <20220706174403.79317-2-snitzer@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706174403.79317-2-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If this now lives in dm (which I'm not really sold on, but I guess it
is the way forward..), can you please give the functions dm_ prefixes?

