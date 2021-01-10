Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD12F09DC
	for <lists+linux-block@lfdr.de>; Sun, 10 Jan 2021 22:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbhAJVWj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 10 Jan 2021 16:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726432AbhAJVWi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Jan 2021 16:22:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2260422AAF;
        Sun, 10 Jan 2021 21:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610313687;
        bh=O4CTUdrmxiblDnBJEAzZdaEvOFMyC4C8FHBBUDg8Z1M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hHNEwHJvcdlR8mB3NuzEZ+Cnbp7+Gsca7esAJBpfYXfXL9EHGGzTLzfn9CDK81FwB
         4NyEBM5QnpPfTlqJuYBJIBl5WDTXvOngOLwFit8/pFTsmhxvafLiMva15/FoKHUBVI
         O6bBs58W/Fp8zkAGL++SGDaddt+1++kKFPneVGqhDL21ZOcpJnKapR0WqvbJbsjm53
         6lLusrVVejqTUFoTYzhsO04ezHDjJxufIpkrVDxkVyhjT9VKIf9JREF+XoIEi8UlQG
         jY7PWgl3Jbsg8Fya53YtJUeN61BPOhdZaBFN9JH8at4skSvce2jZNwrnvnxidWHZ4D
         0HWvPUl7v/erA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 1B7C8600E0;
        Sun, 10 Jan 2021 21:21:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f53ed2e5-3ee5-0e2f-6d4f-ed6a70a1981a@kernel.dk>
References: <f53ed2e5-3ee5-0e2f-6d4f-ed6a70a1981a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f53ed2e5-3ee5-0e2f-6d4f-ed6a70a1981a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-10
X-PR-Tracked-Commit-Id: 5342fd4255021ef0c4ce7be52eea1c4ebda11c63
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed41fd071c57f118ebb37c0d11b1cbeff3c1be6f
Message-Id: <161031368710.28318.8127881420602962848.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 21:21:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 09:23:51 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed41fd071c57f118ebb37c0d11b1cbeff3c1be6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
