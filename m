Return-Path: <linux-block+bounces-20482-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77BDA9AF21
	for <lists+linux-block@lfdr.de>; Thu, 24 Apr 2025 15:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C80701B6746D
	for <lists+linux-block@lfdr.de>; Thu, 24 Apr 2025 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36E414D2BB;
	Thu, 24 Apr 2025 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WpFPaRKz"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A855E69
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501758; cv=none; b=JbOmRvmvOHkgv2kI+rCfeS14HFzpHVnJ58C1BI8jLXokfM1xtVfcCHXuMkEJWmcV/mrTUFrSVJVz4ry199QzpRnXuOaQJt8upNxqubSyse8a43FkLxNqvMNQ9aLq8ygeeH6nhKytPF8nG72sf3nybHASa4yHeESReec2Mmo2uTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501758; c=relaxed/simple;
	bh=WPtzaI6gzO+Ao9RQi1VweoMaU/O7Z60bQSJbDKqCmOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UA2UVblLQXqmZPQiYXfnWf34wkc/GXL0a2kgfIbKohrS0k4ZgojNVxjxtCb2XAI7E6H1fFqMg3kvfB6IHFK4MM9Vy626/25jyGybXVcIIpeBTN7aeBX67dmEB0m/I4N68Vkfy1J/JEuuV19sVdB1JkkG9BIPWJliBmHBsrqhl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WpFPaRKz; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d90208e922so5357535ab.3
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745501756; x=1746106556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y3kb7tbL35mrW374ozZ5zHoQ8x5ddd9COLH2ecrXT4=;
        b=WpFPaRKz0O7NIIA9IeGDNE5RIzQrP6u281XLpXkUtjG7MK31SOudfgRBWn6ciC/o74
         y/PPLkG6LYFqxeOnBxb55sXuZdg3W93rzV42d+CoRpFm2BpzVGzrfVJUdfnGbo26TXbG
         TRDcWNb/4PIOTTvTLx7lgY+qknDf8EPZq41YKaTUmJiiB9LZWwpmMQs9sEScLUMpQ5Zs
         ADN4+bouAJJ9Yt2lH524moLBwuMmZNs39/V84+QhlwtiGIlGNESImiz61sK5xu1Vyqhb
         3o38osX/jGESNj/opUoWouLXOqO3EEkwtb4wllC888SV38CTOfzVcP7B+QCtGlD+V6OJ
         Htww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501756; x=1746106556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y3kb7tbL35mrW374ozZ5zHoQ8x5ddd9COLH2ecrXT4=;
        b=WnhuS1BDRfNLNAwbBMJ5hB72hdW+7gvghPkOmKucCVdu2P8rE0iZqPc6/cKTz7MHro
         Y4jIrf5AflW28Y7nls0L7irdskp2VGbyef4ouk6mjn/DIWUPpS99Twx2sUGAoAru9irf
         Z5P2aSDXZfP/WQ/pf9voTG+tmuNgpZ3xeemdkun2CQtwoZdz3Fbu7VP2hzwy5b37U2VJ
         zwXZmz0jBPPGQCb3dCc3yT61927JYiqujGN/lPIn5SHEVbH1rF7YRe21olL+/KG4IA4g
         PVpSqi6TcT3MjqprTaxWxK0/1ODSVe94d4VlW0o5iR6btOqf/Cv7Z1mRsvERFi8Iw50V
         7Vew==
X-Forwarded-Encrypted: i=1; AJvYcCXeB2YMvl0U8PCX+QWAldJKnyLUONENDSLPrTpNj0t6fwpCbGuyPV9vxuiJCkEkR+riQ6XkSmp7CYe2vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+kIV8mpk6VYC7ntHrn/HzYw8WXPxLP21DTFGlHgGiLpk94VX
	05MPAqfz+e9QrVuJD1l9vzqcIc9ot6bp6HueYesVbH/gNEJqvCt0GO0JD1bn8Sw=
X-Gm-Gg: ASbGnctM88Nt4t0E6Wiu6PaicNhnVcMSkT+a98nwKkJZlmY1vxv0C8RfuHy3t4/Xmih
	XSXCf84JnWo8c0bZxGnEHVLJaKCmqiwNoJHNm5wUuC7+CBK1JaHrZ9DbetkkWJsMikkQ1DFPUBc
	QwmiWa+2NwkUuWUvBMRPhikzMwMeKoNaJgnDL/9rlVVSGhmcwtCUbgTRy+/GtS5GWYK46KLrKWr
	so0rRRguK2QBdtMrfXdeUUu6gQ0at/pI4Dwd2pEtVohOO4/aU7/I6aza8er79MfmlBBp8sM+zzD
	kgfcXnM+I3cMsIdyaFQG3oaSjYxQo74=
X-Google-Smtp-Source: AGHT+IHGUYup65Csh37WQAuNVZgmXMs0428N1C4YOSpFb5unVA+hY8Q9IKjnnn2p20qNo3hrxDTuOA==
X-Received: by 2002:a05:6e02:398e:b0:3d4:276:9a1b with SMTP id e9e14a558f8ab-3d93041e398mr26411495ab.16.1745501755935;
        Thu, 24 Apr 2025 06:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824b80d63sm286172173.94.2025.04.24.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:35:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>
References: <20250423053810.1683309-1-hch@lst.de>
Subject: Re: don't autoload block drivers on stat (and cgroup
 configuration)
Message-Id: <174550175513.658353.8577093198336589021.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 07:35:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 07:37:38 +0200, Christoph Hellwig wrote:
> Christian pointed out that the addition of the block device lookup
> from stat can cause the legacy driver autoload to trigger from a plain
> stat, which is a bad idea.
> 
> This series fixes that and also stops autoloading from blk-cgroup
> configuration, which isn't quite as bad but still silly.
> 
> [...]

Applied, thanks!

[1/4] block: move blkdev_{get,put} _no_open prototypes out of blkdev.h
      commit: c63202140d4b411d27380805c4d68eb11407b7f2
[2/4] block: remove the backing_inode variable in bdev_statx
      commit: d13b7090b2510abaa83a25717466decca23e8226
[3/4] block: don't autoload drivers on stat
      commit: 5f33b5226c9d92359e58e91ad0bf0c1791da36a1
[4/4] block: don't autoload drivers on blk-cgroup configuration
      commit: c4d2519c6ad854dc2114e77d693b3cf1baf55330

Best regards,
-- 
Jens Axboe




