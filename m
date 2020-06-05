Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A58B1F0368
	for <lists+linux-block@lfdr.de>; Sat,  6 Jun 2020 01:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgFEXPU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Jun 2020 19:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgFEXPT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 19:15:19 -0400
Subject: Re: [git pull v2] device mapper changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591398919;
        bh=Hx9Lqe52dmWcYZwruCnYgyjNrNw+D+fuPK+l/lRXEl0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sXgk1GTCunNZhEPa9DOKeULMewqiWYRGlMVKAbn3/88BJLsoiJPBp/0rDRD4BV8Xc
         XLzTBXRcS+tablLAIP14/gd50D+uHnY/WfBjyyOf38UKgW82/T6hp3QBDJ6Y3KCMrG
         9R2z+pY9k/ukK39CyL5Mr9Triq/tLFH/33psgINM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605191613.GA621@redhat.com>
References: <20200605145124.GA31972@redhat.com>
 <20200605191613.GA621@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605191613.GA621@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.8/dm-changes
X-PR-Tracked-Commit-Id: 64611a15ca9da91ff532982429c44686f4593b5f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b25c6644bfd3affd7d0127ce95c5c96c155a7515
Message-Id: <159139891929.4436.16769068315334032119.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 23:15:19 +0000
To:     Mike Snitzer <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Dmitry Baryshkov <dmitry_baryshkov@mentor.com>,
        Eric Biggers <ebiggers@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Hannes Reinecke <hare@suse.de>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        Martin Wilck <mwilck@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 15:16:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b25c6644bfd3affd7d0127ce95c5c96c155a7515

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
