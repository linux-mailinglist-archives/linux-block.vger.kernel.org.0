Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F4009198CBC
	for <lists+linux-block@lfdr.de>; Tue, 31 Mar 2020 09:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCaHL6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Mar 2020 03:11:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41113 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgCaHL6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 03:11:58 -0400
Received: by mail-io1-f67.google.com with SMTP id b12so4406190ion.8
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 00:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyIJAxsjyPfo63pYnLLVkVMuMntd+Bvgnj1mH36dLJ8=;
        b=Syt6I7b4VQq7iQoFWq653jEF4HP3jGalh2TTNhbJ/ZM3hQvoYzOhMvsJCcxKyPUFOd
         i78Qc2IksCvl763wS40XCJVPrNvCf9y+l5GOL0PQSvCq0xi6SzfrVB/+ZY4MMSuAGrLt
         rqaIdr6lq/H5lLSrpiXpY4bFrgnNrqC7HNiiyTPaBGvrfMGlBnDQECXJbcDs6jGKnR3E
         qtZCKd8YsCJVE8U0S7Htve7fGp/Bnqwj9ULbpiZbcwycYCky7e5zW4TmsiYsAk4vNzgc
         GmBvSPxsbVRANypgVgToecOb/dSwlrW87Gbh28EYqjG+1NGjqEn55l7sxeGOsdDnzDi9
         YNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyIJAxsjyPfo63pYnLLVkVMuMntd+Bvgnj1mH36dLJ8=;
        b=WWd8c3bz7TzK8F53MfSQHB7V+C+8ma5F7u1L4cedHzg/IQepRUw2+aLUQJtDSPQK9h
         vLeQpj1nWtPLeovYwhPG4ip3MyZsblZOcvtAIC6QANOIMXLlsFk1GLs2SuudEp0VeSW8
         42vGGW5rOYocK18pO6Ge3Fq1+NmbaOavK2dqp6UGzwn9YdyhQpl9ZeowIXkWINqTNRKa
         R2E4JzvW/wdFfi2r3nbx4d/eEDlhJ5exeTjgpjECjU43PjK07jolLuNTq+8J/Nj8pkuA
         picF1WXoN0t52HmRBUICKHLJfM9QKDAioo6ZcC3tYGIzbVSUsN8J/IosYEXAMIjuWwbo
         /WPg==
X-Gm-Message-State: ANhLgQ2SLm1aXnqaIx8UOXFVm8iZfTZ7PZvnVF90efforQRuHmxR0MLC
        jhlck/2vjwp1g3z3ZUu8SX9PCCcMYxLmablofWU0qA==
X-Google-Smtp-Source: ADFU+vtOl83nx67ab+nsIcYc5sPzd/+sz8Z+61pXzG3C64h7OIrqxepFtqNasJjQAzXhLSGn0T6lLVu5Hz2BMIRCCgc=
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr15018322jas.37.1585638717499;
 Tue, 31 Mar 2020 00:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-5-jinpu.wang@cloud.ionos.com> <cad654ae-d6c9-882d-aeeb-d6871994d280@acm.org>
 <CAMGffE=oU=auw9Re3JcpBx2cap=6i4P0R__bcO4NnN+yW76b8w@mail.gmail.com> <445d2545-de0e-3ca5-4a6a-97c00de6f117@acm.org>
In-Reply-To: <445d2545-de0e-3ca5-4a6a-97c00de6f117@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 09:11:46 +0200
Message-ID: <CAMGffEkfKz2-gAUN_X=ySzbnz7xvAWnms5y9kYyTExzLkRGCxQ@mail.gmail.com>
Subject: Re: [PATCH v11 04/26] RDMA/rtrs: core: lib functions shared between
 client and server modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 31, 2020 at 12:25 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-30 03:34, Jinpu Wang wrote:
> > On Sat, Mar 28, 2020 at 5:26 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 2020-03-20 05:16, Jack Wang wrote:
> >>> +/**
> >>> + * rtrs_addr_to_sockaddr() - convert path string "src,dst" to sockaddreses
> >>> + * @str:     string containing source and destination addr of a path
> >>> + *           separated by comma. I.e. "ip:1.1.1.1,ip:1.1.1.2". If str
> >>> + *           contains only one address it's considered to be destination.
> >>> + * @len:     string length
> >>> + * @port:    will be set to port.
> >>                 ^^^^^^^^^^^^^^^^^^^
> >> What does this mean? Please make comments easy to comprehend.
> > how about just "port number"?
>
> I don't think that's enough information. How about "destination port
> number"?
Sounds better, thank you!
