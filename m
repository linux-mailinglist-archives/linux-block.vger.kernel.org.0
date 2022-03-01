Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206184C8CA6
	for <lists+linux-block@lfdr.de>; Tue,  1 Mar 2022 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiCANau (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Mar 2022 08:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiCANat (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 08:30:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8898A6C2
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 05:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dA6SG2c4ukofm4O8gGY+AmSGCJ
        /pM0pTcefDLCJcpIaqN+ozKkztYhynr5tdW7qp/SI9O6rxvHH6f22+/x4oS6u2uWmteEoXJJ2rxXG
        QehYCpubsKqlDQcwOtPhgFeN6g3OuK5JB29QhASlYqaehKTOl4HbkrODlcZOaEPPY3oltIBJvO8lN
        6an9asdyM7LiDj1rdxHLYuC6syrW9TfHd+3qhDP//ViPG8oe7mlTic2qUwXMpLF/koMWDrCMwRUTl
        kRbw/ika54lfGYYTVcNnossNE/QMSWx+3M/yzNs58JJCdB8HQeUgLjH55Rzhcb2u0r/86vFXbcjkj
        vpjo4jgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP2Zq-00GugW-QZ; Tue, 01 Mar 2022 13:30:06 +0000
Date:   Tue, 1 Mar 2022 05:30:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 1/6] blk-mq: figure out correct numa node for hw queue
Message-ID: <Yh4f3tIXRSsCs2Op@infradead.org>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
 <20220228090430.1064267-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228090430.1064267-2-ming.lei@redhat.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
