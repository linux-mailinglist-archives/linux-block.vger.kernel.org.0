Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112492E85B6
	for <lists+linux-block@lfdr.de>; Fri,  1 Jan 2021 22:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbhAAV0T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 Jan 2021 16:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:54308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbhAAV0S (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Jan 2021 16:26:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 62FE720795;
        Fri,  1 Jan 2021 21:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609536338;
        bh=fl3Dx9jlFlAQbMyug5I/XpEGUHXtjloT7vetVGUJerE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y6ZTmuXZsl//AczYbRa7datGgFqnsWGQGUXxipEro2YFNQ6aAXnOHSJCUYSoxaczC
         D72tR9eDuagrE/RpJpCNOUTJjaNFs+UGmdpTVtuV3CpQIbHBcl3F5XbmqY3w9roivJ
         cawTU6rM40DWL+5u20kYy2nTUzpUPEnBGUFsZ6Cfy2kikq9QFyMjfpadwQdPo8loi2
         5WEJiqYfvWvaPCgkpWtQJ6JwpaD6KN5qiQR8kEqdUfNZu8eSGlVe8Em99bxkRWafkY
         L+8vJwgRgKkDyYSw0EmPbtu0balydFlqpHKNvL8riY8Rixcpe3OAB5O7doOHy3hJ36
         GxaP+JN98UXzw==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 5C22E60190;
        Fri,  1 Jan 2021 21:25:38 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a063a4f6-47d8-8058-cbd3-daad2fab75d8@kernel.dk>
References: <a063a4f6-47d8-8058-cbd3-daad2fab75d8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a063a4f6-47d8-8058-cbd3-daad2fab75d8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-01
X-PR-Tracked-Commit-Id: dc30432605bbbd486dfede3852ea4d42c40a84b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b4805c68ae348b36a24a4c4b5c869c8971ab0c2
Message-Id: <160953633836.8778.8840656884079290791.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jan 2021 21:25:38 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Jan 2021 08:00:46 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2021-01-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b4805c68ae348b36a24a4c4b5c869c8971ab0c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
