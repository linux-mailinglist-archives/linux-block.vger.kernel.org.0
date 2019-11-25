Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE20A1095A4
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfKYWpL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfKYWpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:10 -0500
Subject: Re: [GIT PULL] Post pull for block drivers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721909;
        bh=GFoTCCb7dDPPbykgiNvXlxDlTjCdGI3x3rzIDroqX1I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=azLBU+nNtObfcR/SPJttGa2lhA46e346rx6JOOsq18bRy5InXK8GwTj9rOeteQmK1
         LwtVKvWVQmhv4oNZ3zAj1Z4u0KjVa1toiJauafuEqCxs2AVj64vxxLV6Y7vEzFbqvR
         5/K/z/EAVnySm6Yj7H+ikH3vZsfwZ80DRqL2MnHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
References: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3b9c21af-321a-535c-1192-08fe3961230d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/drivers-post-20191122
X-PR-Tracked-Commit-Id: 03bf73c315edca28f47451913177e14cd040a216
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 323264eefba1ea288d5962c0a9e23ebd62107ca8
Message-Id: <157472190990.22729.4512000875975255747.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 08:37:07 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/drivers-post-20191122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/323264eefba1ea288d5962c0a9e23ebd62107ca8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
