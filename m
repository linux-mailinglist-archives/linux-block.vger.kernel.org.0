Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2742669B7
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgIKUpa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Sep 2020 16:45:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgIKUpX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 16:45:23 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599857122;
        bh=ovvdiB2z/y63fvnbSeW9SrOJqlDhDdnsl+bZo9gwl3o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sc+w1fpgPE2QjGESX9Peq1ow4yZSfHKRPkxDI+a8Xlx7w0sNzAvlMtVxh5B/5V5YA
         f/ukp8QQnol9bIE8LpiuobP87+nt1plEvC8F654eZKlAIoPOXX/5wLwXGKDgERAxyU
         uXT2Fxqn6P751XksSs0jO1aP5rWErvd0UHAdmF6E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <21cdf16d-2303-2eb7-c79b-21f75a268c43@kernel.dk>
References: <21cdf16d-2303-2eb7-c79b-21f75a268c43@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <21cdf16d-2303-2eb7-c79b-21f75a268c43@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-11
X-PR-Tracked-Commit-Id: fd04358e0196fe3b7b44c69b755c7fc329360829
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b8731d9589d569912d6418213890963f1b32e40
Message-Id: <159985712253.5364.12049631536411232400.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Sep 2020 20:45:22 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 11 Sep 2020 10:10:12 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b8731d9589d569912d6418213890963f1b32e40

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
