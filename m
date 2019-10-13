Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68F6FD56C7
	for <lists+linux-block@lfdr.de>; Sun, 13 Oct 2019 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbfJMQPI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 13 Oct 2019 12:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbfJMQPI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Oct 2019 12:15:08 -0400
Subject: Re: [GIT PULL] Single io_uring fix for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570983307;
        bh=l6XBWXor6bHxq5/+kJEol0LfgCMDffGfyLDqJaxCZdo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zppTZiqgYVf4MWpGfgQxmAu38IPg0TzH0RQo6OZDQhyO6XAG3/ibX9e18toInvP21
         bjpPFFnCEMIfZByuy7qcyc4KyZqBKsHlBdV6lf+iwaeGsRp1vi7bSW3ehIGdK4QCHD
         NQYLS7dy0OjXlhzxFN5EbyEc8TBBq9c48XJWf8No=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
References: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5d635c9a-7373-2a12-2a0d-e94806c2c114@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191012
X-PR-Tracked-Commit-Id: 7adf4eaf60f3d8c3584bed51fe7066d4dfc2cbe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b27528b0279a84d889d40cb1b61962c8562cebb4
Message-Id: <157098330772.26372.7926616565615119046.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Oct 2019 16:15:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 12 Oct 2019 11:03:03 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191012

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b27528b0279a84d889d40cb1b61962c8562cebb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
