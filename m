Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 234811606AC
	for <lists+linux-block@lfdr.de>; Sun, 16 Feb 2020 22:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBPVKX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 16 Feb 2020 16:10:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgBPVKV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Feb 2020 16:10:21 -0500
Subject: Re: [GIT PULL] Block fixes for 5.6-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581887420;
        bh=maZdVNScKDYJPtc0M5uaeFYls/kRaLnYNI4jvlkXgJ0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ATpkKRrZhaY9kYm0zqlK5kyKkjvJVxs0nm72AKHVm9Qw6JPZwZSxjTZ2YPlcV9pcw
         wVULk5IzQfVPpw5Vf4pERbqLHlk6hUHtMhjuJO1LIEE/D1DquPkpLfx7UMYqLXiOZ1
         OWB/NH/brRXIdlfr+qVW1BQ4TKnPi3/LH8GOQ+p0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7f2de313-552e-e3d0-9b33-faf09bc65b57@kernel.dk>
References: <7f2de313-552e-e3d0-9b33-faf09bc65b57@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7f2de313-552e-e3d0-9b33-faf09bc65b57@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-2020-02-16
X-PR-Tracked-Commit-Id: f25372ffc3f6c2684b57fb718219137e6ee2b64c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e29c6a13ddf56217563f03fbc6ba9bb72dcbf2e4
Message-Id: <158188742081.12275.7868606005746520937.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Feb 2020 21:10:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 16 Feb 2020 09:05:30 -0800:

> git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e29c6a13ddf56217563f03fbc6ba9bb72dcbf2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
