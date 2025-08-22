Return-Path: <linux-block+bounces-26114-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA8B31A0D
	for <lists+linux-block@lfdr.de>; Fri, 22 Aug 2025 15:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A217642390
	for <lists+linux-block@lfdr.de>; Fri, 22 Aug 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB1231353A;
	Fri, 22 Aug 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+txNMt/"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05730E853
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869794; cv=none; b=LSpuFOvlC8ZymnAmbk/KTuILIILsriMoDTZpQKcf0fqYbrk1NDG1AgXF6Ee3gHr9SemMnRSPVBpho3abmL2YCmWSkUS9uv2SRi596Qk7DQMpPMBo12+EMQ5l3i+GHMTpQfwASfa95Ri9wsk0TUv/yjPAbLFUmC/z4+Cy1jL9eFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869794; c=relaxed/simple;
	bh=u36tcjq1n/R5K6SY7c8IWVEU3aujyptCtZTOzTq8TgM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ur6Gh2sZKwnO3c/gzwVCYuj+vU6tOOniAXw0pgRBuWGw7Ju1UsHnQ+E9d/YrMIRhi0xpzynV5Vc31tqRFFmS3tP6H59pydzkZfkH99IQErTzPAopRkcsWuVAOVzhEjm5A9Z99n9RvUNp4UxHWkBMNh5Nfxkyby/dDVDxxihrnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+txNMt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA11C4CEED;
	Fri, 22 Aug 2025 13:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869794;
	bh=u36tcjq1n/R5K6SY7c8IWVEU3aujyptCtZTOzTq8TgM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=C+txNMt/sQYcopGEIeXNdmw7oyPXwUqfk4f/MFHllOrZn+6s98+kIm50MZwFh3P8I
	 edy/iv6MHNkwKgX3z2YaCaAYuWidFntP5MWwXs3G5rbwr+epPEUHY730FID1ckASOT
	 QYNH93TkXI9ULhUoLiLzrxOiUkuLGFhNZ0z6LR97HhzT0OLsvYHyS/GjO0zj9FYb85
	 pCcKa7Mfw1M9mCdZ+wgpKp225/xAlqXBJOKlFiWhmWhKahsFFGvo9XNtUodO5e/ZBm
	 Soo4DFnADUy1ANV4a4DVZs3+rw81lHK/wBVQ3rLJlQdvelb0HmCblmjh9xED8oTGIX
	 88lpgsXvbv7Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD83383BF6A;
	Fri, 22 Aug 2025 13:36:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <4761fdaa-c939-4150-9189-bb14ffbe6978@kernel.dk>
References: <4761fdaa-c939-4150-9189-bb14ffbe6978@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <4761fdaa-c939-4150-9189-bb14ffbe6978@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.17-20250822
X-PR-Tracked-Commit-Id: 370ac285f23aecae40600851fb4a1a9e75e50973
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a2e94e80790bb103ca72f8a2991f43c80474a4b6
Message-Id: <175586980329.1831455.4178692814833792238.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:43 +0000
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 07:22:38 -0600:

> git://git.kernel.dk/linux.git tags/block-6.17-20250822

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a2e94e80790bb103ca72f8a2991f43c80474a4b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

