Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72551369C50
	for <lists+linux-block@lfdr.de>; Fri, 23 Apr 2021 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbhDWV4d (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Apr 2021 17:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbhDWV4c (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 17:56:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 86F506141C;
        Fri, 23 Apr 2021 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619214955;
        bh=1LH+85bPv6617ng6Ox93mMRVJAFVpPcjDa+IPIR98HQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lkkz37VGgzAxu1s0mRlCzyhfr9449BBtIBZ/5Psy4+A6cbdGoQPjgJH79kOrh06gG
         bR+G6AIReAOgtGggqVuJHpl3IB6PymdJFrELvsPeczzqCugXZE/kHc+87aUWCqcW8q
         IoU39iZXqB8TZeoE1UQjqOzCfQ/ap+6od2ZYFVBxK8pvUxZDlW6JRFX9iYEexXU17A
         95h+w1uM/wGfeV2Kocx8OmQJxrmXeYYPOQZhIEZ1EqXhNbrj9kH+G2s2blfX9SbYrw
         9N1Erz+0SyXv2ewpkYN4TO1noDLnw+D8oXkAYPsVAkgTs2HSviuGR5IzeJTwGA8qWM
         WMvQ7SBRjJ90g==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7CD2160976;
        Fri, 23 Apr 2021 21:55:55 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 5.12 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
References: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-23
X-PR-Tracked-Commit-Id: 68e6582e8f2dc32fd2458b9926564faa1fb4560e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95838bd9fcfaa12452dc9fd6d6920faef6bb5a46
Message-Id: <161921495544.11679.14172628908600806476.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Apr 2021 21:55:55 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Apr 2021 15:06:07 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95838bd9fcfaa12452dc9fd6d6920faef6bb5a46

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
