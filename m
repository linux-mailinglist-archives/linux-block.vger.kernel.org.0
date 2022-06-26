Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E5A55B3D3
	for <lists+linux-block@lfdr.de>; Sun, 26 Jun 2022 21:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiFZTl4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Jun 2022 15:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFZTlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 15:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3711D1
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 12:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8F68B80DF9
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 19:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B55EC341CA;
        Sun, 26 Jun 2022 19:41:51 +0000 (UTC)
Date:   Sun, 26 Jun 2022 15:41:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220626154149.6282deed@rorschach.local.home>
In-Reply-To: <20220625092349.GA23530@lst.de>
References: <20220623180528.3595304-1-bvanassche@acm.org>
        <20220623180528.3595304-52-bvanassche@acm.org>
        <20220624045613.GA4505@lst.de>
        <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
        <20220625092349.GA23530@lst.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 25 Jun 2022 11:23:49 +0200
Christoph Hellwig <hch@lst.de> wrote:

> eah, that is a bit of a mess.  Rasmus, Steven - any good idea how
> we can make the trace even macros fit for sparse?  Maybe just drop the
> is_signed_type check for __CHECKER__ ?

I'm fine with whatever sparse folks come up with. If you want, I can
test any updates to this macro to make sure it doesn't change the
result in other use cases within trace events.

-- Steve
