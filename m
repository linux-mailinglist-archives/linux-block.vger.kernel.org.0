Return-Path: <linux-block+bounces-22-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCE47E4383
	for <lists+linux-block@lfdr.de>; Tue,  7 Nov 2023 16:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839AAB20B88
	for <lists+linux-block@lfdr.de>; Tue,  7 Nov 2023 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E313159C;
	Tue,  7 Nov 2023 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="relNU1V9"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954822C872
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 15:32:40 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9581BD9
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 07:32:40 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc703d2633so8263575ad.0
        for <linux-block@vger.kernel.org>; Tue, 07 Nov 2023 07:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699371160; x=1699975960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Ji/rj2qBgxozHTNNPEhvKWWU1spdtvm+JdV3xf1fTk=;
        b=relNU1V9B+kVhRyM1ZYk2SNQOBpCPy7sp5O0sZSniHyUn4QqTvU1xga5yiqtvyi5XQ
         KHE5sgiYlqaa6WDciqDMXGgwT61jBvjoHidH/kDdpPs3BQfNLPQ5E1pdSYUTtYwMnapB
         8yaj2tveR6sBIgItQGNEgqME1F9s/BRFm8Koh6QgqAObQUeIqvdq2cXPqqaE7fPOelCC
         diKpOZDMVepiOBil4PXQo2R+vEhmgM3dVLYWpGOIH0hwjWkrbfCqz1KYbpSYWG+jr5WP
         WkhyW7Jk+IQGayqjgxTupVZbxKvTeWpPJkm/CJkRmsOU9ulRtSL/qKWTQUDs5DH9cfSy
         PfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371160; x=1699975960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ji/rj2qBgxozHTNNPEhvKWWU1spdtvm+JdV3xf1fTk=;
        b=HOvN6I1fVYNvuQS/8gKHhNy5z1QY95Q53BgACNNFKgAkd+ad1fcM22Ihe8InyOSJ+G
         8HMZ20sLDrK7jXVXIoriz7ly/JSMK7EKrQOOk1V/JfzUzUEl2rqG+VUZLJ7KVW3L+eIq
         4LTEH/z3spWny+63iX8TO0volC0ow0hcSn6iK737LVSKl9RjDFwz8AffhGM3nV/LWtQ2
         yqpievRhiSnV7mhqJtPtmaAKFL1iqEKxzjfmj7Q4XoZDJwsVvP+CNba4tYWlX1Ow3uCc
         Cq2YbgdbkGag/GbOsrgYX8n/Xu5mFMVXylKhlaQvD1hpjmrQQizqWLdbLfiRcyzLXwA0
         9yYA==
X-Gm-Message-State: AOJu0YyRDUidq1lAcFFvOuwVRWXrgxePT8e5ACluRldqTf8vuc9h2fTi
	Tl8bjfxTBGqIatj9Sg4j8BRJ8wezWmvEa+brMLN9Gw==
X-Google-Smtp-Source: AGHT+IGje4cKvrvlMmvsWmwvVisdTup3LfFtuTDl0Lnyq4WXnmKzyWfrugxCSRJA1lkdM3MqBi4ysg==
X-Received: by 2002:a17:902:e3d3:b0:1cc:2bc4:5157 with SMTP id r19-20020a170902e3d300b001cc2bc45157mr31464645ple.1.1699371159556;
        Tue, 07 Nov 2023 07:32:39 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902b28900b001c72f4334afsm7724041plr.20.2023.11.07.07.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:32:38 -0800 (PST)
Message-ID: <73072f69-0e36-4b5d-88ad-3d9df577f9cd@kernel.dk>
Date: Tue, 7 Nov 2023 08:32:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7 v3] block: Add config option to not allow writing to
 mounted devices
Content-Language: en-US
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@google.com>,
 syzkaller <syzkaller@googlegroups.com>,
 Alexander Popov <alex.popov@linux.com>, linux-xfs@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>
References: <20231101173542.23597-1-jack@suse.cz>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231101173542.23597-1-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/23 11:43 AM, Jan Kara wrote:
> Hello!
> 
> This is the third version of the patches to add config option to not allow
> writing to mounted block devices. The new API for block device opening has been
> merged so hopefully this patchset can progress towards being merged. We face
> some issues with necessary btrfs changes (review bandwidth) so this series is
> modified to enable restricting of writes for all other filesystems. Once btrfs
> can merge necessary device scanning changes, enabling the support for
> restricting writes for it is trivial.
> 
> For motivation why restricting writes to mounted block devices is interesting
> see patch 3/7. I've been testing the patches more extensively and I've found
> couple of things that get broken by disallowing writes to mounted block
> devices:
> 
> 1) "mount -o loop" gets broken because util-linux keeps the loop device open
>    read-write when attempting to mount it. Hopefully fixable within util-linux.
> 2) resize2fs online resizing gets broken because it tries to open the block
>    device read-write only to call resizing ioctl. Trivial to fix within
>    e2fsprogs.
> 3) Online e2label will break because it directly writes to the ext2/3/4
>    superblock while the FS is mounted to set the new label.  Ext4 driver
>    will have to implement the SETFSLABEL ioctl() and e2label will have
>    to use it, matching what happens for online labelling of btrfs and
>    xfs.
> 
> Likely there will be other breakage I didn't find yet but overall the breakage
> looks minor enough that the option might be useful. Definitely good enough
> for syzbot fuzzing and likely good enough for hardening of systems with
> more tightened security.

For the series:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


