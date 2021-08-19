Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F92A3F1AF2
	for <lists+linux-block@lfdr.de>; Thu, 19 Aug 2021 15:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbhHSNxr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Aug 2021 09:53:47 -0400
Received: from verein.lst.de ([213.95.11.211]:37743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240102AbhHSNxr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 09:53:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 468A26736F; Thu, 19 Aug 2021 15:53:08 +0200 (CEST)
Date:   Thu, 19 Aug 2021 15:53:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+aa0801b6b32dca9dda82@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] general protection fault in wb_timer_fn
Message-ID: <20210819135308.GB3395@lst.de>
References: <00000000000072e53a05c983ab22@google.com> <20210816091041.3313-1-hdanton@sina.com> <20210816093336.GA3950@lst.de> <yt9dim01iz69.fsf@linux.ibm.com> <20210819090510.GA12194@lst.de> <yt9dr1eph96a.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dr1eph96a.fsf@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 03:10:37PM +0200, Sven Schnelle wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > On Thu, Aug 19, 2021 at 11:03:42AM +0200, Sven Schnelle wrote:
> >> I'm seeing a similar crash in our CI:
> >
> > This series:
> >
> > https://lore.kernel.org/linux-block/20210816131910.615153-1-hch@lst.de/T/#t
> >
> > should fi it.  Can you give it a spin?
> 
> I tested it without your patchset and it crashed around every second
> try. With that patchset, i wasn't able to reproduce it.

Can you send a Tested-by: for the last patch which should fix this?
