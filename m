Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2C311058C
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2019 20:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfLCT4U (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 Dec 2019 14:56:20 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40048 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfLCT4U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Dec 2019 14:56:20 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so4079382oto.7
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2019 11:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2eSaP9cJhqPHyzDC8w3CbFx7JCZ6KKxOyraLwR9PhA=;
        b=wLTIGZ++NbsJM2gFEzkW3jFKZShTPG1f0lsuIQOltlAXcRb5EdTwEBJEbZqvi56cYV
         PxGHzJBqm2IUSJUdsJnmk+JX0dumKWOVdZo56piubBOVXekQKPppFIt64Nd1w467qyEE
         RIcaiqRojms1cvrkcuLcWooyxWpal0suWcPT3OTSqHS3RpJzFukQBKDAkIWaUFG3fEHn
         uWRLqYak21px3vZvwIXwHiydJOe6Uj1/z4PDOQxlJgF9+vZxpVVMPsb3OUBPAJy6FgFX
         aCFMxshhUvyvHYW6naiBXQQ6k8gmWf/cJg/Ce+oSdkMWYIm9IPawU2/E2H564UQnyidg
         MXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2eSaP9cJhqPHyzDC8w3CbFx7JCZ6KKxOyraLwR9PhA=;
        b=P0Jg8NEp1lDfjXA5OVz7XrIh8FOaCzFEprmy6nGu/sssmq+jFF9tmEY0xoiO2kMR6t
         zSAqXgMjLCFH/rbrhI3/tw2YUcZCvoTTAvBiMSpRuQtJ9FcdBDyH8qulPUV31/6OhyrE
         JF/C1CRBbU24px1LKDwsVfTbCGVpb66iiQU5Ldus6akmY2Ehu4AmYAaquycXeA/T8/8c
         RLg5NqzFb3sRorXaIF9nX7CmVodL0Uy4iVxzKOli/i1ELYYn/MkUiE1FdhawI77eNLZe
         bsGbyzJCqKQxj0Ii8lZtut832xqRDYE5dlLJrKx6994AQn8b6b4tSiwuYJ0RFiWygcao
         PjvA==
X-Gm-Message-State: APjAAAUjv45Jiy1Gv4w85Ar9XTTfLK/ZZ5KWdDju6HvefKL4PNtGZ+aP
        SarRyIkjytbq4S0374OsNmxdOcmAhMxPX3xdrMe9bA==
X-Google-Smtp-Source: APXvYqwe49MzVy71zFCSDiZoF+VH7cE8Gtkn2FX6bQOskDctJh/Gw/DbDHrh82SW4A7nARSNeWI6ROO1GDn0hqM3dG4=
X-Received: by 2002:a05:6830:58:: with SMTP id d24mr4555139otp.356.1575402979934;
 Tue, 03 Dec 2019 11:56:19 -0800 (PST)
MIME-Version: 1.0
References: <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
 <20191128091210.GC15549@ming.t460p> <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com> <20191203124558.GA22805@ming.t460p>
In-Reply-To: <20191203124558.GA22805@ming.t460p>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Tue, 3 Dec 2019 14:56:08 -0500
Message-ID: <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
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

Thanks very much for the patch.

> BTW, you may try the attached test patch. If the issue can be fixed by
> this patch, that means it is really caused by un-aligned buffer, and
> the iser driver needs to be fixed.

I have tried the patch, and re-run the test. Results are mixed.

To recap, our test writes the last bytes of an iser attached iscsi
device. The target device is a LIO iblock, backed by a brd ramdisk.
The client does a simple `dd`, doing a seek to "size - offset" of the
device, and writing a buffer of "length" which is equivalent to the
offset.

For example, to test a write at a 512 offset, seek to device "size -
512", and write a length of data 512 bytes.

WITHOUT the patch, writing data at the following offsets from the end
of the device failed to write all the correct data (rather, the write
succeeded, but reading the data back it was invalid):

- failed: 512,1024, 2048, 4096, 8192

Anything larger worked fine.

WITH the patch applied, writing data up to an offset of 4096 all now
worked and verified correctly. However, offsets between 4096 and 8192
all still failed. I started at 512, and incremented by 512 all the way
up to 16384. The following offsets all failed to verify the write:

- failed: 4608, 5120, 5632, 6144, 6656, 7168, 7680, 8192

Anything larger continues to work fine with the patch.

As an example, for the failed 8192 case, the `bpftrace lio.bt` trace shows:

8192 76
4096 0
4096 0
8192 76
4096 0
4096 0
...
[snip]

What do you think are appropriate next steps? Do you think you have an
idea on why the specific "multi-page bvec helpers" commit could have
exposed this particular latent issue? Please let me know what else I
can try, or additional data I can provide for you.

Thanks,
Steve
