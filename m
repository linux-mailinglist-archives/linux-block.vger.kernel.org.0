Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6266770EB4
	for <lists+linux-block@lfdr.de>; Sat,  5 Aug 2023 10:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHEINM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 5 Aug 2023 04:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjHEINL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Aug 2023 04:13:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C5910FC;
        Sat,  5 Aug 2023 01:13:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0099668AA6; Sat,  5 Aug 2023 10:13:06 +0200 (CEST)
Date:   Sat, 5 Aug 2023 10:13:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>, minchan@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dusty Mabe <dusty@dustymabe.com>
Subject: Re: [PATCH] zram: take device and not only bvec offset into account
Message-ID: <20230805081306.GA29615@lst.de>
References: <20230805055537.147835-1-hch@lst.de> <20230805074645.GA907732@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805074645.GA907732@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 05, 2023 at 04:46:45PM +0900, Sergey Senozhatsky wrote:
> > Fixes: af8b04c63708 ("zram: simplify bvec iteration in __zram_make_request")
> > Reported-by: Dusty Mabe <dusty@dustymabe.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Btw, are there any interesting test suites you want me to run on
a > 4K page size system now that I do have this setup available?
