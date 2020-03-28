Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1681A1969F4
	for <lists+linux-block@lfdr.de>; Sun, 29 Mar 2020 00:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgC1XGn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 28 Mar 2020 19:06:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35680 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgC1XGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Mar 2020 19:06:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id e14so12023473qts.2
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2020 16:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xiiE4MtXJp9hkPcDnN/sQzesIxVhebufxtu0qtQrjA4=;
        b=bbi60nrZ4ywmQSEb4pSKe69S89HDAHQvuBKySngYK9t4M7i007YgJNkvH53HOCYFat
         X6wsWvNJs1i4rB4/VQjbOn2rpcm6EPAzLbTLEGrmD0jTWG3o2wbmru3Va7N+DMB8ELFY
         f1IS1DdW4Zj+KxRGk0dCELaJv86v8isO9ibjCnysgWVzrQp+R4Fs53fVYtFp98ygy4F3
         LTN4zgLRMW36GrmjpnOl6IFmk8Qxqims/9dxD0BxG3DikQC41JsLqpqHeFBFANbzZsID
         XlRILL8BXJLMdeJYPtm2iWfpQ/NcEPQD6/rkVCr9LFcBAUPhvfvRozWQQDHwLkOdAYmJ
         VxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xiiE4MtXJp9hkPcDnN/sQzesIxVhebufxtu0qtQrjA4=;
        b=J2qq9kpSDa+S0LQ2iXQFQBtxxTViBj1O9glVWk/QNXM8w+Kep6OUkIiPMuLKUWJX+C
         jDbO2SJQBjz5FMOa1SLVgDihAZceqgi/dr/b9jgIkDtNMtmy+nuiRRrG/mRw6IOAFufD
         Arm53UphE94mSA0+vyCUHaJiIYNIyM/H5Ovx7dK5OKvcclSnhxzQ/kBFpMiDsO2dDJ6i
         wbPaRH4QVEp/WDp7NcEkmlTeSZ8GHHCUym2LsZZqGUfUrqGXe2PEG1iAjaFmVe2kKFGY
         xPr5hmyBiUbW5YdLEDvIiIwZorsL+yuo6TycwRhmSnciiNwuGNXoIoI8JAXYAb/22HGH
         niXA==
X-Gm-Message-State: ANhLgQ1Dk3n0FYdebE5afHR4ocDTzOuVuBkghoopZ1cd0AyZPfCpOfeO
        BSV8B0KJufldjaNQ32lWQ8a3cQ==
X-Google-Smtp-Source: ADFU+vtRJdqd6DLnH7AJC62lsLqGNivqvD/MGWC65hyeHkAUJvj2tViyQIY6BNU7golEoiZHt5tahw==
X-Received: by 2002:ac8:3550:: with SMTP id z16mr5668621qtb.217.1585436801870;
        Sat, 28 Mar 2020 16:06:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h11sm6989944qta.44.2020.03.28.16.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 16:06:41 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIKXI-0000m5-Cw; Sat, 28 Mar 2020 20:06:40 -0300
Date:   Sat, 28 Mar 2020 20:06:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        leon@kernel.org, dledford@redhat.com, danil.kipnis@cloud.ionos.com,
        rpenyaev@suse.de, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v11 23/26] block/rnbd: server: sysfs interface functions
Message-ID: <20200328230640.GC20941@ziepe.ca>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-24-jinpu.wang@cloud.ionos.com>
 <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecc1c47-bad0-dadb-7861-8776b89f0174@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 12:31:08PM -0700, Bart Van Assche wrote:
> On 2020-03-20 05:16, Jack Wang wrote:
> > This is the sysfs interface to rnbd mapped devices on server side:
> > 
> >   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
> >     |- block_dev
> >     |  *** link pointing to the corresponding block device sysfs entry
> >     |
> >     |- sessions/<session-name>/
> >     |  *** sessions directory
> >        |
> >        |- read_only
> >        |  *** is devices mapped as read only
> >        |
> >        |- mapping_path
> >           *** relative device path provided by the client during mapping
> > 
> 
> > +static struct kobj_type ktype = {
> > +	.sysfs_ops	= &kobj_sysfs_ops,
> > +};
> 
> From Documentation/kobject.txt: "One important point cannot be
> overstated: every kobject must have a release() method." I think this is
> something that Greg KH feels very strongly about. Please fix this.

more importantly you can't implement kobjects correctly without a
release so there is some bug in here.

Jason
