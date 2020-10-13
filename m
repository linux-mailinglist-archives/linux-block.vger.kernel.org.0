Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C0928D4E5
	for <lists+linux-block@lfdr.de>; Tue, 13 Oct 2020 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgJMTrE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Oct 2020 15:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728137AbgJMTrE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Oct 2020 15:47:04 -0400
Subject: Re: [GIT PULL] Block updates for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602618424;
        bh=4dIZ7eXcUm0urn9NHEHVVh4pXuVNZRzLsRGYL3SOblU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IbnMgtj8e8WZr47g+wP0+q142TlkFl7PU5+aSjUYXUkVE5UJTo2arbRxRA72bWu6b
         b4xcRAqKJTtpG0/yUerEYcJ+OMYJ10o3r5Ot4pXawlxQK0RxmQ6QX9EN81VGYjrmba
         9kaHenB7dS+NgGZeog5CXG71pOz86LCsljS7d8mc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <deaa5b65-55f6-7ca5-e96c-9ea704c0eaee@kernel.dk>
References: <deaa5b65-55f6-7ca5-e96c-9ea704c0eaee@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <deaa5b65-55f6-7ca5-e96c-9ea704c0eaee@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-12
X-PR-Tracked-Commit-Id: 8858e8d98d5457ba23bcd0d99ce23e272b8b09a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ad11d7ac8872b1c8da54494721fad8907ee41f7
Message-Id: <160261842396.30654.15760396712505598036.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Oct 2020 19:47:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 07:40:45 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ad11d7ac8872b1c8da54494721fad8907ee41f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
