Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A89B58FC
	for <lists+linux-block@lfdr.de>; Wed, 18 Sep 2019 02:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIRAZ0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 20:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfIRAZ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 20:25:26 -0400
Subject: Re: [GIT PULL] io_uring changes for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568766325;
        bh=cTHdtlxrkS03dvudDawB23hdp5gIYMcHzOD/8e3bkrI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JNdvFCsMtsM1c/3ojEbga7XN8FojHn2w9bCx3arAjT8EPuoUOD69D63UmNfspQyTV
         tjTnPZOjKksfJvp1u4qQtdkXiUAX4fqPo11iyZfjbWGSvQb0I2b/njWN21s+l2wp4j
         uLtXuifBdHeZy+Ir7kMUx6J8jpCL9vqpG1jnboGY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
References: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1559f166-52c3-532d-3523-d9b3e34a04b6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 for-5.4/io_uring-2019-09-15
X-PR-Tracked-Commit-Id: 5277deaab9f98229bdfb8d1e30019b6c25052708
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e6fa3a33e6dbe4f24bcc4690950f2888d4bed3a
Message-Id: <156876632546.801.1849322595314373988.pr-tracker-bot@kernel.org>
Date:   Wed, 18 Sep 2019 00:25:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sun, 15 Sep 2019 17:53:13 -0600:

> git://git.kernel.dk/linux-block.git for-5.4/io_uring-2019-09-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e6fa3a33e6dbe4f24bcc4690950f2888d4bed3a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
