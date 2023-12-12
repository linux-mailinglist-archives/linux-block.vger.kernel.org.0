Return-Path: <linux-block+bounces-1012-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1E380EA04
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 12:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C2C281F82
	for <lists+linux-block@lfdr.de>; Tue, 12 Dec 2023 11:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32575D4AF;
	Tue, 12 Dec 2023 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk6cqHcc"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B330D65;
	Tue, 12 Dec 2023 03:12:12 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d32c5ce32eso10335515ad.0;
        Tue, 12 Dec 2023 03:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702379531; x=1702984331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/h+WfEQxtNqWLD65fthYDEoIBJTS6GEtAIchnOXQlY=;
        b=Kk6cqHccBtTNpTtrsT5ogjg8MSsaXvkbTZPE968lafYfy+te+WKs++cx/wlcbag8aB
         tnKktDO1kuu/muZHKpdVCkDmbrDP2uZza1Vezsl4S5/6jTt4IlduGOTfk60ox+O6TU6V
         pxSeS0Nnbe9JoZLFzlKgfrTQ3akwr11FSDufisi1WqgWxGMVuhrdn+/sm6YJ5PzUvhZY
         bCYP7Pu6fJ1ClpQwg9d8zHMB+7PZnzNVWBLzSwoHAf6eP0AF7msUWecHkqwnDUfyF5sD
         1B/Xhpr30ynRZ3tBRwP4e26wPLi+CK20uZKrWpVJatFy7+BZlw4nuS/mqb34p/duNPMJ
         Z3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702379531; x=1702984331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/h+WfEQxtNqWLD65fthYDEoIBJTS6GEtAIchnOXQlY=;
        b=UTEIOnyXHIKxqlzCtYAStawMSUTKVXfgluGxUkxsz2w5oWdeuJ3Nyl7t0sCMqGDDv1
         8doHDp2rRLBLMW+tbG9QzFCBzLFxr3wL2r1VN7h5qbQcxaJeD47E/awT3FSvKL6E0Kxx
         Itz39bSQVvWVveMLW7S1c5F/224yPenQDhlb/YzOX+8Y6hJxsliEGqeCLZh9er3IDVCm
         EbYhr43EclkfAM5SRvwsz5Lq+CX9S2ERQB8538Iqp8jRvYF32A96l37j2MoZPaV7np1f
         VE+X0IcXCjXzIVqsmQ68Ut6XWROZj0wOM2thv3zvGYqA1RMlvN/ImwBBNYZOG7t29lto
         BoDg==
X-Gm-Message-State: AOJu0YxnZznCZSd7c2Ptcp8mxsgcE7o5QnrAXe43sniLQKAW3H27uKTp
	nBTjuiYPQaWkhN6lBxhMlag=
X-Google-Smtp-Source: AGHT+IGBiBDfitZYDKoB131GyaEEkPbtMG+AiK4V16DRcHToH+3lCj+wV3YCBPG1lcsUeZotqWYcAw==
X-Received: by 2002:a17:902:ea0b:b0:1cf:b4bb:9bdc with SMTP id s11-20020a170902ea0b00b001cfb4bb9bdcmr7289304plg.9.1702379531377;
        Tue, 12 Dec 2023 03:12:11 -0800 (PST)
Received: from ubuntu.. ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001d0511c990csm8345453plo.237.2023.12.12.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:12:10 -0800 (PST)
From: Hongyu Jin <hongyu.jin.cn@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	axboe@kernel.dk,
	ebiggers@kernel.org
Cc: zhiguo.niu@unisoc.com,
	ke.wang@unisoc.com,
	yibin.ding@unisoc.com,
	hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH v4 0/5] Fix I/O priority lost in device-mapper
Date: Tue, 12 Dec 2023 19:11:45 +0800
Message-Id: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZXeJ9jAKEQ31OXLP@redhat.com>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hongyu Jin <hongyu.jin@unisoc.com>

A high-priority task obtains data from the dm-verity device using the
RT IO priority, during the verification, the IO reading FEC and hash
by kworker loses the RT priority and is blocked by the low-priority IO.
dm-crypt has the same problem in the process of writing data.

This is because io_context and blkcg are missing.

Move bio_set_ioprio() into submit_bio():
1. Only call bio_set_ioprio() once to set the priority of original bio,
   the bio that cloned and splited from original bio will auto inherit
   the priority of original bio in clone process.

2. Make the IO priority of the original bio to be passed to dm,
   and the dm target inherits the IO priority as needed.

Changes in v4:
  - Modify commit message by Suggestion
  - Modify patch for dm-crypt
Changes in v3:
  - Split patch for device-mapper
  - Add patch to fix dm-crypy I/O priority question
  - Add block patch to review together
  - Fix some error in v2 patch

Changes in v2:
  - Add ioprio field in struct dm_io_region
  - Initial struct dm_io_region::ioprio to IOPRIO_DEFAULT
  - Add two interface
**

Hongyu Jin (5):
  block: Fix bio IO priority setting
  dm: Support I/O priority for dm_io()
  dm-bufio: Support I/O priority
  dm verity: Fix I/O priority lost when read FEC and hash
  dm-crypt: Fix lost ioprio when queuing write bios

 block/blk-core.c                              | 10 ++++++
 block/blk-mq.c                                | 11 ------
 drivers/md/dm-bufio.c                         | 36 ++++++++++---------
 drivers/md/dm-crypt.c                         |  1 +
 drivers/md/dm-ebs-target.c                    |  8 ++---
 drivers/md/dm-integrity.c                     |  7 +++-
 drivers/md/dm-io.c                            |  1 +
 drivers/md/dm-log.c                           |  1 +
 drivers/md/dm-raid1.c                         |  2 ++
 drivers/md/dm-snap-persistent.c               |  5 +--
 drivers/md/dm-verity-fec.c                    |  5 +--
 drivers/md/dm-verity-target.c                 |  8 +++--
 drivers/md/dm-writecache.c                    |  4 +++
 drivers/md/persistent-data/dm-block-manager.c |  6 ++--
 include/linux/dm-bufio.h                      |  6 ++--
 include/linux/dm-io.h                         |  2 ++
 16 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.34.1


