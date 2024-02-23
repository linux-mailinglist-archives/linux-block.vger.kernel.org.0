Return-Path: <linux-block+bounces-3623-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F686169F
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977F61F26B2F
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68785C76;
	Fri, 23 Feb 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="0Xtqqb8+"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5EA84A34
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703901; cv=none; b=u0IqnLs+0nZvBoFLIis3sOGy95gg2WgbGvLn7/Xm0mwwreBWawBGJ2gpPyceo6brXe0mmC4ySk7DhSLvScGAHxVGrCq6bxm+/2iCDx5HZOL+JjES3DnqufFt11pHIVUpW1xAqOHeS+C/tPP4z8waIINT6h66BcoViKRUEQZ8Mwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703901; c=relaxed/simple;
	bh=yubuTyPGf4bTd9nBZMSBW040fOuvUEmyH1Rqt46p1Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6Yo03b7RUx67M8puvaCoVAXrfJQ2n/E9BPVU4NZpEg3xGkTxGh68d2Tnk1JyCIuwxoPRYloxsb/q6YbTl0mow6DzU4wqNu9xBWXORUuuMyZpfuOtJVR/bpJ9wxIE8PLcZ6vHsPvtrrI3uD7a5sV0yL9HZ8edExOw6xE0zC9txQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=0Xtqqb8+; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a17f3217aso68608966b.2
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708703898; x=1709308698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXt+HI9wwNeUARCoHPWGtfsHeSRaQT3zlVaUv+U3mfk=;
        b=0Xtqqb8+1zh8fzxoAxgMsPFrlvjISu+kE0AAhHVeLbU66BwuGySpbxEr9+LaNaaMJw
         TyShQQmia0rEE8Ig+wKKIuylGo0GJrxhrjuZXQ8vNfwgdR2OMYOUuLaymqHpxAXBk32i
         WxWcxxEZ7fmemoy+/3ODYupkX/ya09/lJYl8onuJdyQS+Kz25EruH2zG9c+Y8F1zWCUJ
         Qq6W/LTMC1ctjy6qDATiDVC7zTrv73PldMsuBg5s1w5+MSHZea1plIP6FwmVRtxupTPA
         /QAEReDjHuc/GUa6jDuavtWEzzMqUcSn+b6iZY4/+B2p1/pRpYCxUY08U+4AroBBYsZI
         v/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703898; x=1709308698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qXt+HI9wwNeUARCoHPWGtfsHeSRaQT3zlVaUv+U3mfk=;
        b=vwg0WxqvUGc+MQQzSA8KCDHINcGp67paoagVrUbI5HMwC8eaUUtd8EqkfOixIsaMpi
         yFqrJuIjaR9fTntGOV8SuO++YUPQqfFxNzc8Q7ToDF3GNGQi+6VgP266I84xdm7k6qk5
         AU0nJ+ekaQXsVdw+tGHP97cLnxbP5JR2dtm6e4PX/Os7T0eOrE47aMZrILE/cX5GzXP/
         ux9Px/1AhDf3TLpdCUpEfYsAKKTOotg2dkDJew1lLI6Eb6qznEh3zhTDTETCl8P2R6uY
         xQkXgXniyNnc8EYh5tghbmjqt9xgNV8g8swBoIElj1+8k+DFfxX3en7AQNyqTUWkSbB+
         qL4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZzVOeaaRZmyQczRmgat+dz5ruIReO+Jzh08CykNc/wsUtFInrRXVV/cOq2Wxh4u0AtHHBUfnQqq9+znzA6yiKUP1SQ5r25/l+BSg=
X-Gm-Message-State: AOJu0YzxlyFapxKKe7RUwhTmz+jVhfuvRSPigOLR8YTm/asXvuOyMtPL
	1YhplRt7n8cARci+ccQM1J602Gp9Toybp9PZRYSfGW7oqmi6omvQuFN5k/rO2QI=
X-Google-Smtp-Source: AGHT+IGICtbJmOJxleBJrgHmax806zlycMWeIW3A9rVv8+9wIgvLrGYLOiADJ46veqiwirVtyjam+g==
X-Received: by 2002:a17:906:3787:b0:a41:db75:7642 with SMTP id n7-20020a170906378700b00a41db757642mr70403ejc.37.1708703897542;
        Fri, 23 Feb 2024 07:58:17 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3e28471fa4sm6461293ejc.59.2024.02.23.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:58:17 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 2/2] block/blk-mq: Don't complete locally if capacities are different
Date: Fri, 23 Feb 2024 15:57:49 +0000
Message-Id: <20240223155749.2958009-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223155749.2958009-1-qyousef@layalina.io>
References: <20240223155749.2958009-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The logic in blk_mq_complete_need_ipi() assumes SMP systems where all
CPUs have equal compute capacities and only LLC cache can make
a different on perceived performance. But this assumption falls apart on
HMP systems where LLC is shared, but the CPUs have different capacities.
Staying local then can have a big performance impact if the IO request
was done from a CPU with higher capacity but the interrupt is serviced
on a lower capacity CPU.

Use the new cpus_equal_capacity() function to check if we need to send
an IPI.

Without the patch I see the BLOCK softirq always running on little cores
(where the hardirq is serviced). With it I can see it running on all
cores.

This was noticed after the topology change [1] where now on a big.LITTLE
we truly get that the LLC is shared between all cores where as in the
past it was being misrepresented for historical reasons. The logic
exposed a missing dependency on capacities for such systems where there
can be a big performance difference between the CPUs.

This of course introduced a noticeable change in behavior depending on
how the topology is presented. Leading to regressions in some workloads
as the performance of the BLOCK softirq on littles can be noticeably
worse on some platforms.

Worth noting that we could have checked for capacities being greater
than or equal instead for equality. This will lead to favouring higher
performance always. But opted for equality instead to match the
performance of the requester without making an assumption that can lead
to power trade-offs which these systems tend to be sensitive about. If
the requester would like to run faster, it's better to rely on the
scheduler to give the IO requester via some facility to run on a faster
core; and then if the interrupt triggered on a CPU with different
capacity we'll make sure to match the performance the requester is
supposed to run at.

[1] https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2dc01551e27c..ea69047e12f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1167,10 +1167,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	if (force_irqthreads())
 		return false;
 
-	/* same CPU or cache domain?  Complete locally */
+	/* same CPU or cache domain and capacity?  Complete locally */
 	if (cpu == rq->mq_ctx->cpu ||
 	    (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags) &&
-	     cpus_share_cache(cpu, rq->mq_ctx->cpu)))
+	     cpus_share_cache(cpu, rq->mq_ctx->cpu) &&
+	     cpus_equal_capacity(cpu, rq->mq_ctx->cpu)))
 		return false;
 
 	/* don't try to IPI to an offline CPU */
-- 
2.34.1


