Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DA3297E45
	for <lists+linux-block@lfdr.de>; Sat, 24 Oct 2020 21:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764247AbgJXTzT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 24 Oct 2020 15:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1764226AbgJXTzR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Oct 2020 15:55:17 -0400
Subject: Re: [GIT PULL] Block fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603569317;
        bh=NNWznkCUWpX7bwUDLkJO8Tv5f/le2kriYssXIlvWx0s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XM2JuQJEr926SJgoIp22Dowq+w4a5zuvBp4qMpVB3qFWwYeqpB+G9UoHtn42ugr4R
         xsplKI25jWZIqhEQtFsJsv5NVaAPFFccyLVP2lD54ieCXdUgoSaXGv25WjrrMDgB0p
         dh0olu226L4mPea96K2Nnn08NBk47kjocA6edGxI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
References: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <a73a849f-4818-e083-40f3-c61c662e76e9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-24
X-PR-Tracked-Commit-Id: 24f7bb8863eb63b97ff7a83e6dd0d188a1c0575e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d76913908102044f14381df865bb74df17a538cb
Message-Id: <160356931699.14356.13163200383284732113.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:55:16 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 09:13:36 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d76913908102044f14381df865bb74df17a538cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
