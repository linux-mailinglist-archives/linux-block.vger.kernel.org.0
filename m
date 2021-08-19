Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420B83F160E
	for <lists+linux-block@lfdr.de>; Thu, 19 Aug 2021 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhHSJUU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Aug 2021 05:20:20 -0400
Received: from verein.lst.de ([213.95.11.211]:36746 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhHSJUU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 05:20:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B488467357; Thu, 19 Aug 2021 11:19:41 +0200 (CEST)
Date:   Thu, 19 Aug 2021 11:19:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <20210819091941.GB12883@lst.de>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp> <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp> <YRi9EQJqfK6ldrZG@kroah.com> <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp> <YRjcHJE0qEIIJ9gA@kroah.com> <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp> <20210818134752.GA7453@lst.de> <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 11:34:15PM +0900, Tetsuo Handa wrote:
> I posted "[PATCH] loop: break loop_ctl_mutex into loop_idr_spinlock and loop_removal_mutex"

Well, you hid it somewhere deep inside a mail deep in a thread.  If you
want proper patch review and actually post it as a patch.

> which reduces the locking complexity while fixing bugs, but you ignored it. Instead,

No, it doesn't.  Adding even more locks does not reduce complexity.

> you decided to remove cryptoloop module (where userspace doing "modprobe cryptoloop"
> will break).

Did you try it?  Because on my system it works just fine thanks to
the MODULE_ALIAS().

> That is, you decided not to provide patches which can be backported.

Please stop this bullshit.
