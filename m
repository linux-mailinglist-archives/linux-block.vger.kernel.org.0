Return-Path: <linux-block+bounces-6615-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3BB8B3CC5
	for <lists+linux-block@lfdr.de>; Fri, 26 Apr 2024 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098071C20B5A
	for <lists+linux-block@lfdr.de>; Fri, 26 Apr 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5075439FF2;
	Fri, 26 Apr 2024 16:29:31 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEF156674
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148971; cv=none; b=Yf8ca9EFMpaC7IUq9VQBiU9bpWU8CVPPdOn8LuWyws16nIdAZoNDr92aa+rT15oN5o1v2lgRUXBjzA5pmgi85Pd/KDGJQOAvzptiUbBQvd/n5jo63P8v2i/qKElpUI1rJkKAuQhnYPUbZt0L10rnUsaqssqZSsdgblr4A57jFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148971; c=relaxed/simple;
	bh=Xzf0YrsQaq3PqDI6eFn5IeYiSpav42bGXqVpMPnHWsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EdjSWTLbeust8UtNiF4R8UqALZqkKKWA6yKfoo/kgcMp/mXdyME0pCF7XXVURJj+tkUCjj4fPuvHeyeu7iAzla3DgiABL2Gs+X99ZWRhmejS8br0ZoLBAqzpbcIXo5h5cWPa5g6Szo5+LDZOJwzCbMBcZNCgb3tsDl+nfpC2L9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b6d36b71cso15661926d6.3
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 09:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148968; x=1714753768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sExa2HFzs6PwslTUWtqkQ8fa6GIAXsJ9dTc0im2HLsk=;
        b=f+r8IuPke+LVh8pfTHTH/DZoy+TlmJazS4qDS0D3a+yZ0Z0d4NXb7uMZAPceJ9RBcF
         argG52d8RcBHXsIs7sdEfiB9aFhvOHei4bEgTEvRj23/YX5++my2RW44EBLIR76vV4PM
         gAeZ63zLB0/Nf/JIyWEZtjWnK6lRCh6Dw7bRG6wR9dz597FsJL7rPTA0VvE98HY0Rr3t
         5dEOUQVaUNu1c+x8gzMtazJGbapaMhjf3WubR3fUSxXQeMiCCrKil6cXlUueAdf0QXLk
         TPf2DDv+aXJwNMtSFh6JJ+tN/9vuUze5BLykYn0ionbACbQ+U2Q0cr+lhabkIWN7wcIc
         Mkkw==
X-Forwarded-Encrypted: i=1; AJvYcCWpFojutXMRSZLTWSXcx0mus4AFnv5J3PWBkYeUIuCaHMWuH2BxMOrXrHIK4dY15Mc/wO9icfG5vRu0VF1uc4TlP2Rru0rn3s9HofY=
X-Gm-Message-State: AOJu0Yyjj63Z4ahgwzFocDV5etjXWZq5Yv/hBl3bR6+Lh+Mo7k+vd3En
	BXvET4ZmEBubVqS3v8SA4D7wwWG1EZqvbI3HdE0SJq/214Y8y1qYN5w6c/+cUMPSsvpV+L8xlmY
	=
X-Google-Smtp-Source: AGHT+IFaxf6nB/nrsjiYwz4onRFf5tdc34X1Sp55cv/17zHOi1fY4ofmA0rk2+2+YwLoaEXEpMEQQQ==
X-Received: by 2002:a0c:fa81:0:b0:6a0:a92f:956 with SMTP id o1-20020a0cfa81000000b006a0a92f0956mr3093619qvn.56.1714148967818;
        Fri, 26 Apr 2024 09:29:27 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cf0d1000000b006a04769b5a7sm7975359qvl.110.2024.04.26.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 09:29:27 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:29:26 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Matthew Sakai <msakai@redhat.com>, Ming Lei <ming.lei@redhat.com>
Subject: [git pull] device mapper fixes for v6.9-rc6
Message-ID: <ZivWZtBH77F9v1f7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.9/dm-fixes-3

for you to fetch changes up to 48ef0ba12e6b77a1ce5d09c580c38855b090ae7c:

  dm: restore synchronous close of device mapper block device (2024-04-16 11:32:07 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix 6.9 regression so that DM device removal is performed
  synchronously by default. Asynchronous removal has always been
  possible but it isn't the default. It is important that synchronous
  removal be preserved, otherwise it is an interface change that
  breaks lvm2.

- Remove errant semicolon in drivers/md/dm-vdo/murmurhash3.c
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmYr08wACgkQxSPxCi2d
A1qSXAgAsmfo5nV8/tNsrG3aBYN/rbGyEQaKl+m3eGK3T874WyrbW/On5qfGzEO1
09O5jNEMhkEHBQq6tKu/Gp87xLVJroIOMLTYpmCg6nnlwVIifFy1uuaBFA1xgM9U
xf7myg6fRj66Yjwv0y1WmTaQTX30s9alJ7f/PZQT1MJFhGIuHPIns3bsyZ43RcOl
pNkS9jjdHkDpXK/cWseb9mz6TAISa8Fn2NYkDPvq6r/J/aIxhRiHlhlzFuQnnfkH
Rg5GVg2R/yCZiGQpuA6IqfEX6eqc4HlZa5Ty2zj9BjUhmj+YbuLEKj+uMEB6wMPd
uK7uWfkxZYvsBAdaFfSpU8XyTumaAA==
=zK77
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Matthew Sakai (1):
      dm vdo murmurhash: remove unneeded semicolon

Ming Lei (1):
      dm: restore synchronous close of device mapper block device

 drivers/md/dm-vdo/murmurhash3.c |  2 +-
 drivers/md/dm.c                 | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

