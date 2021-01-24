Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE03301EBE
	for <lists+linux-block@lfdr.de>; Sun, 24 Jan 2021 21:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAXUea (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 24 Jan 2021 15:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbhAXUea (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Jan 2021 15:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9A22122C7B;
        Sun, 24 Jan 2021 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611520429;
        bh=wHWCiU0gGFfOkUFr/aDqNqf9VLFTKv19itbPocpNsz8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rR2YO6ygJdounvzCYyPG/Vwq/RcBqyTbw55+edChfNCB3xNGsaxCSJ4aKYXEZidVN
         dgiEYYT1byE2yCGT5OnIvCCwbAZrSHGeaVRC9L9Qg9YLGYtjlxg9N93gGwcGxN9DDC
         4JfVhEb/xHrvoRKHP6egyAJk4wm5VAl/nSPmQgbBhv9tDBTg0tCU2uBRspGs8gjhNR
         l5VxvpF6/QhZ1CmERYPZKcWqnmRZwHuMPIhAtkL82BwGux0a9yRwq7HIoa7r4iKtAV
         fj+e2wdGV2d4UHdV6PWPBIN9GUaOftu51h9BGz6NfNVzd6sx40OKejTCVH0M9DypeB
         JB+k8e31b81dw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 96B53652E1;
        Sun, 24 Jan 2021 20:33:49 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c97bdf40-6552-ab35-3071-a5b96855c80a@kernel.dk>
References: <c97bdf40-6552-ab35-3071-a5b96855c80a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c97bdf40-6552-ab35-3071-a5b96855c80a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-24
X-PR-Tracked-Commit-Id: 97784481757fba7570121a70dd37ca74a29f50a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a692a610d7ed632cab31b61d6c350db68a10e574
Message-Id: <161152042960.12946.3602978408572870312.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 20:33:49 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 11:50:17 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a692a610d7ed632cab31b61d6c350db68a10e574

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
