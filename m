Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD93156D93
	for <lists+linux-block@lfdr.de>; Mon, 10 Feb 2020 03:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgBJCTo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 9 Feb 2020 21:19:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32948 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgBJCTo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Feb 2020 21:19:44 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so5626686wrt.0;
        Sun, 09 Feb 2020 18:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwngVaNUnsrSnHHLztjdVV6sVUGIb2jQnJfPY4OH8JM=;
        b=TRXu26x4pqVD5fkaCkjWR365smyfMoWtBuHk/tgvXD//tNGrmiXPx/hhh/8sS72emx
         LGYHrfdkqIU0ZHGDRdUjd86JWXLt2zi4Zo/OStGmXQr48QuSWJHW/1CRxU787LR111NC
         5DLmB5WK8WMUDuhOt0AQNkiFdsL2cRiOL1LsGxpv51BMOVieRDvz9LBysSOsP+U0MVEU
         k5Lk4bXiN5X5bYyHdHw9RtlW7yMze5qBzwtsCxAfMtkmWvAalms6Jj2hPj+1zch4ZG3D
         dsAJI5a98TjuIiqyEh+OAi1jgayEkm2Qj22asXDrv08kAI2LKfb7aIEORdPZRM73HmfQ
         k72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwngVaNUnsrSnHHLztjdVV6sVUGIb2jQnJfPY4OH8JM=;
        b=c1PR1bOQddFtQdlSO/bQMj354iGTQgRANEFNjvSHQbaIiHqdmUAm2VVTXrbZhsJs8E
         jtsfg1hJZGgnh5xEQaArkWd+xgmscqUEGDAhaNtOZkubi4wX/hKjB5mnKut+Rvi0Jetb
         6RRZrcew5eLo37OeCEndkvj15EPANQCaDKNVZP7uMVbRGpzzXLKJca2qxOddPTvAvg6t
         jSfqzSt3G2Z0l/5ao5Dnnd2afm+COCcM8ml4f1lm48QQUwHdABcqk4ze3PcB4tttHQin
         tOG4X/SOLdudogHCiWii5DnNAfPelKQSDV88eq9Gc2jp8SI+ComlArAVmDPCmC04n8db
         f4tQ==
X-Gm-Message-State: APjAAAWMgi1i5tS6H7knnMtLJsEDr0MXFDvieO2lHpi6FaLi6ab/Y+c5
        YqyzWcF0vVXRraPn2DzuEIA8SUzJfs6walgaf40=
X-Google-Smtp-Source: APXvYqxfKbHrfduT04LJ8ZEY/MN5R4dm47Rcq5U5TUhMryBOdwiQH/0BxXn52C2ZduDv5nxFpBgmwoDqUmABVjxUEcI=
X-Received: by 2002:adf:db84:: with SMTP id u4mr14078748wri.317.1581301178981;
 Sun, 09 Feb 2020 18:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20200206142812.25989-1-jack@suse.cz>
