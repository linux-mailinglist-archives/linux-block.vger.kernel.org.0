Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070E06E685E
	for <lists+linux-block@lfdr.de>; Tue, 18 Apr 2023 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjDRPg0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Apr 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDRPgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 11:36:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A113C20
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Vdq/bqbZ+gdU0P0Ie8/OyHDCyj
        YdUqxF2gG6NRrarcsVH39n99R/VHDdVgqDnawCXelQBIhhnbsubWW5Gy0jEcgFDhqAoSNxsMV5T4V
        dRy+tPuLhfl2Fn6y4nichNT7Oxq8JDNEu75H5CIerqd+4mCR5yQ7AJJerIZC0zYhNbYU9hErW+ba5
        F5M+Ry7gFhKxujr0m4u22BvutU3HHLy2F1lCTBpVIWgRhuWWjPBV8Feu1GzT3sZeqcu+eSXztohJY
        svB/CHkeYLcsZ8wVVWWOjePZjKPXtUAxEASxQMaJS7qh6O0uSqLKyuG3hfgHFnU6+MyP9rcjb5pWo
        94YxB9YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ponMx-002dz4-2w;
        Tue, 18 Apr 2023 15:35:47 +0000
Date:   Tue, 18 Apr 2023 08:35:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ken Kurematsu <k.kurematsu@nskint.co.jp>
Subject: Re: [PATCH V3] block: ublk: switch to ioctl command encoding
Message-ID: <ZD6402ib4J7tz7f/@infradead.org>
References: <20230418131810.855959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418131810.855959-1-ming.lei@redhat.com>
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
