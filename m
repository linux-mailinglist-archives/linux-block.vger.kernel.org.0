Return-Path: <linux-block+bounces-137-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D66A77EB614
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 19:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDB11F24F91
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C82C1BA;
	Tue, 14 Nov 2023 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533CB2C1B0
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:04:45 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E49D48;
	Tue, 14 Nov 2023 10:04:31 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso6085172b3a.3;
        Tue, 14 Nov 2023 10:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985071; x=1700589871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIXVjXYmWbE5Oq8DTLEiU/nvcYwV1DvaW/F8iST2qnw=;
        b=lUKNCKb+L7vUZSLTrm7GXdS+jLmWpE29TTrkdHpJ3+iAWJ8lYP34po4L55VbW+YJEJ
         r34TsxY/Jlh1WQB5T/7+lDNgEZpuCsSXDQqND/KplTM4YXT5JEiMvkM3g5maM6nKXVyt
         1r6IpMbip3iLn6neqMukxrQ2ma/WRtxpfeYJj9uQfyMNuwwxifhIglif4mbLEV1eim3k
         p1Lh/bJjwnoDk+hwlbGDnXUs3xte4hB9xoNrHC3Z4BtzsV3uHx84MJ2anRFDA6arJHDy
         +BPjLaucDOXNkDSxgcoXC9KyO/cLfmXNVnEvIOVpbnQdY4aStr9YpxLDmLnfLqFAT3Ak
         Of8g==
X-Gm-Message-State: AOJu0Yz3/TbRUGRB4WlqtBG14mubh8i8n3zAQdeZ2L6E4X139zREKiU0
	KcVmhSdX+QfL0gx/tCD14CM=
X-Google-Smtp-Source: AGHT+IHjEvMpHXj3YjldQjUmzT1yck7YpnXRueZuYYJGj3Y46WqRSbjUVjjSZcfujBTMo3jxYp9tfg==
X-Received: by 2002:a05:6a21:6d9c:b0:181:98d6:6b01 with SMTP id wl28-20020a056a216d9c00b0018198d66b01mr12241292pzb.5.1699985071167;
        Tue, 14 Nov 2023 10:04:31 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id bq4-20020a056a02044400b0059d6f5196fasm5101937pgb.78.2023.11.14.10.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 10:04:30 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v5 0/3] Disable fair tag sharing for UFS devices
Date: Tue, 14 Nov 2023 10:04:14 -0800
Message-ID: <20231114180426.1184601-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

The fair tag sharing algorithm reduces performance for UFS devices
significantly. This is because UFS devices have multiple logical units, a
limited queue depth (32 for UFS 3.1 devices), because it happens often that
multiple logical units are accessed and also because it takes time to
give tags back after activity on a request queue has stopped. This patch series
restores UFS device performance to that of the legacy block layer by disabling
fair tag sharing for UFS devices.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v4:
 - Rebased on top of kernel v6.7-rc1.

Changes compared to v3:
 - Instead of disabling fair tag sharing for all block drivers, introduce a
   flag for disabling it conditionally.

Changes between v2 and v3:
 - Rebased on top of the latest kernel.

Changes between v1 and v2:
 - Restored the tags->active_queues variable and thereby fixed the
   "uninitialized variable" warning reported by the kernel test robot.

Bart Van Assche (3):
  block: Introduce flag BLK_MQ_F_DISABLE_FAIR_TAG_SHARING
  scsi: core: Support disabling fair tag sharing
  scsi: ufs: Disable fair tag sharing

 block/blk-mq-debugfs.c    | 1 +
 block/blk-mq.h            | 3 ++-
 drivers/scsi/hosts.c      | 1 +
 drivers/scsi/scsi_lib.c   | 2 ++
 drivers/ufs/core/ufshcd.c | 1 +
 include/linux/blk-mq.h    | 1 +
 include/scsi/scsi_host.h  | 6 ++++++
 7 files changed, 14 insertions(+), 1 deletion(-)


