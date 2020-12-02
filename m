Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057FB2CBCE4
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 13:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgLBMW6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 07:22:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbgLBMW5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 07:22:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3ECDAB7F;
        Wed,  2 Dec 2020 12:22:15 +0000 (UTC)
Date:   Wed, 02 Dec 2020 13:22:14 +0100
Message-ID: <s5hzh2w8kjt.wl-tiwai@suse.de>
From:   Takashi Iwai <tiwai@suse.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Geoff Levand <geoff@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Jim Paris <jim@jtan.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/ps3: make system bus's remove and shutdown callbacks return void
In-Reply-To: <875z5kwgkx.fsf@mpe.ellerman.id.au>
References: <20201126165950.2554997-1-u.kleine-koenig@pengutronix.de>
        <20201126165950.2554997-2-u.kleine-koenig@pengutronix.de>
        <s5hv9dphnoh.wl-tiwai@suse.de>
        <20201129173153.jbt3epcxnasbemir@pengutronix.de>
        <875z5kwgkx.fsf@mpe.ellerman.id.au>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka)
 FLIM/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL/10.8 Emacs/25.3
 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI 1.14.6 - "Maruoka")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 02 Dec 2020 13:14:06 +0100,
Michael Ellerman wrote:
> 
> Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> > Hello Michael,
> >
> > On Sat, Nov 28, 2020 at 09:48:30AM +0100, Takashi Iwai wrote:
> >> On Thu, 26 Nov 2020 17:59:50 +0100,
> >> Uwe Kleine-König wrote:
> >> > 
> >> > The driver core ignores the return value of struct device_driver::remove
> >> > because there is only little that can be done. For the shutdown callback
> >> > it's ps3_system_bus_shutdown() which ignores the return value.
> >> > 
> >> > To simplify the quest to make struct device_driver::remove return void,
> >> > let struct ps3_system_bus_driver::remove return void, too. All users
> >> > already unconditionally return 0, this commit makes it obvious that
> >> > returning an error code is a bad idea and ensures future users behave
> >> > accordingly.
> >> > 
> >> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >> 
> >> For the sound bit:
> >> Acked-by: Takashi Iwai <tiwai@suse.de>
> >
> > assuming that you are the one who will apply this patch: Note that it
> > depends on patch 1 that Takashi already applied to his tree. So you
> > either have to wait untils patch 1 appears in some tree that you merge
> > before applying, or you have to take patch 1, too. (With Takashi
> > optinally dropping it then.)
> 
> Thanks. I've picked up both patches.
> 
> If Takashi doesn't want to rebase his tree to drop patch 1 that's OK, it
> will just arrive in mainline via two paths, but git should handle it.

Yeah, I'd like to avoid rebasing, so let's get it merge from both
trees.  git can handle such a case gracefully.


thanks,

Takashi
