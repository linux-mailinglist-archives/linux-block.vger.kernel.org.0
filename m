Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663852242AF
	for <lists+linux-block@lfdr.de>; Fri, 17 Jul 2020 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgGQSAG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Jul 2020 14:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgGQSAG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 14:00:06 -0400
Subject: Re: [GIT PULL] Block fix for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595008805;
        bh=Sj13IY84ImFfNQ3D4GpljE++KagbW1weXzrKyhITe2U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wUUboLNAtASxOk/8tl/QarWhTBW0lB60QUx0/liAng+Pp+lfHGZNfMuDAFu0PIu59
         +ZE98I+pG9PSTzWpYZjgNkFu9WZSNW0LsRoOp6tl8sjD0KI8V4dkmLPQxOq8sqYMRI
         B2nR2iy6lmuvR26PwQ92jmuwJqjrBeJ8P520k4sw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4dd7ab11-feb0-6ea8-46b6-0e9590d0890d@kernel.dk>
References: <4dd7ab11-feb0-6ea8-46b6-0e9590d0890d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4dd7ab11-feb0-6ea8-46b6-0e9590d0890d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-17
X-PR-Tracked-Commit-Id: 1f273e255b285282707fa3246391f66e9dc4178f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9ea87dc6c3f48a8de02019fe52472a6cdfedd65
Message-Id: <159500880562.6814.3263486956738723314.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 18:00:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 09:50:41 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9ea87dc6c3f48a8de02019fe52472a6cdfedd65

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
