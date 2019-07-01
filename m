Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99D210FE
	for <lists+linux-block@lfdr.de>; Fri, 17 May 2019 01:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEPXZb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 May 2019 19:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbfEPXZb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 19:25:31 -0400
Subject: Re: [git pull v2] device mapper changes for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558049131;
        bh=8uRYp6pF0xgw/fgOpelAIxQ5hZa7qN5mdNQ2Ep68veo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=teBqSSkbmrH4af/C/VSfxKpbzcDXcDt5cVEyvgW5nxFPBW2tawt6bl349STGtqISL
         G0XjZZEDEOX3uNxZmVOYAMOlP5qRdf0FulduNz910U6mNF/NW7OBgU/Ldt2SMuUV3S
         qxXrIql6voLOafqE5KY2w0/k+l9NosG4x+0iiE9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190516143206.GA16368@lobo>
References: <20190513185948.GA26710@redhat.com> <20190516143206.GA16368@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190516143206.GA16368@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.2/dm-changes-v2
X-PR-Tracked-Commit-Id: 8454fca4f53bbe5e0a71613192674c8ce5c52318
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 311f71281ff4b24f86a39c60c959f485c68a6d36
Message-Id: <155804913094.14244.4308114344731796324.pr-tracker-bot@kernel.org>
Date:   Thu, 16 May 2019 23:25:30 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Helen Koike <helen.koike@collabora.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Martin Wilck <mwilck@suse.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Peng Wang <rocking@whu.edu.cn>,
        Sheetal Singala <2396sheetal@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>, Yufen Yu <yuyufen@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 10:32:07 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-changes-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/311f71281ff4b24f86a39c60c959f485c68a6d36

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
