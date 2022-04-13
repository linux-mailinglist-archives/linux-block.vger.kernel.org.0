Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7B4FFBC0
	for <lists+linux-block@lfdr.de>; Wed, 13 Apr 2022 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiDMQxi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Apr 2022 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiDMQxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 12:53:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E2C49684
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YOGZ2rOdooumvALPGOdJ4CvIk1ZoPFY3GaC5b0SGXos=; b=cbzxP6j3/TgaRnpQvBiG3IU17V
        iSI8PzcY0P+HAHH+FGsAC1QjF0pGTfPwgXDtllGKq5nDXG+2eR1tQnLox4tpMEMlTt92xGRuHjMJC
        YPXIR952h7WCkCz9hZYlVG+oYfiDYb7m8hMCE14TmccAPqxntG5wzjmjWGoQJ6laO+Y/yDDMSVREZ
        ikAFzbTFE1MmIfwOZRYM2dGdrHW+n3+aSMjRG2ItaoMZCqYk8ZME2znw/KwvCAidK23Q6CIQNnGVm
        /JgXaFjTJEpZfKRBFVE6M+FERo3M+ZU1k/VLzTe06/9S4LgR52GFT2UkMPsM4xyAMp3WEJ0opckj3
        x8OKyUUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1negD3-001p3O-SG; Wed, 13 Apr 2022 16:51:13 +0000
Date:   Wed, 13 Apr 2022 09:51:13 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] block: avoid io timeout in case of sync polled dio
Message-ID: <Ylb/gciNitj7yd/c@infradead.org>
References: <20220413084805.1571884-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084805.1571884-1-ming.lei@redhat.com>
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

On Wed, Apr 13, 2022 at 04:48:05PM +0800, Ming Lei wrote:
> If the bio is marked as POLLED after submission,

Umm, a bio should never be marked POLLED after submission.

> bio_poll() should be
> called for reaping io since there isn't irq for completing the request,
> so we can't call into blk_io_schedule() in case that bio_poll() returns
> zero.
> 
> Also for calling bio_poll(), current->plug has to be flushed out,
> otherwise bio may not be issued to driver, and ->bi_cookie won't
> be set.

I think we just need to bypass the plug to start with for synchronous
polled I/O. 

Do you have a reproducer?  We'd also need to sort all this out for
polled file system I/O as well.
