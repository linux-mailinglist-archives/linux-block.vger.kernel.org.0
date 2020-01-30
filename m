Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64AE914D584
	for <lists+linux-block@lfdr.de>; Thu, 30 Jan 2020 05:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbgA3EPM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jan 2020 23:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:45694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgA3EPL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jan 2020 23:15:11 -0500
Subject: Re: [git pull] device mapper changes for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580357711;
        bh=HwiiqARjoKZmkqiQs2KmY3uhpxXOAVWnArAIic5cM94=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ay4QpQQkQLmC22WQxQElBS2mUmjAE5bhicaRwDURSRPNokbfoFjMzXtr0+h08Zy29
         +qvqLUksAXxKb+0HqLexKqwLa/rV9qzio5IrJ9f6TeMwFx9Lw4Q1k8w18bwr9PaFEo
         M9sFHL9a9bBGtDqkEfD+29SxDyMnvtwf7u2yxpGo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200129171703.GA26110@redhat.com>
References: <20200129171703.GA26110@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200129171703.GA26110@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.6/dm-changes
X-PR-Tracked-Commit-Id: 47ace7e012b9f7ad71d43ac9063d335ea3d6820b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9f8ca0ae7b7bc9a032b429929431c626a69dd5e
Message-Id: <158035771095.9636.946294396868543275.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jan 2020 04:15:10 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Anatol Pomazau <anatol@google.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        "xianrong.zhou" <xianrong.zhou@transsion.com>,
        zhengbin <zhengbin13@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 29 Jan 2020 12:17:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.6/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9f8ca0ae7b7bc9a032b429929431c626a69dd5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
