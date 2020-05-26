Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAEF1D6403
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 22:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgEPUaK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 16:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgEPUaE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 16:30:04 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589661003;
        bh=K4kskH6ECBIit8dHw0hPLwLzRSuDES8NnC2gP8xYPnU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ToyPVpFZyZluLQdtTGem1DHz18WQ/Sfr+UXisTwPR7RZSG5hS0PDiGnqTfkFnk5R+
         7WaiY7TY2EcnuHMIczbJiL71NGgUKeD5m5F11yRIuA+aftJbk9GwOmwgrWQuBrQNdN
         slSTKKSmG3Ll0/e9WCFnPBSAlI7D0M94WN664Fwk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2e7f23d1-9c9f-81b2-067d-bc6762982701@kernel.dk>
References: <2e7f23d1-9c9f-81b2-067d-bc6762982701@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2e7f23d1-9c9f-81b2-067d-bc6762982701@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-05-16
X-PR-Tracked-Commit-Id: 3948955397511ad5b68dc65fa11fad941d71d307
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d1c1e5931ce45b3a3f309385bbc00c78e9951c6
Message-Id: <158966100383.3231.377753862623389263.pr-tracker-bot@kernel.org>
Date:   Sat, 16 May 2020 20:30:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 16 May 2020 14:22:17 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d1c1e5931ce45b3a3f309385bbc00c78e9951c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
