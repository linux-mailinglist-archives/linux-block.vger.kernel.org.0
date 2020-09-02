Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B4A25B513
	for <lists+linux-block@lfdr.de>; Wed,  2 Sep 2020 22:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIBUIR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Sep 2020 16:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBUIQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 16:08:16 -0400
Subject: Re: [git pull] device mapper fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599077295;
        bh=i41jckTLgwcTfaXEDEFxRi+JSJglFOprSmVMRQqnEs8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1KR6j97F8e3EkzJoGqjsdwP8P+/jzeaT+EXNt6Zjac95GbdlWlPFcFyZJqj4wSzDx
         8V+dQgNV4V0DrH4/PX1lKDSGhm7V8QkLVvrqlEfypsOQ8jmnQmcZ239OTrlIZb1WNs
         p/KLt7A7p232dK4rrCbqN8oiVZ7QxVWwdu5x+2CU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200902180248.GA32957@lobo>
References: <20200902180248.GA32957@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200902180248.GA32957@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes
X-PR-Tracked-Commit-Id: 3a653b205f29b3f9827a01a0c88bfbcb0d169494
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3a1309564d3834bad6547a50e58bd195ee85fb6
Message-Id: <159907729584.15646.7864459280755890818.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Sep 2020 20:08:15 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ye Bin <yebin10@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 2 Sep 2020 14:02:48 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3a1309564d3834bad6547a50e58bd195ee85fb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
