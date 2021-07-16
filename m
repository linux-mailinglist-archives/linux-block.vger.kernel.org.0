Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FDC3CBCBC
	for <lists+linux-block@lfdr.de>; Fri, 16 Jul 2021 21:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhGPTlK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Jul 2021 15:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhGPTlJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jul 2021 15:41:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 52679613F2;
        Fri, 16 Jul 2021 19:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626464294;
        bh=EFpDd8fBlI2SspEDjpG81/KlU7mRqZr6TG5Ma0I1pUY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AoYmDGZdNrVYJ+qIyvWht6jPYhgPJ8a4AUWXIf6bhD7YKDCNTeSqwcO3ZMrfq8FW6
         x420SCzqOEJ7lF9kcGwwF91xVWNgr0pRNoUG2Fg5Z4PA+7OMdu198wr5+LDqNkSaId
         uapUOmBisp2yEt5o2shk2bS88nidH2gMpvenpcfdZa5Br8mp95H7HAvSoonBiA2oHC
         YtFzY3fiw8d+UtA9L5og/IVq66gw4Su0XfrnMDOt7VzYozfev24V1qy4vKQxT3g7JX
         Yni+56dP7ns6kV/7L+EoI8vG1Q72RmFVXUu7UmXx5qI4uTUmTcg1iNwAXdD8MppOSL
         Vw10kkHCexdfA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 40D0060963;
        Fri, 16 Jul 2021 19:38:14 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.14-rc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2b7767f1-3ff0-e65f-398d-4934417dc44e@kernel.dk>
References: <2b7767f1-3ff0-e65f-398d-4934417dc44e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b7767f1-3ff0-e65f-398d-4934417dc44e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-16
X-PR-Tracked-Commit-Id: 05d69d950d9d84218fc9beafd02dea1f6a70e09e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d18c12b288a177906e31fecfab58ca2243ffc02
Message-Id: <162646429420.9691.12889294401950003185.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jul 2021 19:38:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 08:24:57 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d18c12b288a177906e31fecfab58ca2243ffc02

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