In-Reply-To: <20200206142812.25989-1-jack@suse.cz>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 10 Feb 2020 10:19:26 +0800
Message-ID: <CACVXFVOX-_kySr5FsKr3_0o6-2hXVCjoaNW8Gxnx_JZPY+ugHg@mail.gmail.com>
Subject: Re: [PATCH] blktrace: Protect q->blk_trace with RCU
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>, tristmd@gmail.com,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 6, 2020 at 10:29 PM Jan Kara <jack@suse.cz> wrote:
>
> KASAN is reporting that __blk_add_trace() has a use-after-free issue
> when accessing q->blk_trace. Indeed the switching of block tracing (and
> thus eventual freeing of q->blk_trace) is completely unsynchronized with
> the currently running tracing and thus it can happen that the blk_trace
> structure is being freed just while __blk_add_trace() works on it.
> Protect accesses to q->blk_trace by RCU during tracing and make sure we
> wait for the end of RCU grace period when shutting down tracing. Luckily
> that is rare enough event that we can afford that. Note that postponing
> the freeing of blk_trace to an RCU callback should better be avoided as
> it could have unexpected user visible side-effects as debugfs files
> would be still existing for a short while block tracing has been shut
> down.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=205711
> CC: stable@vger.kernel.org
> Reported-by: Tristan <tristmd@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/linux/blkdev.h       |   2 +-
>  include/linux/blktrace_api.h |  18 +++++--
>  kernel/trace/blktrace.c      | 114 +++++++++++++++++++++++++++++++------------
>  3 files changed, 97 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 4c636c42ad68..1cb5afed5515 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -524,7 +524,7 @@ struct request_queue {
>         unsigned int            sg_reserved_size;
>         int                     node;
>  #ifdef CONFIG_BLK_DEV_IO_TRACE
> -       struct blk_trace        *blk_trace;
> +       struct blk_trace __rcu  *blk_trace;
>         struct mutex            blk_trace_mutex;
>  #endif
>         /*
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> index 7bb2d8de9f30..3b6ff5902edc 100644
> --- a/include/linux/blktrace_api.h
> +++ b/include/linux/blktrace_api.h
> @@ -51,9 +51,13 @@ void __trace_note_message(struct blk_trace *, struct blkcg *blkcg, const char *f
>   **/
>  #define blk_add_cgroup_trace_msg(q, cg, fmt, ...)                      \
>         do {                                                            \
> -               struct blk_trace *bt = (q)->blk_trace;                  \
> +               struct blk_trace *bt;                                   \
> +                                                                       \
> +               rcu_read_lock();                                        \
> +               bt = rcu_dereference((q)->blk_trace);                   \
>                 if (unlikely(bt))                                       \
>                         __trace_note_message(bt, cg, fmt, ##__VA_ARGS__);\
> +               rcu_read_unlock();                                      \
>         } while (0)
>  #define blk_add_trace_msg(q, fmt, ...)                                 \
>         blk_add_cgroup_trace_msg(q, NULL, fmt, ##__VA_ARGS__)
> @@ -61,10 +65,14 @@ void __trace_note_message(struct blk_trace *, struct blkcg *blkcg, const char *f
>
>  static inline bool blk_trace_note_message_enabled(struct request_queue *q)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> -       if (likely(!bt))
> -               return false;
> -       return bt->act_mask & BLK_TC_NOTIFY;
> +       struct blk_trace *bt;
> +       bool ret;
> +
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
> +       ret = bt && (bt->act_mask & BLK_TC_NOTIFY);
> +       rcu_read_unlock();
> +       return ret;
>  }
>
>  extern void blk_add_driver_data(struct request_queue *q, struct request *rq,
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 475e29498bca..a6d3016410eb 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -335,6 +335,7 @@ static void put_probe_ref(void)
>
>  static void blk_trace_cleanup(struct blk_trace *bt)
>  {
> +       synchronize_rcu();
>         blk_trace_free(bt);
>         put_probe_ref();
>  }
> @@ -629,8 +630,10 @@ static int compat_blk_trace_setup(struct request_queue *q, char *name,
>  static int __blk_trace_startstop(struct request_queue *q, int start)
>  {
>         int ret;
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> +       bt = rcu_dereference_protected(q->blk_trace,
> +                                      lockdep_is_held(&q->blk_trace_mutex));
>         if (bt == NULL)
>                 return -EINVAL;
>
> @@ -740,8 +743,8 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>  void blk_trace_shutdown(struct request_queue *q)
>  {
>         mutex_lock(&q->blk_trace_mutex);
> -
> -       if (q->blk_trace) {
> +       if (rcu_dereference_protected(q->blk_trace,
> +                                     lockdep_is_held(&q->blk_trace_mutex))) {
>                 __blk_trace_startstop(q, 0);
>                 __blk_trace_remove(q);
>         }
> @@ -752,8 +755,10 @@ void blk_trace_shutdown(struct request_queue *q)
>  #ifdef CONFIG_BLK_CGROUP
>  static u64 blk_trace_bio_get_cgid(struct request_queue *q, struct bio *bio)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> +       /* We don't use the 'bt' value here except as an optimization... */
> +       bt = rcu_dereference_protected(q->blk_trace, 1);
>         if (!bt || !(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
>                 return 0;
>
> @@ -796,10 +801,14 @@ blk_trace_request_get_cgid(struct request_queue *q, struct request *rq)
>  static void blk_add_trace_rq(struct request *rq, int error,
>                              unsigned int nr_bytes, u32 what, u64 cgid)
>  {
> -       struct blk_trace *bt = rq->q->blk_trace;
> +       struct blk_trace *bt;
>
> -       if (likely(!bt))
> +       rcu_read_lock();
> +       bt = rcu_dereference(rq->q->blk_trace);
> +       if (likely(!bt)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>
>         if (blk_rq_is_passthrough(rq))
>                 what |= BLK_TC_ACT(BLK_TC_PC);
> @@ -808,6 +817,7 @@ static void blk_add_trace_rq(struct request *rq, int error,
>
>         __blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
>                         rq->cmd_flags, what, error, 0, NULL, cgid);
> +       rcu_read_unlock();
>  }
>
>  static void blk_add_trace_rq_insert(void *ignore,
> @@ -853,14 +863,19 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
>  static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
>                               u32 what, int error)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> -       if (likely(!bt))
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
> +       if (likely(!bt)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>
>         __blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
>                         bio_op(bio), bio->bi_opf, what, error, 0, NULL,
>                         blk_trace_bio_get_cgid(q, bio));
> +       rcu_read_unlock();
>  }
>
>  static void blk_add_trace_bio_bounce(void *ignore,
> @@ -905,11 +920,14 @@ static void blk_add_trace_getrq(void *ignore,
>         if (bio)
>                 blk_add_trace_bio(q, bio, BLK_TA_GETRQ, 0);
>         else {
> -               struct blk_trace *bt = q->blk_trace;
> +               struct blk_trace *bt;
>
> +               rcu_read_lock();
> +               bt = rcu_dereference(q->blk_trace);
>                 if (bt)
>                         __blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_GETRQ, 0, 0,
>                                         NULL, 0);
> +               rcu_read_unlock();
>         }
>  }
>
> @@ -921,27 +939,35 @@ static void blk_add_trace_sleeprq(void *ignore,
>         if (bio)
>                 blk_add_trace_bio(q, bio, BLK_TA_SLEEPRQ, 0);
>         else {
> -               struct blk_trace *bt = q->blk_trace;
> +               struct blk_trace *bt;
>
> +               rcu_read_lock();
> +               bt = rcu_dereference(q->blk_trace);
>                 if (bt)
>                         __blk_add_trace(bt, 0, 0, rw, 0, BLK_TA_SLEEPRQ,
>                                         0, 0, NULL, 0);
> +               rcu_read_unlock();
>         }
>  }
>
>  static void blk_add_trace_plug(void *ignore, struct request_queue *q)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
>         if (bt)
>                 __blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
> +       rcu_read_unlock();
>  }
>
>  static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
>                                     unsigned int depth, bool explicit)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
>         if (bt) {
>                 __be64 rpdu = cpu_to_be64(depth);
>                 u32 what;
> @@ -953,14 +979,17 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
>
>                 __blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
>         }
> +       rcu_read_unlock();
>  }
>
>  static void blk_add_trace_split(void *ignore,
>                                 struct request_queue *q, struct bio *bio,
>                                 unsigned int pdu)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
>         if (bt) {
>                 __be64 rpdu = cpu_to_be64(pdu);
>
> @@ -969,6 +998,7 @@ static void blk_add_trace_split(void *ignore,
>                                 BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
>                                 &rpdu, blk_trace_bio_get_cgid(q, bio));
>         }
> +       rcu_read_unlock();
>  }
>
>  /**
> @@ -988,11 +1018,15 @@ static void blk_add_trace_bio_remap(void *ignore,
>                                     struct request_queue *q, struct bio *bio,
>                                     dev_t dev, sector_t from)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>         struct blk_io_trace_remap r;
>
> -       if (likely(!bt))
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
> +       if (likely(!bt)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>
>         r.device_from = cpu_to_be32(dev);
>         r.device_to   = cpu_to_be32(bio_dev(bio));
> @@ -1001,6 +1035,7 @@ static void blk_add_trace_bio_remap(void *ignore,
>         __blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
>                         bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
>                         sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
> +       rcu_read_unlock();
>  }
>
>  /**
> @@ -1021,11 +1056,15 @@ static void blk_add_trace_rq_remap(void *ignore,
>                                    struct request *rq, dev_t dev,
>                                    sector_t from)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>         struct blk_io_trace_remap r;
>
> -       if (likely(!bt))
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
> +       if (likely(!bt)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>
>         r.device_from = cpu_to_be32(dev);
>         r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
> @@ -1034,6 +1073,7 @@ static void blk_add_trace_rq_remap(void *ignore,
>         __blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
>                         rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
>                         sizeof(r), &r, blk_trace_request_get_cgid(q, rq));
> +       rcu_read_unlock();
>  }
>
>  /**
> @@ -1051,14 +1091,19 @@ void blk_add_driver_data(struct request_queue *q,
>                          struct request *rq,
>                          void *data, size_t len)
>  {
> -       struct blk_trace *bt = q->blk_trace;
> +       struct blk_trace *bt;
>
> -       if (likely(!bt))
> +       rcu_read_lock();
> +       bt = rcu_dereference(q->blk_trace);
> +       if (likely(!bt)) {
> +               rcu_read_unlock();
>                 return;
> +       }
>
>         __blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
>                                 BLK_TA_DRV_DATA, 0, len, data,
>                                 blk_trace_request_get_cgid(q, rq));
> +       rcu_read_unlock();
>  }
>  EXPORT_SYMBOL_GPL(blk_add_driver_data);
>
> @@ -1597,6 +1642,7 @@ static int blk_trace_remove_queue(struct request_queue *q)
>                 return -EINVAL;
>
>         put_probe_ref();
> +       synchronize_rcu();
>         blk_trace_free(bt);
>         return 0;
>  }
> @@ -1758,6 +1804,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
>         struct hd_struct *p = dev_to_part(dev);
>         struct request_queue *q;
>         struct block_device *bdev;
> +       struct blk_trace *bt;
>         ssize_t ret = -ENXIO;
>
>         bdev = bdget(part_devt(p));
> @@ -1770,21 +1817,23 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
>
>         mutex_lock(&q->blk_trace_mutex);
>
> +       bt = rcu_dereference_protected(q->blk_trace,
> +                                      lockdep_is_held(&q->blk_trace_mutex));
>         if (attr == &dev_attr_enable) {
> -               ret = sprintf(buf, "%u\n", !!q->blk_trace);
> +               ret = sprintf(buf, "%u\n", !!bt);
>                 goto out_unlock_bdev;
>         }
>
> -       if (q->blk_trace == NULL)
> +       if (bt == NULL)
>                 ret = sprintf(buf, "disabled\n");
>         else if (attr == &dev_attr_act_mask)
> -               ret = blk_trace_mask2str(buf, q->blk_trace->act_mask);
> +               ret = blk_trace_mask2str(buf, bt->act_mask);
>         else if (attr == &dev_attr_pid)
> -               ret = sprintf(buf, "%u\n", q->blk_trace->pid);
> +               ret = sprintf(buf, "%u\n", bt->pid);
>         else if (attr == &dev_attr_start_lba)
> -               ret = sprintf(buf, "%llu\n", q->blk_trace->start_lba);
> +               ret = sprintf(buf, "%llu\n", bt->start_lba);
>         else if (attr == &dev_attr_end_lba)
> -               ret = sprintf(buf, "%llu\n", q->blk_trace->end_lba);
> +               ret = sprintf(buf, "%llu\n", bt->end_lba);
>
>  out_unlock_bdev:
>         mutex_unlock(&q->blk_trace_mutex);
> @@ -1801,6 +1850,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>         struct block_device *bdev;
>         struct request_queue *q;
>         struct hd_struct *p;
> +       struct blk_trace *bt;
>         u64 value;
>         ssize_t ret = -EINVAL;
>
> @@ -1831,8 +1881,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>
>         mutex_lock(&q->blk_trace_mutex);
>
> +       bt = rcu_dereference_protected(q->blk_trace,
> +                                      lockdep_is_held(&q->blk_trace_mutex));
>         if (attr == &dev_attr_enable) {
> -               if (!!value == !!q->blk_trace) {
> +               if (!!value == !!bt) {
>                         ret = 0;
>                         goto out_unlock_bdev;
>                 }
> @@ -1844,18 +1896,18 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>         }
>
>         ret = 0;
> -       if (q->blk_trace == NULL)
> +       if (bt == NULL)
>                 ret = blk_trace_setup_queue(q, bdev);
>
>         if (ret == 0) {
>                 if (attr == &dev_attr_act_mask)
> -                       q->blk_trace->act_mask = value;
> +                       bt->act_mask = value;
>                 else if (attr == &dev_attr_pid)
> -                       q->blk_trace->pid = value;
> +                       bt->pid = value;
>                 else if (attr == &dev_attr_start_lba)
> -                       q->blk_trace->start_lba = value;
> +                       bt->start_lba = value;
>                 else if (attr == &dev_attr_end_lba)
> -                       q->blk_trace->end_lba = value;
> +                       bt->end_lba = value;
>         }
>
>  out_unlock_bdev:
> --
> 2.16.4
>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
