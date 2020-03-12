Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF218375C
	for <lists+linux-block@lfdr.de>; Thu, 12 Mar 2020 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCLRZV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Mar 2020 13:25:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCLRZV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 13:25:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id e20so5021489qto.5
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3I4BcKbwDgC4vdY7SeTcDelPRCNOJF9vAmzCTbFTATU=;
        b=Fd0ZdpYdDkTWlh+VloYYrGDdixz8YO3L+2Akq7knHnrdAPUQNUZFoVyrCeo02FiKnE
         QQnTAfEP+QrGLGatyQ+s8FSWC1elVku63MontnSvcxVosG0l73qbTbHCA5XXu0WXS+rI
         i8GUqPoPfoxuBnXRufdPIgo9AvwtWigCpQTaglULeZx4BuOhDip5cFZkJ1+xTbw0duSS
         q5JjH5ClyrhEbPJSRD5EgX2/2MoGpd75i1el/GsuuDywtyNqbR993KoYOznZjFzAD5nN
         PdTtvI1Zcd8tp4/epXfdkG9enQfRqKhjemrTM/QXzsptdU5l/nGU8HjGeEvECzxNlPip
         VioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3I4BcKbwDgC4vdY7SeTcDelPRCNOJF9vAmzCTbFTATU=;
        b=S94cR0GWPO8PldGVWtc37Ozy/T9Vndp53QfPcMtvbx2JI+1c4RSMV2DuiRVGN/oC0u
         uvu2i1cpbdtzNReDOty3YM9nwjFfXGC6FNWGOYyPcRiZEhwi3FfwqeBWLyeEhdI1a11S
         GX0/QRallhAh5zs3/1dh6Kd9jiQUsFrvJGxagPuQanRDqxUUkW6+FN7H8Ky31pr7Z08i
         Mzkyq4/AfhTQMqnaHXTUQVMVrvxDFOPS0+fdWp+aB5gDQlqbeRm91XNjfJQsObiYBZIF
         YChJ8uYmkUCOhvAyL89omuPB/fi461EeEEqWlkNqfIwgqGzn7bUFOuzeEL28/UHcNMh/
         FtcQ==
X-Gm-Message-State: ANhLgQ2HjzDqszVEJM8HCpuCtEx7ehbSWMlq0baNF314v7PTAWdJohU3
        EjW2gyK5TaS68b1RCnjRryJ7PQ==
X-Google-Smtp-Source: ADFU+vtjcpu0B5fdIhByXCSw7Sql34cX0QuCM74cecvBReRgPPnzL00bLjPxdC1HE6wwwSvIj2ArXQ==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr193389qtq.78.1584033918531;
        Thu, 12 Mar 2020 10:25:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x22sm6367315qki.54.2020.03.12.10.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Mar 2020 10:25:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jCRa9-000120-H8; Thu, 12 Mar 2020 14:25:17 -0300
Date:   Thu, 12 Mar 2020 14:25:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: Re: [PATCH v10 06/26] RDMA/rtrs: client: main functionality
Message-ID: <20200312172517.GU31668@ziepe.ca>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
 <20200311161240.30190-7-jinpu.wang@cloud.ionos.com>
 <20200311190156.GH31668@ziepe.ca>
 <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0HuziyOuUZ48Rp5S_-A9osB==UFOTfWH0+35omiqVjogqww@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 12, 2020 at 06:10:06PM +0100, Danil Kipnis wrote:
