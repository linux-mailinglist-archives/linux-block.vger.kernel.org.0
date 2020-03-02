Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9796B1757EA
	for <lists+linux-block@lfdr.de>; Mon,  2 Mar 2020 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgCBKGg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 2 Mar 2020 05:06:36 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38410 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCBKGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Mar 2020 05:06:36 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so10862998iog.5
        for <linux-block@vger.kernel.org>; Mon, 02 Mar 2020 02:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2X+nGF1fhVqqRLQUHKPXqowGBtTbEq4BkYvVF8pJfVg=;
        b=LfRqEai7G+xAgg9v3RL74DgOvK8NtF4n4DcEsbAGuQw24OTerc0pzfwfcRU4azGGfE
         V/iW30zlSfejjt0rHu6FiaDM5FVQ8xZaB6Rov4x6QyM/GNLp722vsuKq7z7ovHIpFXLT
         d5w/Cuk9Se0bvKw9q2Qix0giSiOgyhN6MB4hcl1KuXKSoq3FRUWb+VHAtnxYPxAgyCSl
         2rGT+uPzSc6gvZURWKVW/e5bUsdd1vpQo9G5+7El/vJB9SdkvSTNKCCUeaFEszYfdicA
         kAD3O5WQrfYYcz/eJfwR4V6lKJKr+T33iQcGMXVAbj42Bk3ONhShaq9LLVVtYzkbGWWn
         UUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2X+nGF1fhVqqRLQUHKPXqowGBtTbEq4BkYvVF8pJfVg=;
        b=UHBJEOmbe2TTnE/s9XJDGsjW5iu1Da0WbFM5In8u64AHmhLZ1YIychw0BHZeKpXZRY
         5OP3FKl4JC9vj1q9VhLcpNlY5CNrbpkqHNGGMPQwdC077vzPuMj9udEj7lM4rGSOdlGq
         TXkc4Pp+8/S6AYiZJNSww4ZBysMTXByMH2T539a6YhcyLcaQEJ85rtJu5sAS5jg6CPoM
         YUanm0YMUCBkSkJm3UEtUFMBb70U8JrZuByDl/uYuVGBOHDHuN3WTC692fjhziJktK8V
         gSqGWjkGcpAtN07gq1Mo5AABpd2CIGjz/8BIcBVDxKFDjafz6/gyoU4wbkCEA0079EwP
         LTyQ==
X-Gm-Message-State: APjAAAV6hUGE4/2RI6AmIEoOWBJCL40oRy/n/2nvcKVcYHjjk/J4GE/9
        XoAjLhh6MsTIDR0xZUnS9iiNhaztcBBowPHirZ5j
X-Google-Smtp-Source: APXvYqzC1HC6oDmNPT77OpWVk4Njq/BXRNc4k2oJOC23gD1AFC5wbpICrpo89Na3zapzq04JVfG5qaNSkxtcrEancwI=
X-Received: by 2002:a5e:c111:: with SMTP id v17mr6452821iol.300.1583143595605;
 Mon, 02 Mar 2020 02:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20200221104721.350-1-jinpuwang@gmail.com> <20200221104721.350-22-jinpuwang@gmail.com>
 <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org>
In-Reply-To: <92721a50-158f-3018-39d4-40fce7b0f4d8@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 2 Mar 2020 11:06:24 +0100
Message-ID: <CAHg0Huy_8hzxxA6R8_EzPNfYd3QN-meUckFStUrjiGeVaGj_Qg@mail.gmail.com>
Subject: Re: [PATCH v9 21/25] block/rnbd: server: functionality for IO
 submission to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 1, 2020 at 4:09 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-02-21 02:47, Jack Wang wrote:
> > +static struct bio *rnbd_bio_map_kern(struct request_queue *q, void *data,
> > +                                   struct bio_set *bs,
> > +                                   unsigned int len, gfp_t gfp_mask)
> > +{
> > +     unsigned long kaddr = (unsigned long)data;
> > +     unsigned long end = (kaddr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +     unsigned long start = kaddr >> PAGE_SHIFT;
> > +     const int nr_pages = end - start;
> > +     int offset, i;
> > +     struct bio *bio;
> > +
> > +     bio = bio_alloc_bioset(gfp_mask, nr_pages, bs);
> > +     if (!bio)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     offset = offset_in_page(kaddr);
> > +     for (i = 0; i < nr_pages; i++) {
> > +             unsigned int bytes = PAGE_SIZE - offset;
> > +
> > +             if (len <= 0)
> > +                     break;
> > +
> > +             if (bytes > len)
> > +                     bytes = len;
> > +
> > +             if (bio_add_pc_page(q, bio, virt_to_page(data), bytes,
> > +                                 offset) < bytes) {
> > +                     /* we don't support partial mappings */
> > +                     bio_put(bio);
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +
> > +             data += bytes;
> > +             len -= bytes;
> > +             offset = 0;
> > +     }
> > +
> > +     bio->bi_end_io = bio_put;
> > +     return bio;
> > +}
>
> The above function is almost identical to bio_map_kern(). Please find a
> way to prevent such code duplication.

Hi Bart,

We prealloc bio_set in order to avoid allocation in io path done by
bio_map_kern() (call to bio_kmalloc). Instead we use
bio_alloc_bioset() with a preallocated bio_set. Will test whether
performance advantage is measurable and if not will switch to
bio_map_kern.
>
> > +static inline int rnbd_dev_get_logical_bsize(const struct rnbd_dev *dev)
> > +{
> > +     return bdev_logical_block_size(dev->bdev);
> > +}
> > +
> > +static inline int rnbd_dev_get_phys_bsize(const struct rnbd_dev *dev)
> > +{
> > +     return bdev_physical_block_size(dev->bdev);
> > +}
> > +
> > +static inline int
> > +rnbd_dev_get_max_write_same_sects(const struct rnbd_dev *dev)
> > +{
> > +     return bdev_write_same(dev->bdev);
> > +}
>
> Are you sure that the above functions are useful? Please do not
> introduce inline functions for well known functions, especially if their
> function name is longer than their implementation.

This was initially introduced to abstract fileio/blockio devices, will
drop those since we only support block io now.
Thank you!


> Thanks,
>
> Bart.
