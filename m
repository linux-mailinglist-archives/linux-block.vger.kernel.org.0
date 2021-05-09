Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E710B37788E
	for <lists+linux-block@lfdr.de>; Sun,  9 May 2021 22:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhEIUvJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 9 May 2021 16:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhEIUvI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 9 May 2021 16:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 41A77611F1;
        Sun,  9 May 2021 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620593405;
        bh=rUSk6p4OtuuYO6xlbw62ir4wXn8s91tpntJlGaabMbQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OvgCCH1kRk4rIk2hlwCVpRSUlXZC8suqpkRtgwVmxB8FN0IwaBTPMIkH3Pe5eq4sN
         JRHmKBZDYxV2Pb2xGU18BX3WHLW4uLcdW60x2GIo4rpKEgyZv4kP47lZg8X6o9YsA3
         GOfkVapErFI7FU50A+zvzktn5fgMqdA9DX1beA9yf4OuU4uP3C1GSpMG/RhDz7uoAh
         j0Jt23A5jDkTaUcU8bUnF2Gn4riDSlMGZMIg3X9QuYsdj7aTsIasRxqt2e1YJJC+xZ
         uniOzM6rIXHRjN6uo2fwzxu82VgaLurVvYRbbbO7LxpzsWFSXe7A+t0V3wQwWqK3FZ
         FwOKJkNsKGLLg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 39A4760A0B;
        Sun,  9 May 2021 20:50:05 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2ddc94ae-e805-f0fa-b18a-879c422435cb@kernel.dk>
References: <2ddc94ae-e805-f0fa-b18a-879c422435cb@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2ddc94ae-e805-f0fa-b18a-879c422435cb@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-09
X-PR-Tracked-Commit-Id: 35c820e71565d1fa835b82499359218b219828ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 506c30790f5409ce58aa21c14d7c2aa86df328f5
Message-Id: <162059340522.8686.18417969830548402171.pr-tracker-bot@kernel.org>
Date:   Sun, 09 May 2021 20:50:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Changheun Lee <nanich.lee@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 9 May 2021 10:16:32 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.13-2021-05-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/506c30790f5409ce58aa21c14d7c2aa86df328f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
