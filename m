Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D883FC0BC
	for <lists+linux-block@lfdr.de>; Tue, 31 Aug 2021 04:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbhHaCPW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 Aug 2021 22:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239363AbhHaCPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Aug 2021 22:15:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 71DB661027;
        Tue, 31 Aug 2021 02:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630376067;
        bh=nTi323iBwBpSrIiO6GbO13gFZ5Zg4n68AVNjAtW4KoQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oAdT7eabUMwx+mTINz7/y9mTVjT+V/utC96pQAoZMpEyRehVhoib8Vd6DXHNdQLZA
         PDmiJVvzxk4N4vq/2JRRnTSyAxF9UjnKhnyQDs3LBLLiohDZ2GjqR2Wy2J/1RCP7DE
         qc3Fh8w9I9wZcbYiCXiijmjjTd8ij2XiysiyaYedcI5qSVJyQ05yiTfNRn01xnAjRF
         0NWguOyWImBowMOFPoeDQWuc32MbjkJlOnkD0VdUbuq5lWFU+uchrLSjsD2wk2NqJv
         yMC+8uU/jvpASwPc0KYRrodtZsFHLLzSdlSN2nNdPxLRkjOfE3JLqYxzRctukLgcnX
         FaHDR706fE3DA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6A47460A6F;
        Tue, 31 Aug 2021 02:14:27 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver changes for 5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8e3f076e-4af2-8aa4-64a2-de65e231bfd7@kernel.dk>
References: <8e3f076e-4af2-8aa4-64a2-de65e231bfd7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8e3f076e-4af2-8aa4-64a2-de65e231bfd7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.15/drivers-2021-08-30
X-PR-Tracked-Commit-Id: b5b0eba590f08e2b06c830b8343c1da7059c7a88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a1d6c9e3f53732f2f48f4424e028642db616663
Message-Id: <163037606742.28323.16598870869129091024.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 02:14:27 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 08:39:51 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.15/drivers-2021-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a1d6c9e3f53732f2f48f4424e028642db616663

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
