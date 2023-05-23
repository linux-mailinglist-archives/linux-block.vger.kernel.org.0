Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA1270CF0A
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 02:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjEWAYi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 22 May 2023 20:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbjEVXaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 May 2023 19:30:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55C188
        for <linux-block@vger.kernel.org>; Mon, 22 May 2023 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l4hnCLyKzpkMhMF68lsLPXuEeiW+0JkAbyWRy482BlI=; b=VsF50jYw70MpJdcbLudTsvGWfH
        iRIDdbxAMCl7If65ru+SlVNiUECnX7XSf6WLz8W2gLdhq4DZHVwY1fYmCblCXreG0opTu07F5Yn9U
        bekirVl1zIfAVAyX2NxY+CANfhlYW0tnJRDkA4lRL47myo+z6GlIqpDDrTsf63C2JpUpCS5rcvjN6
        HjR3GFaYmV/L8qlvOZ9G2Cqzj4VM8ZBHeJIeyCfN13E4r8qDRp0Ft1nNlrAR/FGGVt4N4TcvfHsS8
        A0VxLIfYOLdGPASSuzhCIi/HuHLoZYLdu2KRYmhxYt/BJgWh7aymcCG1Kr1b2mJLgj4ttgciTyRS+
        6p+3mAyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1EvY-008Lgw-0A;
        Mon, 22 May 2023 23:26:56 +0000
Date:   Mon, 22 May 2023 16:26:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 2/9] block: Prepare for supporting sub-page limits
Message-ID: <ZGv6QPii5j6Cfb3J@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522222554.525229-3-bvanassche@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 03:25:34PM -0700, Bart Van Assche wrote:
> Introduce variables that represent the lower configuration bounds. This
> patch does not change any functionality.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
