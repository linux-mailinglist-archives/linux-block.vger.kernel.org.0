Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486A84E3D4F
	for <lists+linux-block@lfdr.de>; Tue, 22 Mar 2022 12:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiCVLNz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Mar 2022 07:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiCVLNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 07:13:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268D98119E
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 04:12:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B2D4168BEB; Tue, 22 Mar 2022 12:12:23 +0100 (CET)
Date:   Tue, 22 Mar 2022 12:12:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: yet another approach to fix the loop lock order inversions v3
Message-ID: <20220322111222.GC28931@lst.de>
References: <20220316084519.2850118-1-hch@lst.de> <18f892e5-09f9-ee87-b82b-5458d2f6d5cf@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18f892e5-09f9-ee87-b82b-5458d2f6d5cf@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 07:59:15PM +0900, Tetsuo Handa wrote:
> But I can see that due to no longer waiting for lo->lo_mutex from lo_open(),
> there are occasional I/O errors. What is your plan to avoid this?

There is no plan to avoid that.  We'll get this areas due to have the
remove handling works.  We could play tricks with RQF_QUIET, but I'm
not sure that is worth it.

> By the way, if CONFIG_BLOCK_LEGACY_AUTOLOAD=n,
> 
> # mount -o loop,ro isofs.iso isofs/
> 
> unconditionally fails with
> 
> mount: isofs/: failed to setup loop device for isofs.iso.
> 
> message. Commit 451f0b6f4c44d7b6 ("block: default BLOCK_LEGACY_AUTOLOAD to y")
> says "if the device node already exists because old scripts created it manually".
> But it is not always manual creation of loop devices; I think it is
> ioctl(LOOP_CTL_GET_FREE) in my case.

I'll take a look, thanks!
