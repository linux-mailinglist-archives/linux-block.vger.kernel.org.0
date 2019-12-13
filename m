Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B3411EE46
	for <lists+linux-block@lfdr.de>; Sat, 14 Dec 2019 00:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLMXKW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Dec 2019 18:10:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLMXKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 18:10:19 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576278619;
        bh=hJ2ALtgkNjahDJjRvv8M00mzz/lGCqWB/EU6CpidKy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PlkIn+Ml5+N9DxpRFnGwDlpBbHUJ2Qb6AzVOJIQj1HnEA17FQQTYNv3XLZU3FJs8G
         3i/+UZYSHwpRqwEVzS8upw10xjN5NbKe0WbfmrvRps/4p2EohOFqbE1YVuv65YY26S
         Fdq10xJi2Uv+Pnsjh1EzPxvH0v3nQ6npCH3EOJJU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
References: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1202a2e6-8527-4bd1-7b38-806aafe50e2c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191212
X-PR-Tracked-Commit-Id: 5addeae1bedc4c126b179f61e43e039bb373581f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1fcd7786ec8e316b69860ab856f29f346a9b301
Message-Id: <157627861902.1837.2707380427846646761.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Dec 2019 23:10:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 12 Dec 2019 18:23:32 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191212

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1fcd7786ec8e316b69860ab856f29f346a9b301

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
