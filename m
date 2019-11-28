Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2BB10C335
	for <lists+linux-block@lfdr.de>; Thu, 28 Nov 2019 05:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfK1E0L (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Nov 2019 23:26:11 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34081 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfK1E0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Nov 2019 23:26:10 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so6552081oig.1
        for <linux-block@vger.kernel.org>; Wed, 27 Nov 2019 20:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockbridge-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AtpT72nw5pPuQDPtRZBjsTDkGGXL+5+IagAJ1brhDm4=;
        b=e0LoD2z5dcAZbCKoU2RSjiP7EO812s6+9BAohSAnPLoq9z+C9KgcYaLKwCVPro+zon
         eILRMyRDEmkERlrLAAKbWXuq6q/ePzjblzv4BzEQpxqN0DctTpgxiQ+DHgh3kcaHgEWt
         4mJ0CTFTgLeKyyQsQY6WWROEFfjunCAp74goKtwzYDKSyHAh4woAg9h+MbAu2kPyQM3K
         VhieNJ4k0Y9XF6/OAOtXwqfBld16xWViu4WeCZpBD6as3VMBM74kZTJlpeATJ6C/yLUU
         4myBV6z0Cmeun6PAhKSTwNQnRKBpS/lf3YVQjxw6cNZTf+p9k9L1nMIIGQCQoFwDAWQz
         pABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtpT72nw5pPuQDPtRZBjsTDkGGXL+5+IagAJ1brhDm4=;
        b=m+PfIb4uX5i9oQ1XQvO/DNNrroW+O+44Yp5wVhpN5tQj3blmJxJTGccel+uWNe4GSX
         IB1lckn12Rf1hx8LdSBudSfxQr/98CP+m/H9GNC8kudxzAf7y7EZ8oePj4JVf4jTnCZf
         W7uQb20BGTp7iDRtZzQ49okTXJ1iBZr7+rNwgCrNeZJybv/hYNxisWzJOylAU/FP31/R
         qpmVdwxrLbIDZnQs9nGyOqSDzjDK+3SKCTbzEStUpP/FDdTmt9Ev4H6JN6pLCHR6hEse
         WTTmZutSkpuEECBSQnoy3XZVkmmormxxK7T3N9Sirue7ZhjvE+yNV4lSuqP2K/NXa3vS
         kvEg==
X-Gm-Message-State: APjAAAWU636RghObef1S+QtGDdfMQmDlCQjgfsXd/Jl3wLYRW7oapdJn
        OcFkbQ3jQHaLhbmgkLcxFXJhPpNM5RAsiuCY4/t47A==
X-Google-Smtp-Source: APXvYqwklSTJ2t47ibQqoQxLAVg5zQ0jXSZFYWf09/acfFK2Fq6MC4m5iZbJDAkNMwlIreks3q/Rm6szk5k/J0BulSY=
X-Received: by 2002:aca:fc06:: with SMTP id a6mr6698565oii.12.1574915168262;
 Wed, 27 Nov 2019 20:26:08 -0800 (PST)
MIME-Version: 1.0
References: <CAAFE1bd9wuuobpe4VK7Ty175j7mWT+kRmHCNhVD+6R8MWEAqmw@mail.gmail.com>
 <20191128015748.GA3277@ming.t460p> <CA+VdTb_-CGaPjKUQteKVFSGqDz-5o-tuRRkJYqt8B9iOQypiwQ@mail.gmail.com>
 <20191128025822.GC3277@ming.t460p> <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
In-Reply-To: <CAAFE1bfsXsKGyw7SU_z4NanT+wmtuJT=XejBYbHHMCDQwm73sw@mail.gmail.com>
From:   Stephen Rust <srust@blockbridge.com>
Date:   Wed, 27 Nov 2019 23:25:57 -0500
Message-ID: <CAAFE1bdGCx96tLKgSkNf7=MDZEZMnC==PJghpsRctvZpPLaX5w@mail.gmail.com>
Subject: Re: Data corruption in kernel 5.1+ with iSER attached ramdisk
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Rob Townley <rob.townley@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        target-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[Apologies for dup, re-sending without text formatting to lists]

Hi,

Thanks for your reply.

I agree it does seem surprising that the git bisect pointed to this
particular commit when tracking down this issue.

> Stephen, could you share us how you setup the ramdisk in your test?

The ramdisk we export in LIO is a standard "brd" module ramdisk (ie:
/dev/ram*). We configure it as a "block" backstore in LIO, not using
the built-in LIO ramdisk.

LIO configuration is as follows:

  o- backstores .......................................................... [...]
  | o- block .............................................. [Storage Objects: 1]
  | | o- Blockbridge-952f0334-2535-5fae-9581-6c6524165067
[/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2 (16.0MiB)
write-thru activated]
  | |   o- alua ............................................... [ALUA Groups: 1]
  | |     o- default_tg_pt_gp ................... [ALUA state: Active/optimized]
  | o- fileio ............................................. [Storage Objects: 0]
  | o- pscsi .............................................. [Storage Objects: 0]
  | o- ramdisk ............................................ [Storage Objects: 0]
  o- iscsi ........................................................ [Targets: 1]
  | o- iqn.2009-12.com.blockbridge:rda:1:952f0334-2535-5fae-9581-6c6524165067:rda
 [TPGs: 1]
  |   o- tpg1 ...................................... [no-gen-acls, auth per-acl]
  |     o- acls ...................................................... [ACLs: 1]
  |     | o- iqn.1994-05.com.redhat:115ecc56a5c .. [mutual auth, Mapped LUNs: 1]
  |     |   o- mapped_lun0  [lun0
block/Blockbridge-952f0334-2535-5fae-9581-6c6524165067 (rw)]
  |     o- luns ...................................................... [LUNs: 1]
  |     | o- lun0
[block/Blockbridge-952f0334-2535-5fae-9581-6c6524165067
(/dev/ram-bb.952f0334-2535-5fae-9581-6c6524165067.cm2)
(default_tg_pt_gp)]
  |     o- portals ................................................ [Portals: 1]
  |       o- 0.0.0.0:3260 ............................................... [iser]

> > > Could you explain a bit what is iSCSI attached with iSER / RDMA? Is the
> > > actual transport TCP over RDMA? What is related target driver involved?

iSER is the iSCSI extension for RDMA, and it is important to note that
we have _only_ reproduced this when the writes occur over RDMA, with
the target portal in LIO having enabled "iser". The iscsi client
(using iscsiadm) connects to the target directly over iSER. We use the
Mellanox ConnectX-5 Ethernet NICs (mlx5* module) for this purpose,
which utilizes RoCE (RDMA over Converged Ethernet) instead of TCP.

The identical ramdisk configuration using TCP/IP target in LIO has
_not_ reproduced this issue for us.

> > > /usr/share/bcc/tools/stackcount -K rd_execute_rw

I installed bcc and used the stackcount tool to trace rd_execute_rw,
but I suspect because we are not using the built-in LIO ramdisk this
did not catch anything. Are there other function traces we can provide
for you?

Thanks,
Steve
