Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFAE401F17
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbhIFRQX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Sep 2021 13:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243884AbhIFRQX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 13:16:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 78CEB60EE6;
        Mon,  6 Sep 2021 17:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630948518;
        bh=rweps0lHDulA5+bLN7P42xh/xcLQwkqfJYkxMhZereY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qxpqoNI7LEdq8ITr+4RiKGeSqKIuTAq/425PDCXa7TE8gci/40ahFV7zE8VcZhmDz
         VHhlAqJR9p0kqf1BA9PSCKLxdWFNrMJJufQuIrPSZOvXiEPUjiSR9Jmv61y7SkA+rc
         EJkcx5uWLhYF/VgQwHsJe/feNinIF8Zsut6uLVlnoc6f+UwplC8ZlSGUuitNjVFMgl
         k4VZcJIVqgXB9n8OFyc9MzikWAc/qbJrAdEL26igGZ3yJ37M5JgFmncmlxcwOnaIdD
         fYTJRoaTYc93YwoEoXIJ7NAbYF8Vp/0p5x2erZpynAG2PaMioFlJR9YVdzgV/pQHbU
         CjEuORrH4CwGw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 726E0608FA;
        Mon,  6 Sep 2021 17:15:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e8a816f2-b3f6-cd37-aa4d-b3aa7aed565c@kernel.dk>
References: <e8a816f2-b3f6-cd37-aa4d-b3aa7aed565c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e8a816f2-b3f6-cd37-aa4d-b3aa7aed565c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-05
X-PR-Tracked-Commit-Id: 1c500ad706383f1a6609e63d0b5d1723fd84dab9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1dbe7e386f505bdae30f7436c41769149c7dcf32
Message-Id: <163094851846.9377.5350726223641120614.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Sep 2021 17:15:18 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 5 Sep 2021 21:06:32 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1dbe7e386f505bdae30f7436c41769149c7dcf32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
