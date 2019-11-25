Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B551095A6
	for <lists+linux-block@lfdr.de>; Mon, 25 Nov 2019 23:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfKYWpM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Nov 2019 17:45:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727812AbfKYWpL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 17:45:11 -0500
Subject: Re: [GIT PULL] Zoned block device changes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574721911;
        bh=e5wJxnRt7ZxAEUMJmY5JVQOja/TfKxIav9YBbl3fljw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dhMASz1yH9mRVAq0oe0POkF8OIqaPDgQD3TFrJ+Z8w6hWS2H32xVRt6ohZrTVyYfn
         X22OGKGCLfUm1JHGaZH1jr5ZEPoPCK0O+Mhs6h+gdaS05u5H8RTofFJj3ZVxDhx03E
         4Sypg2TzLqLyL6BQNfH25jFTjfvLUetglfm4FL/4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <104ef28e-3b71-ead9-60ea-13fff988b919@kernel.dk>
References: <104ef28e-3b71-ead9-60ea-13fff988b919@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <104ef28e-3b71-ead9-60ea-13fff988b919@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.5/zoned-20191122
X-PR-Tracked-Commit-Id: a468168130ec1a3245812f2c713be97081149ca2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 464a47f45d2ae2db859f0e7c128b5f01aff19a53
Message-Id: <157472191156.22729.4063530783106330073.pr-tracker-bot@kernel.org>
Date:   Mon, 25 Nov 2019 22:45:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 22 Nov 2019 08:49:03 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.5/zoned-20191122

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/464a47f45d2ae2db859f0e7c128b5f01aff19a53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
