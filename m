Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED70C55919F
	for <lists+linux-block@lfdr.de>; Fri, 24 Jun 2022 07:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiFXFFe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jun 2022 01:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiFXFFd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 01:05:33 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50FF506D0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 22:05:30 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7364467373; Fri, 24 Jun 2022 07:05:27 +0200 (CEST)
Date:   Fri, 24 Jun 2022 07:05:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 00/51] Improve static type checking for request flags
Message-ID: <20220624050527.GA4716@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

I generally like this.  Two thoughs:

 - I suspect most places that currently pass a enum req_op might really
   want a blk_opf_t for future extensibility, exceptions are very 
   low-level helpers like req_op() and bio_op() where the enum is
   very nice to force switch statements to handle all ops or have
   a default statements
 - a lot of the flags printinting is a mess, and introduce the code
   smell of __force casts.  It migh make sense to introduce a new
   %psomething format specifier first to print a blk_opf_t using
   printk/vsprintf/etc and switch everyone to that first instead of
   hand crafted printing.

