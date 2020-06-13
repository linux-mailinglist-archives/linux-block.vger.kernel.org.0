Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB71F8011
	for <lists+linux-block@lfdr.de>; Sat, 13 Jun 2020 02:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFMA5l (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 12 Jun 2020 20:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFMA5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Jun 2020 20:57:40 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F9BC03E96F
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2020 17:57:40 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s13so8788609otd.7
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2020 17:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/tbNsb4h1oo1Kvv3ZTF7UVzr13bdpQmryrhin+IMGzI=;
        b=TPkP+7e1lugY3PZx/7kKuvhwk6F71O8rFA4NxbxH7NQFZwDZs0SgeL1huI0MEgJ7KT
         wBVfFYQRDxPLmG95zgta3BV8ww4jp+Lz98FBy47raaudk4pURtTTaCnSxLnfRSaL8IaC
         +/PBo0ql+OaSivv66wQTtpcMz4CWK3tghBzn4FGADQY2CBdi5MZ7znYfBBTayJOBKaGA
         q3QVP7YsR0TFhe901yv4EvFl00fu/TSX7AoE0PaoR3+PVs7iweLsQjHgV+frJWsd87jR
         fwizQLUT7UkrDvruvXN/5uVeHEHGm2r8EHlt9He27D3xyLXjgPPsys7rIW3D3RdCBLAw
         CsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/tbNsb4h1oo1Kvv3ZTF7UVzr13bdpQmryrhin+IMGzI=;
        b=LSxtJYTz1I0TUJcRvcIT4s1TCestMeTkGckiQ+u8KdL9lK7lu15uPvcPSvBw1Qsw+D
         +MhdQ4xoKCrIFWyQPSFIFItgxkUfJk2BdQOKUULN3762Urg51mQaUYGeL99Sriw2J80H
         REv9vgOa4R57RXpGfpBKNeHptCLlIdrCaYAliwwo5YQXKiuGCo+TFe/cHzBlNByl7DUz
         JztWekYJbif/ycoBFAQ1jqCdCFGbn7/Uup6BboYdG4VOfhTKq/pY5zbSWEfpE+JKXAgP
         crKyU1TYL4scAFFcjFq4uaBFg7FDnQAa+D1AE7/vgmeuKal4tvh2rgzu6aGiics9D2ii
         vWfA==
X-Gm-Message-State: AOAM533ZQeu66oPCYJOKmqR50/iEz+RcXXyUGROLDlMmFCQRXEbNyJkE
        A6uFzx3WgYCIpbGakbOMtBGxLsId7/XpZoiuncA=
X-Google-Smtp-Source: ABdhPJw5+nU4WLez3uT/1eV26X9CrFn1KWpdRGkeuyIy8uIdomPyqc0+JpXkIUhOly74QSbaMaWo6puN0h98NAyejvE=
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr13369554otr.171.1592009860116;
 Fri, 12 Jun 2020 17:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
 <8c37b659-30bd-8308-8697-27868b2a4ac0@acm.org> <BYAPR04MB4965B7894160F6EE0861D2A6869E0@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965B7894160F6EE0861D2A6869E0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 12 Jun 2020 17:57:29 -0700
Message-ID: <CAD+ocbxsxMCCvW6=ckNtaFoJaGv8CZbbYX7_szhaWESUBs3oTA@mail.gmail.com>
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        shakeelb@google.com
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the feedback Chaitanya and Bart.

In an offline sync-up with Shakeel and Bart, Shakeel mentioned that
probably doing the GFP_ACCOUNT is the right approach as long as the
trace buffer allocation lifetime can be tied with the process
lifetime. Given that, we can drop this patch for now. Whenever I get
time, I'll try to submit a new patch with that handled.

On Fri, Jun 12, 2020 at 5:09 PM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> > Is this the wrong structure to add a limit like blktrace_max_alloc? As
> > far as I can see struct queue_limits is only used for limits that are
> > affected by stacking block devices. My understanding is that the
> > blktrace_max_alloc limit is not affected by device stacking. See also
> > blk_stack_limits().
>
> I can also see that, how about adding a parameter in
> struct request_queue under CONFIG_BLK_DEV_IO_TRACE if we are going that
> route ?
>
