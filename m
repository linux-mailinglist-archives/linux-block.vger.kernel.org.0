Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8980658F6F
	for <lists+linux-block@lfdr.de>; Fri, 28 Jun 2019 02:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfF1AzG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 20:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfF1AzF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 20:55:05 -0400
Subject: Re: [git pull] device mapper fixes for 5.2 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561683304;
        bh=eRLiDsk6N9/Ctubwo2iaRw27RerVPb1neFpS+r8sr9o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fFysGFie5gWQ9SXfe0L+x8rJ5Zie9b8OzBmybtXaUaBxkLbt3gAyZbsUhRLdRzXpp
         FLoY+4nP6wnK7K+/hs1gIVJQDXGDLpWnIc6d7V2PfW5A9vHSDxnoe0aKE8199ZDyjP
         IIm40BMz1vcaZC71UkqH70vwjohydm4TQ3qZTQYE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190627181904.GA10850@redhat.com>
References: <20190627181904.GA10850@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190627181904.GA10850@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.2/dm-fixes-2
X-PR-Tracked-Commit-Id: 2eba4e640b2c4161e31ae20090a53ee02a518657
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 65ee21eb633c644501185502d51831c4dee22c7b
Message-Id: <156168330473.8716.11293425856375068132.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jun 2019 00:55:04 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        zhangyi <yi.zhang@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 27 Jun 2019 14:19:06 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/65ee21eb633c644501185502d51831c4dee22c7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
