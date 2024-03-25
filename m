Return-Path: <linux-block+bounces-5002-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 009E288A029
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 13:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A797C1F39A03
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 12:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298413E038;
	Mon, 25 Mar 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsqa6Jx2"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D614F1C32AB;
	Mon, 25 Mar 2024 04:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341943; cv=none; b=COHk0HH8ZdhSbhtw0ddwpvSpG52PNcjWMZaTdDbJhEHlf28pgsnTZHpaSymi6cMOvErp24rJgQDfpC9X9OlQdnBzrSUETL9fWfpHehDrf/Ei+Nlss0NZ+MsrjtGQb/EMkaa67mGiHUKajHGfEV6e1LODCVWwNf/CRo/bxQUoOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341943; c=relaxed/simple;
	bh=XkkLTLoYqIdJmT3jXyyqSLxcLQBh66Wj7heBwI4xPC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TC0Z16oekij7uAgGH1T8FyKqmiAqbXVo7/VnHx60DxvPvi+TKwSqIKeQ9JUsPS3Ch6JAC3vlvkxehx6LDi4LWOST70g4c0Kvvg4xGrK6ejvfBc+IRiVnqvjENoTfuWZ+e3DYWmpYSkk88wo+QnUoMiJaaY9CamLgrZXwNZxpe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsqa6Jx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7778C43390;
	Mon, 25 Mar 2024 04:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341943;
	bh=XkkLTLoYqIdJmT3jXyyqSLxcLQBh66Wj7heBwI4xPC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsqa6Jx2/+4N+bzB0ZByHmmK7tMFoxPRWfS6GVPj4k16P5RvjGWu3CoyJ042sO4OS
	 7i47USBIVehl1gSV5r1wXgHc6pzjrEQefqHtAjj1DTV3/DEc1kMaCKgi017aM+o7Fq
	 4D8IZ6MudL8IFgLIK2pHjJa8yUWdCfAs1gGC0JyyhwtGJ+ZasF5AUkP/tt926uhjGB
	 U1UxbWm/21v+dZTfyaEWHp8B9aaCwXzgjQqRiVWLmBHnQrqEwvXayNPv9u6uGpPXU8
	 GQbp3HYnDpVOMdC+Q/SJLunt77QcmYNKgMUIsNlc1nrmW6yUUplrSX85UoURO+DGLp
	 iiIf90Ri8xFXQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Mon, 25 Mar 2024 13:44:51 +0900
Message-ID: <20240325044452.3125418-28-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325044452.3125418-1-dlemoal@kernel.org>
References: <20240325044452.3125418-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that zone block device write ordering control does not depend
anymore on mq-deadline and zone write locking, there is no need to force
select the mq-deadline scheduler when CONFIG_BLK_DEV_ZONED is enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9f647149fbee..d47398ae9824 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -100,7 +100,6 @@ config BLK_DEV_WRITE_MOUNTED
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
-	select MQ_IOSCHED_DEADLINE
 	help
 	Block layer zoned block device support. This option enables
 	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-- 
2.44.0


