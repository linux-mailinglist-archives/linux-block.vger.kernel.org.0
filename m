Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BEB557D61
	for <lists+linux-block@lfdr.de>; Thu, 23 Jun 2022 15:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiFWN62 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jun 2022 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiFWN62 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:58:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2923B031
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CNEC6qDqeizPOe9GnlBmxUaHzm
        tfrY/usQok1VJEc1FbEPN++5p83s45YfLBWVs7S3lmkV2BxBwkKQCilAYIQqdmur6d983+8mWmxbr
        BEwrq+J5uG1uItE+ED/quCGMcYrmngTU9eJiBBtIngydqH7TlM0eFM0DeZb/78PfHMN3vS4zl+VVS
        o/PCfuJSxRcaW+2Eys9nejE/ZltI4kvRj71FtsF/Vk7pNhzh622R1XiBdQzJUkXPHZdFPoZdMtiQo
        2mNfq81JA7aMxH08f0WoHq8EquMyVmHGzQQiRi2hx+aikVYm52ZOc0ciJ248fYDerqhYZOh6Nsl8L
        SL3yBqpA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NLm-00FRbf-Vq; Thu, 23 Jun 2022 13:58:27 +0000
Date:   Thu, 23 Jun 2022 06:58:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 4/9] block: Make ioprio_best() static
Message-ID: <YrRxghveX+G3SnNb@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-4-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
