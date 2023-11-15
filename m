Return-Path: <linux-block+bounces-139-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 839AF7EB616
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 19:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D04B281342
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 18:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB6D11C90;
	Tue, 14 Nov 2023 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282512C1BD
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 18:04:47 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68BD5E;
	Tue, 14 Nov 2023 10:04:45 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso53011595ad.3;
        Tue, 14 Nov 2023 10:04:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699985084; x=1700589884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWHGrQLU71IG94aXxynwdk2LkNtFMni7Y7JI8/Qdscc=;
        b=pxMOYClZl5yVs/x8KQ7MZOUiA/f7vljtQnE0HRmqTxKu6qF5nPUvP84Buao9FR/sYr
         ZvWzAOUSeezUQasWX8F1kFDMCR6g21bM2yN8BQoaja8+sOzTgw0w7yFF4Ya3qlArjLdx
         CTEhJSYc+9YNJO/hyE6ae88P3zmfw6izkO9TJOZIRe6/43fPfnMoHOwACKxzYDcw1Biq
         8mGZl6GsahciR0RggS8s58qM/Eexc56MGneZNsNHiQlQr5GKgGKSQcKhDHfRJ224MNoD
         znbM/Su2bvTatezy431+E+xxUJViCRQLA0GYHbh2/NPWOEOIYwPDMAFL47wDlt+t3bKb
         +pLg==
X-Gm-Message-State: AOJu0YzWXgxZ6oMCeW0DiHiAOjxKCcRvoHoy/HFmdLn1oliWlwRzrLLN
	Lm4EQVo85QQmJL4l7IaWUso=
X-Google-Smtp-Source: AGHT+IFrCIOVP+0mYEK72xr4IxarBqmedllQHRz7fEQJ+NsEZxA3JuktK5Hn9fhlhlBxTHog/yfeJA==
X-Received: by 2002:a17:902:7d87:b0:1c9:e508:ad54 with SMTP id a7-20020a1709027d8700b001c9e508ad54mr2332638plm.13.1699985084067;
        Tue, 14 Nov 2023 10:04:44 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id bq4-20020a056a02044400b0059d6f5196fasm5101937pgb.78.2023.11.14.10.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 10:04:43 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Yu Kuai <yukuai1@huaweicloud.com>,
	Ed Tsai <ed.tsai@mediatek.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanley Chu <stanley.chu@mediatek.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Asutosh Das <quic_asutoshd@quicinc.com>,
	"Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
	Peter Wang <peter.wang@mediatek.com>,
	Bean Huo <beanhuo@micron.com>,
	Arthur Simchaev <Arthur.Simchaev@wdc.com>
Subject: [PATCH v5 3/3] scsi: ufs: Disable fair tag sharing
Date: Tue, 14 Nov 2023 10:04:17 -0800
Message-ID: <20231114180426.1184601-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231114180426.1184601-1-bvanassche@acm.org>
References: <20231114180426.1184601-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the block layer fair tag sharing algorithm because it
significantly reduces performance of UFS devices with a maximum queue
depth of 32.

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Ed Tsai <ed.tsai@mediatek.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/ufs/core/ufshcd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 8b1031fb0a44..a2219cbb9720 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8973,6 +8973,7 @@ static const struct scsi_host_template ufshcd_driver_template = {
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.skip_settle_delay	= 1,
+	.disable_fair_tag_sharing = 1,
 	.sdev_groups		= ufshcd_driver_groups,
 	.rpm_autosuspend_delay	= RPM_AUTOSUSPEND_DELAY_MS,
 };

