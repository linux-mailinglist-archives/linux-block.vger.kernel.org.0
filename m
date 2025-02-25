Return-Path: <linux-block+bounces-17673-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0694EA44E2C
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F93189218C
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CB7DF59;
	Tue, 25 Feb 2025 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="U2JpH1Ew"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AF2046B1
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517137; cv=none; b=UaiwZn0ddbEDw3YF+Kjly4DFyBMgtOA6N6BHXVN/JissQM3Fr1ZrAMbE6ePXFuRs8/DFhMQKneDQqFcvx9G5SnWT/NqQ7YUGBl6LzhM3TyBeP0dCAo+sgCcLrwXHft5PfDSPPKadHBARoglXAN7j77ZKHpslg45/EUb5JuHPTcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517137; c=relaxed/simple;
	bh=qkFTxSfJpD+0LIkxun9qCJJ9p5YQg9CwYjmtlsbI5rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVmjctfjUIcsn4OdILIDZw52K6ehoqjB4SXlq0VGypS4N8lPub+vvmIjsBpXjC4ktynDTgeVptraxN9XfSeBATae/g3xEwtKnyV1hM6Ku9sWL+/JC3Mgs/mqFk0GWuqStKdjZWqHFDoTRmlMRL4jOBG9CT48oAZtIgQxH7QXkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=U2JpH1Ew; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f74e6c6cbcso1601250a91.2
        for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 12:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740517135; x=1741121935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8kVezVrAcJKDJFMuTzmtnUuA8DHsRC/LzdjW6ubIq4=;
        b=U2JpH1EwB04SzocCP5vR9qVIc8RTbplk2QhrG4UTdLnG3dgdEWE0AzuFO/rKlX0vpn
         66uE+BspKno65MMlLoiSv3gNHBeCyIZbG0NfFpyRBjYeO5fCCpSdgx2tcFsftG4XyApH
         rqhRbHdj3iXgkKdoPFl9SoaGRg0hu9lnQFtN2V1vfA5eaw7RTs0jPHrPpcy2er07mN09
         Pdmyrmxcg81M2oPuKd11Ed+JSVA91odsew+C78rWfdq5vhnC79599ccsC8xClqptHxAb
         rN1rO1fwZg39cEtGGP+ZGIHbWmfmFEVitT6ZvTZ3PHCOQDz1zBNPgMCzM/nnmWYuUCL7
         r8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740517135; x=1741121935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8kVezVrAcJKDJFMuTzmtnUuA8DHsRC/LzdjW6ubIq4=;
        b=jZc25N8F18F9FBl7vqdOiFCw1MsrlGxAbF89XElWeGYiSG4yinkbOQD5YzUD1zXsLa
         A/AY00YkoxRw3IRj33R4vSP/qpWnifpFqplhrSSLKu6lG2vg1sVO5DOIQO62LpwB8aCl
         8fsLUmBE6RUyOQ9f360M4s3/s5FkRFsaZgWtG3W8bXHjOzHREIZuXZksG5nfL1BmvSAp
         ZpOb3/dT0uNhp4fDvY/AJDigjldxirrTWVxq8TzW+RMerWYuYOGW2z9oioDqlO7Is+Kc
         D/kzp+uH/74ok6AhFiwAAD28XLLUirCDhjOJRNBX7E+WjBbf69Ppii1btPuLSfKCjT19
         f2rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTJ26wCCGU4MUmxF4aGZIafqGU52xfn+9EaLpUsJ6ZgGinV/AGQFLongfBRdcFxV4r+fk7WYoB+N5DAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCYcwOQCCVwmas3iwNkz5AYZigWWh5HK4B73umQULXDghHxPLi
	6j1Ao3fmfB57A1M4whvjtCtqecEbLIs9CQXuoNA9CRTon6QjLMINriNTSNiZsiiv2bGu7cArhWr
	PMgvhMoTCExu9EWILu8sUc5bVrMyFPZNv/kFdrw==
X-Gm-Gg: ASbGncs7IZJ5iwmiq9zzl0ydK8ReZQvWnsGyPW8sAxT1zikN626z1Vk4Ndy+20VH0oZ
	1ScrR8KsZVOPRzr9zADqRuUiEE922BRz7FVZaPZ7tdrx1h761N6RQ/UFVj8h4+eiSk6yASh8mVR
	sZao45ow==
X-Google-Smtp-Source: AGHT+IFtCpB78XzmbgpGiWKMacJsPPZ+r4r4NuNEzLMmxS84MrKWoCpBypXNynKti/77UrzVFpai7iz8m0OUJsLRyhk=
X-Received: by 2002:a17:90b:2811:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-2fe7f51d429mr280856a91.0.1740517134894; Tue, 25 Feb 2025
 12:58:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224213116.3509093-1-kbusch@meta.com> <20250224213116.3509093-8-kbusch@meta.com>
