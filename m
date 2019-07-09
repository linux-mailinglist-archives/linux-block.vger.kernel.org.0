Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6863A77
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 20:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGISFS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 14:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfGISFP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 14:05:15 -0400
Subject: Re: [GIT PULL] Block changes for 5.3-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562695515;
        bh=jDf/abxHNbY9B+yeAK8Ys9SxCwvCM13owCcyUuaazLY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=i+oLhuo+d03bPdeABNQto+FgSzPElNTWmmF5qWxt4l3hte2GrlmOWSD4am1SA4zwU
         gug8C6VTpoOuJ0/lH2cMW85gL9yZVYKnM2XtCdE6sHLzsEipr/M2R2EbQAOzM9zqxc
         S9Vl1aFJLPk6kkaoXFMU3tL6gzGp9ZNRdp7N+pTU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
References: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.3/block-20190708
X-PR-Tracked-Commit-Id: c9b3007feca018d3f7061f5d5a14cb00766ffe9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b99107f0e0298e6fe0787f75b8f3d8306dfb230
Message-Id: <156269551516.14383.2389336891073222130.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jul 2019 18:05:15 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 8 Jul 2019 15:21:21 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.3/block-20190708

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b99107f0e0298e6fe0787f75b8f3d8306dfb230

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
