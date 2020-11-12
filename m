Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2E2B0DFC
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKLTZn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 14:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgKLTZn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 14:25:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C35BAB95;
        Thu, 12 Nov 2020 19:25:42 +0000 (UTC)
Date:   Thu, 12 Nov 2020 20:25:40 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [PATCH 2/2] loop: Fix occasional uevent drop
Message-ID: <20201112192540.GB14767@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201112165005.4022502-1-hch@lst.de>
 <20201112165005.4022502-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112165005.4022502-3-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

> From: Petr Vorel <pvorel@suse.cz>
Thanks for rebasing my code. Using loop.c specific code in the file instead of
the function is indeed much better.

I also like your cleanup for 5.11 (remove the update_bdev parameter from
set_capacity_revalidate_and_notify).

> Commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
> causes an occasional drop of loop device uevent, which are no longer
> triggered in loop_set_size() but in a different part of code.

> Bug is reproducible with LTP test uevent01 [1]:

> i=0; while true; do
>     i=$((i+1)); echo "== $i =="
>     lsmod |grep -q loop && rmmod -f loop
>     ./uevent01 || break
> done

> Put back triggering through code called in loop_set_size().

> Fix required to add yet another parameter to
> set_capacity_revalidate_and_notify().
This ^ is no longer true and should be removed.

Kind regards,
Petr
