Return-Path: <linux-block+bounces-28896-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCAABFD91B
	for <lists+linux-block@lfdr.de>; Wed, 22 Oct 2025 19:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E033AA5ED
	for <lists+linux-block@lfdr.de>; Wed, 22 Oct 2025 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3327A123;
	Wed, 22 Oct 2025 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yYhkhmFO"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70341C862E
	for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153270; cv=none; b=L/ImtDVuRDzlx/MIViSAZPIzgePtKX2N6vbNbJwn6JUplqlc5MYwcen/sqw5OVcHRttIGLRNiim3QxyR67fu6MgwysxvvdIr1ZPIG8+Tg2QMsRStLsy0joNasfFFpsV4JZk0Gxclc0ug4qzDwMTJpZqJ2qh6BhChAoOuIN09kxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153270; c=relaxed/simple;
	bh=alRvOln8Nm7xlD06ADuHu4fWBMIFmyhc0+nC9Kjtgz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u092sajrctMJ5Lt13sPNq5N1M+Wj3buVwmBg6lvHx7yzWaJM5oYFZYrTWoGppzMDz4YNvgbHI+GWkl4sywxmbjoQL6c0bisg0znlZs+kmLlHNMGZZdov7y0p2BpN/rSTI9tjjkIx52l+XDEm/o05aymzmFsTGSD3yV64QzOiX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yYhkhmFO; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430c151ca28so28236085ab.2
        for <linux-block@vger.kernel.org>; Wed, 22 Oct 2025 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761153268; x=1761758068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=yYhkhmFOGHZ79ceAeRzsTTx0uIufp2jrNynNpQGjS7S+3KCfVr2bpmUpwJYH/OkF+1
         b9mIzOGpiNrIrauCc69AFuJoYt3+qRbNIDK8l/4rRoFv6Cw2ac1uqGl5MnnGe09P1vES
         qv2URYzJ5eGZAYcdCZ65BvMGL1rjbFXYFFKOXkToGWXhxLTr5UoPZAH1+0cQuiacRG60
         tuTcGb5GLXAAeOY2pikrwWIS8Ci5qQOt39KHYEsmsRNtXwZEVoBPhLkvlSgnITJMv7Cy
         58Ai49HfLjqrdEd54yvYAU1xC5SThHzljHjD3mvlCyer8zmZ1zWm+tnAWBVII86K4Ets
         7f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153268; x=1761758068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=fQ9vgwMznmOPWRt7GEfX1RwqMUPpjWCjPmo5vEN86oCO6aQlRZHe6bqWM3c87smBkt
         kX4EHkNmDQ6wo8ZkAqVPXZPd+KK9ia877A+JIuLKd6COcz1BEc6SNesrGJoSg1ZkI7xO
         1bUNCuoqhqZLahNAh2DimVvLV8GCSOjP7gHjTarzrQT2XNPvtUNvkjbd833idyQuZUkM
         A1b7MiweI5w8PvD6B0AjLstITkmckRbRbpTO8FaaFH33yKh/r31PgG21HYIZ5DhEHJIb
         o/pvS6ZDVbZ7wiJoLHhsQ+41RAZrx6jdY+/c1txyt0dZMs2KiJZPKUPa+58fK6kJnZHc
         Pghg==
X-Forwarded-Encrypted: i=1; AJvYcCX7eXgEAJ4wCNmk8dXBZx1NGozX85mAuD4rkdladkeE0wSsKXaz54RKrWEAaPlWiwo53HD2g749hkdTiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XDaHGcrFSdhBLncJrGZ+rZy6lnO3oo6TGlu//2JAfzzG5Rop
	Rx2UMi3nQABMHi8iJxuIDm2mNaL/HRBgVSxtmrUu2W2HwaRMrJq+rxHavRisGuEwEKI=
X-Gm-Gg: ASbGncsBXQECes+F2bruMsmzIZGHT5eh/TVAHQpUpLyWvFWZqPxMQDLFmNYiHlFF9U/
	hLjTz0umOVCs2/lcrQcdRQFQyX0Gwm7Y5EniWIrM/h/mjClWJwZcPDCcp5UIsnzFfkQWHkmFO+t
	xcUbu1k4kPvoZh4+DFkEbUOJlkOvI4JEhYvo1p/QfZAqHlFCutCTK8dX1j0zKrK8vMlV+7TBVg3
	N394c8DWKTMBeJyw2MV7wfXCKjX8YJk+ZZPJ1f54sAojFi9kkq7r7dWa8ksGu9TPSMg57i+2evl
	W38wIHF9Zfy0qfGTMgcLOUoNk8Ptw6iKWnSIMp8wbcTqMcyOLg5tS/VgXR70WgjTIsdjqs6er6+
	z0K5hKhaGbJvYopSDd7AJ7ysVH/iMX+ca+SzV/3vPS6DdCn9u9/j34mPEmNb9+uM9MPSnvoxkTJ
	bvaw==
