Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D4A1142E6
	for <lists+linux-block@lfdr.de>; Thu,  5 Dec 2019 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbfLEOoW (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Dec 2019 09:44:22 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39553 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbfLEOoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 09:44:22 -0500
Received: by mail-ot1-f41.google.com with SMTP id 77so2776074oty.6
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 06:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7s4JQTEdjPmFNYaI5B29BFTXVQs+UKOANRkCHolsJ14=;
        b=CuuoiKed4MEPD9+MqamEqAcFzgwxZsWo1rNXQ9lYrvqTdTUxiPXH9onz9z60JDj4V+
         8YRnpfO/Y1pCWtVlb/qbbcnZE0JDLqgONNLG3voHqdPbX8Nnl41ZM6Aq47rU2+0HKlN4
         JNXobe63xWFMHcW4e3sLN2LMqjAkMx//9WlADwmOWEXr2cvbEZQFQsCYxtKQ/OoKKxXo
         Mjkd/e1h33kSt8R8OLHm//0hyO/a1fiO4nV2t6r5Ug0dY7DS/6Z5tVL/5633HHVDNKjt
         BEl7U3afeGnk9NDWvlFcud+uNr3cth2Bo9dgBqsAq5dDYRP4eXO4gnAVvKfmS6eNgjGK
         8Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7s4JQTEdjPmFNYaI5B29BFTXVQs+UKOANRkCHolsJ14=;
        b=M1kdiSCEIrZhnx1+pv48dt5UdgHhs1q057f8ruB0cWbYESyD9eBrL1qbtgQLxyLgmq
         KfcMjJbbyKtyK/zJWbg5T6cGFNGnNg3hM2CSJfjzLu7xrntVViDgPri9tGK8dJRoBHGF
         n5e8MNyRaFBzQBJT4noctAQuOQWYCjrJE7QMNp2wlwJppqrVgrXIjYdpxuGu+MX+r/X1
         TOMXfeiTGv2QRXTUnKs2iL0410a4nvnQoVJi/g75q4jDxcJeSXKx64cb/41UCTDeVz7n
         IdpTe1xd7AEDyjhcICo/xagnUqK/A4xj4xIHerhqwZ1dsPBOzEiTLmfibypj9IzE1M/0
         VqqA==
X-Gm-Message-State: APjAAAU3LH+sNu4tGcJvLO4dFj10Z6GW4Ro5NkiozzJeAdVYPBMhYWaG
        Jzvn1lttDzzTn7lWI/Ke6rzsttJuddj8NfqJyB2+/eHGuCnVrw==
X-Google-Smtp-Source: APXvYqxexfBfOd8xUtRQNR5HIQ6mQugnieMgIjTub1FS+7nvU8GGRglLUM4azifsJW1OZMvCMRt2xHV4PhCOe1O+yOc=
X-Received: by 2002:a05:6830:1248:: with SMTP id s8mr6774044otp.202.1575557060619;
 Thu, 05 Dec 2019 06:44:20 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1beMkvyRctGqpffd3o_QtDH0CrmQSb=fV4GzqMUXWzPyOw@mail.gmail.com>
 <20191203005849.GB25002@ming.t460p> <CAAFE1bcG8c1Q3iwh-LUjruBMAuFTJ4qWxNGsnhfKvGWHNLAeEQ@mail.gmail.com>
 <20191203031444.GB6245@ming.t460p> <CAAFE1besnb=HV4C_buORYpWbkXecmtybwX8d_Ka2NsKmiym53w@mail.gmail.com>
 <CAAFE1bfpUWCZrtR8v3S++0-+gi8DJ79X3e0XqDe93i8nuGTnNg@mail.gmail.com>
 <20191203124558.GA22805@ming.t460p> <CAAFE1bfB2Km+e=T0ahwq0r9BQrBMnSguQQ+y=yzYi3tursS+TQ@mail.gmail.com>
 <20191204010529.GA3910@ming.t460p> <CAAFE1bcJmRP5OSu=5asNTpvkF=kjEZu=GafaS9h52776tVgpPA@mail.gmail.com>
 <20191204230225.GA26189@ming.t460p> <683a4567-6b34-ac3b-93ff-74d788ac4242@acm.org>
In-Reply-To: <683a4567-6b34-ac3b-93ff-74d788ac4242@acm.org>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Thu, 5 Dec 2019 09:44:09 -0500
Message-ID: <CAAFE1beNvij=QpqrmNgkm32QtRoXwGtR81YbS0ute5XBMN7d=w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 4, 2019 at 7:16 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> Do you need the iSER protocol? I think that the NVMeOF and SRP drivers
> also support RoCE and that these align data buffers on a 512 byte boundary.

Hi Bart,

In this case we do. But thank you for the other references. Those
might be options for us for other use cases.

Thanks,
Steve
