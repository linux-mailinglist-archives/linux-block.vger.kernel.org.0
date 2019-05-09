Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFC18D98
	for <lists+linux-block@lfdr.de>; Thu,  9 May 2019 18:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfEIQCm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 May 2019 12:02:42 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51633 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfEIQCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 12:02:41 -0400
Received: by mail-wm1-f42.google.com with SMTP id o189so3965131wmb.1
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 09:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72iJSKNrn4/WIKyCqbso2R/2Vr5AvP5U4vGBJoqRk+w=;
        b=n5q8T95OaaLXCOVhWGWqhGfmVLLLeKC4afECgp25K3FFZvjTCaoGzWel8a/XnBv3uq
         vbzMl5MyFPnokOXqx7szXcsHto+HE93iCusoC9OJdgyj0dKYB9gT1t1PsDESph2NrPlq
         AWGuX0toiKr2URYs0kqrZt65owS0jMLbJDaYAdzAb2hNbFyAEb8ljWHGOwa6bvDXtU5j
         kNlTY+7usEaB0RSkP7i6MIfp+0bk9CH0MrGmib6sicJCoQl9dUZQqKUGbiBxPJ2U146f
         pH5AqUDUgI8d2DyQ0Xbc2ognPUCYux8HFy/wL+IG0jlb1aomK/f6hkDIvNSmTj03Zry0
         IG5Q==
X-Gm-Message-State: APjAAAU1ww5ZoZhvLXWp96O8kfv/Ko97FFqwS0V+HBlhlm357GfLOchQ
        Gxe5XX1QjtZi7a6112gfeZmgkmppp3CnTsAIb/6MzA==
X-Google-Smtp-Source: APXvYqyaEh7Ga7EQkvx77mM/fbenf6LgszJXyXYXhp+s4skZ0uo2W3V8i+YpINHX7wxcXaWFNpJNNWikmH+XCQEySV4=
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr3442107wme.113.1557417759358;
 Thu, 09 May 2019 09:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <4a484c50-ef29-2db9-d581-557c2ea8f494@gmail.com>
 <20190507220449.GP1454@dread.disaster.area> <a409b3d1-960b-84a4-1b8d-1822c305ea18@gmail.com>
 <20190508011407.GQ1454@dread.disaster.area> <13b63de0-18bc-eb24-63b4-3c69c6a007b3@gmail.com>
 <yq1a7fwlvzb.fsf@oracle.com> <0a16285c-545a-e94a-c733-bcc3d4556557@gmail.com>
 <yq15zqkluyl.fsf@oracle.com> <99144ff8-4f2c-487d-a366-6294f87beb58@gmail.com>
In-Reply-To: <99144ff8-4f2c-487d-a366-6294f87beb58@gmail.com>
From:   Bryan Gurney <bgurney@redhat.com>
Date:   Thu, 9 May 2019 12:02:28 -0400
Message-ID: <CAHhmqcS19DUptiUeQ7q3pPCiZ6QcAXYxQwaX5nQ1FM38trzWtQ@mail.gmail.com>
Subject: Re: Testing devices for discard support properly
To:     Ric Wheeler <ricwheeler@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?B?THVrw6HFoSBDemVybmVy?= <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 8, 2019 at 2:12 PM Ric Wheeler <ricwheeler@gmail.com> wrote:
>
> (stripped out the html junk, resending)
>
> On 5/8/19 1:25 PM, Martin K. Petersen wrote:
> >>> WRITE SAME also has an ANCHOR flag which provides a use case we
> >>> currently don't have fallocate plumbing for: Allocating blocks without
> >>> caring about their contents. I.e. the blocks described by the I/O are
> >>> locked down to prevent ENOSPC for future writes.
> >> Thanks for that detail! Sounds like ANCHOR in this case exposes
> >> whatever data is there (similar I suppose to normal block device
> >> behavior without discard for unused space)? Seems like it would be
> >> useful for virtually provisioned devices (enterprise arrays or
> >> something like dm-thin targets) more than normal SSD's?
> > It is typically used to pin down important areas to ensure one doesn't
> > get ENOSPC when writing journal or metadata. However, these are
> > typically the areas that we deliberately zero to ensure predictable
> > results. So I think the only case where anchoring makes much sense is on
> > devices that do zero detection and thus wouldn't actually provision N
> > blocks full of zeroes.
>
> This behavior at the block layer might also be interesting for something
> like the VDO device (compression/dedup make it near impossible to
> predict how much space is really there since it is content specific).
> Might be useful as a way to hint to VDO about how to give users a
> promise of "at least this much" space? If the content is good for
> compression or dedup, you would get more, but never see less.
>

In the case of VDO, writing zeroed blocks will not consume space, due
to the zero block elimination in VDO.  However, that also means that
it won't "reserve" space, either.  The WRITE SAME command with the
ANCHOR flag is SCSI, so it won't apply to a bio-based device.

Space savings also results in a write of N blocks having a fair chance
of the end result ultimately using "less than N" blocks, depending on
how much space savings can be achieved.  Likewise, a discard of N
blocks has a chance of reclaiming "less than N" blocks.


Thanks,

Bryan
