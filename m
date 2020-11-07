Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAEB2AA82D
	for <lists+linux-block@lfdr.de>; Sat,  7 Nov 2020 23:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgKGWI2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 7 Nov 2020 17:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:50232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgKGWI2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 7 Nov 2020 17:08:28 -0500
Subject: Re: [GIT PULL] Block fixes for 5.10-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604786907;
        bh=6Sd4LlhldpP03v6mDeNGZGPORSjZT3yNxlqALYWQwUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=o1vr8BrHyoy4vaLyccs8361OwHXvdfHGrDbUQG90G92okj2gQaQY4g7jxT6Ajmjzc
         5NT9IKPHx0HmBjUITi139dYKu5TNQ05KOZUzP4SNDP+kNxJ3987a4QQoVJ1dO3K6Ks
         Ka6GpKr3Zdi4I9KjkUvVfYIzHTsvYsiuvEveTZLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
References: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bdeefa97-9ec3-cac8-3e6b-dd912d0c0c33@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-07
X-PR-Tracked-Commit-Id: e1777d099728a76a8f8090f89649aac961e7e530
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4429f14aeea979b63bcafdcf9f09677fcf8fd475
Message-Id: <160478690793.18289.14124482235571299779.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Nov 2020 22:08:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 7 Nov 2020 13:14:02 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-11-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4429f14aeea979b63bcafdcf9f09677fcf8fd475

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
