Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02980148553
	for <lists+linux-block@lfdr.de>; Fri, 24 Jan 2020 13:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgAXMoH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jan 2020 07:44:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38767 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729609AbgAXMoH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 07:44:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so1465707oth.5
        for <linux-block@vger.kernel.org>; Fri, 24 Jan 2020 04:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EcauhiWAwaqH1U+TqXb6ywn1b4F/ZwJaD8W5VGiPmnQ=;
        b=IOag6tP3JotisDvbYzJOn5yT9Vong9OLJEJuV5eqD+CgZqaBq409BEMu/5PO1I7Uhn
         X9k0972Nekwd2vNnv47vU9IetbfHKGEdiHs/WQcRuZxlZOXtvjd0Aost/79hkGB7d6fD
         DqUoeQwymmLlfgRUO1FDjYdIPEwbX7TJ/0ggg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EcauhiWAwaqH1U+TqXb6ywn1b4F/ZwJaD8W5VGiPmnQ=;
        b=ewCZgGPesXmD2J6fnxlAaaQJAHtZ4Mnbz7nSmH2z1Ex346lwEZlT2SMSD+V2CAdiKq
         FCJt2q2u08DmrtkXE2qqM+aDb9sk5ehzJpGzE3rjVoG+Z2kpU6waX94eyoyrQI6ugt53
         /nKMSoE+V4xAHT/5F6lXjwDD/VugP5YSFQvVPN7dEMwZFNNNvm9HXOfBSE64RO9D5WWk
         nd73WTyLXgysGmGzcXA8yC0zXnSItxO9WIjlnHQjbB+Cqfa2wM2GeBFr60WMFn3OBVMn
         dUmsTR9JQ8ZZeguaCiuW/inbO+m0ZvJjYIokH17fG6ReLFg0KpEiXN49qjQalEW929t1
         wZXw==
X-Gm-Message-State: APjAAAXx3z80TeWwnNstUxxJCG+ZbC2NOiTcJlgRmY1KXjorfi43gNa6
        xuxbs2W0nRpRHDF+Qt8aeMNGnIUWQF2mr+dT75rPz7a9Le3txg==
X-Google-Smtp-Source: APXvYqyzw/mGJc5NEMRtJr6aKe5QMI52QpLsTEPhGQFDPwYJ/ySV0blQLhanABAdiL8KrP2xD9owJ7Ez4MzB/LDe3XE=
X-Received: by 2002:a9d:23b5:: with SMTP id t50mr2453840otb.122.1579869846907;
 Fri, 24 Jan 2020 04:44:06 -0800 (PST)
MIME-Version: 1.0
References: <20200119071432.18558-1-ming.lei@redhat.com> <20200119071432.18558-6-ming.lei@redhat.com>
 <yq1y2u1if7t.fsf@oracle.com> <20200123025429.GA5191@ming.t460p>
 <yq1sgk5ejix.fsf@oracle.com> <20200124015957.GA17387@ming.t460p>
In-Reply-To: <20200124015957.GA17387@ming.t460p>
From:   Sumit Saxena <sumit.saxena@broadcom.com>
Date:   Fri, 24 Jan 2020 18:13:40 +0530
Message-ID: <CAL2rwxrLVeAZmFPGvOOqDrea8Nh3p1Cb5BSd4r4noC_8AzRtHg@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: core: don't limit per-LUN queue depth for SSD
 when HBA needs
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 24, 2020 at 7:30 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hi Martin,
>
> On Thu, Jan 23, 2020 at 08:21:42PM -0500, Martin K. Petersen wrote:
> >
> > Ming,
> >
> > > However, it depends on if the target device returns the congestion to
> > > host. From my observation, looks there isn't such feedback from NVMe
> > > target.
> >
> > It happens all the time with SCSI devices. It is imperative that this
> > keeps working.
> >
> > > Even if there was such SSD target which provides such congestion
> > > feedback, bypassing .device_busy won't cause big effect too since
> > > blk-mq's SCHED_RESTART will retry this IO returning STS_RESOURCE only
> > > after another in-flight one is completed.
> >
> > The reason we back off is that it allows the device to recover by
> > temporarily reducing its workload. In addition, the lower queue depth
> > alleviates the risk of commands timing out leading to application I/O
> > failures.
>
> The timeout risk may only happen when driver/device doesn't return
> congestion feedback, meantime the host queue depth is big enough.
>
> So far we don't see such issue on NVMe which hw queue depth is 1023, and
> the hw queue count is often 32+, and not see such timeout report
> when there are so many inflight IOs(32 * 1023) on single LUN.
>
> Also megaraid sas's queue depth is much less than (32 * 1023), so it
> seems much unlikely to happen.
>
> Megaraid guys, could you clarify if it is one issue? Kashyap, Sumit
> and Shivasharan?

Hi Ming, Martin,

megaraid_sas driver does not enable =E2=80=9C.track_queue_depth=E2=80=9D, s=
o
megaraid_sas adapters never used QUEUE FULL interface of Linux SCSI
layer. Most of the handling of QUEUE FULL is managed by MegaRAID
controller Firmware and it also manages reducing drive level QD (like
ramp up/down).

"mpt3sas" adapters support QUEUE FULL based on IOCCapabilities of
Firmware.  Default configuration is Firmware will manage QUEUE FULL.
This is not same as Linux SCSI level handling. It is delayed retry in
Firmware. It means, we should not expect IO timeout in case of QUEUE
FULL from device since firmware can handle it as delayed retry. User
can disable Firmware handling QUEUE FULL condition (through customized
firmware) and allow QUEUE FULL return back to SCSI layer.  This
feature is called =E2=80=9CMPI2_IOCFACTS_CAPABILITY_TASK_SET_FULL_HANDLING=
=E2=80=9D.
So for mpt3sas driver, we may use QUEUE FULL handling of OS. We can
opt to enable =E2=80=9Cno_device_queue_for_ssd=E2=80=9D for mpt3sas driver =
only if FW
does not expose MPI2_IOCFACTS_CAPABILITY_TASK_SET_FULL_HANDLING.

Thanks,
Sumit

>
> >
> > > At least, Broadcom guys tests this patch on megaraid raid and the
> > > results shows that big improvement was got, that is why the flag is
> > > only set on megaraid host.
> >
> > I do not question that it improves performance. That's not my point.
> >
> > > In theory, .track_queue_depth may only improve sequential IO's
> > > performance for HDD., not very effective for SSD. Or just save a bit
> > > CPU cycles in case of SSD.
> >
> > This is not about performance. This is about how the system behaves whe=
n
> > a device is starved for resources or experiencing transient failures.
>
> Could you explain a bit how this patch changes the system beaviror? I
> understand the EH just retries the incompleted requests, which total
> number is just less than host queue depth.
>
>
> Thanks,
> Ming
>
