Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E56B612B8
	for <lists+linux-block@lfdr.de>; Sat,  6 Jul 2019 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfGFSuF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 6 Jul 2019 14:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfGFSuF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jul 2019 14:50:05 -0400
Subject: Re: [GIT PULL] Single block fix for 5.2-final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562439004;
        bh=UrwTq7iXtLu15+CSMzqLbarnDJ/V+NLB7aWFo7eQVb4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HORtw54RpReV+ltzrvemWjFtAqm2BHArv8x+gz4NLYf2rFWKls0g0G5RKRcx8Segb
         atGflLBfJi2xd2MthboYPsd4Ma9JZBateH5b+0CXSNs+E8BWNC1yPFXe5Eelp3sKMC
         F6hGsJbpEZsmYGutAuFeP15SJnalZheCxTcf96Xc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
References: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190706
X-PR-Tracked-Commit-Id: 7e41c3c9b6ceb2da52ba9d2b328d1851f269a48e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46713c3d2f8da5e3d8ddd2249bcb1d9974fb5d28
Message-Id: <156243900468.6423.15724866292086516633.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jul 2019 18:50:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 6 Jul 2019 12:47:39 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190706

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46713c3d2f8da5e3d8ddd2249bcb1d9974fb5d28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