In-Reply-To: <20250224213116.3509093-8-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 25 Feb 2025 12:58:43 -0800
X-Gm-Features: AWEUYZl9nMXZ-1DULImO5mGipJatSmFAgm4tn0bLWbkupi0yR8cVo28IU5SD5dE
Message-ID: <CADUfDZreF+YLLkE4Z+UniVXBo7HRm9nTd+O9yRVqJ9STpFJaJA@mail.gmail.com>
Subject: Re: [PATCHv5 07/11] io_uring: add support for kernel registered bvecs
To: Keith Busch <kbusch@meta.com>
Cc: ming.lei@redhat.com, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, io-uring@vger.kernel.org, bernd@bsbernd.com, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 1:31=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Provide an interface for the kernel to leverage the existing
> pre-registered buffers that io_uring provides. User space can reference
> these later to achieve zero-copy IO.
>
> User space must register an empty fixed buffer table with io_uring in
> order for the kernel to make use of it.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  include/linux/io_uring/cmd.h |   7 ++
>  io_uring/rsrc.c              | 123 +++++++++++++++++++++++++++++++++--
>  io_uring/rsrc.h              |   8 +++
>  3 files changed, 131 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> index 87150dc0a07cf..cf8d80d847344 100644
> --- a/include/linux/io_uring/cmd.h
> +++ b/include/linux/io_uring/cmd.h
> @@ -4,6 +4,7 @@
>
>  #include <uapi/linux/io_uring.h>
>  #include <linux/io_uring_types.h>
> +#include <linux/blk-mq.h>
>
>  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
>  #define IORING_URING_CMD_CANCELABLE    (1U << 30)
> @@ -125,4 +126,10 @@ static inline struct io_uring_cmd_data *io_uring_cmd=
_get_async_data(struct io_ur
>         return cmd_to_io_kiocb(cmd)->async_data;
>  }
>
> +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
> +                           void (*release)(void *), unsigned int index,
> +                           unsigned int issue_flags);
> +void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int in=
dex,
> +                              unsigned int issue_flags);
> +
>  #endif /* _LINUX_IO_URING_CMD_H */
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index f814526982c36..e0c6ed3aef5b5 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -9,6 +9,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/compat.h>
>  #include <linux/io_uring.h>
> +#include <linux/io_uring/cmd.h>
>
>  #include <uapi/linux/io_uring.h>
>
> @@ -104,14 +105,21 @@ int io_buffer_validate(struct iovec *iov)
>  static void io_buffer_unmap(struct io_ring_ctx *ctx, struct io_rsrc_node=
 *node)
