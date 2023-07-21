Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6075BEC0
	for <lists+linux-block@lfdr.de>; Fri, 21 Jul 2023 08:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGUGWO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Jul 2023 02:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGUGVv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 02:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4353A8B
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mnhDz6jOWXMUaAr2uvRaCtMfVZ
        JpyTR52cRspNOOqg19nhJn4ZN0s17ajh+315RcMAIt8JWadh3UeXEYwHYhyVuSTfx97qIBQGXR20M
        7I7k5pUcYb6m6fr0EDaQyNYUEHPvK2hi6bcmRgQcI4+mJvX5a8iw9hY63H9+Awz32bGWOZ3Qdlp1t
        P2y3LlSe8O48MoErLynARSkzzIhRYMMOy3kVamtmE3WBetkQWlSBNaALISo/OzvUkP/qr6p0fIX0C
        6/rubJ9s/PNiXCxT2RBEjfRClKdF/J+asaJzwGi9EJfwpUxnIY1DUBn5DO5tk7OrlzN3rcpPTIf8A
        lJrGq8vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMjUd-00D1Tv-2M;
        Fri, 21 Jul 2023 06:19:59 +0000
Date:   Thu, 20 Jul 2023 23:19:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH v2 1/2] loop: deprecate autoloading callback loop_probe()
Message-ID: <ZLojjygixxZCSWfC@infradead.org>
References: <20230720143033.841001-1-mfo@canonical.com>
 <20230720143033.841001-2-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720143033.841001-2-mfo@canonical.com>
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
