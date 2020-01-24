Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 695A2148EC4
	for <lists+linux-block@lfdr.de>; Fri, 24 Jan 2020 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390897AbgAXTlZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Jan 2020 14:41:25 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44462 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390186AbgAXTlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jan 2020 14:41:25 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so3390730wrm.11
        for <linux-block@vger.kernel.org>; Fri, 24 Jan 2020 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=KIoPgyD/uHdbw/hRYTLjyyF+abTVqKoC6UW0RlLuccs=;
        b=YSzUg3W1HrCe+bgYHDU9A0rFSo+FDvP0TNM2cdGv2aU850+fH2rOc0kr+f4tAwTuKK
         kXOpry1/o1XfYoJsz10jBzghAUIEvWJxoCwxppP+RhN0/YG3QoXP0eFOgNKr0qI5aUGL
         V+hNCqsvRf5qAriFUeJFu/DXbUMa/BSlhMmOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=KIoPgyD/uHdbw/hRYTLjyyF+abTVqKoC6UW0RlLuccs=;
        b=Ao4vduh2pxyVff1o5AtklwTRUwSvOWNGiNYkXmtaKxOPzoFDlb7VaNcp/zrPo3/wEb
         UgQiRtNPHof17lAZu0le0apDcaqTEcGv+an1u1IE2lxuYCPaPJpv3FQrw7Ra99X5EtfO
         RCUYg5AXCvRIrx7zSXFdSfxPeG/xdJe7pQxjtb+MlZjNNmdQ7nKLSXKybQIXKAh9A3cV
         jkuRdwyb3EsFx1PIyDy4DS4k8nyE0AuFGgVdH1lN3MukxsCU41JQbhrnuKUvb96+FhXY
         /BvHN1VRrOYclqy54KcsJ1aZ5r+C5E5PtN4ZmnugYufbCBohGulPoZIW0D1yRpkMO559
         3vuQ==
X-Gm-Message-State: APjAAAWbQsdYstZZA6e9vgCXEYiAfHNCaCrdHm3qBF7sU3zW+LmCmF8n
        cQ+6bwKPgYBrDpZlK3KmpqFT5eCFy1kLNdDyIvSoPw==
X-Google-Smtp-Source: APXvYqyhuBrPE/e3gFMMRLeHpcFhRXQfqhqgPcw7PaiCrm6PIHL+eijqzcE8xi4WLy1ltHKdOS5umamvzo+dv6cSptA=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr5922428wrp.236.1579894883745;
 Fri, 24 Jan 2020 11:41:23 -0800 (PST)
From:   Sumanesh Samanta <sumanesh.samanta@broadcom.com>
References: <20200119071432.18558-1-ming.lei@redhat.com>        <20200119071432.18558-6-ming.lei@redhat.com>
 <yq1y2u1if7t.fsf@oracle.com>   <ab676c4c-03fb-7eb9-6212-129eb83d0ee8@broadcom.com>
 <yq1iml1ehtl.fsf@oracle.com>
In-Reply-To: <yq1iml1ehtl.fsf@oracle.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMGKWhM81/SGNPryz/MgrKjfT/XowLUtWFaAjRd+LcBvgdOhwHnm/r4pVQPsFA=
Date:   Fri, 24 Jan 2020 12:41:20 -0700
Message-ID: <f4f06cf8459c21749335c6b7a4cfe729@mail.gmail.com>
Subject: RE: [PATCH 5/6] scsi: core: don't limit per-LUN queue depth for SSD
 when HBA needs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        Sumit Saxena <sumit.saxena@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

>> Please read what I proposed. megaraid VDs don't report QUEUE_FULL so
you would not trigger the device_busy counter.

Yes, megaraid does not use set track_queue_depth, and never reports
QUEUE_FULL . Instead of relying on QUEUE_FULL and some complex heuristics
of when to start tracking device_busy, why can't we simply use  "
track_queue_depth" ( along with the other flag that Ming added) to decide
which devices need queue depth tracking, and track device_busy only for
them?

>>Something like not maintaining device_busy until we actually get a
>>QUEUE_FULL condition. And then rely on the existing queue depth ramp up
>>heuristics to determine when to disable the busy counter again.

I am not sure how we can suddenly start tracking device_busy on the fly,
if we do not know how many IO are already pending for that device? Won't
device_busy have a high chance of getting negative ( or at least wrong
value) when pending IOs start getting completed?

Thanks,
Sumanesh


-----Original Message-----
From: Martin K. Petersen <martin.petersen@oracle.com>
Sent: Thursday, January 23, 2020 6:59 PM
To: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: linux-scsi@vger.kernel.org; Martin K. Petersen
<martin.petersen@oracle.com>
Subject: Re: [PATCH 5/6] scsi: core: don't limit per-LUN queue depth for
SSD when HBA needs


Sumanesh,

> The high-end controllers might expose a SCSI interface, but can have
> all kind of devices (NVMe/SCSI/SATA) behind it, and has its own
> capability to queue IO and feed to devices as needed. Those devices
> should not be penalized with the overhead of the device_busy counter,
> just because they chose to expose themselves has SCSI devices (for
> historical and backward compatibility reasons).

Please read what I proposed. megaraid VDs don't report QUEUE_FULL so you
would not trigger the device_busy counter.

-- 
Martin K. Petersen	Oracle Linux Engineering
