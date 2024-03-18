Return-Path: <linux-block+bounces-4614-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6587E1EE
	for <lists+linux-block@lfdr.de>; Mon, 18 Mar 2024 02:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB96E2821B9
	for <lists+linux-block@lfdr.de>; Mon, 18 Mar 2024 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A41DDF1;
	Mon, 18 Mar 2024 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ff5Rlm0O"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B501CD23
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727152; cv=none; b=qqQq7sMxLSmyUJnB2fa3HdlaiNzBSx8gwKosFt8o9asTupUgawQSCAYfVgk205wcFPZzl2t8nGQcaUYsdJm0CyrFsp1Vj1r7Rw31pc6Rfu2mGCkghlIPOW10hLCSeHNWIENH33/Dw+gy+NkasaR7pm6P5ypU6Wzy8NduOB/PoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727152; c=relaxed/simple;
	bh=FqUgQgxrfZtI2qk5V+CbuvudPfEzb8SHu5+APKjhAeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ic4tFSKcWd73kA0nrK5HZgr6A9Sn0Tj0bV2qDezHZ7SRtxgNihVMWvyDNkEcPqcGkhDHFGtZM6m4rXeL5vrmF1vFs7CBWU5jND9yVIzdQDRWOnO97bBjpP6vIVVBnBQ8MbKm04j3mV3uC7VqrpSOcK+VzgRXNZRh8UErTAhgenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ff5Rlm0O; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso2479983276.1
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2024 18:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710727149; x=1711331949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+xmMKXEK467msfGN/zI+NTXm1eyrFZs4w/DgUrLeb0=;
        b=ff5Rlm0OqJGTFufoNSAdBwVZgv7YQzDUK9LuTVsnWNeAxL5/lYtce8A5c+meoj3Obz
         uqGggRKfDFZv/PGw4gSjeiFY4IeYNS+bzjThDxuKBKdBCmepGBkqQjkPw5dBgHQ8+Xsj
         sbBqjbKUEDYtsoLeCJsyIz0qz3ZgGK4uJV7oN1ATAtVkXc5VQaW33doPJSa06C0Zdvwj
         6JKSm4lwAVu6uEBacnUqjWkYDSa2SezmIIKE5ILy4z9ydb0MXrvDwuCGtltbZ5wNbzB4
         n1/ovTasoLwc74tmSXWCVB1HimrCWeQVlnqVT2nbZeAn6eWRVNUMjKX/ZYD4J1K5qH0x
         fzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710727149; x=1711331949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+xmMKXEK467msfGN/zI+NTXm1eyrFZs4w/DgUrLeb0=;
        b=JJw8cmeg0hFwbQ2imeZ62t5DmBNUZePeydLxAocwDqq0C6zn7Lgg/RIgs7Pzf06i4W
         MatLYZ3g05T74TpDchXsI0F4cF5ghv/envI3HVQO0UV+jaReZkqOQuJOLF8vW99vRfnh
         Dis6C1Dfjsdu5fOqZJjy0PhbqZ+Ji5pvdr+Pem5TgKblYZfF32ehxy6q4zlKXXngZy1H
         wJb4bAgvdSOpY28INnr5ElTdrJw6eJH+gHlIVZ8rabsSYoCQJ89QYshirvXuy55g5ZTL
         sxAWraAjrExEoI7//e3oc2WUG1nwJn5S4llqDhw2famj+HotzOLBT6GxzFI9+UrH4X4F
         iaTg==
X-Forwarded-Encrypted: i=1; AJvYcCXQCmXT66V6yVF3Bw/m2aBuvdzb6jVEwpGnKk+zI1wyeIo36f4OKnBnCzAf2jWWOptLe854oCTEEOww5QWSMDALd9Vs8skIB7eNjfU=
X-Gm-Message-State: AOJu0YzMTlSaw9LPuNb3iLcj/AzA7wALNkZO1SDmYPYt4PjgeUfygVAW
	235TWD3KgXKNkqZ2N8imeRWeTX/oSxE3LIsdhzWa4UsdpW/nKC1yi7fmb5fMNdnAlt8zIY9E5vY
	Dwv9YeDcC/oQr4Bk+Q438qp0SCEeNRN3S7kRg
X-Google-Smtp-Source: AGHT+IFvxqCFh/zzQZhmtHVeJ4wKXtt8mxhTmxAcg93TKyWxNqDHIDARX3X+xrhcmbPvVzgaKwOoMXL4saPB2bh9WMY=
X-Received: by 2002:a25:abef:0:b0:dcc:e854:d454 with SMTP id
 v102-20020a25abef000000b00dcce854d454mr8541158ybi.14.1710727148753; Sun, 17
 Mar 2024 18:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-6-git-send-email-wufan@linux.microsoft.com> <43958767-32db-4c53-8408-8367cfc14d2f@schaufler-ca.com>
In-Reply-To: <43958767-32db-4c53-8408-8367cfc14d2f@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 17 Mar 2024 21:58:58 -0400
Message-ID: <CAHC9VhRsOp8-C+bEH+NnRrBu_NRjJongAXZu_P2+c_OkDBs9rw@mail.gmail.com>
Subject: Re: [RFC PATCH v15 05/21] initramfs|security: Add a security hook to do_populate_rootfs()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, 
	jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, 
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 8:29=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/15/2024 8:35 PM, Fan Wu wrote:
> > This patch introduces a new hook to notify security system that the
> > content of initramfs has been unpacked into the rootfs.
> >
> > Upon receiving this notification, the security system can activate
> > a policy to allow only files that originated from the initramfs to
> > execute or load into kernel during the early stages of booting.
> >
> > This approach is crucial for minimizing the attack surface by
> > ensuring that only trusted files from the initramfs are operational
> > in the critical boot phase.
> >
> > Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >
> > ---
> > v1-v11:
> >   + Not present
> >
> > v12:
> >   + Introduced
> >
> > v13:
> >   + Rename the hook name to initramfs_populated()
> >
> > v14:
> >   + No changes
> >
> > v15:
> >   + No changes
> > ---
> >  include/linux/lsm_hook_defs.h |  2 ++
> >  include/linux/security.h      |  8 ++++++++
> >  init/initramfs.c              |  3 +++
> >  security/security.c           | 10 ++++++++++
> >  4 files changed, 23 insertions(+)
> >
> > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_def=
s.h
> > index 334e00efbde4..7db99ae75651 100644
> > --- a/include/linux/lsm_hook_defs.h
> > +++ b/include/linux/lsm_hook_defs.h
> > @@ -450,3 +450,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct=
 cred *new)
> >  LSM_HOOK(int, 0, uring_sqpoll, void)
> >  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
> >  #endif /* CONFIG_IO_URING */
> > +
> > +LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
>
> This is an awfully expensive way to set a flag. Adding a LSM hook list
> isn't free. Isn't there a way to capture this state change through one of
> the mount hooks?

Unfortunately no, the initramfs isn't mounted like a traditional
filesystem, it is "populated" by unpacking the cpio into the initramfs
at early boot.  This LSM hook should be called exactly once during
boot, and the performance impact should be minimal; I should also be
wildly more performant than earlier revisions of this patchset that
required grabbing a single spinlock on every file access.

Of course if you have an idea on how this could be done
differently/better I think we're all open to new ideas ...

--=20
paul-moore.com

