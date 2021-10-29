Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B4F44027A
	for <lists+linux-block@lfdr.de>; Fri, 29 Oct 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhJ2SwI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Oct 2021 14:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhJ2SwH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Oct 2021 14:52:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E7D660F4B;
        Fri, 29 Oct 2021 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635533378;
        bh=A8499suByx8cLRcYm1EuMQy3v4IsqirkJyhgDtPlh2c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MHe2j0IBaJYTy6732uMAWOTYs6EI1F+5NX5er7DSeXGCyhpHOcr4+n24h3sthtmks
         ErrSgIAN+9YOYEdOQdBp5k4xM/dl75MT4B59Cj/pAdPKb6YtFuWQMuzcGhMo3UJUop
         b51JOOcn/HhEgv0TNSTp9rfMQGeL7tYhAq8QRMkwVVNrjtSZKHfA0g+x6Jx8K/hnFU
         SjQhg2fanLtjF8TWTFrgmMIkCOaKuebCIGM7nS0X+ypfkwe50AQMnE6WYL7bUF8km0
         Tw0yAdkF9sK17AW3n+zXgIREO2QED32cfm8NG89JRTZuLcUWHuf8LbC2C1aLmjkFoS
         WPqjB2inIOkqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6872F60987;
        Fri, 29 Oct 2021 18:49:38 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.15-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f86feb9d-f667-66d1-1ffe-d74f83847d3a@kernel.dk>
References: <f86feb9d-f667-66d1-1ffe-d74f83847d3a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f86feb9d-f667-66d1-1ffe-d74f83847d3a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-29
X-PR-Tracked-Commit-Id: f4aaf1fa8b17e74aa46bf0165c35a1575b239d4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a379fbbcb88bcf43d886977c6fb91fb43f330b84
Message-Id: <163553337842.6387.868004401441769063.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Oct 2021 18:49:38 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 09:08:34 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-10-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a379fbbcb88bcf43d886977c6fb91fb43f330b84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
