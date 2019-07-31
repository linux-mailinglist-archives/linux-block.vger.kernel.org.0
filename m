Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A37BC54
	for <lists+linux-block@lfdr.de>; Wed, 31 Jul 2019 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbfGaI4f (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 Jul 2019 04:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725209AbfGaI4f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 04:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77A4AAFF8;
        Wed, 31 Jul 2019 08:56:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D7CBE1E43D6; Wed, 31 Jul 2019 10:56:31 +0200 (CEST)
Date:   Wed, 31 Jul 2019 10:56:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jan Kara <jack@suse.cz>, John Lenton <john.lenton@canonical.com>,
        Kai-Heng Feng <kaihengfeng@me.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org, jean-baptiste.lallement@canonical.com
Subject: Re: [PATCH] loop: Don't change loop device under exclusive opener
Message-ID: <20190731085631.GA15806@quack2.suse.cz>
References: <20190516140127.23272-1-jack@suse.cz>
 <50edd0fa-9cfa-38e1-8870-0fbc5c618522@kernel.dk>
 <20190527122915.GB9998@quack2.suse.cz>
 <b0f27980-be75-bded-3e74-bce14fc7ea47@kernel.dk>
 <894DDAA8-2ADD-467C-8E4F-4DE6B9A50625@me.com>
 <20190730092939.GB28829@quack2.suse.cz>
 <CAL1QPZQWDx2YEAP168C+Eb4g4DmGg8eOBoOqkbUOBKTMDc9gjg@mail.gmail.com>
 <20190730101646.GC28829@quack2.suse.cz>
 <20190730133607.GD28829@quack2.suse.cz>
 <009a7a06-67c5-6b3c-5aa3-7d67ca35fc3a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009a7a06-67c5-6b3c-5aa3-7d67ca35fc3a@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-07-19 13:17:28, Jens Axboe wrote:
> On 7/30/19 7:36 AM, Jan Kara wrote:
> > On Tue 30-07-19 12:16:46, Jan Kara wrote:
> >> On Tue 30-07-19 10:36:59, John Lenton wrote:
> >>> On Tue, 30 Jul 2019 at 10:29, Jan Kara <jack@suse.cz> wrote:
> >>>>
> >>>> Thanks for the notice and the references. What's your version of
> >>>> util-linux? What your test script does is indeed racy. You have there:
> >>>>
> >>>> echo Running:
> >>>> for i in {a..z}{a..z}; do
> >>>>      mount $i.squash /mnt/$i &
> >>>> done
> >>>>
> >>>> So all mount(8) commands will run in parallel and race to setup loop
> >>>> devices with LOOP_SET_FD and mount them. However util-linux (at least in
> >>>> the current version) seems to handle EBUSY from LOOP_SET_FD just fine and
> >>>> retries with the new loop device. So at this point I don't see why the patch
> >>>> makes difference... I guess I'll need to reproduce and see what's going on
> >>>> in detail.
> >>>
> >>> We've observed this in arch with util-linux 2.34, and ubuntu 19.10
> >>> (eoan ermine) with util-linux 2.33.
> >>>
> >>> just to be clear, the initial reports didn't involve a zany loop of
> >>> mounts, but were triggered by effectively the same thing as systemd
> >>> booted a system with a lot of snaps. The reroducer tries to makes
> >>> things simpler to reproduce :-). FWIW,  systemd versions were 244 and
> >>> 242 for those systems, respectively.
> >>
> >> Thanks for info! So I think I see what's going on. The two mounts race
> >> like:
> >>
> >> MOUNT1					MOUNT2
> >> num = ioctl(LOOP_CTL_GET_FREE)
> >> 					num = ioctl(LOOP_CTL_GET_FREE)
> >> ioctl("/dev/loop$num", LOOP_SET_FD, ..)
> >>   - returns OK
> >> 					ioctl("/dev/loop$num", LOOP_SET_FD, ..)
> >> 					  - acquires exclusine loop$num
> >> 					    reference
> >> mount("/dev/loop$num", ...)
> >>   - sees exclusive reference from MOUNT2 and fails
> >> 					  - sees loop device is already
> >> 					    bound and fails
> >>
> >> It is a bug in the scheme I've chosen that racing LOOP_SET_FD can block
> >> perfectly valid mount. I'll think how to fix this...
> > 
> > So how about attached patch? It fixes the regression for me.
> 
> Jan, I've applied this patch - and also marked it for stable, so it'll
> end up in 5.2-stable. Thanks.

Thanks Jens!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
