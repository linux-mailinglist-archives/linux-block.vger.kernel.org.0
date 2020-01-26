Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98499149CE2
	for <lists+linux-block@lfdr.de>; Sun, 26 Jan 2020 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgAZUpF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Jan 2020 15:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgAZUpF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jan 2020 15:45:05 -0500
Subject: Re: [GIT PULL] Block fix for 5.5-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580071504;
        bh=TkrnnQaRaQJfIweQsIMe3OvlJmCL5qBujSuO9Lwq2F4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RGHX+Pxi/vDHTvZFYpPHFVVEncE/G0GxpSm9mTz6NI7mTApYVjbOYhvdq626vqx08
         s5fSSEj0nWatN7eXYtpuLT+S6fTP9Uiis7HZYoRuJcK7DmAFe+wsL4djEdBEEaL2Cp
         o3UuTJf4aBwd78G3zZj4Qu8BznGv64KxGJmcAqqE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
References: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4deb18d9-34fd-c780-dbb4-f544d30ac807@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-2020-01-26
X-PR-Tracked-Commit-Id: b72053072c0bbe9f1cdfe2ffa3c201c185da2201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dbca16087099b9d9826011cddfdae2a16404336
Message-Id: <158007150468.2238.11529751228269797886.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jan 2020 20:45:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 26 Jan 2020 10:32:04 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-2020-01-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dbca16087099b9d9826011cddfdae2a16404336

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
