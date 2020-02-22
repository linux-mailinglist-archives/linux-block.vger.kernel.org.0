Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5011691A0
	for <lists+linux-block@lfdr.de>; Sat, 22 Feb 2020 20:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgBVTpU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 22 Feb 2020 14:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbgBVTpT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Feb 2020 14:45:19 -0500
Subject: Re: [GIT PULL] Block fixes for 5.6-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582400719;
        bh=aAzZx1uQo9OCE203s1NST1T1x3ouQhz71m56CKrXNwU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XoKNBK0N/HfSr0aCbe7ngvIEDtE1yyibvOVtlqxNK+PlrGE0cKrBnTPKaYbtL3/Wm
         pwZ8AesYX7n1knVW94cRP8pAClYlrVpTOoyCDhZlxdfFvwroPw5Fi9G5qbXLdSi2vM
         ++6A4+YisUryn3e0VUmoabiHmatwss9iEhZ1iHrQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
References: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <6afcdd61-2d0c-3059-4baf-4814c26c5885@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git block-5.6-2020-02-22
X-PR-Tracked-Commit-Id: ae7bbc091351a4c6ebddfbe36eb5eb7a149cd7a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6c69b7f51456a914da11c4ad1b14eba933d36aa
Message-Id: <158240071943.14316.7191259993278966273.pr-tracker-bot@kernel.org>
Date:   Sat, 22 Feb 2020 19:45:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 22 Feb 2020 09:02:06 -0800:

> git://git.kernel.dk/linux-block.git block-5.6-2020-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6c69b7f51456a914da11c4ad1b14eba933d36aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
