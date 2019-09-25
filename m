Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337B5BD5AE
	for <lists+linux-block@lfdr.de>; Wed, 25 Sep 2019 02:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfIYAFd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 24 Sep 2019 20:05:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfIYAFd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 20:05:33 -0400
Subject: Re: [GIT PULL] Block bits for 5.4-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569369932;
        bh=fJnURCYQMHv3glmQV+jOvY8PTp0MbyjQnNcJ+i2O1ww=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KABTpWuwFqYi0Y6aZzztwX5FGkzhxmv91hcAw/r1IMzyz2cfYtdKzH4jaJM+eVgMo
         cWtZ1ayxz8E9a6jm776sqnNdM1C+YPKrXtkFyHAW8wQKUZ/opEz/J18ZAgBhJvqfln
         9o8/SAKopdyZhVcT0IAF6JREiXrZ1gZdBYqL86ss=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b1a3b9fe-7e66-4275-2a84-da70a4580637@kernel.dk>
References: <b1a3b9fe-7e66-4275-2a84-da70a4580637@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b1a3b9fe-7e66-4275-2a84-da70a4580637@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.4/post-2019-09-24
X-PR-Tracked-Commit-Id: d46fe2cb2dce7f5038473b5859e03f5e16b7428e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e959dd87a9f58f1ad824d830e06388c9e328239
Message-Id: <156936993293.955.6892909401916004318.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Sep 2019 00:05:32 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 24 Sep 2019 12:45:23 +0200:

> git://git.kernel.dk/linux-block.git tags/for-5.4/post-2019-09-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e959dd87a9f58f1ad824d830e06388c9e328239

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
