Return-Path: <linux-block+bounces-14302-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D199D1CFB
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 02:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C120F1F20FD4
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2024 01:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A073451;
	Tue, 19 Nov 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP0muQXj"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0721A29A
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 01:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978586; cv=none; b=AQ3HFKdvdtCUY8EtUieI1Tc8oE7KgJoLNZlXf2PMJ6xg0e38iqMaA55/RiSvhvm7VjN5lK8I5LGUIZvke7ZeMqfEQWsDBgmdFICpZghUiTecrTiuS/RJM7FT+2wQyyllbzuuLLRVG8pX524TlijlP9k6e8kGQe/Ub5PHxrMZmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978586; c=relaxed/simple;
	bh=8EDc2GwUGXoY3fNRBC5wut1tw6A4VeUG1riGxBnBnfw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CwbcE3pQaafW6dUUU5miBA/kCPSdSPw2cTPCJyVJAA+g2VdfBD1jZ6iELmPVf5hDtqEboV25kITIhfkNJlLE9ugkIB30C8oBxCNZeZ00SVZPsHdGomRnlpuxM9+NeVpXvcem5rps/Kv7P2gtUflp9Tc8x/s/wkdPeF8gwSSYVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP0muQXj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C18C4CECF;
	Tue, 19 Nov 2024 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978586;
	bh=8EDc2GwUGXoY3fNRBC5wut1tw6A4VeUG1riGxBnBnfw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VP0muQXj6c2EUYeHZPikwz78qJbubtZegBGro48GL/SileDHfSJ+9bWe9b3AavGF2
	 Pcwo/u9Dk1gzBeXRzy+KURMIFTRbCspnz1jc+AeeN6kxJQJawXp2RGVYffjD76JA9Y
	 Y3iWWhEFSAFYv7TZQz+crqcvmWXWT6jrqBI14D1X9WwAy6Q6+LZt6ubZWfCPterj5J
	 IHw2UOcS7TKJH4gYe+4s5Dbh9thS8w3DbXwJp+KaACPdzCnxbARU2PzhSBplRrtmQn
	 SIy062wInldmkpC1IT5VFVe167pnCghJGkERPN4cizR02V3AGSMoX2CbIZv8vJZIqf
	 E7ipBSDY9733A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6C3809A80;
	Tue, 19 Nov 2024 01:09:59 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <968b578f-146c-4e94-a68e-e7451762a81a@kernel.dk>
References: <968b578f-146c-4e94-a68e-e7451762a81a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <968b578f-146c-4e94-a68e-e7451762a81a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.13/block-20241118
X-PR-Tracked-Commit-Id: 88d47f629313730f26a3b00224d1e1a5e3b7bb79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 77a0cfafa9af9c0d5b43534eb90d530c189edca1
Message-Id: <173197859826.48692.17565201871589682047.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 01:09:58 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 07:38:04 -0700:

> git://git.kernel.dk/linux.git tags/for-6.13/block-20241118

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/77a0cfafa9af9c0d5b43534eb90d530c189edca1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

