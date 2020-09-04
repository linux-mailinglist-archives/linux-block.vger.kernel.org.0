Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6388825E306
	for <lists+linux-block@lfdr.de>; Fri,  4 Sep 2020 22:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgIDUt1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Sep 2020 16:49:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:32952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgIDUtV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:21 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252561;
        bh=tYqiK1Xe6f7EYzBcqQfmwIi+i1tWLNxPjSW3UT9wa3Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AGnXIVIXZW4acZk47rTkiC3k6R6T87nv8S+hOJYTzxh2Y+tX+MZn8IgItLCrhORde
         VOHAiULo4cLjiwoI2f9Emya/dWGa1HXqVoeCjPSMP4wGRPXYOldsczWhFL0h07YyUW
         rLbc7a9z6MB3swQ46ofYdwPvS0/Y7wMT8TpsOqyM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
References: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <48487797-7770-0c9b-2a6f-bd3b3dae86f7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-04
X-PR-Tracked-Commit-Id: 7e24969022cbd61ddc586f14824fc205661bb124
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8075fc3b113dee1531106aaec3dfa19c8158374d
Message-Id: <159925256140.25529.9506623681970593529.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 4 Sep 2020 09:23:42 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8075fc3b113dee1531106aaec3dfa19c8158374d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
