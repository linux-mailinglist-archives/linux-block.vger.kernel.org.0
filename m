Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AF73D49C4
	for <lists+linux-block@lfdr.de>; Sat, 24 Jul 2021 22:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGXTgK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 24 Jul 2021 15:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhGXTgJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 15:36:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 377E560EAF;
        Sat, 24 Jul 2021 20:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627157801;
        bh=7Hhzc41ALdyOmjP3nMbs/0Rcj8fhnGhC2XQ3VeTy7Qo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mLxayoVF6fHUzP0d4MycTpRK5n4Q1XRRHiv6pKrZTHC+jbd/M6KXckydgDEFX1XIG
         lGwR5Jncdjw4Y+Y87Jv+VKhV1iGrLOC/txjUXeOE88+IPdeiovB+Q2iGRwPuJ0cnKv
         NLDLGr3wrLkBsY35JBOSYLvnOQFQ0myTY2/nQs62aFHkMNzy4dTHlr1K2KmoXRxnXo
         md+ZfxYwlwWAdDQd0USukPQEY6Gn6zAMrGfpj8cKi56lMOxPZ0j/aruZ2AyDuphaWA
         BtTuicjeuHCX8LeqCZvbV+fAFW5jMOQxoM5Zmffd7QBsdc86jfQyTWu9bEISmRNeKY
         sQCpsFm8VCPGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3153060972;
        Sat, 24 Jul 2021 20:16:41 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.14-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b5a906fb-0e55-cfb1-ba4b-d12ecc3a42d4@kernel.dk>
References: <b5a906fb-0e55-cfb1-ba4b-d12ecc3a42d4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b5a906fb-0e55-cfb1-ba4b-d12ecc3a42d4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-24
X-PR-Tracked-Commit-Id: 7054133da39a82c1dc44ce796f13a7cb0d6a0b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d4a60cede3604208c671f5a73a6edd094237b13
Message-Id: <162715780119.1145.1933843129936356243.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Jul 2021 20:16:41 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 24 Jul 2021 09:50:54 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d4a60cede3604208c671f5a73a6edd094237b13

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
