Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED27320D1B
	for <lists+linux-block@lfdr.de>; Sun, 21 Feb 2021 20:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBUTPh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 21 Feb 2021 14:15:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230158AbhBUTPe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Feb 2021 14:15:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1115B64E41;
        Sun, 21 Feb 2021 19:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613934894;
        bh=btRmAof1180ALHybP9xO3KojrUjgwrzpS2sGNeHYLqU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tNVaz5I8mcCI+8xFgSjusLA1/HgH3DRsjYe9huj+TFVru2k66oVFf39Am51pYlNn0
         /KsslnYgnhfjPAp6+/lK7G1y33UQj+TfU+RI1ZXX5Yv0vSHMcV/VvtbfvjMT3xX0D9
         bj1491/eJ7zA4UfIC61UYwtMxJKLmjAJmesZCikJ8/AH9tgfApq4NUS2v8nCk3JvjA
         KtrggbupU1Ewl7ZGxhBZtfJjieeB0hsUtIMUrkH31Rlh+hSBHVFpHSOCJKjJcDFWFA
         tIl33LnZvkwoDVrxDnmq5JKITkpf90P9nyBmicuOV/pgGO2+SYVtabB10Qq63furvR
         6AHybpVVzaTeQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0CA4B60A3C;
        Sun, 21 Feb 2021 19:14:54 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver changes for 5.12-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
References: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.12/drivers-2021-02-17
X-PR-Tracked-Commit-Id: f4b64ae6745177642cd9610cfd7df0041e7fca58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9820b4dca0f9c6b7ab8b4307286cdace171b724d
Message-Id: <161393489404.9182.8227513667570114625.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Feb 2021 19:14:54 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 17 Feb 2021 15:58:02 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.12/drivers-2021-02-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9820b4dca0f9c6b7ab8b4307286cdace171b724d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
