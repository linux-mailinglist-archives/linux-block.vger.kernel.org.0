Return-Path: <linux-block+bounces-530-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075397FC782
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 22:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E6B1C21213
	for <lists+linux-block@lfdr.de>; Tue, 28 Nov 2023 21:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCFF5024F;
	Tue, 28 Nov 2023 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auKkZZhF"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A744C7B;
	Tue, 28 Nov 2023 21:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C00C433CD;
	Tue, 28 Nov 2023 21:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205786;
	bh=gfTRgwpbepPJtGUiW85IAfzQ70VbVccuFpv2c4zqL2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auKkZZhF7Z+Tqw/wgc6uJMJxD1r79Ah5zuidp5HwsqAnaIV0aBQ5WN22xW7MG2B1T
	 qAAZjN6slRhkkpWBZe50J3vMyLo8shIIV6t8+vFyRUTHeiwEyKPYYo5bJp9hOneY5O
	 agkhQqA+e7EFPo9eRbbBy3Yf8ELXupkl8+6KMz2xXdn3sb4GAcCUNqzMdNPvH+rV8k
	 eKV07bBublXnWrY1xbEQRehq7EQlO1xWF6SjuUVW6l4RqQTjsm2qfiifwVWzFpXs/G
	 a8VtlzQkYuemU1GHRjmTOQ4x9UAlz3HTYW6+rjnkLMRcB7ciNQm1CdyNusAbdvWVhY
	 Z5RZ0LsFJ2sTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Changhui Zhong <czhong@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	tj@kernel.org,
	josef@toxicpanda.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 02/11] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date: Tue, 28 Nov 2023 16:09:26 -0500
Message-ID: <20231128210941.877094-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210941.877094-1-sashal@kernel.org>
References: <20231128210941.877094-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.262
Content-Transfer-Encoding: 8bit

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 27b13e209ddca5979847a1b57890e0372c1edcee ]

Inside blkg_for_each_descendant_pre(), both
css_for_each_descendant_pre() and blkg_lookup() requires RCU read lock,
and either cgroup_assert_mutex_or_rcu_locked() or rcu_read_lock_held()
is called.

Fix the warning by adding rcu read lock.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index bd870f9ae4586..43444934b9850 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1374,6 +1374,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1401,6 +1402,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.42.0


