Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454A0308FE1
	for <lists+linux-block@lfdr.de>; Fri, 29 Jan 2021 23:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbhA2WNI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jan 2021 17:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233544AbhA2WM7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jan 2021 17:12:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C8EBC64DEC;
        Fri, 29 Jan 2021 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611958338;
        bh=Q4mH2VJRYNwNmiReDPQ1lc/ppQfydazP8g6APzVH8hE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pUuTvFjvVI7VdgDOWpHyyW6/Tmnwsja/0e2ZB/LItrZ0lcHDXEwLWiMyvSj5DJXrB
         pQgeJt9jOeUyBawmCr7Pk1I1uRww+KNp6Zy0/QPCg41YdM4/ZTzOCCOrM2Q3Fv6z/Q
         CMntidk6o23ModxwIJgF+jSJBSrfvBFX5L+ZodEQvUNfy+6Hszg+JNpIi0NvgGxN+b
         9Mbr9f+lfrNXFO9YHO9vy0QeVnbp6YWxPAFLoQT2uYc3qZEWTw4wvU0cHEgslvH9M1
         Lakk2+DPKhTBe6g2lcq5GeZ/9WkBfPt4vj4LQ7XYorc1AfJtLD60onKkwdTqJ2bzdx
         P3KoCdchhBPDA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D2B2860176;
        Fri, 29 Jan 2021 22:12:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eb91c072-f5e2-147d-792d-165b53406313@kernel.dk>
References: <eb91c072-f5e2-147d-792d-165b53406313@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <eb91c072-f5e2-147d-792d-165b53406313@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-29
X-PR-Tracked-Commit-Id: cd92cdb9c8bcfc27a8f28bcbf7c414a0ea79e5ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ba1c4d1a4b5fb9961452286bdcad502b0c8b78a
Message-Id: <161195833885.1476.15421191218577501522.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Jan 2021 22:12:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Jan 2021 12:14:57 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ba1c4d1a4b5fb9961452286bdcad502b0c8b78a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
