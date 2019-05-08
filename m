Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1904116F25
	for <lists+linux-block@lfdr.de>; Wed,  8 May 2019 04:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEHCkU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 May 2019 22:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:47420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfEHCkU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 May 2019 22:40:20 -0400
Subject: Re: [GIT PULL] libata changes for 5.2-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557283220;
        bh=6EvmA2e+hkv2nqfv+EYlBtCy2r10QjM2z/ZT80zQy04=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WE0z4lqjeI2lymwffeWq3eRITynnT6rpvKvwST3Eqn1K3tuHnSzFTpzFUbceRIUVw
         p8cBido5JwnYlTmzXszWR4GSKeaqFW9Zt/s3rT/zGjFTyuhx0MPhrGvhpws4U8YJ6U
         hca2mrCrZOlcCfa7wXP1MD/4oxJQ6P3IGEXwBQgg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4d9198b4-5b07-d63f-67f5-e34666b3b73a@kernel.dk>
References: <4d9198b4-5b07-d63f-67f5-e34666b3b73a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4d9198b4-5b07-d63f-67f5-e34666b3b73a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.2/libata-20190507
X-PR-Tracked-Commit-Id: a1d78317f84bf5b5ed3775b911a7dea344a884a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4eaa9efbf79ccf6dc9915a9623049ef341bba85
Message-Id: <155728322012.19924.15471348046680834538.pr-tracker-bot@kernel.org>
Date:   Wed, 08 May 2019 02:40:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 7 May 2019 15:14:07 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.2/libata-20190507

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4eaa9efbf79ccf6dc9915a9623049ef341bba85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
