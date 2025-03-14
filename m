Return-Path: <linux-block+bounces-18450-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA47BA61E3D
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 22:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DBB8816F3
	for <lists+linux-block@lfdr.de>; Fri, 14 Mar 2025 21:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0938319049B;
	Fri, 14 Mar 2025 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyufX0Is"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905E1DFED
	for <linux-block@vger.kernel.org>; Fri, 14 Mar 2025 21:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988136; cv=none; b=aAIwjk5zWJedYgMXxK0FmrLaX5HS+2ubwzpAefLxqM+7KTbMXA+yH64oArlDRM/KLuO8IQJwz9na8+d6GQ6JsmWTIcnT9EhRYdSjOGWwphPSWqTOpZxNot/Q0BDkE29ATAMwZFe1iT3x6iidFytDMEzBkKLg+/sLwy+NQSBqb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988136; c=relaxed/simple;
	bh=PyYoMRWjoahzXkxt6bQ7fEMvezc6GBbEegyWK0SyLUw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Eu2s0J0+18D+mj2e2ySfHxiIL7bP8Zb7SIFoX5tDYEmHU8t8E7Evf3rKxaIAEJhMJAkFjMuJWIK2Ov10fRqDxQYGEfgqMDeXmG3kSK8CsCoFSXVCS9V2YhlFZi9qWSStqyFkkSfhL4Tj1YOaCQBO+HigFKX8XCnMa/3neHF5VMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyufX0Is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B6BC4CEE3;
	Fri, 14 Mar 2025 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988136;
	bh=PyYoMRWjoahzXkxt6bQ7fEMvezc6GBbEegyWK0SyLUw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nyufX0IsvYsFTrD7BxF0NnCJrdk40lKlMIAsVRLcFmovsTTqjgupBHQfCJouUb1Wd
	 vt3Mzf0OELhSJxp3UvImQGGBVnifwgn79e9YmGLrWfw5FUE6AdPWz/k/RDun3mhhqc
	 7LEoYVa/c17yDfuXtDkLnNl/c2Fv9g/nnG4bs5c4QjajizqcxOfvaH3OErge2zWmxv
	 54CKfEBTgl6LkpaJE7ppwaOHNqT7ffyzDc8iU0KpWAdr3PjukxxIl8Jg7VqK7SjHAC
	 8gDKGqodGjPxWexrDyuylStqHu3HakVhFNGEMLsNzT4uF7656dFMX3H39VrpJj8OLn
	 a42VfqZLmu/ZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE36A380CEE2;
	Fri, 14 Mar 2025 21:36:12 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.14-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <8bb4ab47-d557-4017-ba70-308ad3251c94@kernel.dk>
References: <8bb4ab47-d557-4017-ba70-308ad3251c94@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <8bb4ab47-d557-4017-ba70-308ad3251c94@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.14-20250313
X-PR-Tracked-Commit-Id: a9381351dd6c52bf465233cae5f50da227834607
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 580b2032359d978418e5f7178511aef512229345
Message-Id: <174198817143.2391063.11136180776055410478.pr-tracker-bot@kernel.org>
Date: Fri, 14 Mar 2025 21:36:11 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Mar 2025 08:53:20 -0600:

> git://git.kernel.dk/linux.git tags/block-6.14-20250313

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/580b2032359d978418e5f7178511aef512229345

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

