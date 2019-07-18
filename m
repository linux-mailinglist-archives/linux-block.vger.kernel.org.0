Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 624E16D6BA
	for <lists+linux-block@lfdr.de>; Fri, 19 Jul 2019 00:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391500AbfGRWFT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jul 2019 18:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfGRWFT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 18:05:19 -0400
Subject: Re: [git pull] additional device mapper changes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563487518;
        bh=P0ndy0p1hlIc8sSMEbEgCp8ktb6klmENdbkEEh5PRRE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MVddz57AxG6TcKpsTfnKWJoVuWe8MVTwrLg8VYaAD/t5wjOAjl79Q7zA4JNjMBz8F
         NuDTSizUn21rHqtXY6QdqnZhz5BEPDfXXw/IbKfc5zmVBDExtcZp1jppT4KZ9QHdKX
         so6mQWisU+ayC2rC6JcSTv0qpC8G6mYmM9NBjMfc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190718205308.GA65274@lobo>
References: <20190718205308.GA65274@lobo>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190718205308.GA65274@lobo>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.3/dm-changes-2
X-PR-Tracked-Commit-Id: 733232f8c852bcc2ad6fc1db7f4c43eb01c7c217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3bfe1fc46794631366faa3ef075e1b0ff7ba120a
Message-Id: <156348751828.19422.13802747332217273278.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 22:05:18 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 16:53:08 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-changes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3bfe1fc46794631366faa3ef075e1b0ff7ba120a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
