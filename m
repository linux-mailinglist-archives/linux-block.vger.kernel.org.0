Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3899632745C
	for <lists+linux-block@lfdr.de>; Sun, 28 Feb 2021 21:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhB1UO5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 28 Feb 2021 15:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231269AbhB1UOv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 21B7664E74;
        Sun, 28 Feb 2021 20:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614543251;
        bh=D+jrIf2htSMK2y0ARpzRbP6Tv4ZekpjQBOx3+YHVXB0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cGg/e7saNeanwsbSnyExomcYJ9e73hD+YX7br9trkoLro8a9HAor0W0AfLL478UC2
         3pyj6O1nK5ayqNkKI/3hvan074Q8Xll5fjhqlYlqi2HUW+HIMH6w9dgiZ8SRhigSKx
         K4P7XkJvLhDjfn4kvtaRc4v/XTbVaoZm45P0/VTUElP0+UA4XhDzsclbyYlupkSjfW
         15+I4n8zfO3HLoM4uN/ymYya1mvaZc3K9dnTBp+EQ0Bvn5+PdagQPyM2iibPRIKmYp
         qFNO8W/FwI0P/z7cdZ69X+5x9ARENL6FW1U9b0Cjz8fjypjz1rpeIzH2mzGS41wt4k
         DoVjCc+U4oDLA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1D9BF60A13;
        Sun, 28 Feb 2021 20:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes for this merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
References: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4fb0811b-af58-60db-1c27-ef367876c491@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-02-27
X-PR-Tracked-Commit-Id: 5f7136db82996089cdfb2939c7664b29e9da141d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ab6608e66b16159c3a3c2d7015b9c11cd3396c1
Message-Id: <161454325111.2182.18416858079502535409.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Feb 2021 20:14:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 27 Feb 2021 12:52:51 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-02-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ab6608e66b16159c3a3c2d7015b9c11cd3396c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