X-Google-Smtp-Source: AGHT+IHTj61GCU43Ny9CqJZTcArqcqLG4N55exTJ/CO6XywRSm8cR6B046X/oK+en5lUBxrNojHA2Q==
X-Received: by 2002:a05:6e02:1a66:b0:426:c373:25f5 with SMTP id e9e14a558f8ab-430c527dc0bmr294941715ab.17.1761153267700;
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a82ebsm58994535ab.22.2025.10.22.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: chaitanyak@nvidia.com, dlemoal@kernel.org, hare@suse.de, hch@lst.de, 
 john.g.garry@oracle.com, linux-block@vger.kernel.org, 
 linux-btrace@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naohiro.aota@wdc.com, 
 rostedt@goodmis.org, shinichiro.kawasaki@wdc.com
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v5 00/16] block: add blktrace support for zoned block
 devies
Message-Id: <176115326663.119946.495631617143867642.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 11:14:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Oct 2025 13:40:59 +0200, Johannes Thumshirn wrote:
> This patch series extends the kernel blktrace infrastructure to support
> tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
> ZNS) introduce command types such as zone open, close, reset, finish, and zone
> append. These are currently not visible in blktrace, making it difficult to
> debug and analyze I/O workloads on zoned devices.
> 
> The patches in this series utilize the new trace points for these zone
> management operations, and propagate the necessary context to the blktrace
> logging path. These additions are designed to be backward-compatible, and are
> only active when zoned devices are in use.
> 
> [...]

Applied, thanks!

[01/16] blktrace: only calculate trace length once
        commit: a65988a0ad047dbdb8a1eb6f07540b980858b522
[02/16] blktrace: factor out recording a blktrace event
        commit: 472eca538358fc8a56884a8adb0cc6047bf05cf3
[03/16] blktrace: split out relaying a blktrace event
        commit: 04678e72e95f4165d58442b3ed108e06605984df
[04/16] blktrace: untangle if/else sequence in __blk_add_trace
        commit: 70e3c62b891281b94b9d449a381e033ce592acc8
[05/16] blktrace: change the internal action to 64bit
        commit: 370cd70a402f972f6d7a7e54ba5a82d1a72c762f
[06/16] blktrace: split do_blk_trace_setup into two functions
        commit: 42da88a724d8a3b92ade35ae2ef4d5e5a491df2d
[07/16] blktrace: add definitions for blk_user_trace_setup2
        commit: 0d8627cc936de8ea04f3cc1e6921c63fb72cc199
[08/16] blktrace: pass blk_user_trace2 to setup functions
        commit: 113cbd62824afdf62d2f3f092809cf37cc7f1dd8
[09/16] blktrace: add definitions for struct blk_io_trace2
        commit: c44347d606260f36a81f6d8415a5af33cb3015fa
[10/16] blktrace: differentiate between blk_io_trace versions
        commit: 915bb53860c3a6cc3dd2c9a5e0d1988ada0e377d
[11/16] blktrace: move trace_note to blk_io_trace2
        commit: 67bfa74d81bae9271f6ec72d2058d081732949cb
[12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
        commit: 4d8bc7bd4f73c6b34ba29d3e8277864c6e0a44a7
[13/16] blktrace: add block trace commands for zone operations
        commit: f9ee38bbf70fb20584625849a253c8652176fa66
[14/16] blktrace: expose ZONE APPEND completions to blktrace
        commit: 1c164fcc1b08e75f1cad1532718f09cddc0ddebe
[15/16] blktrace: trace zone write plugging operations
        commit: 3f6722816a73e2017599d965683dbe71833afd7a
[16/16] blktrace: handle BLKTRACESETUP2 ioctl
        commit: 4ae8efb4f907383a16abf3c59b353763e31ae106

Best regards,
-- 
Jens Axboe




