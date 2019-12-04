Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 091121130BB
	for <lists+linux-block@lfdr.de>; Wed,  4 Dec 2019 18:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLDRXm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Dec 2019 12:23:42 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34304 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfLDRXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Dec 2019 12:23:42 -0500
Received: by mail-ot1-f67.google.com with SMTP id a15so7069155otf.1
        for <linux-block@vger.kernel.org>; Wed, 04 Dec 2019 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsCzQi8E+i59OetclexFEuGwaInTqcScwjzkGJ7Iw3Y=;
        b=fT1/3V8zo6Ho8bQmHchM2zRNQciwQJZW83Ik+qPSTDEnFA/ysUxVKKsXA+WmPkadC5
         objdZHiPkRjebVmcem9kDUUetJIQ0/Fm3ubn8hT/aQ5BWtsffjrNgistyM4scWf1nYjl
         j5z4c0FvG281u+UrCXrHaBAovfyUU6iYXwS6TNeBlQLAZ8fycGYxNtygb6FaMHMNQ+dY
         1EuFdzdUtyCHKpUi2eNzpgGIwWgRT7fBO9iNty7repmudXsrhLYmjw+t9TU+X2OaW/hC
         whhkGZmNOMBjwL7fb3w6lO3AJ1E1+JCnXLvucw3l8HwMOChWwtyNefnvtvnJ5OSIUCw+
         ksvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsCzQi8E+i59OetclexFEuGwaInTqcScwjzkGJ7Iw3Y=;
        b=PS2j60CHhOAyTn5fE+6DlJfVy4T1YgIRaaXPFZ7ITEaeR3Y8P5DRyCRCVCRHf+yYuG
         3C6Zc52QrwQCupE1DozOLMQQn/xsBz3s1YojsxAPgFFw1ZCDvuPQrez/IunnTDd24UmY
         AZYA3JZ1VuQZhxJBHn7Hr3GjATD0BLn1WHxWNgK5kYkuePMLJJEkI877WYzgqyb3Jiv7
         2NhP5g4fGTNrYYsNLde1tLuw8S0HntNUzb7JDDw2Lyx3MfUAnVQdDkgQkl29c34VlLM5
         A/Te5UKNlHUCxxBviFk847HBuDdfO4oE8q7yPDC6QjjiAMufd2LM7mTjkCIQy8UvzasC
         +bVg==
X-Gm-Message-State: APjAAAUn9/shBiDjkTT/v2Jsrs6QJk607oWn6iF8JF6ybrBnaxvcZA8L
        UdyY9LIvhW+2oZmSuw818dWQp1hSUO9592WzcBLiUQ==
X-Google-Smtp-Source: APXvYqxDzeT0lRIVPfz0OUxh4T5CV12SKPG3ZsGFxNj7PMyfRcQk4TUX55GUPPYWTmDJouOQEO7uecQGcSnynq4egtY=
X-Received: by 2002:a05:6830:58:: with SMTP id d24mr3349473otp.356.1575480221331;
 Wed, 04 Dec 2019 09:23:41 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p>
In-Reply-To: <20191204010529.GA3910@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Wed, 4 Dec 2019 12:23:39 -0500
Message-ID: <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I have tried your latest "workaround" patch in brd including the fix
for large offsets, and it does appear to work. I tried the same tests
and the data was written correctly for all offsets I tried. Thanks!

I include the updated additional bpftrace below.

> So firstly, I'd suggest to investigate from RDMA driver side to see why
> un-aligned buffer is passed to block layer.
>
> According to previous discussion, 512 aligned buffer should be provided
> to block layer.
>
> So looks the driver needs to be fixed.

If it does appear to be an RDMA driver issue, do you know who we
should follow up with directly from the RDMA driver side of the world?

Presumably non-brd devices, ie: real scsi devices work for these test
cases because they accept un-aligned buffers?

> The patch might not cover the big offset case, could you collect bpftrace
> via the following script when you reproduce the issue with >4096 offset?

Here is the updated bpftrace output for an offset of 8192:

8192 76
4020 76 1 131056
4096 0 1 131063
76 0 1 131071
4096 0
4096 0 0 0
4096 0
4096 0 0 8
4096 0
4096 0 0 130944
8192 76
4020 76 1 131056
4096 0 1 131063
76 0 1 131071
4096 0
4096 0 0 130808
4096 0
4096 0
4096 0 0 131056
4096 0 0 131064
[snip]

Thanks,
Steve
