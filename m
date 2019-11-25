Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28FE51095A0
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfKYWpJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfKYWpI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:08 -0500
Subject: Re: [GIT PULL] Core block changes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721908;
        bh=dUei2EM6JZjRRw4fyFqiYqFUzlgOFnWuOZ2ndbxJHAU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=h1tFtodrN/PsZ2ydV5FclOmSljVPqEUkJp6qIe77x/XnLFmQGAYZmupE1T7CxlBKP
         88lY60qyDl2m6niDxHMJggAOQDFtA1F2yHVAUQ+duo4h7r8TDQmzJkvLGNiIY5P9Hq
         weXgy5nHnBstxA0DxV2M4KBt2I4uRPlDRpjhb4d0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <01989838-5239-70b9-a3b6-f2d73e311c97@kernel.dk>
References: <01989838-5239-70b9-a3b6-f2d73e311c97@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <01989838-5239-70b9-a3b6-f2d73e311c97@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/block-20191121
X-PR-Tracked-Commit-Id: 1e279153dfd53e76006720df804d5935a6cbc6d5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff6814b078e33a4d26fee9ea80779c81a6744cd8
Message-Id: <157472190821.22729.5322045246838985445.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 21 Nov 2019 10:23:38 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/block-20191121

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff6814b078e33a4d26fee9ea80779c81a6744cd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
