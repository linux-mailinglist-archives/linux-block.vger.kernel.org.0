Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F3F3FCFAC
	for <lists+linux-block@lfdr.de>; Wed,  1 Sep 2021 00:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240604AbhHaWum (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Aug 2021 18:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240492AbhHaWuk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 18:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A210B610A2;
        Tue, 31 Aug 2021 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450184;
        bh=Li+/OY2/JxNT3svnasSUp9RCaY8cReM7pAD+dQdzN30=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AvDE9XN5LaUDeJ1tMHINYdsIkEbvNU2bsfOlLnmPw05RJnvQN2YwDzNApxBlhzIR6
         KTT0q6yuvpkgMnv3OrriVTLGngIQTFc/Zxre2JOK1/sOw5aYcHil4SOv7BD50pq2bD
         BTcxuJJRHNBAfMTyof8TnpvTbSNNshCXhj6ayTzwH/BOwxLIBcEH+d8uHBFb7JQSKB
         CcqxDgNlLcr50VEawZMFcyiqmgUVecKMzFOR/4lwSW4VjdWNgALzdflSxuOqDVf+11
         wPk2EDZ8XDT2WNuhEat/7Cepwkdi41APmo/scg4OPvv5WIkIKsgcyM9sPnkDoe2mkD
         YPxx1PcfwY9kw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C87560A6C;
        Tue, 31 Aug 2021 22:49:44 +0000 (UTC)
Subject: Re: [git pull] device mapper changes for 5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS5aLC4FSqL31PLI@redhat.com>
References: <YS5aLC4FSqL31PLI@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS5aLC4FSqL31PLI@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-changes
X-PR-Tracked-Commit-Id: d3703ef331297b6daa97f5228cbe2a657d0cfd21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efa916af13206eb15916e102c45c99a13ea78f33
Message-Id: <163045018463.32002.7512936844641360922.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 22:49:44 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Arne Welzel <arne.welzel@corelight.com>,
        Changbin Du <changbin.du@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 12:34:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.15/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efa916af13206eb15916e102c45c99a13ea78f33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
