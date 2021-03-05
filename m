Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC232F5AC
	for <lists+linux-block@lfdr.de>; Fri,  5 Mar 2021 23:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhCEV7b (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Mar 2021 16:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229922AbhCEV7A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Mar 2021 16:59:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 725B364FEE;
        Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981540;
        bh=5VaXpKha6Ql+a+oZZ8MCDqv3NVmJNFfeR1P3uAG0xjg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Om73lByhq+Pt7lJIMSvhDlzlct2dt383erbZLB72m9sQv976PBQU8W/Yoj41vE5VE
         ISSAlCQaTA3u+8h/TYiUYj7HuffLSXtp7KN0XY4GInEq2FbXoSlw8oHC+wGm6uPOP3
         m00zYsE8PiokHHBb/GMWlkEJh5zO5L/FZGfCPR10RHyztJvDdQwQzSTI++sw9YuLOn
         ggTSenZ0bUDYqIol0ibsDyxPUy3cf4CUgvPUg2kcG6mGK2dgpciUFYLFgLzmJfCbag
         hCMhh34zV4BepzVooub3mUxXD9Q28UrkwgzGOR+uKesI/vGLE4m6odZ1TikKLQw7kL
         UzJwZ8Bq5l7XA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6DAD460A12;
        Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210305192641.GA21876@redhat.com>
References: <20210305192641.GA21876@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210305192641.GA21876@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes
X-PR-Tracked-Commit-Id: df7b59ba9245c4a3115ebaa905e3e5719a3810da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 63dcd69d9b497c045c4169cddc6a24e1a7428f88
Message-Id: <161498154044.14373.7360159985864637822.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:59:00 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 14:26:42 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/63dcd69d9b497c045c4169cddc6a24e1a7428f88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
