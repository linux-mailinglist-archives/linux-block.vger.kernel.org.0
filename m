Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7E13DF62
	for <lists+linux-block@lfdr.de>; Thu, 16 Jan 2020 16:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgAPP6G (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Jan 2020 10:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgAPP6F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jan 2020 10:58:05 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CBB32073A;
        Thu, 16 Jan 2020 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579190284;
        bh=krR/WSQXn7BqJOsPzeYbrFK7mbFbl5d4AXaU9zmNbkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bu19Ky0SaeeuhvfJjPF1GGshkzL4S7MwPjwNIRxO7rvi7xN6tBGQbRcN61AaWLK4u
         bQqTOMF/7m84SQEmeHvLzRJ/hv4sJKwrcxIJw+HrnognFNq4DZVGUNLKcNev11GEQG
         iTorV1zIAIP49WpT0BjSm4NJXRcV0EDseaFNCTGo=
Date:   Thu, 16 Jan 2020 17:58:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCH v7 06/25] RDMA/rtrs: client: main functionality
Message-ID: <20200116155800.GA18467@unreal>
References: <20200116125915.14815-1-jinpuwang@gmail.com>
 <20200116125915.14815-7-jinpuwang@gmail.com>
 <20200116145300.GC12433@unreal>
 <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffE=pym8iz4OVxx7s6i37AU+KPFN3AeVrCTOpLx+N8A9dEQ@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 16, 2020 at 04:43:41PM +0100, Jinpu Wang wrote:
> On Thu, Jan 16, 2020 at 3:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Thu, Jan 16, 2020 at 01:58:56PM +0100, Jack Wang wrote:
> > > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> > >
> > > This is main functionality of rtrs-client module, which manages
> > > set of RDMA connections for each rtrs session, does multipathing,
> > > load balancing and failover of RDMA requests.
> > >
> > > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2967 ++++++++++++++++++++++++
> > >  1 file changed, 2967 insertions(+)
> > >  create mode 100644 drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > new file mode 100644
> > > index 000000000000..717d19d4d930
> > > --- /dev/null
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -0,0 +1,2967 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * RDMA Transport Layer
> > > + *
> > > + * Copyright (c) 2014 - 2018 ProfitBricks GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > > + *
> > > + * Copyright (c) 2019 - 2020 1&1 IONOS SE. All rights reserved.
> >
> > Please no extra lines between Copyright lines.
> I checked in kernel tree, seems most of Copyright indeed contain no
> extra line in between
>
> >
> > > + */
> > > +
> > > +#undef pr_fmt
> > > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> >
> > I never understood this pr_fmt() thing, do we really need it?
> you can custorm the format for print, include modue name and line
> number in this case, it's quite useful for debugging.

The idea that messages are needed to be unique and don't rely on line
numbers.

> >
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/rculist.h>
> > > +#include <linux/blkdev.h> /* for BLK_MAX_SEGMENT_SIZE */
> > > +
> > > +#include "rtrs-clt.h"
> > > +#include "rtrs-log.h"
> > > +
> > > +#define RTRS_CONNECT_TIMEOUT_MS 30000
> > > +
> > > +MODULE_DESCRIPTION("RDMA Transport Client");
> > > +MODULE_LICENSE("GPL");
> > > +
> > > +static ushort nr_cons_per_session;
> > > +module_param(nr_cons_per_session, ushort, 0444);
> > > +MODULE_PARM_DESC(nr_cons_per_session,
> > > +              "Number of connections per session. (default: nr_cpu_ids)");
> > > +
> > > +static int retry_cnt = 7;
> > > +module_param_named(retry_cnt, retry_cnt, int, 0644);
> > > +MODULE_PARM_DESC(retry_cnt,
> > > +              "Number of times to send the message if the remote side didn't respond with Ack or Nack (default: 7, min: "
> > > +              __stringify(MIN_RTR_CNT) ", max: "
> > > +              __stringify(MAX_RTR_CNT) ")");
> > > +
> > > +static int __read_mostly noreg_cnt;
> > > +module_param_named(noreg_cnt, noreg_cnt, int, 0444);
> > > +MODULE_PARM_DESC(noreg_cnt,
> > > +              "Max number of SG entries when MR registration does not happen (default: 0)");
> >
> > We don't like modules in new code.
> could you elaberate a bit, no module paramters? which one? all?

All of them.

