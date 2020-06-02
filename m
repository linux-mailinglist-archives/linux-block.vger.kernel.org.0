Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6231EC549
	for <lists+linux-block@lfdr.de>; Wed,  3 Jun 2020 00:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgFBWuJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jun 2020 18:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbgFBWuI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 18:50:08 -0400
Subject: Re: [GIT PULL] Core block changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591138208;
        bh=ycKR6lIIIC/KvNCZRUxnttmwdBT1qF3XVAK8EGRY22k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v3U2qOsfOlm5Nr+2yLFY4BpBMeUQVgQuaswOvDWMl/2fj/9yJPxtBDBzQH5ASmbvd
         MvaCB6Mrrb2X1jUHp6tQ/k4jrZOyc32iO0nLX6TpwfBeAlLARjpWqsAQbPT8smxcX1
         1yvNWwQq5QH9W1qOL2w5MNPkul/zPyEEdbJNSZkU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
References: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <88e3cc9b-efba-055f-880a-1b7ae8d1e6cb@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.8/block-2020-06-01
X-PR-Tracked-Commit-Id: abb30460bda232f304f642510adc8c6576ea51ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 750a02ab8d3c49ca7d23102be90d3d1db19e2827
Message-Id: <159113820855.13730.10251941557917657886.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:50:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:41:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.8/block-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/750a02ab8d3c49ca7d23102be90d3d1db19e2827

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
