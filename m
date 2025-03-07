Return-Path: <linux-block+bounces-18078-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF6A5723D
	for <lists+linux-block@lfdr.de>; Fri,  7 Mar 2025 20:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD98E189A47C
	for <lists+linux-block@lfdr.de>; Fri,  7 Mar 2025 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC9250C0E;
	Fri,  7 Mar 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFWbaSOc"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B876924FC03;
	Fri,  7 Mar 2025 19:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376492; cv=none; b=EVYbxjyCjP2FMiO4uYnkdDTVT9Zx8ZJDlmB/Umhfa+sgDn0OvzetyAZuJ74G8J0f9ckz6zhhWLbAEOLZQWkoW5P4F72hU0RzGHBNPOew/sTrG+FbilWFR/iz0pz6+1NU6kBgtQyO+h6pAmfys0UtzsOunfeF8pU9QAofFtbvsYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376492; c=relaxed/simple;
	bh=yTA4jjpar0nAQIcDEzZ4DTe+OS4ZxvTCnC3mkdPUP+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rq4dVmK1V4pLAhvDhplXbsY2FwC8II83tUfTEglLp+PySJ+bIAypDKr6kUP03z2EVVap8gzn2sI8gbhKVABY7iFXwqi36abKlRpugrUA9N0IBZwRZ3FDy6C6brv4xtX+LXYeipFD834H8MqwyGEsjIfN7FlousEjzKyJIKCPs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFWbaSOc; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so181978e0c.0;
        Fri, 07 Mar 2025 11:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741376488; x=1741981288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxADRnTRL5Zf4OanqbxnTYyjpNbUObusM/RVQfon6dU=;
        b=QFWbaSOci3aSXmpwXSG7P6/DVZ/BPV+ZdTBGe4W/7EmcTazTy+HfBS+/jco+KCJC55
         3doPbPFEin7HxJmf/yLBYcatts7XE/D5KJFscs+pHZhI7vbQxaJs+eogSwUu40OhohDS
         SIqZL8w0ZkRomKh01H5R3BnQfv0YGaX8if+X/o2bKKP8H1jo+1GYdJErSd8CLvM5DXkR
         AB4u6zXNifaeynwsVr6YNiz/rRqxgCGRu3wCzYo0yXmZO+D6N1iEVTCLLNYk8GKMNisa
         WZA5ECCdvtJb6HNBMd7rEVXFA/zXUGpgTYT2AGUP9oKBESmt6z7Kmm0RiCD+fVJ9GUMj
         dKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741376488; x=1741981288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxADRnTRL5Zf4OanqbxnTYyjpNbUObusM/RVQfon6dU=;
        b=lCn7Iwete8aJDChanBXYOITwI48VROqKg1nCGlJrcGaZcznChtA78qbaFC6c/YbEgh
         BV2Og5zwTr3EEw/xXYswikuISP4a0QQSRC978jyaGSV/W43LgaFoZLVZ9KshS5ngHPLE
         YaWQ/v8FgLEACOGnR/OfBt4GbZk52v7TDxGd31g0iNVcHwW9h/W1OujLiaDax/0pgZsO
         NsuHyuHARb47zh6SFIIog0viuq1uLN5V+HsgwoGaxMhYbdTMbcH4NDQYxXQKNkYx/MqU
         zrR5WIueuIV6xd1NxE8DtTKI2SzJBbsI5Zm1nXxdxjeiu8lX1Z6wTjnljykBhocYyEdg
         0cWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmaq65Mo2ezyiWfuhEy16BCTkm6bXbKwSfFkI37zZteRzc0hdSR1mxWkXnGZ2uyhicyQvvRF/QTVAjlw==@vger.kernel.org, AJvYcCXm8C42sbh+HZieQbM36pY0MFrrPmkM9Zl0sA/OAay9F22PMuaF63Yq7RdDPmBsKSmY3TbIeMM1STG9DfZX@vger.kernel.org
