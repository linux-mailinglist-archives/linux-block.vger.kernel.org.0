Return-Path: <linux-block+bounces-446-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C87B7F8585
	for <lists+linux-block@lfdr.de>; Fri, 24 Nov 2023 22:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA8CB2177B
	for <lists+linux-block@lfdr.de>; Fri, 24 Nov 2023 21:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF153BB37;
	Fri, 24 Nov 2023 21:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LvjOrOHK"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7876E10F0
	for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:26 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso28911241fa.3
        for <linux-block@vger.kernel.org>; Fri, 24 Nov 2023 13:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1700861665; x=1701466465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=05GnJYzxI6Xz0MjYgJ4GFFsxH6+i7xCLGVv9SBg2f+A=;
        b=LvjOrOHK1VFa9AFRSHWKsB/RSSAJ1NQu7WW63YReuXxVi7DMKpwrVn5qRRK38x73Ht
         oDDcNHdIcxKze+WPzH723sSkOLIqIXyvHCtUi1mo/+tC9V4pJZxvy5bhJdHZp81Mofx+
         WHm8L+ybnx2j3edlhyEE84oSwd9lvvmPeh/Pi5MgwPDoiv/Vr+vdMjpTxNHOS5ETL3I5
         OO8jHoFp0wrkj4gWljSMzf/crKC20YOuJPtiK6mAN4QIDibLpUzlL21hcIQdeFrl1HD7
         mSAVKFzyQ0Nxs/E7I6/gbL67xu8rmnEfw4NhmUHCGh4Pd4rPtK1bLQE++vEVQ+V/H87f
         F16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700861665; x=1701466465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05GnJYzxI6Xz0MjYgJ4GFFsxH6+i7xCLGVv9SBg2f+A=;
        b=g6zdUrTJncYoX3ZhGT94dndLYLhipEPMXrDekeVmWZaaflA9TJQHSEcoHltU/jR2ZO
         CR58Sd8XQm257GUkfgV1OpjQ0YaeOjlPsR0stC48ZRlwdB/vsKjlRe1wvQ5ZQPpPSqbJ
         Pk7XMiBKX7zs+TVPxWgsHWdA4f70Y8KcN/QjFS1RP3c9lxGMhLId35delrXfe9XPmjmv
         3XyHG1h8fn4SUdySfEmc3u0TkcSV/U7N0a/248lOMBYzlcWBJcghsBPzXAuFQYKuCJ1k
         TTzS3654Biu8KwMlZUh+3hDoY4WstKFvyHsc94KsUW7XZ0ob1PKtuWOPQjo80BvmyxKh
         LDxw==
X-Gm-Message-State: AOJu0YzojV4YmEw8x8fTvEg1sDk37kRHDEH7rFEjTp6Z9/hKR03Skb/i
	i4RbPBmNy1BsofVPXPeVRDChthk3NXKQ6yWIYGs=
X-Google-Smtp-Source: AGHT+IFWPmHS5YC6/LzFgVx6rouK7d4U0yzREsfy3oo6gKwEdgszodQ/IlFH3RGoxBRZTinehNT/xw==
X-Received: by 2002:a2e:8e96:0:b0:2c6:edfd:658e with SMTP id z22-20020a2e8e96000000b002c6edfd658emr2781277ljk.52.1700861664734;
        Fri, 24 Nov 2023 13:34:24 -0800 (PST)
Received: from lb01533.speedport.ip (p200300f00f4ce298610448d17080cbe0.dip0.t-ipconnect.de. [2003:f0:f4c:e298:6104:48d1:7080:cbe0])
        by smtp.gmail.com with ESMTPSA id y18-20020a17090668d200b009fc95fc3dabsm2548857ejr.130.2023.11.24.13.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 13:34:24 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	hch@infradead.org,
	sagi@grimberg.me,
	bvanassche@acm.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com
Subject: [PATCH v2 for-next 0/2] Misc patches for RNBD
Date: Fri, 24 Nov 2023 22:34:20 +0100
Message-Id: <20231124213422.113449-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please consider to include following changes to the next merge window.

Changes in v2:
	Rebased

Santosh Pradhan (1):
  block/rnbd: add support for REQ_OP_WRITE_ZEROES

Supriti Singh (1):
  block/rnbd: use %pe to print errors

 drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
 drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
 drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
 3 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.25.1


