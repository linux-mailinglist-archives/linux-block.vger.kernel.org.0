Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FA153F9F
	for <lists+linux-block@lfdr.de>; Thu,  6 Feb 2020 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFIAW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Feb 2020 03:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgBFIAW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Feb 2020 03:00:22 -0500
Subject: Re: [GIT PULL] Block changes for 5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580976021;
        bh=YcHNldVLvayhcvNDURkQWNfCMhGb3j4FruOVgm791+A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=RA+sWnqOP864ZCf6wJLSufThXkPNXlDqoB3gkMkwuahkgmlZQIkUg8ywlSv6BWaGE
         +5nJ0bkd546sAswbqoL2QYD4r2HHvvuaObfMDPW9ksOwhp5tvsRfIv7AHa+0hmFklX
         QkCkpdy3gur2VpEobHn77qD0uQcSXMkZNRPzMVJo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <46878e95-2ae8-e05d-416c-237df0c1f62f@kernel.dk>
References: <46878e95-2ae8-e05d-416c-237df0c1f62f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <46878e95-2ae8-e05d-416c-237df0c1f62f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.6-2020-02-05
X-PR-Tracked-Commit-Id: b74e58cd472cb782d34ecfad553c12c66eb02b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed535f2c9e00eafdeb57d6310b7c8c5a009a9262
Message-Id: <158097602154.20426.12599813903481105853.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Feb 2020 08:00:21 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 5 Feb 2020 14:21:59 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.6-2020-02-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed535f2c9e00eafdeb57d6310b7c8c5a009a9262

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
