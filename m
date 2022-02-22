Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4F4BF41B
	for <lists+linux-block@lfdr.de>; Tue, 22 Feb 2022 09:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiBVIyX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVIyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 03:54:23 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E02113AE5
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 00:53:57 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 601CD68AA6; Tue, 22 Feb 2022 09:53:54 +0100 (CET)
Date:   Tue, 22 Feb 2022 09:53:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, Pankaj Raghav <pankydev8@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: block loopback driver possible regression since next-20220211
Message-ID: <20220222085354.GA6423@lst.de>
References: <YhBfsIqCNsi7D/st@bombadil.infradead.org> <cfce5ca9-e845-4b56-e33d-283fee37c3aa@kernel.dk> <YhE/c0K0FN9j8LFE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YhE/c0K0FN9j8LFE@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 19, 2022 at 11:05:23AM -0800, Luis Chamberlain wrote:
> Indeed. The issue is that dropping that also does not allow the
> association of extra custom higher number loop block nodes created manually
> even if you *do* load a respective module before use. That is by design
> by the commit, since we're stuffing the nasty old probe logic now under the new
> CONFIG_BLOCK_LEGACY_AUTOLOAD. Subtle difference, but same deprecation
> effect.
> 
> I agree with the approach to stuff all this nasty cruft under
> BLOCK_LEGACY_AUTOLOAD however I suspect v5.19 might be too soon to tell if we
> can nuke it safely by then though.

Yeah.  5.19 was planned when I submitted this for 5.17, but with it
appearing in 5.18 it is far too early anyway.

> I'd go so far as to say that we should sadly make
> BLOCK_LEGACY_AUTOLOAD=y for a while before going with an axe to kill it.
> I think we have a few hidden gems we'll soon discover might need a bit
> more time to adjust.

Probably.

> 
> FWIW below is a simple test, which now fails to explain what I mean with
> the above.
> 
> root@kdevops ~ # cat loop-high-devs.sh 

The interesting part is that the script works if I remove this mknod:

> if [[ ! -e $LOOPDEV ]]; then
> 	mknod $LOOPDEV b 7 $NUM
> fi

so it seems like losetup is trying to be smart here and skip the manual
creation if the device exists.  I'll take a look at the code and wіll
prepare a patch for that.
