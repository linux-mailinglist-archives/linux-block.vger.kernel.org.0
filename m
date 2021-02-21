Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34D9320D1C
	for <lists+linux-block@lfdr.de>; Sun, 21 Feb 2021 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhBUTPh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 21 Feb 2021 14:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhBUTPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 14:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EB79064E04;
        Sun, 21 Feb 2021 19:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613934894;
        bh=ZgIaKMGGFA6Pu0fBzIoUbgh4T8J9d5xOBow50N9MJEY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+dKbqZt+yyIbWC3hMi3rFPF/mTXS8aUPi0CzeJWVwSSGLy+BBaOLhb9Us3DMSfMs
         XRON4HK8gEXiY5K/MDv/WzB9cXJkiJ+zX3aoPk0q1k+CseN7fhKBmAa0umugsQ47pp
         wg6EhsY5HY9CNV5Tg7iaHvE7SqVZm5ruDqMCIBhlna0RvvmXOzslrZXPjcev7UCSkg
         LOFuCM0lxx7T/F7dx4UGtM5yXUNhHRmzZW7McmWkWRguQHslkVTlzi+k9H1NE8YASh
         EdJYoc5k3EXkxVOUSDskIY9qIheg45euv6W1UbNImMp+73+JFOCz9VXZ08P1pKElDY
         W+Yp9VDfQ1Mlw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E75D660967;
        Sun, 21 Feb 2021 19:14:53 +0000 (UTC)
Subject: Re: [GIT PULL] Core block changes for 5.12-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ff4cdd19-1930-bf79-c0fd-f022147095f7@kernel.dk>
References: <ff4cdd19-1930-bf79-c0fd-f022147095f7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ff4cdd19-1930-bf79-c0fd-f022147095f7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.12/block-2021-02-17
X-PR-Tracked-Commit-Id: f885056a48ccf4ad4332def91e973f3993fa8695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 582cd91f69de8e44857cb610ebca661dac8656b7
Message-Id: <161393489394.9182.6498557931805054890.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 19:14:53 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 15:45:27 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.12/block-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/582cd91f69de8e44857cb610ebca661dac8656b7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
