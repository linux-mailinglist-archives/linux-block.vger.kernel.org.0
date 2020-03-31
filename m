Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA364198D59
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 09:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgCaHsc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 03:48:32 -0400
Received: from verein.lst.de ([213.95.11.211]:37197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgCaHsc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 03:48:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ABC3168C4E; Tue, 31 Mar 2020 09:48:28 +0200 (CEST)
Date:   Tue, 31 Mar 2020 09:48:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
Message-ID: <20200331074828.GA24372@lst.de>
References: <20200329140459.18155-1-maco@android.com> <20200330010024.GA23640@ming.t460p> <CAB0TPYG4N-2Gg95VwQuQBQ8rvjC=4NQJP4syJWS3Q6CO28HzTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYG4N-2Gg95VwQuQBQ8rvjC=4NQJP4syJWS3Q6CO28HzTQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 30, 2020 at 10:06:41AM +0200, Martijn Coenen wrote:
> Hi Ming,
> 
> On Mon, Mar 30, 2020 at 3:00 AM Ming Lei <ming.lei@redhat.com> wrote:
> > The new ioctl LOOP_SET_FD_WITH_OFFSET looks not generic enough, could
> > you consider to add one ioctl LOOP_SET_FD_AND_STATUS to cover both
> > SET_FD and SET_STATUS so that using two ioctl() to setup loop can become
> > deprecated finally?
> 
> I originally started out doing that. However, it is a significantly
> larger refactoring of the loop driver, and it makes things like error
> handling more complex. I thought configuring loop with an offset is
> the most common case. But if there's a preference to do an ioctl that
> takes the full status, I can work on that.

I think the full blown set fd an status would seem a lot more useful,
or even better a LOOP_CTL_ADD variant that sets up everything important
on the character device so that we avoid the half set up block devices
entirely.
