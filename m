Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9936063EA25
	for <lists+linux-block@lfdr.de>; Thu,  1 Dec 2022 08:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiLAHKG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Dec 2022 02:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLAHKG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Dec 2022 02:10:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182245A2A
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 23:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HrSKpoNw3jD5eIGQprYk1H9KYy
        xO6qotmOZMKhseHpb9kWABfvVuM8rlgnB61VFBgWQeahfR2niYVXBE8trynWZ/wAYSI5KMN99eec5
        9mFQcsNEE4A7QzByBseSG0d8kC9IrFjRBf1ttmhaZiND/roSK/MyWKyLP/bQucVDOHZ9wpgcHPhqG
        d/an8aDWo9gXs4YsIo8tJd4nbeDepoZjLRdxJ5AVdJ13381t44KCD/+3ESrDgKDkIQhrFl/ftw7rW
        drrLycIR/kFTepjxbJrytvOJxCreDH31lLTAo39zVtRO0/lT666oFlGQwkGibSXHiaUYgOnVw4KvN
        WRoTnnBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0dhq-005Qlz-Ga; Thu, 01 Dec 2022 07:10:02 +0000
Date:   Wed, 30 Nov 2022 23:10:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <Y4hTSppjf0in7tzW@infradead.org>
References: <20221130175653.24299-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130175653.24299-1-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
