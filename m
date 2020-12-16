Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E882DC83B
	for <lists+linux-block@lfdr.de>; Wed, 16 Dec 2020 22:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgLPVSv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Dec 2020 16:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbgLPVSu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Dec 2020 16:18:50 -0500
Subject: Re: [GIT PULL] Block changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608153490;
        bh=hXreBK6RachCheLveGz5Klz+3B9z0CzYcPZQQL+/XUo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BM8lGj1eUKUJvl3Qz/6B/RKhuEN5S1OaxMdrvsIYZKzlEFEwnOz26O6EWvr81abDM
         nb4VVwbBgZ/NCwvE1gSyMJOHwe/K91gq2zzqAbrF0xeoUnnIqQ4Ch4bg2PKIT9WFTf
         AxrBVq4qWW/0JWOGPgeh1iLd1rhoBrG12KrSKTD+OzlbW5y5R7KMM9Eahb3gXtcMKt
         4DBa5RIrlJj5pc316m6Xwa/KhN49Pr3fRN2An5eviBmz9kHl5ugKulMjnqNZWj9Kmy
         +CVpl0QacONWIYb679DVDrg25kWA0KWxYpFgc+14Fi1EA39i+wnm8oqdxd2Z03YO4T
         tsg7m+U6KLOBQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
References: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <774c987e-0743-6a7b-cfa7-1c65c35931b3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.11/block-2020-12-14
X-PR-Tracked-Commit-Id: fa94ba8a7b22890e6a17b39b9359e114fe18cd59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac7ac4618cf25e0d5cd8eba83d5f600084b65b9a
Message-Id: <160815349038.27795.4280091907319928338.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 21:18:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 08:06:21 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.11/block-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac7ac4618cf25e0d5cd8eba83d5f600084b65b9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
