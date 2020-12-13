Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8552D903A
	for <lists+linux-block@lfdr.de>; Sun, 13 Dec 2020 20:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387779AbgLMTkA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 13 Dec 2020 14:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbgLMTjy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Dec 2020 14:39:54 -0500
Subject: Re: [GIT PULL v2] Final block fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607888350;
        bh=8veU1mzj8J8H9/62c/rakKCel5DwMBcfuTi0taasvhM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=efUHCHsywNqt9ohdcnCOfMygzKjhyoZWVIEFEYHNmwjKMUtJ+G2kONOyhbENgN8zF
         XZUTtvVu3XxMxJxeZ9jsZVguYXEOKy/h3ddfEq3K7AhynRdsK/wJ4g4JdXTDWr7oy4
         SyBNFMSMFEq5EEasK4UHsMOqp9hD2IclUCaN1YBr8/MUt0C0xSe4ivX+Q81gJrr+fS
         Np48r51dIRygv3ohcSmb9Mb+/jUz/4VLyJeccbF7EGsJCX0RK2xcYqokKxFON8uNeM
         58d1pLEDXd+3R68bB+wOaAjgFrN8grgFVEB1lnc4++jEESx+26L8SX2lqTv35bneiA
         1NElmQUwHm1WA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3cee02fb-ded4-e773-a0a2-a296397beff9@kernel.dk>
References: <3cee02fb-ded4-e773-a0a2-a296397beff9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <3cee02fb-ded4-e773-a0a2-a296397beff9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-12
X-PR-Tracked-Commit-Id: 6ffeb1c3f8226244c08105bcdbeecc04bad6b89a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2360a398f0b68722641c59aeb2623e79bd03e34
Message-Id: <160788835085.9552.9178220159884486423.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Dec 2020 19:39:10 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 12 Dec 2020 14:10:41 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2360a398f0b68722641c59aeb2623e79bd03e34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
