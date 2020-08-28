Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F0F256389
	for <lists+linux-block@lfdr.de>; Sat, 29 Aug 2020 01:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH1XkU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Aug 2020 19:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgH1XkU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 19:40:20 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598658020;
        bh=S6bAcQsmriaEwVo7umh92kgACvpSsAeGP79ksIlbr+I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XVOXK1vWERrfSPTaI4OQi6FtTwM7IXvh6hlOjBu8s2mDxYlR0jI33lluPhSKAVSq8
         YRl0YJ5t1jv5Pg4j1amnOF5IWRtcNbc9S/bxW+iiQDbaeI1a47zpE1up2GpNjEEMSP
         qr7lZKiZ2PjOV1RCK0m0mRUjI6Fk8WP1N+LcKaac=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ea435538-0daa-b039-833a-cf619d210bb7@kernel.dk>
References: <ea435538-0daa-b039-833a-cf619d210bb7@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ea435538-0daa-b039-833a-cf619d210bb7@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-28
X-PR-Tracked-Commit-Id: a433d7217feab712ff69ef5cc2a86f95ed1aca40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d41ead6ead97c3730bbd186a601a64828668f01
Message-Id: <159865801999.1894.5303631905546038729.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 23:40:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 14:03:28 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d41ead6ead97c3730bbd186a601a64828668f01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
