Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6492523CF46
	for <lists+linux-block@lfdr.de>; Wed,  5 Aug 2020 21:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHETSq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Aug 2020 15:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgHETQx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Aug 2020 15:16:53 -0400
Subject: Re: [GIT PULL] Post block bits for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596652778;
        bh=jN2oaK8WMD/CxEkns5jra1h6Q5u+MBtY+Rc9xzFAVUE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dUjnVSQaDFVppHlT+atV2lQ+/KDZhjSKES831UJFwucE6dZOvIluZkYhbqL2QYKzU
         lPU+bSya5tigdBx/eAQm0aylFi5gM+1U7tcEmjYJiI6hiqppqeHkqgyALEdNCZ58gP
         xsYxbZhdLcGMmKPJJnlJKtqfx8p17wyoD3zOYak8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f165cbc1-d122-d668-4192-80dc8e8fd7cf@kernel.dk>
References: <f165cbc1-d122-d668-4192-80dc8e8fd7cf@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f165cbc1-d122-d668-4192-80dc8e8fd7cf@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.9/block-merge-20200804
X-PR-Tracked-Commit-Id: 1a1206dc4cf02cee4b5cbce583ee4c22368b4c28
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 060a72a268577cf27733d9e8eb03b3ca427f45e6
Message-Id: <159665277827.15741.18193245558663755417.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 18:39:38 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 10:28:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.9/block-merge-20200804

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/060a72a268577cf27733d9e8eb03b3ca427f45e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
