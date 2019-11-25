Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 511691095A7
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfKYWpN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:39956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbfKYWpJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:09 -0500
Subject: Re: [GIT PULL] Main block driver changes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721909;
        bh=CjuyLv7uyacXvJxbePFhF7eZtJmLRulm45rECkB/lIw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DY265NoXkHhJGqeRwjykMRyoVd9F/cik5SeA705trDNGo7+h8KrNJ8z8OQovMIc3q
         hEsS2YG+2AHJ3mGE0CBkiICyi6UGNjEsqmZvjgQ/FFoM0mseZpqhlQwog3IPAfRFX8
         LOfv8G8Abd3Xy7TNkxBofg44MDT+XAEkpgLoHqLw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8d7e00cd-2e9d-8692-1104-30709a7b7426@kernel.dk>
References: <8d7e00cd-2e9d-8692-1104-30709a7b7426@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8d7e00cd-2e9d-8692-1104-30709a7b7426@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/drivers-20191121
X-PR-Tracked-Commit-Id: 00b89892c869f34528deca957b10d1468c4e8b38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d53943090c336c9d298638bad292be349e1b9c4
Message-Id: <157472190908.22729.6175048824619220210.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 10:30:30 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/drivers-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d53943090c336c9d298638bad292be349e1b9c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
