Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C458281DE2
	for <lists+linux-block@lfdr.de>; Fri,  2 Oct 2020 23:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgJBVyT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Oct 2020 17:54:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJBVyP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Oct 2020 17:54:15 -0400
Subject: Re: [GIT PULL] Block fix for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601675654;
        bh=bslo2NTfrjejpkp9qo0Hq3ZVeyd4+l2oR2OCcfx3ST4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GAmkDzgY28K12wyS8IYxFdFJH64w+/mwmnPgm/imINcDvKtxE+scUa8lwr9FEgZmt
         TS4Fnw4A6xaaK1N1UQJnhQNMECh7CrenjR7L/3gPzj7K5xpcR0wW5kEJOjcenG3FQU
         oVIlrHchGT0N/hJlCLThg6bAH5iuDeFeX/Nb0tZY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d07d1d6-174d-f131-71e7-712c207ebcf2@kernel.dk>
References: <5d07d1d6-174d-f131-71e7-712c207ebcf2@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d07d1d6-174d-f131-71e7-712c207ebcf2@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-10-02
X-PR-Tracked-Commit-Id: 632bfb6323799c087fcb4108dfe59518609667a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f016a5405234709938b38e965e02950e51084ac3
Message-Id: <160167565481.8763.1508672208974926523.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 21:54:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 11:47:43 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-10-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f016a5405234709938b38e965e02950e51084ac3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
