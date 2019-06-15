Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39CF746DAA
	for <lists+linux-block@lfdr.de>; Sat, 15 Jun 2019 03:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFOBzJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jun 2019 21:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfFOBzI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 21:55:08 -0400
Subject: Re: [GIT PULL] Block fixes for 5.2-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560563707;
        bh=hV5Ba9cFDn50J6IafSCyXu9NofAKTcIjxW1IAHRPFQI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rqw6m2/8GkeXoVuWJSCrbx5Bb4mrA3/QMLQWTaFaNAvGo+NOPXrgrxRlXs6h0sZQH
         JvWRY+8d9X6NJOdcxRpBKdto9D20UQ/Mi3oxERk2XbijYDMDzX1W184DoCktL1CTUL
         esNLCti3seGS4NwSXIDFMOjTIGt+aXSc48Jh/Kmg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <8247d8ee-9fce-6824-3a3e-886b0023bdc4@kernel.dk>
References: <8247d8ee-9fce-6824-3a3e-886b0023bdc4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8247d8ee-9fce-6824-3a3e-886b0023bdc4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190614
X-PR-Tracked-Commit-Id: 1d0c06513bd44e724f572ef9c932d0c889d183c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b10315128c697b32c3a920cd79a8301c7466637
Message-Id: <156056370788.9443.8578524705622470302.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 01:55:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 10:44:42 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190614

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b10315128c697b32c3a920cd79a8301c7466637

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
