Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EC53F7A9A
	for <lists+linux-block@lfdr.de>; Wed, 25 Aug 2021 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhHYQdH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Aug 2021 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbhHYQdH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 12:33:07 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409A2C061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:32:21 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id y144so28251320qkb.6
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3Uui9UOCw0Rxj5md1ZToAucZFiRj12lefabiBhlvxZ0=;
        b=lDmO14Qb90STa9Dfiwi7N1A7QJw8CynEG1VOFU0mcZDqrX1HoV69empswjAJqNER7X
         nxQWth/zv2KCS42VMQMXtrDRJkPvJxVn63dzh3j0ZxaECOPC2ru/bW7xh0I4XnY07HLz
         FC5aciuzUJuHWUMPJg797Av3/QDczlAOGIYslFOx907dV6jZ61twwt3RxupBGKu5HZ4h
         5fbVWHEEqQ2iHkrG5mrAYPI7+MnORIRPLMNzt5fEqzKSMzrXFOHuuwkCcx6JEFGX9FPd
         3twMCICxLlBoc547+fb0iqcs6eDj3S3Pjz8/B18N93MaVcri5HF8FtkSxqJOexXU/Ugj
         45/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Uui9UOCw0Rxj5md1ZToAucZFiRj12lefabiBhlvxZ0=;
        b=EqcLgBz/JJ80RNRcBTAXHgjnNEFYGbMaUTdGtCCW5pDVs5XhaMFzgbpgEXKb/Le+HB
         KWndjBfjqE3Uv9tLMSZi1u2HA4oL0/Cno2Ulepw6CqFEWzbuLcdqV2Vuh9AaQjwzZWFr
         C0zQdY7N1sQv5LTvme6nAT5Mo3Aex1qJhdmr+2rDrXy6Z6SvzoTYu2IToB2txjTJENrB
         rbotslk2VTSiddYJbKRTpM+sxqnpgEqcaIQYoPXPQLxlyZYm8yXGJSBh3GfCVtQoo3Gz
         CxnnIJj6If8MlCG1rq9klxtd9oFwHbGJGTnTNG4Lsq/QVHA9UybvFkKalJURWw2GuY7h
         gsUw==
X-Gm-Message-State: AOAM530n9wBuAH4bmanY/bR8GBs7QdJ842zInzPxVfbZKYupixHc0pYc
        02AOW2mePMoSZjxxYkY/5hgyGg==
X-Google-Smtp-Source: ABdhPJweMp/84QzOtbO5Oh79VuPkzY7QfOuSshGi3pHYB52uAxRxzrROMD6ot6amUhYJW7vvLy0bAw==
X-Received: by 2002:a37:6114:: with SMTP id v20mr33083127qkb.348.1629909140457;
        Wed, 25 Aug 2021 09:32:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j26sm367922qki.26.2021.08.25.09.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:32:20 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mIvp5-004zSz-Gw; Wed, 25 Aug 2021 13:32:19 -0300
Date:   Wed, 25 Aug 2021 13:32:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: v5.14 RXE driver broken?
Message-ID: <20210825163219.GY543798@ziepe.ca>
References: <c3d1a966-b9b0-d015-38ec-86270b5045fc@acm.org>
 <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENcriq-mwnvzY3UdowuGpKb=Uekvk-v8Lj0G=QB-qK0kJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 25, 2021 at 11:02:14AM +0800, Zhu Yanjun wrote:
> On Tue, Aug 24, 2021 at 11:02 AM Bart Van Assche <bvanassche@acm.org> wrote:
> >
> > Hi Bob,
> >
> > If I run the following test against Linus' master branch then that test
> > passes (commit d5ae8d7f85b7 ("Revert "media: dvb header files: move some
> > headers to staging"")):
> >
> > # export use_siw=1 && modprobe brd && (cd blktests && ./check -q srp/002)
> > srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
> >     runtime    ...  48.849s
> >
> > The following test fails:
> >
> > # export use_siw= && modprobe brd && (cd blktests && ./check -q srp/002)
> > srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [failed]
> >     runtime  48.849s  ...  15.024s
> >     +++ /home/bart/software/blktests/results/nodev/srp/002.out.bad      2021-08-23 19:51:05.182958728 -0700
> >     @@ -1,2 +1 @@
> >      Configured SRP target driver
> >     -Passed
> 
> Can this commit "RDMA/rxe: Zero out index member of struct rxe_queue"
> in the link https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc
> fix this problem?
> 
> And the commit will be merged into linux upstream very soon.

Please let me know Bart, if the rxe driver is still broken I will
definitely punt all the changes for RXE to the next cycle until it can
be fixed.

Jason
