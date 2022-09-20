Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA35BDE9C
	for <lists+linux-block@lfdr.de>; Tue, 20 Sep 2022 09:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiITHny (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Sep 2022 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbiITHnh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Sep 2022 03:43:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BD25E542
        for <linux-block@vger.kernel.org>; Tue, 20 Sep 2022 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7+fDpMneg4PDhnL1/lHuTh41oqm/RT/OuEBWfRER6s=; b=MERZSSAxiCi/uB5wEF/Q0QV8Bh
        aaTBfWiYa8h9ZIPYJK/eGnwQM3ZhGzGWVkj2orr4D7WeyD64tVYJcMRGCwkjiJbfJma9qwJORxMoD
        vYZHvTD43J6FFwly5PARYoY40h1YOOf4qLybUcn4R5LqWdSBVBSIz/7UgShYS+AQaN6i2zuSV0SVq
        4eTpHfoEdG0o0QS56oJnT/moEgXwIePmcVzgFnl4wVBidVTNJRBfxZJ8drnvYMfR+PCw1YTr8ErML
        uqEFJSq1Y8doqNlC/iLijKbXNLMZrhAsgMV/8iTpE8unDyZ6bS0ubgBT3uPuc38Uud/yVh3qxGIF/
        8LZu6Tdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXt8-001Rkn-Bz; Tue, 20 Sep 2022 07:41:50 +0000
Date:   Tue, 20 Sep 2022 00:41:50 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify
 aoe_debugfs
Message-ID: <Yyluvun0JFf7Mai1@infradead.org>
References: <20220915023424.3198940-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915023424.3198940-1-liushixin2@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

How maintained is aoe still?  Everytime I looked at it it feels
more and more bitrotting..