>
> >
> > > +
> > > +static const struct rtrs_rdma_dev_pd_ops dev_pd_ops;
> > > +static struct rtrs_rdma_dev_pd dev_pd = {
> > > +     .ops = &dev_pd_ops
> > > +};
> > > +
> > > +static struct workqueue_struct *rtrs_wq;
> > > +static struct class *rtrs_clt_dev_class;
> > > +
> > > +static inline bool rtrs_clt_is_connected(const struct rtrs_clt *clt)
> > > +{
> > > +     struct rtrs_clt_sess *sess;
> > > +     bool connected = false;
> > > +
> > > +     rcu_read_lock();
> > > +     list_for_each_entry_rcu(sess, &clt->paths_list, s.entry)
> > > +             connected |= (READ_ONCE(sess->state) == RTRS_CLT_CONNECTED);
> > > +     rcu_read_unlock();
> > > +
> > > +     return connected;
> > > +}
> > > +
> > > +static inline struct rtrs_permit *
> > > +__rtrs_get_permit(struct rtrs_clt *clt, enum rtrs_clt_con_type con_type)
> > > +{
> > > +     size_t max_depth = clt->queue_depth;
> > > +     struct rtrs_permit *permit;
> > > +     int cpu, bit;
> > > +
> > > +     /* Combined with cq_vector, we pin the IO to the the cpu it comes */
> > > +     cpu = get_cpu();
> > > +     do {
> > > +             bit = find_first_zero_bit(clt->permits_map, max_depth);
> > > +             if (unlikely(bit >= max_depth)) {
> > > +                     put_cpu();
> > > +                     return NULL;
> > > +             }
> > > +
> > > +     } while (unlikely(test_and_set_bit_lock(bit, clt->permits_map)));
> > > +     put_cpu();
> > > +
> > > +     permit = GET_PERMIT(clt, bit);
> > > +     WARN_ON(permit->mem_id != bit);
> > > +     permit->cpu_id = cpu;
> > > +     permit->con_type = con_type;
> > > +
> > > +     return permit;
> > > +}
> > > +
> > > +static inline void __rtrs_put_permit(struct rtrs_clt *clt,
> > > +                                   struct rtrs_permit *permit)
> > > +{
> > > +     clear_bit_unlock(permit->mem_id, clt->permits_map);
> > > +}
> > > +
> > > +struct rtrs_permit *rtrs_clt_get_permit(struct rtrs_clt *clt,
> > > +                                       enum rtrs_clt_con_type con_type,
> > > +                                       int can_wait)
> > > +{
> > > +     struct rtrs_permit *permit;
> > > +     DEFINE_WAIT(wait);
> > > +
> > > +     permit = __rtrs_get_permit(clt, con_type);
> > > +     if (likely(permit) || !can_wait)
> > > +             return permit;
> > > +
> > > +     do {
> > > +             prepare_to_wait(&clt->permits_wait, &wait,
> > > +                             TASK_UNINTERRUPTIBLE);
> > > +             permit = __rtrs_get_permit(clt, con_type);
> > > +             if (likely(permit))
> > > +                     break;
> > > +
> > > +             io_schedule();
> > > +     } while (1);
> > > +
> > > +     finish_wait(&clt->permits_wait, &wait);
> > > +
> > > +     return permit;
> > > +}
> > > +EXPORT_SYMBOL(rtrs_clt_get_permit);
> > > +
> > > +void rtrs_clt_put_permit(struct rtrs_clt *clt, struct rtrs_permit *permit)
> > > +{
> > > +     if (WARN_ON(!test_bit(permit->mem_id, clt->permits_map)))
> > > +             return;
> > > +
> > > +     __rtrs_put_permit(clt, permit);
> > > +
> > > +     /*
> > > +      * Putting a permit is a barrier, so we will observe
> > > +      * new entry in the wait list, no worries.
> > > +      */
> > > +     if (waitqueue_active(&clt->permits_wait))
> >
> > Where do you put permit? Does it include barrier?
> __rtrs_put_permit calls clear_bit_unlock which includes barrier
> rnbd-clt call rtrs_clt_put_permit before finish the request to block layer.
> >
> > > +             wake_up(&clt->permits_wait);
> > > +}
> > > +EXPORT_SYMBOL(rtrs_clt_put_permit);
> > > +
> > > +struct rtrs_permit *rtrs_permit_from_pdu(void *pdu)
> > > +{
> > > +     return pdu - sizeof(struct rtrs_permit);
> >
> > C standard doesn't allow pointer arithmetic on void*.
> gcc never complains,  searched aournd:

It is known bug in GCC.

> https://stackoverflow.com/questions/3523145/pointer-arithmetic-for-void-pointer-in-c
>
> You're right, will fix.
>
> >
> > > +}
> > > +EXPORT_SYMBOL(rtrs_permit_from_pdu);
> > > +
> > > +void *rtrs_permit_to_pdu(struct rtrs_permit *permit)
> > > +{
> > > +     return permit + 1;
> > > +}
> > > +EXPORT_SYMBOL(rtrs_permit_to_pdu);
> > > +
> > > +/**
> > > + * rtrs_permit_to_clt_con() - returns RDMA connection pointer by the permit
> > > + * @sess: client session pointer
> > > + * @permit: permit for the allocation of the RDMA buffer
> > > + * Note:
> > > + *     IO connection starts from 1.
> > > + *     0 connection is for user messages.
> > > + */
> > > +static
> > > +struct rtrs_clt_con *rtrs_permit_to_clt_con(struct rtrs_clt_sess *sess,
> > > +                                         struct rtrs_permit *permit)
> > > +{
> > > +     int id = 0;
> > > +
> > > +     if (likely(permit->con_type == RTRS_IO_CON))
> > > +             id = (permit->cpu_id % (sess->s.con_num - 1)) + 1;
> > > +
> > > +     return to_clt_con(sess->s.con[id]);
> > > +}
> > > +
> > > +static bool __rtrs_clt_change_state(struct rtrs_clt_sess *sess,
> > > +                                  enum rtrs_clt_state new_state)
> > > +{
> > > +     enum rtrs_clt_state old_state;
> > > +     bool changed = false;
> > > +
> > > +     lockdep_assert_held(&sess->state_wq.lock);
> > > +
> > > +     old_state = sess->state;
> > > +     switch (new_state) {
> > > +     case RTRS_CLT_CONNECTING:
> > > +             switch (old_state) {
> >
> > Double switch is better to be avoided.
> what's the better way to do it?

Rewrite function to be more readable.

> >
> > > +             case RTRS_CLT_RECONNECTING:
> > > +                     changed = true;
> > > +                     /* FALLTHRU */
> > > +             default:
> > > +                     break;
> > > +             }
> > > +             break;
> >
> >
> > ....
> >
> > Thanks
> Thanks
