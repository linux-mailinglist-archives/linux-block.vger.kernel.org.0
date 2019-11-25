Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6881F1095A5
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfKYWpL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfKYWpL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:11 -0500
Subject: Re: [git pull] device mapper changes for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721910;
        bh=T5NUYv3Llr4HQeWpIrUzuyNt2O2vq4taQpk099t+AiM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wYtfLgCzc7mQuqvyn2dqS2culazBBjTY8bZsHz/8sXj7bqa0HGJQg7CB6uDgw/P47
         yjxf+BKBxE4lZehS9cuA+rAJOUGKW/B2cNteavLz4NbzxqnlHSoblv5glr+MbrNIg7
         XacGKWnNs6IIZ7A4Z2mDBXfzJBEY37j44HopI90M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191122153747.GA23143@redhat.com>
References: <20191122153747.GA23143@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191122153747.GA23143@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.5/dm-changes
X-PR-Tracked-Commit-Id: f612b2132db529feac4f965f28a1b9258ea7c22b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eeee2827ae75ca58a6965e1b6d208576a5a01920
Message-Id: <157472191073.22729.17157564640043635383.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:10 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maged Mokhtar <mmokhtar@petasan.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 10:37:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.5/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eeee2827ae75ca58a6965e1b6d208576a5a01920

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
