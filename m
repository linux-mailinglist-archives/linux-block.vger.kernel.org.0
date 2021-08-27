Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7B3FA1CA
	for <lists+linux-block@lfdr.de>; Sat, 28 Aug 2021 01:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhH0X15 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 19:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232405AbhH0X15 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 19:27:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9428060F14;
        Fri, 27 Aug 2021 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630106827;
        bh=/VfWUvO6MqPrXJXQiDRfy4e65wHMzZI0HXfByqBj1jU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JRC5Im0oHagkyXByxRpWS434x1VymV3yAgNqYx6v8ORUh50YBEgRV/0SuXPGi0UDp
         FQMLY1IdkaFBhdYQUhlqa9yARwMwmX16KUMu6gpwgEX63MUL6jtr0+s+c7rCw2Z82m
         MdEI5NCdMXq3i03h73jGMl+c59GMiE0rai0vqdzZE5xpUqHNfLD2nX9rCeYIg1aVBc
         TVhshD+yGrrP7fGtcB4wvxH7Ux/LzRbazlWW3zfqtssVQDE7E1jUVEMalY7Kjt+8ld
         oOy+cMw4zN+tkWxehNHGo0XAlz2C7iDTosza6eNAjR/4NwkQ5CfBmVQVrwJio5yOLv
         w721NZtnp9vkg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 8DD1260972;
        Fri, 27 Aug 2021 23:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.14-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2d7d0f57-b8f4-cd34-4034-25b9047652fa@kernel.dk>
References: <2d7d0f57-b8f4-cd34-4034-25b9047652fa@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2d7d0f57-b8f4-cd34-4034-25b9047652fa@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-27
X-PR-Tracked-Commit-Id: 222013f9ac30b9cec44301daa8dbd0aae38abffb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64b4fc45bea6f4faa843d2f97ff51665280efee1
Message-Id: <163010682757.22639.11984186521699919231.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 23:27:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 16:31:42 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64b4fc45bea6f4faa843d2f97ff51665280efee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
