Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362C91CCD53
	for <lists+linux-block@lfdr.de>; Sun, 10 May 2020 21:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgEJTpH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 10 May 2020 15:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgEJTpG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 May 2020 15:45:06 -0400
Subject: Re: [GIT PULL v2] Block fixes for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589139905;
        bh=w/ND34oJzDK32eZMi+NKlKDwwA1JL0hfWyiC5efb6WU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gOAnY0sRsXnY/n54sbQmw2phLmEjBSH45w7q64bQG7qngQEGdqK7mxL/qYuxNuIYb
         NYvnY7c20N9WAmktZZBFSMrCUqWLbUeWSlYLiwO2Rn0bUXPi+ckn75giFc0cp8A3kI
         2VtxSS51jYq5L0Lld0aHNJwniVEzbFQkujzBNXo8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
References: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <98383cfe-ef17-45f3-a799-9eff8fc0f2fd@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-05-09
X-PR-Tracked-Commit-Id: 59c7c3caaaf8750df4ec3255082f15eb4e371514
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a85ed6e7fce8075bb3090f8eac05ca1000f5969
Message-Id: <158913990587.3456.8851887508779977173.pr-tracker-bot@kernel.org>
Date:   Sun, 10 May 2020 19:45:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 9 May 2020 19:33:19 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-05-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a85ed6e7fce8075bb3090f8eac05ca1000f5969

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
