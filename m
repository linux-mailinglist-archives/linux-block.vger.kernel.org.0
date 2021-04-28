Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF46F36E1AF
	for <lists+linux-block@lfdr.de>; Thu, 29 Apr 2021 01:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhD1WZy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Apr 2021 18:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhD1WZy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 18:25:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B2B0261423;
        Wed, 28 Apr 2021 22:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619648708;
        bh=pS/qYXdAhfbbmUeqThIlWdsqn72fSPi7DJEdlQr6bNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jBMaPp5WEQkW7oR8sXPcAWZjY1FQVCOQgEAycpLa2lZt0h6QLtFnvAxarv7FfhwiS
         1bhKf2sKVGkIUlZ5oiPcXeXknCvV4ZNzRnG4XAu988tyakof1t2wlZRYLMRcOQyGL5
         aW7fgCTbro8rgnStNtKXEiKilSndc88vcFpe4Ob5UB5UEQQriUmpKwyaftdY28TtO4
         wEM6FJuMMgIPSPEOmneSVBWHPQSthsqYLbC/oUYH94zNB0ux7KTox5yTPW1Ghy7U9r
         H0krd74xkYs8rQPdyPRGocgdhTpuDAM6aF/XVFpFXIJyPhZYthkthcfztaYOFa/ivG
         lOmJsyXrDVb9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ACF1160A23;
        Wed, 28 Apr 2021 22:25:08 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver changes for 5.13-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f332f5e8-8c45-7d20-de68-ea8f706a2350@kernel.dk>
References: <f332f5e8-8c45-7d20-de68-ea8f706a2350@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f332f5e8-8c45-7d20-de68-ea8f706a2350@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.13/drivers-2021-04-27
X-PR-Tracked-Commit-Id: 8324fbae75ce65fc2eb960a8434799dca48248ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc0586062816559defb14c947319ef8c4c326fb3
Message-Id: <161964870870.18647.8428626591069710474.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 22:25:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 09:13:43 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.13/drivers-2021-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc0586062816559defb14c947319ef8c4c326fb3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
