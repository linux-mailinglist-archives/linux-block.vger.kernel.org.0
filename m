Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3A23AE3B
	for <lists+linux-block@lfdr.de>; Mon,  3 Aug 2020 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHCUfG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Aug 2020 16:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbgHCUfG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 3 Aug 2020 16:35:06 -0400
Subject: Re: [GIT PULL] Core block changes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596486906;
        bh=7e9PWY1iRtriE4P4hEf7Cg9PEgQSoknjFG46zVtsj5k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Dar0QZDUiOUm+GI1jAf7PhH8Wt+/zqB32EeprAZ/2kzwSUwWbMfnZRgbWckRISKX6
         EZygj5USNHk9rbncirZWNGtmBTVbl25qwadc9CYqhlsiY67qyNAUXKID1h6gKLrGQX
         NYHFcCILFhqYRG7uGyMpNtNlfNWthhlsBAgkRDvg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9127f74b-d312-6812-ee5f-d761301215ff@kernel.dk>
References: <9127f74b-d312-6812-ee5f-d761301215ff@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9127f74b-d312-6812-ee5f-d761301215ff@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.9/block-20200802
X-PR-Tracked-Commit-Id: d958e343bdc3de2643ce25225bed082dc222858d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 382625d0d4325fb14a29444eb8dce8dcc2eb9b51
Message-Id: <159648690617.10543.18229671366491606056.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 20:35:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 2 Aug 2020 15:41:13 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.9/block-20200802

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/382625d0d4325fb14a29444eb8dce8dcc2eb9b51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
