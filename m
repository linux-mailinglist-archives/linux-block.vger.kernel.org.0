Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045F66527C
	for <lists+linux-block@lfdr.de>; Thu, 11 Jul 2019 09:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfGKH1Y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Jul 2019 03:27:24 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43381 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKH1X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 03:27:23 -0400
Received: by mail-io1-f65.google.com with SMTP id k20so10352683ios.10
        for <linux-block@vger.kernel.org>; Thu, 11 Jul 2019 00:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5UDD2PQr8A+4fkF74jRpQjrDOTSh0xYZIA6dZ/Htjw=;
        b=LIY6xG3BDrWKAzQfPkWVRL4sqiSwKj8n1WnjhzZ9UggwxDvZ7D5bXXBnwM3oiZbDFP
         EZIejnyXLp+gnnZSNUY4pb1sz6Lhekpnec9VrsvTvwCHaIlJeTKPB1V4nzOcbFx3Ip5g
         taEnuWMVV+FejKgzVRcZQZ+sMb4X2aDcEfams0VFEfadP8sZ11+f7bMP3NHNc27I2RTb
         0QxorSLgyoAmO/IgOfsZBNYDMq+8ttbTzJc9ycdJB21rycBS0c7WEfkRacMeZV2ThCV8
         Maic0mwqjs6TeIQFGw5wEndmpXdpJo6fkkVpO1rBDrn/MTxh45OlJ8APM4jninCGu6SG
         f/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5UDD2PQr8A+4fkF74jRpQjrDOTSh0xYZIA6dZ/Htjw=;
        b=jDRIbutgPpCLRug2jhujo8XAFV+6awmAyvHynfxGzsgXh5Bw+ScyIITZdYoiWcvpZc
         0h0Kg82L11pw+zfotDwV5qM8QyKaZJm88l+ZW6xg6HKaMgx7iRO5ttaS7SAM9NzWmC2S
         MPVuZarWjb6c0ysGBTmJ8kFQ5owwgod09dRRh3C66SZ1qIendZAQjUsb5UzzU7HYYNqO
         51PKgVJvjnZ0PDCzzcPLeInpYZ29B/iEDV4VOCiXAW3CntZfTre5PSyWudZYKrX0VMKH
         D52MTJ8fzbQMOp9UzJn2LAG0T1fwHDlDtZg97wTNEZ6un92BbcBcIb4M7VwdRS6sFv1z
         vPWw==
X-Gm-Message-State: APjAAAUgTq/ZZ8W03+qcUP1/QUO5wXTe9G4C1Vk5hPt12YYVS0zhIEMy
        GxT4F4kZAr7X+P0YFg0hd8uriVOKL12lsgoVBzU9
X-Google-Smtp-Source: APXvYqzP/GEHKRGAFz3PmilWWiv14j8G7gP975ds+zKIubBHvlXkC/uFiFlTKauhqCCNbkssheN5c1gR/lm0DQFWEJc=
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr2792250jao.72.1562830043055;
 Thu, 11 Jul 2019 00:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190620150337.7847-1-jinpuwang@gmail.com> <CAHg0HuzUaKs-ACHah-VdNHbot0_usx4ErMesVAw8+DFR63FFqw@mail.gmail.com>
 <a8f2f1d2-b5d9-92fc-40c8-090af0487723@grimberg.me> <20190710135519.GA4051@ziepe.ca>
 <c49bf227-5274-9d13-deba-a405c75d1358@grimberg.me> <20190710172505.GD4051@ziepe.ca>
 <930e0bc6-8c5c-97b5-c500-0bd1706b32c1@grimberg.me>
In-Reply-To: <930e0bc6-8c5c-97b5-c500-0bd1706b32c1@grimberg.me>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 11 Jul 2019 09:27:11 +0200
Message-ID: <CAHg0HuxmYV3=L9ifjiOW3c+Zv-+neHMozxCk8_rovdohV=Q-Bg@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jack Wang <jinpuwang@gmail.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, Christoph Hellwig <hch@infradead.org>,
        bvanassche@acm.org, dledford@redhat.com,
        Roman Pen <r.peniaev@gmail.com>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Sagi,

thanks a lot for the analysis. I didn't know about about the
inline_data_size parameter in nvmet. It is at PAGE_SIZE on our
systems.
Will rerun our benchmarks with
echo 2097152 > /sys/kernel/config/nvmet/ports/1/param_inline_data_size
echo 2097152 > /sys/kernel/config/nvmet/ports/2/param_inline_data_size
before enabling the port.
Best
Danil.

On Wed, Jul 10, 2019 at 9:11 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> I still do not understand why this should give any notice-able
> >> performance advantage.
> >
> > Usually omitting invalidations gives a healthy bump.
> >
> > Also, RDMA WRITE is generally faster than READ at the HW level in
> > various ways.
>
> Yes, but this should be essentially identical to running nvme-rdma
> with 512KB of immediate-data (the nvme term is in-capsule data).
>
> In the upstream nvme target we have inline_data_size port attribute
> that is tunable for that (defaults to PAGE_SIZE).



-- 
Danil Kipnis
Linux Kernel Developer

1&1 IONOS Cloud GmbH | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: danil.kipnis@cloud.ionos.com | Web: www.ionos.de


Head Office: Berlin, Germany
District Court Berlin Charlottenburg, Registration number: HRB 125506 B
Executive Management: Christoph Steffens, Matthias Steinberg, Achim Weiss

Member of United Internet

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this
e-mail in any way is prohibited. If you have received this e-mail in
error, please notify the sender and delete the e-mail.
