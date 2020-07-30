Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2CC23376A
	for <lists+linux-block@lfdr.de>; Thu, 30 Jul 2020 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgG3RKH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Jul 2020 13:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730222AbgG3RKG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 13:10:06 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596129006;
        bh=RDPQlNuidTgRt+shz3s3o92jVXmzWKckqHQHU1Imem0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LhDNqN+vmDRIjKN5fYXkbbnIWmYL5NI0YfbnyUobj5lPkrAQqdL2xtU3oC5MXQ8uS
         ADWqUjxDaopD/2OuLjMJmbn79kU2kCn9BvqJSQCjFGiZA4D2Z3L1mTGruJWWMpHOY2
         IVoCQ7t8HpxToZFm4DAw1NJh8+aqMXUpqjp6tZoI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fdd0107a-a9cf-b7c5-211c-78226f901bf5@kernel.dk>
References: <fdd0107a-a9cf-b7c5-211c-78226f901bf5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fdd0107a-a9cf-b7c5-211c-78226f901bf5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-30
X-PR-Tracked-Commit-Id: d6364a867ccbf34a6afe0d57721ff64aa43befcd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2c46b5762c616c249201688d3b9846627f78d2c
Message-Id: <159612900635.480.874665383766401167.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jul 2020 17:10:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 30 Jul 2020 09:20:10 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2c46b5762c616c249201688d3b9846627f78d2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
