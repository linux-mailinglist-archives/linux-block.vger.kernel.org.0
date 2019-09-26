Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CEFBF60D
	for <lists+linux-block@lfdr.de>; Thu, 26 Sep 2019 17:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfIZPiZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Sep 2019 11:38:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35728 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfIZPiY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 11:38:24 -0400
Received: by mail-io1-f65.google.com with SMTP id q10so7792621iop.2
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh5tIrifhCGwEblEk0uaUyXDhhvPj9j5rW2V2gwVGcU=;
        b=Vx2Q2UPgYEUF8Xmkx/9xhohOpE68qdaWbVcHX5UDNohEKa9qV/UagHZar2QRyYaxv5
         cQ2Tan6V7e1oZVkIvtuwao3YX/9M4KR+NvjbunDEycr3rq8sECiLESEL9yw3y7ysvdBx
         Utf66xm2wwRHmcKiEoozzcemO9ROevzJeoab7iZRKluzv+8RfoDTPdAmsno6KL7mW0II
         ObVi9yeBbc3dXcQxfCoS3b7DrmNgg4FXi0is9Jh/TFKNIC/AkZ7mtU6nDj0h1d8FpyFW
         F+hRaAPPCCO+NQCj1sYl6ENT+cYyDuYBN6hNiUasFnzSjF3w3S8nYr/WJpqkdvrpbRe7
         gQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh5tIrifhCGwEblEk0uaUyXDhhvPj9j5rW2V2gwVGcU=;
        b=G5NupL9+QvFvfZhihIv0KXbaM/E81ra0e3XXfaO7pPQW5cJzXU9xTXdDtBDCnfTLPA
         DMDsXYo/94qc0V0kwI9tpAOw56tEaaP0EkKthJNkFkdQAnjgAOXiRVOUlDvkEyxOvUkh
         D+qKytnYOZPmeQZOmkCinV3LcXMVCfw4CmsTWc2VUMXG/HeJBVxZyb+cZZrZ6fF1bRue
         huD7hl1TLDYYSCarsRSovUCFDGQX8OP+uMdpxo6lRQgnJwWol1bQCi5ixqOkxijFFClN
         6UBm6EGUBrRavnoB2u41JnHHnqe1ZxKJROdBgl/P8q0eE1uEvQWvEZ4QulYNsgS0E++e
         WjQQ==
X-Gm-Message-State: APjAAAUbvu3Dc7UX9DRJr6+voiA30YLTHza5ZGfImVbMv1OZYENTPvpE
        uv9ii5uadVC+WmSXZwsiLw1ifYe88S5I0YeeV63z
X-Google-Smtp-Source: APXvYqxVAcTskR1MOwPRDd2AEz8PUi5T5ga+pwMPnis+3DCwSXqmMNV4Ui9T+PF8wy6NWAyUda+SOJWPK/eX/su4NvA=
X-Received: by 2002:a6b:c348:: with SMTP id t69mr3871001iof.66.1569512304072;
 Thu, 26 Sep 2019 08:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <20190620150337.7847-22-jinpuwang@gmail.com>
 <d1208649-5c25-578f-967e-f7a3c9edd9ce@acm.org> <CAMGffE=RpTjDX-LL2E5t_eOF8iwG=UpgWFcnB3tz-N-PQ0etoQ@mail.gmail.com>
 <ab90033d-6045-fcdf-f238-80d8b4852559@acm.org> <CAHg0HuwJJ3LmUwOOw2Uba0Zq_c9hwUyFBrao2nzpv4y97U1Mvg@mail.gmail.com>
 <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org>
In-Reply-To: <40f69402-5f38-c78b-8922-3a77babb4c6c@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 26 Sep 2019 17:38:13 +0200
Message-ID: <CAHg0HuxOP7Vhkd3pHi8XZBo2uCBGmMOMgSpBQuPTVY9MLB5EBA@mail.gmail.com>
Subject: Re: [PATCH v4 21/25] ibnbd: server: functionality for IO submission
 to file or block dev
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > Bart, would it in your opinion be OK to drop the file_io support in
> > IBNBD entirely? We implemented this feature in the beginning of the
> > project to see whether it could be beneficial in some use cases, but
> > never actually found any.
>
> I think that's reasonable since the loop driver can be used to convert a
> file into a block device.
Jack, shall we drop it?
