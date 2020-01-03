Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7412F965
	for <lists+linux-block@lfdr.de>; Fri,  3 Jan 2020 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgACO7T (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jan 2020 09:59:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41135 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgACO7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jan 2020 09:59:19 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so36775047ils.8
        for <linux-block@vger.kernel.org>; Fri, 03 Jan 2020 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GpEOSGykdHi9OUbNbFAr8WeMOosoG0PHmiJOULWlVFg=;
        b=MNZLSd8RAs6HvqfNOJGD0xKiwQw8f8AjwWJASrVlnbN2nYYdDKsb3FsXWpCpEkBnqQ
         zlT6tWv8mr+iRLzaD9iUwrG4I6s0iHDJVf2C+puW7cOSFGqnx7q9DCYiqmVD3gCvAq3W
         jmpeV3pdRaFtlE1C+JbecB97hwQEJKBYNMttaDmXasZAPdkFSucyciPHvWSZum6HHbth
         9qfD0eWKHgmj+el/phF+9S07Mym8d3pS6DSTxcP3j9aikamd3Tp1prNjvnGim2DEOJrP
         bHFSR3PyUarZQytsqiXa9rg/C79hOWSRTYdDv89ziNBy2N3LDzjiQ483bS7RKYyiKAYD
         r9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GpEOSGykdHi9OUbNbFAr8WeMOosoG0PHmiJOULWlVFg=;
        b=jK0xu//Mh0PYm48aPoBlDjBGOnOfIpMp0De0+QULoqpb3prIsT3xV0EKywIllt5tDP
         B6X4WNeryEr6CwdrSPpPPHkp3m9LQmWUhJDyVqPC/1euDYFK/nywLsbJVzVtN11uMGv3
         EOH4T0TpYcYOlmP7aQ5a99+zG3kGFnp0JBNgXrXbobFU1zaNfK1XCCdhol8bn42EuIvb
         qSN4jnapu6U2Bacc3Z+0BnQig4gFbxbYtx/Dm22P20o1Nju0/+NGnu/1h26vLmhhRs06
         L1uMUq+499SsBlWVseO506Yl/XbcalsfhKXvbryKVQGtKs/4R1mDofctbNVgSbqaBZZo
         qYOg==
X-Gm-Message-State: APjAAAXn1yo5MdOITKjOJfWRCwcgvJUIGPi/Z2IuCLYlQSn/qOu8klEB
        puPV5uEwD4N9jaxrtHcSPTkXfnJA8p8xsDSve8bF3g==
X-Google-Smtp-Source: APXvYqyyFWOvXuXkKT3qaGa8REOkW2XA9grKnJTal+MjouGPiRCNUMaSpp8NJIly2aUxu+faDQ42BuSDH9xrVCjfYBs=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr77213155ill.71.1578063558482;
 Fri, 03 Jan 2020 06:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20191230102942.18395-1-jinpuwang@gmail.com> <20191230102942.18395-9-jinpuwang@gmail.com>
 <8be61a28-baf7-99dd-c94d-53244565906f@acm.org>
In-Reply-To: <8be61a28-baf7-99dd-c94d-53244565906f@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 3 Jan 2020 15:59:07 +0100
Message-ID: <CAMGffEk+XSSdLU==O5inqEc2UycSaB7K1+vqkof=4RDnN4pp6Q@mail.gmail.com>
Subject: Re: [PATCH v6 08/25] rtrs: client: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 2, 2020 at 10:14 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/30/19 2:29 AM, Jack Wang wrote:
> > +static struct kobj_type ktype = {
> > +     .sysfs_ops = &kobj_sysfs_ops,
> > +};
>
> Can this data structure be declared 'const'?
No, kobject_init_and_add expect sturct kobj_type *.
>
> > +static ssize_t max_reconnect_attempts_show(struct device *dev,
> > +                                        struct device_attribute *attr,
> > +                                        char *page)
> > +{
> > +     struct rtrs_clt *clt;
> > +
> > +     clt = container_of(dev, struct rtrs_clt, dev);
>
> If the above two statements would be combined into a single statement,
> does the result still fit in 80 columns? If so, please combine these two
> statements into a single statement.
ok.
>
> > +static ssize_t max_reconnect_attempts_store(struct device *dev,
> > +                                         struct device_attribute *attr,
> > +                                         const char *buf,
> > +                                         size_t count)
> > +{
> > +     struct rtrs_clt *clt;
> > +     int value;
> > +     int ret;
> > +
> > +     clt = container_of(dev, struct rtrs_clt, dev);
>
> Same comment here and also for other uses of 'clt': how about combining
> the declaration and initialization of 'clt' into a single line of code?
ok.
>
> > +static ssize_t mpath_policy_show(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              char *page)
> > +{
> > +     struct rtrs_clt *clt;
> > +
> > +     clt = container_of(dev, struct rtrs_clt, dev);
> > +
> > +     switch (clt->mp_policy) {
> > +     case MP_POLICY_RR:
> > +             return sprintf(page, "round-robin (RR: %d)\n", clt->mp_policy);
> > +     case MP_POLICY_MIN_INFLIGHT:
> > +             return sprintf(page, "min-inflight (MI: %d)\n", clt->mp_policy);
> > +     default:
> > +             return sprintf(page, "Unknown (%d)\n", clt->mp_policy);
> > +     }
> > +}
>
> Is the above show function compatible with the sysfs one-value-per-file
> rule?
It's a single string :)
>
> > +static struct kobj_attribute rtrs_clt_remove_path_attr =
> > +     __ATTR(remove_path, 0644, rtrs_clt_remove_path_show,
> > +            rtrs_clt_remove_path_store);
>
> Could __ATTR_RW() have been used here?
can be used, but I prefer to keep the rtrs_clt_ prefix for function names.
>
> > +static struct kobj_attribute rtrs_clt_src_addr_attr =
> > +     __ATTR(src_addr, 0444, rtrs_clt_src_addr_show, NULL);
>
> Could __ATTR_RO() have been used here?
dito.
>
> > +static struct attribute_group rtrs_clt_sess_attr_group = {
> > +     .attrs = rtrs_clt_sess_attrs,
> > +};
>
> Can this data structure be declared 'const'?
Yes.
>
> Thanks,
>
> Bart.
Thanks
