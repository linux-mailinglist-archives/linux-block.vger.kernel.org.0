Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCB834294B
	for <lists+linux-block@lfdr.de>; Sat, 20 Mar 2021 01:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCTAJi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 Mar 2021 20:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCTAJV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 20:09:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 725DD6198C;
        Sat, 20 Mar 2021 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616198961;
        bh=+DopkhZKdTNvYK7z4/LO7zy/9JKck6Xvf/n2xN+k+DY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sM1BROgEQxK0GAdNF1SqZndhgLOVLHmnhYV2kVJ9SH6SWOeC53k0+QffvJFRI6+Tc
         WJcAx1UHD5Ji6frrA9wHuWDzuAnrvtGhkwyVS4HK+Dw8EyeehKCGCfz/0lcEyN+wra
         ZY/RgyrJe/FtrCAlSorGCi0uSu+T9CgzwSqauAs+a4SAPlxfmZCa6pw1f7NHUdmhou
         LHOY5LB6k2NtrTY26nma8qilJQZIlYdIRJj/4IAOjsNxiBtbBFoKey6w671N2HMOtv
         OGKKh1BD6SYU2Q38MkmraGPB/aL7o1LH6fuGNAFvKZAY8fD/gqvX39vDl6NgjeUgVy
         OR1ev5f62onuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6E62360A0B;
        Sat, 20 Mar 2021 00:09:21 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d68738f1-c8c7-c0ee-9d04-1e9d913fd742@kernel.dk>
References: <d68738f1-c8c7-c0ee-9d04-1e9d913fd742@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d68738f1-c8c7-c0ee-9d04-1e9d913fd742@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-19
X-PR-Tracked-Commit-Id: d38b4d289486daee01c1fdf056b46b7cdfe72e9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d626c692aaeb2ff839bfe463f096660c39a6d1eb
Message-Id: <161619896144.24257.13797506553779355789.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Mar 2021 00:09:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 19 Mar 2021 16:31:00 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-03-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d626c692aaeb2ff839bfe463f096660c39a6d1eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
