Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA736E1AE
	for <lists+linux-block@lfdr.de>; Thu, 29 Apr 2021 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhD1WZy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Apr 2021 18:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231607AbhD1WZy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 18:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 7D7B96143D;
        Wed, 28 Apr 2021 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619648708;
        bh=u1Cwu6iOPchmya8e++hFTQFY2wlNQOjB5+6wzVnO8bE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+aeHqk3Wcuf4BxnOsWNLWpWypC2wn5BZN0upn7Ie6u8JZmWFarzMTJxwrj8BlbFi
         YwiSzFFtEVWRGQpYIkh4gRQffIMFl0veg84M+hrW6iiGbhD9CF8AxnjJmrQ44EcScB
         BgfLSDA2OSt2FREYsW3OtRR6B/dt3gJBlWvaJdNZ3sw1a4G0HKigKnOKmrHIELcLRt
         PZDryKYg8SOFerPln5LCx635UexPVhJgluipxdT/iBqCbOmLrAQ+GCnuKYPXbHT+Uo
         NPJPwbwu/c4KxsEv5QjYEEb67Zfupo/3ptXk6oa3u1/PNzeUhLu1AI/RCmI6GE+oEG
         p5RHpGO6+e45w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7704B609B3;
        Wed, 28 Apr 2021 22:25:08 +0000 (UTC)
Subject: Re: [GIT PULL] Core block changes for 5.13-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <e0a1b214-e3db-c7fa-dde1-8a5d93f2ff46@kernel.dk>
References: <e0a1b214-e3db-c7fa-dde1-8a5d93f2ff46@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <e0a1b214-e3db-c7fa-dde1-8a5d93f2ff46@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.13/block-2021-04-27
X-PR-Tracked-Commit-Id: f46ec84b5acbf8d7067d71a6bbdde213d4b86036
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c0029211382011af508273c4fc98a732f841d95
Message-Id: <161964870848.18647.8547049603150888186.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 22:25:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 09:00:27 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.13/block-2021-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c0029211382011af508273c4fc98a732f841d95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
