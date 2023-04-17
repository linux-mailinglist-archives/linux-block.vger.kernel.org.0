Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0A6E452B
	for <lists+linux-block@lfdr.de>; Mon, 17 Apr 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDQK2T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Apr 2023 06:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDQK2S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Apr 2023 06:28:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E293C18
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vVARBM1v9Hak0PHJAZjryeNtq9PkJUObGlr+fi9thZA=; b=0CZnm1W8jQGVaoQVMJ31MmiRa/
        pbQH31/bT7BS5xXhSG+mhlE+qc3exFCnEQLnwu/JAIU05lPrWm8iAcVPBpZiEA/qjiFWU/2KqJ3gi
        +1mZ86hJ7fAjBrLVDHt36OKDqCOMLMW6S2f9H8eNqCOGXTRW/gXx13bCwEErEey0lo49Un/6u236L
        ZcEwv18/CH11je1QuTBGnCbc+vYzEfTS73md7CbsGclrbHR7dycP20UD+pXdxccVSp0yKwHlRIduQ
        Rjf2LwyY5EQHe11OST9+wtcLEt/QRBEzv78a7NnMtTxl2gSxOqAezNGxhc2ScCB163ZNFN9g/OMR1
        WdI5uCGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1poLTd-00Fd0b-0t;
        Mon, 17 Apr 2023 09:48:49 +0000
Date:   Mon, 17 Apr 2023 02:48:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: ublk: switch to ioctl command encoding
Message-ID: <ZD0WAT1hRphTlXjl@infradead.org>
References: <20230407083722.2090706-1-ming.lei@redhat.com>
 <ZDzQeE3dHIC8FmE8@infradead.org>
 <ZDzzn0jg/0LL4r7F@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDzzn0jg/0LL4r7F@ovpn-8-16.pek2.redhat.com>
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

On Mon, Apr 17, 2023 at 03:22:07PM +0800, Ming Lei wrote:
> The traditional ioctl command encodes type/nr/dir info, and basically
> each command is unique if every driver respects the rule, so at least:
> 
> 1) driver can figure out wrong command sent from userspace easily
> 
> 2) easier for security subsystem audit[1]

Please add this to the commit log.

And maybe add a config option for the old opcodes so that distros
newly picking up ublk can disable them from the start.