X-Gm-Message-State: AOJu0YwopFZNfiMjrHaKyY41HWH7gWFv40Vm7I5RoQC+pw4KBkkQ6sGW
	hswVk88Z6LnIr5k6chqYcov37hJypc/aXKrvDlajRhybjQ6Xzgr4IrC6i+J5bUWwNY3zRNLg6Ut
	oiNM7QGBsFVYnz07rEHsDjWVsiTI=
X-Gm-Gg: ASbGncu6Ea5uwd4KPfDuOMfzBCgaMIR+xft9fRohpARzP9RadhSSOf4SNgEboKyIesx
	eIhcKwxqj5wbKUjFkpGS4/VEdhjbKJ43wo0SUYvFQtIpaSgmxNSH3SqpLqiYbYPlSRwrKpG4jbb
	H7FMsoSfzVdmZ2ObNiCaoA5Ozp0Q==
X-Google-Smtp-Source: AGHT+IErC9InPZ9XBRKp6Rom58kBjYYUxu3mePp0BMBXU1RuaBhOiaC4Tj1uk5RWPM1jNhqDuhDOHzIrZjJrW7wbKg4=
X-Received: by 2002:a05:6102:d8e:b0:4c1:a448:ac7d with SMTP id
 ada2fe7eead31-4c30a54d408mr3032359137.10.1741376488483; Fri, 07 Mar 2025
 11:41:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com> <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
In-Reply-To: <20250307120141.1566673-3-qun-wei.lin@mediatek.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 8 Mar 2025 08:41:17 +1300
X-Gm-Features: AQ5f1Jr_NH_JmxbOO5LScfPMgZlBxT61u6xunECHMLc6vlHdXZJRYzFSi8sd-ig
Message-ID: <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Casper Li <casper.li@mediatek.com>, Chinwen Chang <chinwen.chang@mediatek.com>, 
	Andrew Yang <andrew.yang@mediatek.com>, James Hsu <james.hsu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 1:02=E2=80=AFAM Qun-Wei Lin <qun-wei.lin@mediatek.co=
m> wrote:
>
> Introduced Kcompressd to offload zram page compression, improving
> system efficiency by handling compression separately from memory
> reclaiming. Added necessary configurations and dependencies.
>
> Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
> ---
>  drivers/block/zram/Kconfig      |  11 ++
>  drivers/block/zram/Makefile     |   3 +-
>  drivers/block/zram/kcompressd.c | 340 ++++++++++++++++++++++++++++++++
>  drivers/block/zram/kcompressd.h |  25 +++
>  drivers/block/zram/zram_drv.c   |  22 ++-
>  5 files changed, 397 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/block/zram/kcompressd.c
>  create mode 100644 drivers/block/zram/kcompressd.h
>
> diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
> index 402b7b175863..f0a1b574f770 100644
> --- a/drivers/block/zram/Kconfig
> +++ b/drivers/block/zram/Kconfig
> @@ -145,3 +145,14 @@ config ZRAM_MULTI_COMP
>           re-compress pages using a potentially slower but more effective
>           compression algorithm. Note, that IDLE page recompression
>           requires ZRAM_TRACK_ENTRY_ACTIME.
> +
> +config KCOMPRESSD
> +       tristate "Kcompressd: Accelerated zram compression"
> +       depends on ZRAM
> +       help
> +         Kcompressd creates multiple daemons to accelerate the compressi=
on of pages
> +         in zram, offloading this time-consuming task from the zram driv=
er.
> +
> +         This approach improves system efficiency by handling page compr=
ession separately,
> +         which was originally done by kswapd or direct reclaim.

For direct reclaim, we were previously able to compress using multiple CPUs
with multi-threading.
After your patch, it seems that only a single thread/CPU is used for compre=
ssion
so it won't necessarily improve direct reclaim performance?

Even for kswapd, we used to have multiple threads like [kswapd0], [kswapd1]=
,
and [kswapd2] for different nodes. Now, are we also limited to just one thr=
ead?
I also wonder if this could be handled at the vmscan level instead of the z=
ram
level. then it might potentially help other sync devices or even zswap late=
r.

But I agree that for phones, modifying zram seems like an easier starting
point. However, relying on a single thread isn't always the best approach.


