Return-Path: <linux-block+bounces-11169-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC496A367
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3304B26129
	for <lists+linux-block@lfdr.de>; Tue,  3 Sep 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65C188A21;
	Tue,  3 Sep 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WXrR46r5"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C803188A03
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725378999; cv=none; b=M/PoTVyDw9MMamskCP1jj6RVJPZyTlHCByUf/dska7G+eD46Uk7CRD5LUfCzW2cUooWlZYZ/hhm7n2rwquGpNy6J1uU98Wj/KIYR/F6q+UczKHohN5au/B37X7zBU5Zwu+fWJLqZCv12FH9R83l579QqXk867yWRAGj/1HeHvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725378999; c=relaxed/simple;
	bh=x9eBFNYcmSA+F605zh4BXbC0+qNWOIIN1Ef2O343EAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tYfk50DkLktBybiszt6L26lJx+5QLb/fkV0H9c4jUlGvFr5OzpM0dn5aBF1XAGMUsIj+Co7BB+yf5G9q8j3ZpChEB9v2UwRpDvQSGdo3DRQtnqbK22VO7i0mccQ8nclM4zMAtrItp4+wqTls99TJZs0AUCon3PebCWiywwa0d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WXrR46r5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2059112f0a7so16343265ad.3
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2024 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725378997; x=1725983797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/vwR2rDKW/EcPbbGEGYrWhFAP7Mg7TTorU2MbfDU1U=;
        b=WXrR46r5XGUsb2QnruCO9Agquo1AISPlw+yEdvS6E2swbJAUAbOYkiHDVqJSMYa0Fe
         u2jjA/YtOP5YWX65sh3ZjFhqxAoZVFD7f7teKcnsaTgKCGdPWFb/USmN7YKsqbO79LZe
         dqE/2vOEpTq52MGwJxFzP+nOfsb/K7FplIjElCILxBYBhx6SlLw2QYLfIFGvTPy39h3A
         p14txsCCT8uQFCmravaOxieijWRhFFh6JPYwh8duHTDBvqVT8xrOvK3hmMgr+KqLNJlf
         XSqE/HXf22SNbYD7Q2QkrE+5XCCdmfRHIz1I0RbBDMFDG+dFagQFyiZ0aK/UfFf1QZhb
         Tc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725378997; x=1725983797;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/vwR2rDKW/EcPbbGEGYrWhFAP7Mg7TTorU2MbfDU1U=;
        b=ECk759BGioi/RuO7MP67FmMk2E/tud0JZ/IqC2IwLkzyp411QsGoE8cUlaQzVhuLiI
         kLI1N9xlQ3OI6rV3yDIdiiwcZzpQxufNmHZWhc0ps15PAOSte7uRfTDub+3sk7r0ZB8n
         iXGZp2THNJBYFRyVXGcmTvcFVaUmJiR8VmFFVPE6l2b5+RHyqJP1P7Y88WKeSqHtmJOu
         6DEGvIB0kfoTr1yvZulWzpUD3/6tLoPpxs/hVp/bUL2tOVEkXK6mfEqk2rbYGCuCVUJJ
         t/78VVCzuPegHh5B862G2jcN00JqMEjwKDAjhqxCKRSm/V32VU6G6Ra+JlJKl5TJXpsM
         FDUA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9dHlXzSE58NkTCjtE/Y6Zto12kPIME6gdiS6bYn20OXQXHfE1juU7b92HRxs3YFgy6NRJnJGUpVoSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJmh0ISLvxFt5g8qzZ5YA+xwR4IhWZteNL/NneEohCYCu7dJN
	FYY/zZ1gdG9v7XhA1f6mVJYI6T932ecdw2bvZnroHRhWhEJ7CbnzZtU9mLBXbCU=
X-Google-Smtp-Source: AGHT+IF7kSJ+TJ/wY2n9i+uShTgLH1ufLH8yQgQU0p1Oius38tmTwi2VRPtkqZ1g4h2IW07ttzBsjA==
X-Received: by 2002:a17:902:e552:b0:202:2f0:3bb2 with SMTP id d9443c01a7336-2050c496431mr184803755ad.60.1725378997293;
        Tue, 03 Sep 2024 08:56:37 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68a91sm142255ad.288.2024.09.03.08.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 08:56:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, 
 paolo.valente@unimore.it, mauro.andreolini@unimore.it, 
 avanzini.arianna@gmail.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
 yangerkun@huawei.com
In-Reply-To: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to
 bfqq merging
Message-Id: <172537899519.20156.7615001741383878457.b4-ty@kernel.dk>
Date: Tue, 03 Sep 2024 09:56:35 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 02 Sep 2024 21:03:25 +0800, Yu Kuai wrote:
> Our syzkaller report a UAF problem(details in patch 1), however it can't
> be reporduced. And this set are some corner cases fix that might be
> related, and they are found by code review.
> 
> Yu Kuai (4):
>   block, bfq: fix possible UAF for bfqq->bic with merge chain
>   block, bfq: choose the last bfqq from merge chain in
>     bfq_setup_cooperator()
>   block, bfq: don't break merge chain in bfq_split_bfqq()
>   block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
> 
> [...]

Applied, thanks!

[1/4] block, bfq: fix possible UAF for bfqq->bic with merge chain
      commit: 18ad4df091dd5d067d2faa8fce1180b79f7041a7
[2/4] block, bfq: choose the last bfqq from merge chain in bfq_setup_cooperator()
      commit: 0e456dba86c7f9a19792204a044835f1ca2c8dbb
[3/4] block, bfq: don't break merge chain in bfq_split_bfqq()
      commit: 42c306ed723321af4003b2a41bb73728cab54f85
[4/4] block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
      commit: f45916ae60eb60e7c9c3ac60cf07e66fe1a7faad

Best regards,
-- 
Jens Axboe




