Return-Path: <linux-block+bounces-2828-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA788476DF
	for <lists+linux-block@lfdr.de>; Fri,  2 Feb 2024 19:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CE7284A0F
	for <lists+linux-block@lfdr.de>; Fri,  2 Feb 2024 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092B2148FFF;
	Fri,  2 Feb 2024 18:00:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511D45BF3
	for <linux-block@vger.kernel.org>; Fri,  2 Feb 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896843; cv=none; b=e8XpvanwyScS45okMHzU7hzYDiZcEdCVD7ccN9u95poauNlKozVYYTek3VIDxmD0v4voOM7zLuN9QvC+X72MdmsQ014dC6lnhppVsrv4p+XruMjW3EWhZhpOnB0ce2aR109uDh3+7AXSl9R6ldzyO94IOOXXGyC1cNAmJUbGI70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896843; c=relaxed/simple;
	bh=91UoMQHdvKhLLV+iS2XlYfjN49Un9UdaXKx0pSuvHUI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CWK/82rqpB0g6XxElEsgKE8cPt6O4GjkhyKwNi7VtL5hMcr7KReyJ4qT9j3nIyk2GDdZXh7f4Ex8Ac56aBtlPWnw4Bs58njNqs+WpmrZDZ27zpVxwkk8MdaFhlVUPk5rHEtpv6lgHlFP7norjdnPDJbyndXxv+2+s1MNB1jf3hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-599f5e71d85so1495775eaf.3
        for <linux-block@vger.kernel.org>; Fri, 02 Feb 2024 10:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706896840; x=1707501640;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uxe0Pox3nCPQeYCGVFRmgrhBPsjnwvAw8Cx+/7NHlm8=;
        b=Pgjy7fJQQ7o85cmWv7N4sLZLMcY23gFG1JkMtE6f1ILbFfH6XKaVz0ChWTFqR42tqO
         yd+X4QdT7ap6kPqdAt0oLYmfqGepZ6j9IShHuAc3h6NKxKO0b737KFxFWyBmaytsPoEe
         hGLMhnWr8XBn4nWDGYGi2txE/vdZ1yn9aXPapo8X3DF+qqMCLIEH6SGI3bEUBHV3DM76
         dtcdFlmHkHOrI05NRulIwOz6wy32DGn0pm2GNvOfMDOjf3gUenvuah9ZPEfdnB6oHoEs
         1utBKwS9UeeeI0XQPR5EjY3cLI0gMedbyRVxW3hz8chWaPjf5LLdWfuRzVCvy8dXJRIu
         bZzQ==
X-Gm-Message-State: AOJu0Yzjk7yJcGUIodc2eZclQ/tHjcQ2k9ATzNyoC/Q85lEnL8RJqMVq
	OR9lvja4vsmcTyz92bNzw8ML0FIhr4OqT0A/+suu3tU6dL12sogi1gRSLsUdqQ==
X-Google-Smtp-Source: AGHT+IEyl1ZAh4nsb4iyLjSb5vsiuy+bj3K4FAazNzFmrILUmFuiokvB5W25XiTwE2f10RIdXCbnlQ==
X-Received: by 2002:a05:6358:704:b0:176:4e7d:f30e with SMTP id e4-20020a056358070400b001764e7df30emr8602483rwj.14.1706896840111;
        Fri, 02 Feb 2024 10:00:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZtjzYo9hdxAB20P+0xZzuTje9iJLYb3hQ0WQRJrYnlnMP9nj0/mDMUZ+RHsDxPiSHTtDZvi7QROu1TejyVIG7Z9qf1MukyG/fUgI6/mhYc8wFxx6AxFNi/4krqFPKe4qDFkL0yn7TshG7YDRArNpeWdHbrobUOPULuhkJUnRDL74adHcC
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id of6-20020a056214434600b0068c87e3c7c4sm304761qvb.2.2024.02.02.10.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:00:39 -0800 (PST)
Date: Fri, 2 Feb 2024 13:00:38 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Alasdair G Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 6.8-rc3
Message-ID: <Zb0txmt9K4MMHst3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.8/dm-fixes

for you to fetch changes up to 0a9bab391e336489169b95cb0d4553d921302189:

  dm-crypt, dm-verity: disable tasklets (2024-02-02 12:33:50 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM ioctl interface to avoid INT_MAX overflow warnings from
  kvmalloc by limiting the number of targets and parameter size area.

- Fix DM stats to avoid INT_MAX overflow warnings from kvmalloc by
  limiting the number of entries supported.

- Fix DM writecache to support mapping devices larger than 1 TiB by
  switching from using kvmalloc_array to vmalloc_array -- which avoids
  INT_MAX overflow in kvmalloc_node and associated warnings.

- Remove the (ab)use of tasklets from both the DM crypt and verity
  targets. They will be converted to use BH workqueue in future.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmW9LCsACgkQxSPxCi2d
A1qILwgAmL9XOtavSKJ/8o9scJygutYpNSLE0f6mdkdCgJB2nknJ1vR38bXyDpNr
X3s6QC5TqKTtG7DtRTfnZc8zgtBHajjUZTFBu1NUF9kgNQcrjG3jW+quZ51pxkV0
1rvzOiYts6ca8csbFViMPS9FJVq1h3PnAyrkhI0SUS7+jEvDZy/QIX4DP20ye9SX
wKguOSK544haSLHPNYuZqqCEoTBF+Vh1k1gDkxr594NwjsIJJK0+HGelamjzN/96
/jr88P4bm/6OIVdvwTUefnpIhNIum1Dfa8QWciKOzuct0jqsub65+SUSoTLmoiY4
/3AZDvp0ZMEwpMAvCIyvHnm81K72MA==
=sioN
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Mikulas Patocka (4):
      dm: limit the number of targets and parameter size area
      dm stats: limit the number of entries
      dm writecache: allow allocations larger than 2GiB
      dm-crypt, dm-verity: disable tasklets

 drivers/md/dm-core.h          |  2 ++
 drivers/md/dm-crypt.c         | 38 ++------------------------------------
 drivers/md/dm-ioctl.c         |  3 ++-
 drivers/md/dm-stats.c         |  9 +++++++++
 drivers/md/dm-table.c         |  9 +++++++--
 drivers/md/dm-verity-target.c | 26 ++------------------------
 drivers/md/dm-verity.h        |  1 -
 drivers/md/dm-writecache.c    |  8 ++++----
 8 files changed, 28 insertions(+), 68 deletions(-)

