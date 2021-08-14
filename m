Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33D13EBF42
	for <lists+linux-block@lfdr.de>; Sat, 14 Aug 2021 03:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhHNBMx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Aug 2021 21:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236200AbhHNBMv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 21:12:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D6EB610F7;
        Sat, 14 Aug 2021 01:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628903544;
        bh=hleaGF9Z4fxjHRuUvBKMrKiLwbHJkc8mwwVap196o/8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NVFpnRIJCat3FdcWtnDH6l3cyraFnI7UaqZjh72wYXeesdj+sPqyLzKLd5LE/YMaK
         8Z4y3xxWpow6CJbA+zAHFNFIVqno4em3XqEKBoRa0TGn8W6jySC0I/j1bYky3deh7b
         J3SheOVOGROverIpxqf0EM2P2YTOa5LCVMXsawRRdLkd6XrOUEBKX6PORkuMxNXElC
         a+w2oWZxGiF6DICZar+4iDU0yAroE4XaGXTNTqbIKCSgEXmWZMX4UIekelmleuAOp4
         W5zE7m5RLYTA5u/1CmW4lU4CtRFGTXsZ75UNecJUA8qAra84hbmuf3eDy241AkPJjB
         TwJulB9IBRIjQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 17AE1609AF;
        Sat, 14 Aug 2021 01:12:24 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <07a53f5d-0b2d-0fd3-8d50-098726bb7650@kernel.dk>
References: <07a53f5d-0b2d-0fd3-8d50-098726bb7650@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <07a53f5d-0b2d-0fd3-8d50-098726bb7650@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-13
X-PR-Tracked-Commit-Id: cddce01160582a5f52ada3da9626c052d852ec42
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 020efdadd84958debc36e74fb5cc52b30697a611
Message-Id: <162890354408.25277.14910399792937250254.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Aug 2021 01:12:24 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 13 Aug 2021 13:12:48 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-08-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/020efdadd84958debc36e74fb5cc52b30697a611

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
