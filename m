Return-Path: <linux-block+bounces-23117-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81216AE65AC
	for <lists+linux-block@lfdr.de>; Tue, 24 Jun 2025 14:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAE13A3F87
	for <lists+linux-block@lfdr.de>; Tue, 24 Jun 2025 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E516B28A411;
	Tue, 24 Jun 2025 12:56:20 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from iris.vrvis.at (iris.vrvis.at [92.60.8.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80127C16A;
	Tue, 24 Jun 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.60.8.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769780; cv=none; b=gZ5jxMK0gXRiyzyCdbUw1Ok0U/uVNsh6FxiLhs9I5teAzP46WEjvBbTgMc9T58EgN2OQ3RfryBG0J0oz3hDYJaWsCZOvDbTnuW2tjkAOns8duLDDDhpl+OgnEqGi5aXglCRXdCJEIKUlNlrwB5RkatVmRfxQnjSuUP43DpyZB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769780; c=relaxed/simple;
	bh=G/nDuPf4Gl3F1VeBjjLGf468q9v5be0mA5063UAQuy0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Content-Type:Subject; b=V4OqZfwJ3iSvlCUcOPPYykskJlLhygBKUlJPgZL9uH500l7N7YRt9ZaRbf29GG+bMvv8Mb7VdXMWvWHVmO/JQLBTfZewgLnSYLE9b/qemRINoBl4GiAOpNe6CpKwXxTZUre5ta8I5Xo3u2+3XmS9TTRpJHjJtyLhaYWN9vhgJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at; spf=pass smtp.mailfrom=vrvis.at; arc=none smtp.client-ip=92.60.8.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrvis.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrvis.at
Received: from whiskey.org.vrvis.lan ([10.42.2.171])
	by iris.vrvis.at with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(ESMPT Server)
	(envelope-from <valentin@vrvis.at>)
	id 1uU3Bu-0007mE-27;
	Tue, 24 Jun 2025 14:56:03 +0200
Message-ID: <7915e7a7-cc01-40e3-9807-2488b6b5db92@vrvis.at>
Date: Tue, 24 Jun 2025 14:55:58 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Valentin Kleibel <valentin@vrvis.at>
Content-Language: en-US, de-AT-frami
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Justin Sanders <justin@coraid.com>,
 Justin Sanders <jsanders.devel@gmail.com>
Cc: ed.cashin@acm.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -4.5 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]
	* -0.1 GREYLIST_ISWHITE The incoming server has been whitelisted for this
	*      receipient and sender
Subject: [PATCH] aoe: flush: fix device name string comparison
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)

Only flush a device if device_name exactly matches.
Previously all devices starting with the requested string were flushed.

e.g. 'echo e10.1 > /dev/etherd/flush' erroneously flushed devices
e10.10, e10.11,... in addition to e10.1 if they existed.

Signed-off-by: Valentin Kleibel <valentin@vrvis.at>
---
  drivers/block/aoe/aoedev.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 3a240755045b..c9d4b9339a20 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -264,6 +264,8 @@ user_req(char *s, size_t slen, struct aoedev *d)
  	lim -= p - d->gd->disk_name;
  	if (slen < lim)
  		lim = slen;
+	if (p[lim] != '\0')
+		return 0;
   	return !strncmp(s, p, lim);
  }
-- 
2.39.5


