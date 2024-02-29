Return-Path: <linux-block+bounces-3865-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347FF86CFE5
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C444C1F22B75
	for <lists+linux-block@lfdr.de>; Thu, 29 Feb 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE76CBF2;
	Thu, 29 Feb 2024 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xvb1sr0+"
X-Original-To: linux-block@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AB16065D
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225676; cv=none; b=D4lP1xGG54HB7WT2qOdAJVdHmcZoSlIpO1xsNuAKyJxPstQ3AaqOPyu/zUjC/ZZIIM9uUmm0rhGA71ZTChpZwmtqml1MjIwIZUuPibtCu6Et3r4XLW4KMrhNs/sw6AZLeCrcmJ/9/4mjnOxBevuBZgOl3pVGLWJqLTjCZmvJK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225676; c=relaxed/simple;
	bh=e6vmTGem8oV8nJ/WvMjpV0MJ4Xq6I1PYHVShbuzpde4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=HzYbXCfSpZUaPsm1ftPIQHUeqS7EWhrBMhPx/vnoJkiOycTXrE9GIlJhBranNupalVaaiXt6RNdcwQkDggApTuKGkM1BFgqO0+TZVB1uzVQC/lEXAadv92wNK2DiE8My3ymyFSX9dRU3yrdX5Hl3tDCuBBvd4iYWgl75CRxUK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xvb1sr0+; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <639b5125-f597-83a7-01dd-d92b5fc53061@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709225672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f8YXqcEgWL1IE93kMEJy4Tz/CTAqPh4sqws3O+ADWu8=;
	b=xvb1sr0+oVb5sFfomf5Js49Ox7RYYU2kscDCU90u/BeBwTYFxm1lWpgm2w4NR+a9U4QllT
	zxCtmtfZROwmqMU0m5R7NlpMyealUcEL6uqnASDN8JV6TkshvFbfenSAwuOe8jFgfsJfiL
	dGpPlWiaHyDpc36BgVXUT4iuM66pj/Q=
Date: Fri, 1 Mar 2024 00:54:01 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
Subject: Missing S: in the "CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)"
 entry?
To: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Running

# ./scripts/get_maintainer.pl -f block/blk-cgroup.c
Tejun Heo <tj@kernel.org> (unknown:CONTROL GROUP - BLOCK IO CONTROLLER 
(BLKIO))
Josef Bacik <josef@toxicpanda.com> (unknown:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
Jens Axboe <axboe@kernel.dk> (unknown:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
cgroups@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO CONTROLLER 
(BLKIO))
linux-block@vger.kernel.org (open list:CONTROL GROUP - BLOCK IO 
CONTROLLER (BLKIO))
linux-kernel@vger.kernel.org (open list)

shows "unknown" instead of "maintainer" or "supporter".  Is it
intentional?

