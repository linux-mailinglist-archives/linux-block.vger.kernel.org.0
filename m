Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D641C0B1C
	for <lists+linux-block@lfdr.de>; Fri,  1 May 2020 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgD3XuQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Apr 2020 19:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgD3XuP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 19:50:15 -0400
Subject: Re: [git pull] device mapper fixes for 5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588290615;
        bh=Tbee2LGNa4XQ+SYM0tj1+E3eHiwkLMVKO4ZGYXMDXmk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ogG/KpvXyO5YvAWx+5sFOShpqmyHeIZtcldEAv8IZvsh05r0fXU0Uyx2q8Q60b5+i
         uZKHsCzfiXoP6iarKMem11hawGCmgW+wgp6+vRdOEhHiB2m+lHQO3Fk8Hd+qIQwk3E
         lMdgpbF2WW76xRIM3HzJDTDGLGjbDTOpH2S6eFoE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200430220735.GA30584@redhat.com>
References: <20200430220735.GA30584@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200430220735.GA30584@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
 tags/for-5.7/dm-fixes-2
X-PR-Tracked-Commit-Id: 5686dee34dbfe0238c0274e0454fa0174ac0a57a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c45e8bccecaf633480d378daff11e122dfd5e96d
Message-Id: <158829061518.2910.6523630144003020969.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Apr 2020 23:50:15 +0000
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Sunwook Eom <speed.eom@samsung.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 30 Apr 2020 18:07:36 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c45e8bccecaf633480d378daff11e122dfd5e96d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
