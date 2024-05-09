Return-Path: <linux-block+bounces-7148-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD1B8C08EA
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 03:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725DA1C20F83
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8892D13A3F3;
	Thu,  9 May 2024 01:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMpl6gDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DeS/l+hm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TMpl6gDJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DeS/l+hm"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FF23C482;
	Thu,  9 May 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715217086; cv=none; b=qX6vFMXpLB2zDWhaHL13uxp/+I7La4futqRcYNbiRl8h4DqhgpsFTXjhhWwGCXEpNYJWVBr8gvS8XXRXZkWHJnQDOGXdOp78imKiYKJl5oRr/H4O+6fICQSU6Ow5eExfdW6WnkazMVTAHa1wsWK+Mvmc5zyabNx3U1q35qmmGIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715217086; c=relaxed/simple;
	bh=VBErHUxaaBcJNTMrNhCJi897Vl9mGvsHqeWzPHWtVSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5Vmz3pNkgNd3k4aStEv1gP4ae4C6/crma/pJtq6B7IQ9q7IusTbJY8W9rpXVF8rKSWdxQQSzubWgVuacV2j05V/1zxb+QqGr0UW3HDkEL9qsyr3/Z9s5X44HQjmBzLNiP6QQdg7SaLXFryokh/+0jMh6X+g37dnf+qMx7Qg3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMpl6gDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DeS/l+hm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TMpl6gDJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DeS/l+hm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from suse-arm.lan (unknown [10.149.192.130])
	by smtp-out1.suse.de (Postfix) with ESMTP id 539FC3790E;
	Thu,  9 May 2024 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715217081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T7E+jwQc4W0pgxmLqTd86bEWzjocEnA5z3ss1dpdjYk=;
	b=TMpl6gDJw8GTABdzjTfA0httSRnJWXBWTMgplON8bI9LxtX6KA+qrqlep/sazVGodtrs0W
	2Sgl9YGuSTpK3o2EXcFR1cTQmIvw1svFAlF2p5nK4KPWPVvSlEnjxjQInMX5kMhtuJ976H
	KFro9RoLFN/d2eR2qs1K49QaZH8u+3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715217081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T7E+jwQc4W0pgxmLqTd86bEWzjocEnA5z3ss1dpdjYk=;
	b=DeS/l+hmJSfbYDJr1MUSxbCXuY7Mgw9eY5ahPrhuoMnUcH0rVj/nJev4uW80bSW2EiI29o
	XW2GGrsyFMNE9JAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715217081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T7E+jwQc4W0pgxmLqTd86bEWzjocEnA5z3ss1dpdjYk=;
	b=TMpl6gDJw8GTABdzjTfA0httSRnJWXBWTMgplON8bI9LxtX6KA+qrqlep/sazVGodtrs0W
	2Sgl9YGuSTpK3o2EXcFR1cTQmIvw1svFAlF2p5nK4KPWPVvSlEnjxjQInMX5kMhtuJ976H
	KFro9RoLFN/d2eR2qs1K49QaZH8u+3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715217081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=T7E+jwQc4W0pgxmLqTd86bEWzjocEnA5z3ss1dpdjYk=;
	b=DeS/l+hmJSfbYDJr1MUSxbCXuY7Mgw9eY5ahPrhuoMnUcH0rVj/nJev4uW80bSW2EiI29o
	XW2GGrsyFMNE9JAw==
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH 0/2] bcache-6.10 20240509
Date: Thu,  9 May 2024 09:11:15 +0800
Message-Id: <20240509011117.2697-1-colyli@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-0.24 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.44)[78.75%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -0.24
X-Spam-Flag: NO

Hi Jens,

There are two bcache patches I'd like to submit upstream.

The patch from Christophe uses ida_alloc_max()/ida_free() to replace the
deprecated ida_simple_get()/ida_simple_remove().

Patch from Matthew uses similar method which bcachefs code uses, to
remove UBSAN warning of out-of-bounds index on dynamic sized bset
iteration from the in-memory btree node.

These two patches are quite straightforward and have been tested on
my machine for a while and no regression observed.

Please consider take these two patches for bcache-6.10.

Thanks in advance.

Coly Li
---

Christophe JAILLET (1):
  bcache: Remove usage of the deprecated ida_simple_xx() API

Matthew Mirvish (1):
  bcache: fix variable length array abuse in btree_iter

 drivers/md/bcache/bset.c      | 44 +++++++++++++++++------------------
 drivers/md/bcache/bset.h      | 28 ++++++++++++++--------
 drivers/md/bcache/btree.c     | 40 ++++++++++++++++---------------
 drivers/md/bcache/super.c     | 15 ++++++------
 drivers/md/bcache/sysfs.c     |  2 +-
 drivers/md/bcache/writeback.c | 10 ++++----
 6 files changed, 75 insertions(+), 64 deletions(-)

-- 
2.35.3


