Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140D23CED1
	for <lists+linux-block@lfdr.de>; Wed,  5 Aug 2020 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHETG1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Aug 2020 15:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgHETFR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Aug 2020 15:05:17 -0400
Subject: Re: [GIT PULL] Block driver changes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596652777;
        bh=HFxtcAPL1imynQdnin6ID6igYR5zuKIUXeYA6zlXDYc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1KDWBXk7WETdHePw2rbF+TH1sCH18cWHRuBmx+tTGo0VArMlDm2Pvb2p5pJ2XPy8k
         OzjGNKwg/AZ0aJIYl2bw8cpEQthJkHtVzw3e3FftijbdannEab8D5i5nlkYIoMLVsj
         AU3FZdUSa91udG+mUMwXA6XvJPN/Hlp6cnyR3AWU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
References: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.9/drivers-20200803
X-PR-Tracked-Commit-Id: f59589fc89665102923725e80e12f782d5f74f67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0fc99e21e6e299673f1640105ac0c1d829c2d93
Message-Id: <159665277762.15741.17973504387506488399.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 18:39:37 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 4 Aug 2020 09:39:19 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.9/drivers-20200803

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0fc99e21e6e299673f1640105ac0c1d829c2d93

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
