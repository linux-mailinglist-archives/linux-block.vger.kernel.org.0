Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC740FDE3
	for <lists+linux-block@lfdr.de>; Fri, 17 Sep 2021 18:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhIQQay (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Sep 2021 12:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhIQQax (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 12:30:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id B256960F6D;
        Fri, 17 Sep 2021 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631896171;
        bh=zgDPtQg4MSWYUOdbLMn86rEMSVuc65Uve6JJp5vVlwM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HnMIndv5bvo+NmrAZl6wR3UnVr582wFhUaeSY3THSta3XrQxz8zA/u9honPM1rDKL
         b/AL9U6ab3QnfPHyTWVIdx3zRKyvkHSqIDhXBdhYE+q9+4EQKNUN4lz6f2VyFj4W0M
         mlpVOPqRHrOQZWWCAX8dToAbHlnNZ+d3bVIl1dS3+QGYXRpn0Wpnba7KgfYBLbRSGR
         99ZLFbekHlvlCkAXoRodj2cak7gYHKUlHrD0NtjbYNYtEYvXjDF/wN1d35e4ZRBYGq
         yC/hrIbLyfQBuimse8KEJbh+ibrlxeTGXK5oXxlVTlD9WFDpYp0iikpyGS9r3tRAuB
         hJmmTL7CzULUw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id A3A5360726;
        Fri, 17 Sep 2021 16:29:31 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.15-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <56b251c1-3638-40d9-6fee-38b8f3b9bed2@kernel.dk>
References: <56b251c1-3638-40d9-6fee-38b8f3b9bed2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <56b251c1-3638-40d9-6fee-38b8f3b9bed2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-17
X-PR-Tracked-Commit-Id: 858560b27645e7e97aca37ee8f232cccd658fbd2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36d6753bc205b6e8588cb49631642455165333ab
Message-Id: <163189617160.30150.948026553460944098.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Sep 2021 16:29:31 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Sep 2021 08:44:23 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.15-2021-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36d6753bc205b6e8588cb49631642455165333ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
