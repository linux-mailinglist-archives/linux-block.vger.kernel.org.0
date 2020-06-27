Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A916320C2F3
	for <lists+linux-block@lfdr.de>; Sat, 27 Jun 2020 18:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgF0QFT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 27 Jun 2020 12:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgF0QFO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jun 2020 12:05:14 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593273914;
        bh=RXjOJJNfGZe1cP0tiv75Xkj+y2X+09uWQD1BaaIRnp4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2a2IyRpH7Cuu+tZTFdCt/vATjrPoitiTn+mb5MFEmNma9QlYMaixcPUSKA8iVqe7d
         O6ho3TRBMaNSRr8beBX9CIqTydcIhHrdnxEZcUXasFM5NM5czrznD9FzRJqwamReVA
         FNY7M3z5dct2QmvubkTESjtWq2zam9O1bQKx64A4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cb6043bd-9ab0-0d3f-af78-cf9b72f10b20@kernel.dk>
References: <cb6043bd-9ab0-0d3f-af78-cf9b72f10b20@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cb6043bd-9ab0-0d3f-af78-cf9b72f10b20@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-06-26
X-PR-Tracked-Commit-Id: 1b52671d79c4b9fdc91a85f99f69b7c91a3b1b71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b8d02079643b55343b41fb07ce7eb3d25472ce5
Message-Id: <159327391400.13835.12636012272413114200.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 16:05:14 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Jun 2020 13:40:46 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-06-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b8d02079643b55343b41fb07ce7eb3d25472ce5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
