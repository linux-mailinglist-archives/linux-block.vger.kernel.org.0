Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9922B07B3
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 15:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKLOnL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 09:43:11 -0500
Received: from verein.lst.de ([213.95.11.211]:43938 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOnL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 09:43:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A475567373; Thu, 12 Nov 2020 15:43:07 +0100 (CET)
Date:   Thu, 12 Nov 2020 15:43:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
Subject: Re: [PATCH 1/1] loop: Fix occasional uevent drop
Message-ID: <20201112144307.GA8377@lst.de>
References: <20201111180846.21515-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111180846.21515-1-pvorel@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 07:08:46PM +0100, Petr Vorel wrote:
> 716ad0986cbd caused to occasional drop of loop device uevent, which was
> no longer triggered in loop_set_size() but in a different part of code.
> 
> Bug is reproducible with LTP test uevent01 [1]:
> 
> i=0; while true; do
>     i=$((i+1)); echo "== $i =="
>     lsmod |grep -q loop && rmmod -f loop
>     ./uevent01 || break
> done
> 
> Put back triggering through code called in loop_set_size().
> 
> Fix required to add yet another parameter to
> set_capacity_revalidate_and_notify().

I don't like where this is heading, especially as I've rewritten the whole
area pending inclusion for 5.11. I think the you want something like what
I did in this three commits with a loop commit equivalent to the last
commit for nbd:

http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4

http://git.infradead.org/users/hch/block.git/commitdiff/89348f9f510d77d0bf69994f096eb6b71199e0f4

Jens, maybe I should rebase things so that a version of that first
commit can go into 5.10 and stable?
