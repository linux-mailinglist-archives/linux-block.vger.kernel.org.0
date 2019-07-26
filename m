Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91DE87713A
	for <lists+linux-block@lfdr.de>; Fri, 26 Jul 2019 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387549AbfGZSZe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jul 2019 14:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387458AbfGZSZd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 14:25:33 -0400
Subject: Re: [GIT PULL] Block fixes for 5.3-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564165532;
        bh=HAtGwrtSsGDOs8POStUOgbgxktkPRyynPVvg6wwDoAc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0TYjC2Z9M6vxHypnFNQVKqfp/QLWJl7zEnYu3kgbf/uoHKw7SEFVVo1MAKHdpH30E
         ungbxJ4PNJZso6rCq6sKu1mfmxUzUSCvJGP2Hl2mUcl9qTXle+yFIRChm+P0tB4W+b
         alp30GKrYqM5LkjIhXC6+oVchH7bguPgxD4oKH8k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
References: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b22063e-660c-a238-f109-fcf3f1b888b5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190726
X-PR-Tracked-Commit-Id: 9c0b2596f2ac30967af0b8bb9f038b65926a6f00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 04412819652fe30f900d11e96c67b4adfdf17f6b
Message-Id: <156416553289.19332.3924118421674813735.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Jul 2019 18:25:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 09:12:42 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190726

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/04412819652fe30f900d11e96c67b4adfdf17f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