>  {
>         struct io_mapped_ubuf *imu =3D node->buf;
> -       unsigned int i;
>
>         if (!refcount_dec_and_test(&imu->refs))
>                 return;
> -       for (i =3D 0; i < imu->nr_bvecs; i++)
> -               unpin_user_page(imu->bvec[i].bv_page);
> -       if (imu->acct_pages)
> -               io_unaccount_mem(ctx, imu->acct_pages);
> +
> +       if (imu->release) {
> +               imu->release(imu->priv);
> +       } else {
> +               unsigned int i;
> +
> +               for (i =3D 0; i < imu->nr_bvecs; i++)
> +                       unpin_user_page(imu->bvec[i].bv_page);
> +               if (imu->acct_pages)
> +                       io_unaccount_mem(ctx, imu->acct_pages);
> +       }
> +
>         kvfree(imu);
>  }
>
> @@ -761,6 +769,9 @@ static struct io_rsrc_node *io_sqe_buffer_register(st=
ruct io_ring_ctx *ctx,
>         imu->len =3D iov->iov_len;
>         imu->nr_bvecs =3D nr_pages;
>         imu->folio_shift =3D PAGE_SHIFT;
> +       imu->release =3D NULL;
> +       imu->priv =3D NULL;
> +       imu->perm =3D IO_IMU_READABLE | IO_IMU_WRITEABLE;
>         if (coalesced)
>                 imu->folio_shift =3D data.folio_shift;
>         refcount_set(&imu->refs, 1);
> @@ -857,6 +868,95 @@ int io_sqe_buffers_register(struct io_ring_ctx *ctx,=
 void __user *arg,
>         return ret;
>  }
>
> +int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq=
,
> +                           void (*release)(void *), unsigned int index,
> +                           unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct io_rsrc_data *data =3D &ctx->buf_table;
> +       struct req_iterator rq_iter;
> +       struct io_mapped_ubuf *imu;
> +       struct io_rsrc_node *node;
> +       struct bio_vec bv, *bvec;
> +       u16 nr_bvecs;
> +       int ret =3D 0;
> +
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       if (index >=3D data->nr) {
> +               ret =3D -EINVAL;
> +               goto unlock;
> +       }
> +       index =3D array_index_nospec(index, data->nr);
> +
> +       if (data->nodes[index] ) {

nit: extra space before )

> +               ret =3D -EBUSY;
> +               goto unlock;
> +       }
> +
> +       node =3D io_rsrc_node_alloc(IORING_RSRC_BUFFER);
> +       if (!node) {
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       nr_bvecs =3D blk_rq_nr_phys_segments(rq);
> +       imu =3D kvmalloc(struct_size(imu, bvec, nr_bvecs), GFP_KERNEL);
> +       if (!imu) {
> +               kfree(node);
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       imu->ubuf =3D 0;
> +       imu->len =3D blk_rq_bytes(rq);
> +       imu->acct_pages =3D 0;
> +       imu->folio_shift =3D PAGE_SHIFT;
> +       imu->nr_bvecs =3D nr_bvecs;
> +       refcount_set(&imu->refs, 1);
> +       imu->release =3D release;
> +       imu->priv =3D rq;
> +
> +       if (op_is_write(req_op(rq)))
> +               imu->perm =3D IO_IMU_WRITEABLE;
> +       else
> +               imu->perm =3D IO_IMU_READABLE;

imu->perm =3D 1 << rq_data_dir(rq); ?

> +
> +       bvec =3D imu->bvec;
> +       rq_for_each_bvec(bv, rq, rq_iter)
> +               *bvec++ =3D bv;
> +
> +       node->buf =3D imu;
> +       data->nodes[index] =3D node;
> +unlock:
> +       io_ring_submit_unlock(ctx, issue_flags);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(io_buffer_register_bvec);
> +
> +void io_buffer_unregister_bvec(struct io_uring_cmd *cmd, unsigned int in=
dex,
> +                              unsigned int issue_flags)
> +{
> +       struct io_ring_ctx *ctx =3D cmd_to_io_kiocb(cmd)->ctx;
> +       struct io_rsrc_data *data =3D &ctx->buf_table;
> +       struct io_rsrc_node *node;
> +
> +       io_ring_submit_lock(ctx, issue_flags);
> +       if (index >=3D data->nr)
> +               goto unlock;
> +       index =3D array_index_nospec(index, data->nr);
> +
> +       node =3D data->nodes[index];
> +       if (!node || !node->buf->release)
> +               goto unlock;

Would it be useful to return some error code in these cases so
userspace can tell that the unregistration parameters were invalid?

Best,
Caleb


> +
> +       io_put_rsrc_node(ctx, node);
> +       data->nodes[index] =3D NULL;
> +unlock:
> +       io_ring_submit_unlock(ctx, issue_flags);
> +}
> +EXPORT_SYMBOL_GPL(io_buffer_unregister_bvec);
> +
>  static int io_import_fixed(int ddir, struct iov_iter *iter,
>                            struct io_mapped_ubuf *imu,
>                            u64 buf_addr, size_t len)
> @@ -871,6 +971,8 @@ static int io_import_fixed(int ddir, struct iov_iter =
*iter,
>         /* not inside the mapped region */
>         if (unlikely(buf_addr < imu->ubuf || buf_end > (imu->ubuf + imu->=
len)))
>                 return -EFAULT;
> +       if (!(imu->perm & (1 << ddir)))
> +               return -EFAULT;
>
>         /*
>          * Might not be a start of buffer, set size appropriately
> @@ -883,8 +985,8 @@ static int io_import_fixed(int ddir, struct iov_iter =
*iter,
>                 /*
>                  * Don't use iov_iter_advance() here, as it's really slow=
 for
>                  * using the latter parts of a big fixed buffer - it iter=
ates
> -                * over each segment manually. We can cheat a bit here, b=
ecause
> -                * we know that:
> +                * over each segment manually. We can cheat a bit here fo=
r user
> +                * registered nodes, because we know that:
>                  *
>                  * 1) it's a BVEC iter, we set it up
>                  * 2) all bvecs are the same in size, except potentially =
the
> @@ -898,8 +1000,15 @@ static int io_import_fixed(int ddir, struct iov_ite=
r *iter,
>                  */
>                 const struct bio_vec *bvec =3D imu->bvec;
>
> +               /*
> +                * Kernel buffer bvecs, on the other hand, don't necessar=
ily
> +                * have the size property of user registered ones, so we =
have
> +                * to use the slow iter advance.
> +                */
>                 if (offset < bvec->bv_len) {
>                         iter->iov_offset =3D offset;
> +               } else if (imu->release) {
> +                       iov_iter_advance(iter, offset);
>                 } else {
>                         unsigned long seg_skip;
>
> diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
> index f0e9080599646..64bf35667cf9c 100644
> --- a/io_uring/rsrc.h
> +++ b/io_uring/rsrc.h
> @@ -20,6 +20,11 @@ struct io_rsrc_node {
>         };
>  };
>
> +enum {
> +       IO_IMU_READABLE         =3D 1 << 0,
> +       IO_IMU_WRITEABLE        =3D 1 << 1,
> +};
> +
>  struct io_mapped_ubuf {
>         u64             ubuf;
>         unsigned int    len;
> @@ -27,6 +32,9 @@ struct io_mapped_ubuf {
>         unsigned int    folio_shift;
>         refcount_t      refs;
>         unsigned long   acct_pages;
> +       void            (*release)(void *);
> +       void            *priv;
> +       u8              perm;
>         struct bio_vec  bvec[] __counted_by(nr_bvecs);
>  };
>
> --
> 2.43.5
>

