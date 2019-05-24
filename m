Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 195892A17D
	for <lists+linux-block@lfdr.de>; Sat, 25 May 2019 01:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfEXXP1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 May 2019 19:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfEXXP0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 19:15:26 -0400
Subject: Re: [GIT PULL] Block fixes for 5.2-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558739726;
        bh=tEzl916REZjAttWPWMAk742VBCxnkwwDzEiAXSnNY9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KIr9WnCbRe8eVJI5jTUqUzqj/ql7GWm4CWFvQ63yKgLhw4FmdtG4dm52PZPXbu5rE
         HvRRI2qA0KvGheRiO+NQfQB85FNzAipNpWEQWH5ZRDhGFOlrte7QFD2rqZgnavhPxO
         3FF/XkKMWtA+CvoyMccXNZCFQ+CSBNzGnRYYQ1Bk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <75a2e13c-1e40-6e36-393c-97383eb945f3@kernel.dk>
References: <75a2e13c-1e40-6e36-393c-97383eb945f3@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <75a2e13c-1e40-6e36-393c-97383eb945f3@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190524
X-PR-Tracked-Commit-Id: 096c7a6d90082586ff265d99e8e4a052dee3a403
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fbc78e3155a0c464bd832efc07fb3c2355fe9bd
Message-Id: <155873972642.4676.15031588508911217261.pr-tracker-bot@kernel.org>
Date:   Fri, 24 May 2019 23:15:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 May 2019 16:19:10 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190524

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fbc78e3155a0c464bd832efc07fb3c2355fe9bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
