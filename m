Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26D0E4D88B
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2019 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfFTS1O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jun 2019 14:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbfFTSFG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 14:05:06 -0400
Subject: Re: [GIT PULL] Block fixes for 5.2-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053905;
        bh=FGI3L8Iqv22dzrxTPINcfGYGkpOrT8bDmBGjduB/Tt0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nd1eZaquOBVs14wKg6PJ2MoLR/lilP14b4zq2Fw6HSgsVlr8rdg7D90OL7kkreSOv
         aY3LK2mOwGsa41R7Wx93fbMBDy8bsQ8mCN6Sy8O9mAugC2yPnWTmT6J/gMulcMj4eP
         vd1mmR4HM9/P3h7PPkHLoQDfHqSANBYkyNmHlXGA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fad0dd2d-9991-f993-a072-8eae509030a9@kernel.dk>
References: <fad0dd2d-9991-f993-a072-8eae509030a9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fad0dd2d-9991-f993-a072-8eae509030a9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190620
X-PR-Tracked-Commit-Id: 440078db7a5539b36bd780a826cb6e2cf2cce0d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41a247d896d20b2b7c73ec40523d7caf058c0698
Message-Id: <156105390579.28041.7702415594948418495.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Jun 2019 18:05:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 20 Jun 2019 03:24:48 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190620

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41a247d896d20b2b7c73ec40523d7caf058c0698

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
