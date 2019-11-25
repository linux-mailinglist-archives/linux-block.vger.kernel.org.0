Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF56F1095A8
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfKYWpN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfKYWpM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:12 -0500
Subject: Re: [GIT PULL] Disk revalidation cleanups for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721912;
        bh=XrXmaD2hczXH0UvjdlOW/G635BjcBaGiKTSsI2fuSdM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L6usK2NsDLL3xm4qz6bSyyp9Ea/49b8KfMX9/KZzVvkA7MWr7g4JHA7a2eUH0FaRb
         HOyUq56RlQAxGG0LYGarJeX1t/pBhSjQL5QYWC6kXST8CloLs7f0FkkpEhI5pqZs2E
         5U4tX3Dd4R20RyzngnZyUfn4jcU/GG/PS8PvelBM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <98189772-b987-2f83-29c5-a300b83f4b08@kernel.dk>
References: <98189772-b987-2f83-29c5-a300b83f4b08@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <98189772-b987-2f83-29c5-a300b83f4b08@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/disk-revalidate-20191122
X-PR-Tracked-Commit-Id: 979c690d9a017db14b7759a099478e3faad991ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7e5192b93c3b8661791f65f0d477d0da234ca202
Message-Id: <157472191238.22729.3603753002401780785.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:12 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 08:51:55 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/disk-revalidate-20191122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7e5192b93c3b8661791f65f0d477d0da234ca202

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
