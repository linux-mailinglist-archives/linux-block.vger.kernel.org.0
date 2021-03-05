Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ADE32F5AA
	for <lists+linux-block@lfdr.de>; Fri,  5 Mar 2021 23:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhCEV7c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Mar 2021 16:59:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:57860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhCEV7A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Mar 2021 16:59:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 373D265012;
        Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614981540;
        bh=geoYLiVNhe4T/Fx38r6MWprEGp7lSQCvKKACrRsb9r8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H1cytc63I9VeB8Z2KvvTF+2FsTC4kcS4iZGeHD2zVqDPQklHMyfCOY2/F4Aw1EAR2
         1UvJrLn1dzUysN+M5Et4d+J55XBS0XhzsGy5yzihRv/mBbca3tppjuwhL/4ZqLZKxN
         FcJqAYcxsUHT/xVc0Il40dVDiyKyz4IiEEmT+dmH4AftluhGZ+ifiOv7vaS43T5+zI
         CswOZspyHz8l3lLIi3rzIBmIAtgD0E3r76LGGrWxEs5PRSdt8jj5gDscWI/dMYOplp
         NTfgJXvIVZUkGLrHNnhUdN2AVdGuw1j0IGkfuaBdqm6LApmuZmJW9xun6MjDsV2wg4
         EV5oL50+lRQ/Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 33272609EA;
        Fri,  5 Mar 2021 21:59:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fbbd162e-2221-502a-2d3a-d6115b206be0@kernel.dk>
References: <fbbd162e-2221-502a-2d3a-d6115b206be0@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fbbd162e-2221-502a-2d3a-d6115b206be0@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-05
X-PR-Tracked-Commit-Id: a2b658e4a07d05fcf056e2b9524ed8cc214f486a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47454caf45f0481988912a4980ef751a1c637b76
Message-Id: <161498154020.14373.6967921945376238587.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Mar 2021 21:59:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Mar 2021 11:09:21 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47454caf45f0481988912a4980ef751a1c637b76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