> Hi Jason,
> 
> On Wed, Mar 11, 2020 at 8:01 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Mar 11, 2020 at 05:12:20PM +0100, Jack Wang wrote:
> > > +static void rtrs_clt_remove_path_from_arr(struct rtrs_clt_sess *sess)
> > > +{
> > > +     struct rtrs_clt *clt = sess->clt;
> > > +     struct rtrs_clt_sess *next;
> > > +     bool wait_for_grace = false;
> > > +     int cpu;
> > > +
> > > +     mutex_lock(&clt->paths_mutex);
> > > +     list_del_rcu(&sess->s.entry);
> > > +
> > > +     /* Make sure everybody observes path removal. */
> > > +     synchronize_rcu();
> > > +
> > > +     /*
> > > +      * At this point nobody sees @sess in the list, but still we have
> > > +      * dangling pointer @pcpu_path which _can_ point to @sess.  Since
> > > +      * nobody can observe @sess in the list, we guarantee that IO path
> > > +      * will not assign @sess to @pcpu_path, i.e. @pcpu_path can be equal
> > > +      * to @sess, but can never again become @sess.
> > > +      */
> > > +
> > > +     /*
> > > +      * Decrement paths number only after grace period, because
> > > +      * caller of do_each_path() must firstly observe list without
> > > +      * path and only then decremented paths number.
> > > +      *
> > > +      * Otherwise there can be the following situation:
> > > +      *    o Two paths exist and IO is coming.
> > > +      *    o One path is removed:
> > > +      *      CPU#0                          CPU#1
> > > +      *      do_each_path():                rtrs_clt_remove_path_from_arr():
> > > +      *          path = get_next_path()
> > > +      *          ^^^                            list_del_rcu(path)
> > > +      *          [!CONNECTED path]              clt->paths_num--
> > > +      *                                              ^^^^^^^^^
> > > +      *          load clt->paths_num                 from 2 to 1
> > > +      *                    ^^^^^^^^^
> > > +      *                    sees 1
> > > +      *
> > > +      *      path is observed as !CONNECTED, but do_each_path() loop
> > > +      *      ends, because expression i < clt->paths_num is false.
> > > +      */
> > > +     clt->paths_num--;
> > > +
> > > +     /*
> > > +      * Get @next connection from current @sess which is going to be
> > > +      * removed.  If @sess is the last element, then @next is NULL.
> > > +      */
> > > +     next = list_next_or_null_rr_rcu(&clt->paths_list, &sess->s.entry,
> > > +                                     typeof(*next), s.entry);
> >
> > calling rcu list iteration without holding rcu_lock is wrong
> This function (add_path) along with the corresponding
> remove_path_from_arr() are the only functions modifying the
> paths_list. In both functions paths_mutex is taken so that they are
> serialized. Since the modification of the paths_list is protected by
> the mutex, the rcu_read_lock is superfluous here.

Then don't use the _rcu functions.

> >
> > > +     /*
> > > +      * @pcpu paths can still point to the path which is going to be
> > > +      * removed, so change the pointer manually.
> > > +      */
> > > +     for_each_possible_cpu(cpu) {
> > > +             struct rtrs_clt_sess __rcu **ppcpu_path;
> > > +
> > > +             ppcpu_path = per_cpu_ptr(clt->pcpu_path, cpu);
> > > +             if (rcu_dereference(*ppcpu_path) != sess)
> >
> > calling rcu_dereference without holding rcu_lock is wrong.
> We only need a READ_ONCE semantic here. ppcpu_path is pointing to the
> last path used for an IO and is used for the round robin multipath
> policy. I guess the call can be changed to rcu_dereference_raw to
> avoid rcu_lockdep warning. The round-robin algorithm has been reviewed
> by Paul E. McKenney, he wrote a litmus test for it:
> https://lkml.org/lkml/2018/5/28/2080.

You can't call rcu expecting functions without holding the rcu lock -
use READ_ONCE/etc if that is what is really going on

> >
> > > +static void rtrs_clt_add_path_to_arr(struct rtrs_clt_sess *sess,
> > > +                                   struct rtrs_addr *addr)
> > > +{
> > > +     struct rtrs_clt *clt = sess->clt;
> > > +
> > > +     mutex_lock(&clt->paths_mutex);
> > > +     clt->paths_num++;
> > > +
> > > +     /*
> > > +      * Firstly increase paths_num, wait for GP and then
> > > +      * add path to the list.  Why?  Since we add path with
> > > +      * !CONNECTED state explanation is similar to what has
> > > +      * been written in rtrs_clt_remove_path_from_arr().
> > > +      */
> > > +     synchronize_rcu();
> >
> > This makes no sense to me. RCU readers cannot observe the element in
> > the list without also observing paths_num++
> Paths_num is only used to make sure a reader doesn't look for a
> CONNECTED path in the list for ever - instead he makes at most
> paths_num attempts. The reader can in fact observe paths_num++ without
> observing new element in the paths_list, but this is OK. When adding a
> new path we first increase the paths_num and them add the element to
> the list to make sure the reader will also iterate over it. When
> removing the path - the logic is opposite: we first remove element
> from the list and only then decrement the paths_num.

I don't understand how this explains why synchronize_rcu would be need
here.

> > > +static void rtrs_clt_close_work(struct work_struct *work)
> > > +{
> > > +     struct rtrs_clt_sess *sess;
> > > +
> > > +     sess = container_of(work, struct rtrs_clt_sess, close_work);
> > > +
> > > +     cancel_delayed_work_sync(&sess->reconnect_dwork);
> > > +     rtrs_clt_stop_and_destroy_conns(sess);
> > > +     /*
> > > +      * Sounds stupid, huh?  No, it is not.  Consider this sequence:
> >
> > It sounds stupid because it is stupid. cancel_work is a giant race if
> > some other action hasn't been taken to block parallel threads from
> > calling queue_work before calling cancel_work.
> Will double check. It might be possible to avoid the second call to
> the cancel_delayed_work_sync().

I would have guessed first call.. Before doing cancel_work something
must have prevented new work from being created.

> > > +     err = rtrs_clt_create_sysfs_root_folders(clt);
> >
> > sysfs creation that is not done as part of device_regsiter races with
> > udev.
> We only use device_register() to create
> /sys/class/rtrs_client/<sessionname> sysfs directory. We then create
> some folders and files inside this directory (i.e. paths/,
> multipath_policy, etc.). Do you mean that the uevent is generated
> before we create those subdirectories? How can the creation of this
> subdirectories and files be integrated into the device_register()
> call?

Yes the uevent..

Limited types of sysfs files can be created with the group scheme.

Others need to manipulate the uevent unfortunately, see how ib device
registration works

> > > +struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> > > +                              const char *sessname,
> > > +                              const struct rtrs_addr *paths,
> > > +                              size_t paths_num,
> > > +                              u16 port,
> > > +                              size_t pdu_sz, u8 reconnect_delay_sec,
> > > +                              u16 max_segments,
> > > +                              s16 max_reconnect_attempts)
> > > +{
> > > +     struct rtrs_clt_sess *sess, *tmp;
> > > +     struct rtrs_clt *clt;
> > > +     int err, i;
> > > +
> > > +     clt = alloc_clt(sessname, paths_num, port, pdu_sz, ops->priv,
> > > +                     ops->link_ev,
> > > +                     max_segments, reconnect_delay_sec,
> > > +                     max_reconnect_attempts);
> > > +     if (IS_ERR(clt)) {
> > > +             err = PTR_ERR(clt);
> > > +             goto out;
> > > +     }
> > > +     for (i = 0; i < paths_num; i++) {
> > > +             struct rtrs_clt_sess *sess;
> > > +
> > > +             sess = alloc_sess(clt, &paths[i], nr_cpu_ids,
> > > +                               max_segments);
> > > +             if (IS_ERR(sess)) {
> > > +                     err = PTR_ERR(sess);
> > > +                     goto close_all_sess;
> > > +             }
> > > +             list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> > > +
> > > +             err = init_sess(sess);
> > > +             if (err)
> > > +                     goto close_all_sess;
> > > +
> > > +             err = rtrs_clt_create_sess_files(sess);
> > > +             if (err)
> > > +                     goto close_all_sess;
> > > +     }
> > > +     err = alloc_permits(clt);
> > > +     if (err)
> > > +             goto close_all_sess;
> > > +     err = rtrs_clt_create_sysfs_root_files(clt);
> > > +     if (err)
> > > +             goto close_all_sess;
> > > +
> > > +     /*
> > > +      * There is a race if someone decides to completely remove just
> > > +      * newly created path using sysfs entry.  To avoid the race we
> > > +      * use simple 'opened' flag, see rtrs_clt_remove_path_from_sysfs().
> > > +      */
> > > +     clt->opened = true;
> >
> > A race solution without locks?
> We wanted to make sure that a path belonging to a session currently
> being established can't be removed from sysfs before the establishment
> is finished.

There are still no locks, so this solution to races is probably racey.

Jason
