Return-Path: <linux-block+bounces-7467-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBB68C7F2B
	for <lists+linux-block@lfdr.de>; Fri, 17 May 2024 02:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F6091C215E2
	for <lists+linux-block@lfdr.de>; Fri, 17 May 2024 00:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029938B;
	Fri, 17 May 2024 00:27:39 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645B384
	for <linux-block@vger.kernel.org>; Fri, 17 May 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905659; cv=none; b=gsZ6EKauLFUa+k+vwKFUcKFQeE8xwOncsHyPV+O0p1xAHpsnL8l01HabacSDZxflznKk4U/7NHklPDBF+uTvknxFNLIyWxaK9KN2pY3vKuNGOF/DlJ4iTcOOTvGb1IvEI8gHAxTAqwinElzeW3UHjcPfd21LQIZuIrmrPzcdZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905659; c=relaxed/simple;
	bh=8qFUR2iOKvNNFBqKCBKdFwMl9uNt7r1Sbz/DRwDBBSw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZPo9B5pGQkOFUYfEebP1+7D01Tz7AxKkNfz3QHtxFDxQSOJ4aAt/S0SEMRGcIslyVbLBEuo/Q8vEst7yyukPaBc8CjOEUenEVAga9zaQADz6Mlogpqe03DjGdrlssiuzkNi5MddxA6wSik+x1+0ou5JvhuA2LAgmW3c3Vc/rS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id E2CA084;
	Thu, 16 May 2024 17:20:20 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id k_2nIwCVhlUB; Thu, 16 May 2024 17:20:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id 9044440;
	Thu, 16 May 2024 17:20:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net 9044440
Date: Thu, 16 May 2024 17:18:17 -0700 (PDT)
From: Eric Wheeler <dm-devel@lists.ewheeler.net>
To: dm-devel@lists.linux.dev
cc: linux-block@vger.kernel.org
Subject: Kernel namespaces for device mapper targets and block devices?
Message-ID: <61c1fff7-b5ff-dfdd-62c1-506e055ae5e@ewheeler.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello everyone,

Is there any work being done on namespaces for device-mapper targets, or 
for the block layer in general? 

For example, namespaces could make `dmsetup table` or `losetup -a` see 
only devices mapped in that name space. I found this article from to 2013, 
but it is quite old:
	https://lwn.net/Articles/564854/

If you know any more recent work on the topic that I would be interested. 
Thank you for help!

--
Eric Wheeler

