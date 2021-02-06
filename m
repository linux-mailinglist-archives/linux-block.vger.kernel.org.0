Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A8312055
	for <lists+linux-block@lfdr.de>; Sat,  6 Feb 2021 23:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBFWqp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 6 Feb 2021 17:46:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFWqp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Feb 2021 17:46:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id F29BB64E27;
        Sat,  6 Feb 2021 22:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612651565;
        bh=v+VJvUeiovHRb/m2SN+FcoD9yn+Gcbu8YqyVmy3sbAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lljOz6jc4TmKCO0C7WiCLfSY7fL5zb2k/b/l/rP7YXXTtY2qZ4Ro3I8w2HPp8FHqC
         Rzvdj6o73hXdzgE5/YdfEGfnAIzPwnJoSMrlrXl27Asb0dNXeiib703K/G9Lm1NZwc
         OHRz1dH26MS/tux2kHl5y+QpPA4P1uj70I2ZVHN0T1wJ3ibZC68LdR5jg76/EpeuxV
         Lgjq04QdhQeirUEcv9fOYusykm8BFrMzN2L4jaY/OpjmoOwfSURquP1emsb+CgGviR
         HjnkwFKX70dFDIQ40L1QohsZA6xj5sSzPQuPCPqNNjyIrEwdrhJHve2oGil0zs+iar
         X/4MktipNLNEA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ED8A960978;
        Sat,  6 Feb 2021 22:46:04 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1b6014c3-84cf-ec3e-69bf-73a8b10c7e88@kernel.dk>
References: <1b6014c3-84cf-ec3e-69bf-73a8b10c7e88@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1b6014c3-84cf-ec3e-69bf-73a8b10c7e88@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-02-05
X-PR-Tracked-Commit-Id: ea8465e611022a04d85393f776874911a9fc0a2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eec79181212c9c2670423400a9e78bb1f0c0075d
Message-Id: <161265156496.9050.3872173736662773693.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 22:46:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Feb 2021 16:16:47 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-02-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eec79181212c9c2670423400a9e78bb1f0c0075d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
