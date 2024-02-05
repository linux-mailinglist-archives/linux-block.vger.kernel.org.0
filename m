Return-Path: <linux-block+bounces-2911-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E2A84A062
	for <lists+linux-block@lfdr.de>; Mon,  5 Feb 2024 18:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A7B281031
	for <lists+linux-block@lfdr.de>; Mon,  5 Feb 2024 17:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55138F9C;
	Mon,  5 Feb 2024 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xKBvo8yv"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30344C6A
	for <linux-block@vger.kernel.org>; Mon,  5 Feb 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153391; cv=none; b=NsmSZtFBKb/hYeoJM0gFVvLhPEH6mBGK8Lq03JJB8HQY0/b7KgiK6yetG1147oAkPYWlQqkJvP3TOW681xe57tSvWgwFSiZy9wEHiXGmjuaHFlzqbccHgHgsUjmIyGXSsNhJ6Ui/Twmy5+PQRvYUGBuj7sYSVbdmc1pXKstyVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153391; c=relaxed/simple;
	bh=piaR+OlvSafD8F9Muj4jdMl0CtYQbMZ6TzkK428/s98=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pb8f7QL+xqwS8ySJWIYAfGIPIJ/KuVa1MmMmlkaqqx5ySJ22L7+tigHgG+KtGzWPtGkUsyzejKnFpZ3gQIeUQ6Lemqnb1+TPMnOFruBMabgC4fRan41kZbeBVcHi4LROPB/NYPvnEnDsC3olPqSefyJRp+AFVK/0m0OagmSP/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xKBvo8yv; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363ce7a4823so594585ab.0
        for <linux-block@vger.kernel.org>; Mon, 05 Feb 2024 09:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707153388; x=1707758188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn9JODr/JoAaSiGEhGpmDiigEzzGF4d02eSYaBgfml0=;
        b=xKBvo8yvMUDgPC0HrVnmgUyPwvNnjCn76URLRnB8xXGKiE4Of33of9UHg99IwH+y7z
         5xFE+QhGN0c3y6dGdWcUx5m3H9/KqX2N7/e82jrHve1Oj9ynr6kKTNFJh2Q+YmbnpkgH
         8gbsQBcInn1FSEXw54Gfw27csdMEeK8JgQHUgP1y9v8G1pM/TrT/b7E6ZIRaZJn+F4fn
         I+W4kUTezPMz1xtdKJI64VKIH0lMVnnljJTRiS4UJAfzQ+JAAKVomchNScMAbuSkKcj1
         +15iHAxDnJRV1e4Zwn7A60fwL/sc8jEfjv689CCvqyiGNOZaFcNdU4ksgpKqEI396iDr
         Q5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707153388; x=1707758188;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn9JODr/JoAaSiGEhGpmDiigEzzGF4d02eSYaBgfml0=;
        b=Mero4Ljgx0J1FdtS6q2l7MH063dcJ5Qk4uuffSUnNQzgWSkD+FmpZ50odAm+wFc5XM
         a4riWC6tJqdJJ2C65TC7+I14jzZOMT1Yt+XFtAWDHtaWRMDGkFDmkQDQlvSC60/7k6Mn
         bCvh3INGwIOCqSwbIn4ETrRQ+cocxkvSZlzM1+Kk/sYHk2L+SR9onaLiFphTMsceHSxP
         fNAqE8sw1vkZ4Ol6laWyuVzOt6HZ0W8KZQED4+Yn+k5dSzjlpiU1vRiL9BrPzXd3im6C
         Z/z73eKp3jcxdBqh5mg2vYYKwJZSUN8I9v7lrCPjBY39+7OKcPQdAaVHqgp3rCbMTmca
         ncOA==
X-Gm-Message-State: AOJu0Yx0jpWO9tNsx8B/1mEDSKnOGnOBFkFghV7G/hTaBXRdsxle39tY
	hLKchS/IA9gefxANlDb8Z4Gp5+yvqhlbCZ0Id/C1l/mkbLl5osFhsjlIdTgtMvE=
X-Google-Smtp-Source: AGHT+IF9xzHnKqV2+QFxIe4MP6yuw8AhazZJSLemHsDNED3aABwGp5oU+CSGl6UoDPC7tTCpMoE/ew==
X-Received: by 2002:a92:c26c:0:b0:363:b9d6:126a with SMTP id h12-20020a92c26c000000b00363b9d6126amr439549ild.1.1707153388555;
        Mon, 05 Feb 2024 09:16:28 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUrkCvJqfZ0mquUR3S2ekjLknyUXgZyySSTKgxjk3t4MKFUWRnYDJOteX+ZDPI/odTvcid6HF38RUeLjVNFyblhKXUOvxqEoxyKT+tBJhoJkKAqBpME3YIv+Z7DsnuEKv/RupbOLoeyJF33JZnX1n1Q4dVot2qvM/El75dYZSwE8laH4uuthX8oowiYTS4UIEli4Ok3wLs=
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id k1-20020a056e0205a100b00363c4838148sm26844ils.24.2024.02.05.09.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 09:16:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, Tang Yizhou <yizhou.tang@shopee.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chunguang.xu@shopee.com
In-Reply-To: <20240123081248.3752878-1-yizhou.tang@shopee.com>
References: <20240123081248.3752878-1-yizhou.tang@shopee.com>
Subject: Re: [PATCH] blk-throttle: Eliminate redundant checks for data
 direction
Message-Id: <170715338749.494668.12422641038980561010.b4-ty@kernel.dk>
Date: Mon, 05 Feb 2024 10:16:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 23 Jan 2024 16:12:48 +0800, Tang Yizhou wrote:
> After calling throtl_peek_queued(), the data direction can be determined so
> there is no need to call bio_data_dir() to check the direction again.
> 
> 

Applied, thanks!

[1/1] blk-throttle: Eliminate redundant checks for data direction
      commit: 3bca7640b4c50621b94365a1746f4b86116fec56

Best regards,
-- 
Jens Axboe