> +
> diff --git a/drivers/block/zram/Makefile b/drivers/block/zram/Makefile
> index 0fdefd576691..23baa5dfceb9 100644
> --- a/drivers/block/zram/Makefile
> +++ b/drivers/block/zram/Makefile
> @@ -9,4 +9,5 @@ zram-$(CONFIG_ZRAM_BACKEND_ZSTD)        +=3D backend_zstd=
.o
>  zram-$(CONFIG_ZRAM_BACKEND_DEFLATE)    +=3D backend_deflate.o
>  zram-$(CONFIG_ZRAM_BACKEND_842)                +=3D backend_842.o
>
> -obj-$(CONFIG_ZRAM)     +=3D      zram.o
> +obj-$(CONFIG_ZRAM)             +=3D zram.o
> +obj-$(CONFIG_KCOMPRESSD)       +=3D kcompressd.o
> diff --git a/drivers/block/zram/kcompressd.c b/drivers/block/zram/kcompre=
ssd.c
> new file mode 100644
> index 000000000000..195b7e386869
> --- /dev/null
> +++ b/drivers/block/zram/kcompressd.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 MediaTek Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/bio.h>
> +#include <linux/bitops.h>
> +#include <linux/freezer.h>
> +#include <linux/kernel.h>
> +#include <linux/psi.h>
> +#include <linux/kfifo.h>
> +#include <linux/swap.h>
> +#include <linux/delay.h>
> +
> +#include "kcompressd.h"
> +
> +#define INIT_QUEUE_SIZE                4096
> +#define DEFAULT_NR_KCOMPRESSD  4
> +
> +static atomic_t enable_kcompressd;
> +static unsigned int nr_kcompressd;
> +static unsigned int queue_size_per_kcompressd;
> +static struct kcompress *kcompress;
> +
> +enum run_state {
> +       KCOMPRESSD_NOT_STARTED =3D 0,
> +       KCOMPRESSD_RUNNING,
> +       KCOMPRESSD_SLEEPING,
> +};
> +
> +struct kcompressd_para {
> +       wait_queue_head_t *kcompressd_wait;
> +       struct kfifo *write_fifo;
> +       atomic_t *running;
> +};
> +
> +static struct kcompressd_para *kcompressd_para;
> +static BLOCKING_NOTIFIER_HEAD(kcompressd_notifier_list);
> +
> +struct write_work {
> +       void *mem;
> +       struct bio *bio;
> +       compress_callback cb;
> +};
> +
> +int kcompressd_enabled(void)
> +{
> +       return likely(atomic_read(&enable_kcompressd));
> +}
> +EXPORT_SYMBOL(kcompressd_enabled);
> +
> +static void kcompressd_try_to_sleep(struct kcompressd_para *p)
> +{
> +       DEFINE_WAIT(wait);
> +
> +       if (!kfifo_is_empty(p->write_fifo))
> +               return;
> +
> +       if (freezing(current) || kthread_should_stop())
> +               return;
> +
> +       atomic_set(p->running, KCOMPRESSD_SLEEPING);
> +       prepare_to_wait(p->kcompressd_wait, &wait, TASK_INTERRUPTIBLE);
> +
> +       /*
> +        * After a short sleep, check if it was a premature sleep. If not=
, then
> +        * go fully to sleep until explicitly woken up.
> +        */
> +       if (!kthread_should_stop() && kfifo_is_empty(p->write_fifo))
> +               schedule();
> +
> +       finish_wait(p->kcompressd_wait, &wait);
> +       atomic_set(p->running, KCOMPRESSD_RUNNING);
> +}
> +
> +static int kcompressd(void *para)
> +{
> +       struct task_struct *tsk =3D current;
> +       struct kcompressd_para *p =3D (struct kcompressd_para *)para;
> +
> +       tsk->flags |=3D PF_MEMALLOC | PF_KSWAPD;
> +       set_freezable();
> +
> +       while (!kthread_should_stop()) {
> +               bool ret;
> +
> +               kcompressd_try_to_sleep(p);
> +               ret =3D try_to_freeze();
> +               if (kthread_should_stop())
> +                       break;
> +
> +               if (ret)
> +                       continue;
> +
> +               while (!kfifo_is_empty(p->write_fifo)) {
> +                       struct write_work entry;
> +
> +                       if (sizeof(struct write_work) =3D=3D kfifo_out(p-=
>write_fifo,
> +                                               &entry, sizeof(struct wri=
te_work))) {
> +                               entry.cb(entry.mem, entry.bio);
> +                               bio_put(entry.bio);
> +                       }
> +               }
> +
> +       }
> +
> +       tsk->flags &=3D ~(PF_MEMALLOC | PF_KSWAPD);
> +       atomic_set(p->running, KCOMPRESSD_NOT_STARTED);
> +       return 0;
> +}
> +
> +static int init_write_queue(void)
> +{
> +       int i;
> +       unsigned int queue_len =3D queue_size_per_kcompressd * sizeof(str=
uct write_work);
> +
> +       for (i =3D 0; i < nr_kcompressd; i++) {
> +               if (kfifo_alloc(&kcompress[i].write_fifo,
> +                                       queue_len, GFP_KERNEL)) {
> +                       pr_err("Failed to alloc kfifo %d\n", i);
> +                       return -ENOMEM;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static void clean_bio_queue(int idx)
> +{
> +       struct write_work entry;
> +
> +       while (sizeof(struct write_work) =3D=3D kfifo_out(&kcompress[idx]=
.write_fifo,
> +                               &entry, sizeof(struct write_work))) {
> +               bio_put(entry.bio);
> +               entry.cb(entry.mem, entry.bio);
> +       }
> +       kfifo_free(&kcompress[idx].write_fifo);
> +}
> +
> +static int kcompress_update(void)
> +{
> +       int i;
> +       int ret;
> +
> +       kcompress =3D kvmalloc_array(nr_kcompressd, sizeof(struct kcompre=
ss), GFP_KERNEL);
> +       if (!kcompress)
> +               return -ENOMEM;
> +
> +       kcompressd_para =3D kvmalloc_array(nr_kcompressd, sizeof(struct k=
compressd_para), GFP_KERNEL);
> +       if (!kcompressd_para)
> +               return -ENOMEM;
> +
> +       ret =3D init_write_queue();
> +       if (ret) {
> +               pr_err("Initialization of writing to FIFOs failed!!\n");
> +               return ret;
> +       }
> +
> +       for (i =3D 0; i < nr_kcompressd; i++) {
> +               init_waitqueue_head(&kcompress[i].kcompressd_wait);
> +               kcompressd_para[i].kcompressd_wait =3D &kcompress[i].kcom=
pressd_wait;
> +               kcompressd_para[i].write_fifo =3D &kcompress[i].write_fif=
o;
> +               kcompressd_para[i].running =3D &kcompress[i].running;
> +       }
> +
> +       return 0;
> +}
> +
> +static void stop_all_kcompressd_thread(void)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr_kcompressd; i++) {
> +               kthread_stop(kcompress[i].kcompressd);
> +               kcompress[i].kcompressd =3D NULL;
> +               clean_bio_queue(i);
> +       }
> +}
> +
> +static int do_nr_kcompressd_handler(const char *val,
> +               const struct kernel_param *kp)
> +{
> +       int ret;
> +
> +       atomic_set(&enable_kcompressd, false);
> +
> +       stop_all_kcompressd_thread();
> +
> +       ret =3D param_set_int(val, kp);
> +       if (!ret) {
> +               pr_err("Invalid number of kcompressd.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D init_write_queue();
> +       if (ret) {
> +               pr_err("Initialization of writing to FIFOs failed!!\n");
> +               return ret;
> +       }
> +
> +       atomic_set(&enable_kcompressd, true);
> +
> +       return 0;
> +}
> +
> +static const struct kernel_param_ops param_ops_change_nr_kcompressd =3D =
{
> +       .set =3D &do_nr_kcompressd_handler,
> +       .get =3D &param_get_uint,
> +       .free =3D NULL,
> +};
> +
> +module_param_cb(nr_kcompressd, &param_ops_change_nr_kcompressd,
> +               &nr_kcompressd, 0644);
> +MODULE_PARM_DESC(nr_kcompressd, "Number of pre-created daemon for page c=
ompression");
> +
> +static int do_queue_size_per_kcompressd_handler(const char *val,
> +               const struct kernel_param *kp)
> +{
> +       int ret;
> +
> +       atomic_set(&enable_kcompressd, false);
> +
> +       stop_all_kcompressd_thread();
> +
> +       ret =3D param_set_int(val, kp);
> +       if (!ret) {
> +               pr_err("Invalid queue size for kcompressd.\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D init_write_queue();
> +       if (ret) {
> +               pr_err("Initialization of writing to FIFOs failed!!\n");
> +               return ret;
> +       }
> +
> +       pr_info("Queue size for kcompressd was changed: %d\n", queue_size=
_per_kcompressd);
> +
> +       atomic_set(&enable_kcompressd, true);
> +       return 0;
> +}
> +
> +static const struct kernel_param_ops param_ops_change_queue_size_per_kco=
mpressd =3D {
> +       .set =3D &do_queue_size_per_kcompressd_handler,
> +       .get =3D &param_get_uint,
> +       .free =3D NULL,
> +};
> +
> +module_param_cb(queue_size_per_kcompressd, &param_ops_change_queue_size_=
per_kcompressd,
> +               &queue_size_per_kcompressd, 0644);
> +MODULE_PARM_DESC(queue_size_per_kcompressd,
> +               "Size of queue for kcompressd");
> +
> +int schedule_bio_write(void *mem, struct bio *bio, compress_callback cb)
> +{
> +       int i;
> +       bool submit_success =3D false;
> +       size_t sz_work =3D sizeof(struct write_work);
> +
> +       struct write_work entry =3D {
> +               .mem =3D mem,
> +               .bio =3D bio,
> +               .cb =3D cb
> +       };
> +
> +       if (unlikely(!atomic_read(&enable_kcompressd)))
> +               return -EBUSY;
> +
> +       if (!nr_kcompressd || !current_is_kswapd())
> +               return -EBUSY;
> +
> +       bio_get(bio);
> +
> +       for (i =3D 0; i < nr_kcompressd; i++) {
> +               submit_success =3D
> +                       (kfifo_avail(&kcompress[i].write_fifo) >=3D sz_wo=
rk) &&
> +                       (sz_work =3D=3D kfifo_in(&kcompress[i].write_fifo=
, &entry, sz_work));
> +
> +               if (submit_success) {
> +                       switch (atomic_read(&kcompress[i].running)) {
> +                       case KCOMPRESSD_NOT_STARTED:
> +                               atomic_set(&kcompress[i].running, KCOMPRE=
SSD_RUNNING);
> +                               kcompress[i].kcompressd =3D kthread_run(k=
compressd,
> +                                               &kcompressd_para[i], "kco=
mpressd:%d", i);
> +                               if (IS_ERR(kcompress[i].kcompressd)) {
> +                                       atomic_set(&kcompress[i].running,=
 KCOMPRESSD_NOT_STARTED);
> +                                       pr_warn("Failed to start kcompres=
sd:%d\n", i);
> +                                       clean_bio_queue(i);
> +                               }
> +                               break;
> +                       case KCOMPRESSD_RUNNING:
> +                               break;
> +                       case KCOMPRESSD_SLEEPING:
> +                               wake_up_interruptible(&kcompress[i].kcomp=
ressd_wait);
> +                               break;
> +                       }
> +                       return 0;
> +               }
> +       }
> +
> +       bio_put(bio);
> +       return -EBUSY;
> +}
> +EXPORT_SYMBOL(schedule_bio_write);
> +
> +static int __init kcompressd_init(void)
> +{
> +       int ret;
> +
> +       nr_kcompressd =3D DEFAULT_NR_KCOMPRESSD;
> +       queue_size_per_kcompressd =3D INIT_QUEUE_SIZE;
> +
> +       ret =3D kcompress_update();
> +       if (ret) {
> +               pr_err("Init kcompressd failed!\n");
> +               return ret;
> +       }
> +
> +       atomic_set(&enable_kcompressd, true);
> +       blocking_notifier_call_chain(&kcompressd_notifier_list, 0, NULL);
> +       return 0;
> +}
> +
> +static void __exit kcompressd_exit(void)
> +{
> +       atomic_set(&enable_kcompressd, false);
> +       stop_all_kcompressd_thread();
> +
> +       kvfree(kcompress);
> +       kvfree(kcompressd_para);
> +}
> +
> +module_init(kcompressd_init);
> +module_exit(kcompressd_exit);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Qun-Wei Lin <qun-wei.lin@mediatek.com>");
> +MODULE_DESCRIPTION("Separate the page compression from the memory reclai=
ming");
> +
> diff --git a/drivers/block/zram/kcompressd.h b/drivers/block/zram/kcompre=
ssd.h
> new file mode 100644
> index 000000000000..2fe0b424a7af
> --- /dev/null
> +++ b/drivers/block/zram/kcompressd.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 MediaTek Inc.
> + */
> +
> +#ifndef _KCOMPRESSD_H_
> +#define _KCOMPRESSD_H_
> +
> +#include <linux/rwsem.h>
> +#include <linux/kfifo.h>
> +#include <linux/atomic.h>
> +
> +typedef void (*compress_callback)(void *mem, struct bio *bio);
> +
> +struct kcompress {
> +       struct task_struct *kcompressd;
> +       wait_queue_head_t kcompressd_wait;
> +       struct kfifo write_fifo;
> +       atomic_t running;
> +};
> +
> +int kcompressd_enabled(void);
> +int schedule_bio_write(void *mem, struct bio *bio, compress_callback cb)=
;
> +#endif
> +
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 2e1a70f2f4bd..bcd63ecb6ff2 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -35,6 +35,7 @@
>  #include <linux/part_stat.h>
>  #include <linux/kernel_read_file.h>
>
> +#include "kcompressd.h"
>  #include "zram_drv.h"
>
>  static DEFINE_IDR(zram_index_idr);
> @@ -2240,6 +2241,15 @@ static void zram_bio_write(struct zram *zram, stru=
ct bio *bio)
>         bio_endio(bio);
>  }
>
> +#if IS_ENABLED(CONFIG_KCOMPRESSD)
> +static void zram_bio_write_callback(void *mem, struct bio *bio)
> +{
> +       struct zram *zram =3D (struct zram *)mem;
> +
> +       zram_bio_write(zram, bio);
> +}
> +#endif
> +
>  /*
>   * Handler function for all zram I/O requests.
>   */
> @@ -2252,6 +2262,10 @@ static void zram_submit_bio(struct bio *bio)
>                 zram_bio_read(zram, bio);
>                 break;
>         case REQ_OP_WRITE:
> +#if IS_ENABLED(CONFIG_KCOMPRESSD)
> +               if (kcompressd_enabled() && !schedule_bio_write(zram, bio=
, zram_bio_write_callback))
> +                       break;
> +#endif
>                 zram_bio_write(zram, bio);
>                 break;
>         case REQ_OP_DISCARD:
> @@ -2535,9 +2549,11 @@ static int zram_add(void)
>  #if ZRAM_LOGICAL_BLOCK_SIZE =3D=3D PAGE_SIZE
>                 .max_write_zeroes_sectors       =3D UINT_MAX,
>  #endif
> -               .features                       =3D BLK_FEAT_STABLE_WRITE=
S        |
> -                                                 BLK_FEAT_READ_SYNCHRONO=
US     |
> -                                                 BLK_FEAT_WRITE_SYNCHRON=
OUS,
> +               .features                       =3D BLK_FEAT_STABLE_WRITE=
S
> +                                                 | BLK_FEAT_READ_SYNCHRO=
NOUS
> +#if !IS_ENABLED(CONFIG_KCOMPRESSD)
> +                                                 | BLK_FEAT_WRITE_SYNCHR=
ONOUS,
> +#endif
>         };
>         struct zram *zram;
>         int ret, device_id;
> --
> 2.45.2
>

Thanks
Barry

