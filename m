Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17D167C50
	for <lists+linux-block@lfdr.de>; Sun, 14 Jul 2019 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfGMWuX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 13 Jul 2019 18:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbfGMWuQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Jul 2019 18:50:16 -0400
Subject: Re: [git pull] device mapper changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563058216;
        bh=FfiFRhcVo3oHTyWaTbBKiAFRixfEwAnHsSXqaE/zfg4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HtPqjgxJKOeTRlynD8IH1QZE9q+GpmCLynhpJpOoxYgA1POv8NyvwGDMkmXPUIieK
         cXiJBZ6tMw251WjXErEqGqT3TFUrnnVlXjYtzAmb2fFzq/piNqle0z25gLB0dQtbLP
         MJ2GwLe9k68OJ8iRnryubCEDYaDHuGNk5vWQqckU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712190552.GA52544@lobo>
References: <20190712190552.GA52544@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712190552.GA52544@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.3/dm-changes
X-PR-Tracked-Commit-Id: bd293d071ffe65e645b4d8104f9d8fe15ea13862
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2260840592fbed5be98ca03c97eb8172941f27ac
Message-Id: <156305821635.12932.3973331384786871643.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 22:50:16 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Milan Broz <gmazyland@gmail.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Qu Wenruo <wqu@suse.com>,
        Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 12 Jul 2019 15:05:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2260840592fbed5be98ca03c97eb8172941f27ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
