Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9880292
	for <lists+linux-block@lfdr.de>; Sat,  3 Aug 2019 00:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437201AbfHBWKS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Aug 2019 18:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731120AbfHBWKO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Aug 2019 18:10:14 -0400
Subject: Re: [git pull] device mapper fixes for 5.3-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564783813;
        bh=C0wVo17fKYx2j3ao2c1BYC/5b/RvbXABwmmbVN+QdUc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=avAomMnpZnQsIIFF7r6kxdWlXpSmz/jcS+O+KZK/POzMxjYBWjfLmFgafaaEIG9ke
         gTzI8E8eCHXNpCx2Bn275iEOgbb0SX8UgoAoYjzpOlI21+IFMW0HjEN6WUJm4jpsay
         kaSRPmTv5uQu9xe6gK09qXlvXE9vSbjTWkj+jwFQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190802151824.GA86075@lobo>
References: <20190802151824.GA86075@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190802151824.GA86075@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.3/dm-fixes-1
X-PR-Tracked-Commit-Id: 9c50a98f55f4b123227eebb25009524d20bc4c2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c742373d19b356b112d9f3ca4e9377c6f9708d
Message-Id: <156478381353.28292.12883710388695934497.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Aug 2019 22:10:13 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Aug 2019 11:18:25 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c742373d19b356b112d9f3ca4e9377c6f9708d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
