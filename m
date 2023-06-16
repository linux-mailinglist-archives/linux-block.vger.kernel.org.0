Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82A87323AF
	for <lists+linux-block@lfdr.de>; Fri, 16 Jun 2023 01:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjFOXb4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Jun 2023 19:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjFOXb4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 19:31:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BCBB3
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 16:31:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f649db9b25so15202e87.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 16:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20221208.gappssmtp.com; s=20221208; t=1686871913; x=1689463913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYCrQY+vD5Zhy3XYtfstQ901gmXcf6Fa7FD0xvyG1mA=;
        b=WkXEayk061Kdw3iPzXlRwePQmWd2w33QCzircznXEC0Xx0IC+D9GzBjbBVkK4jKq2q
         nfdE6tqVk/Gikz2CP+Thg4Q1DCawjcIr2SSaIclxQg+u0CPecJ/NTczT8BeRY3Dk/dET
         d+oQ293TtRZuAOMXp7I2K/t+PBKNmWMkHPNwSfQxviqsRH1vq9CtH5sao+riq5IN72c2
         /hxRKvTivMHKM90GmVp55bdLn7HnYcurm+je0mswz7Q26LMaedh8OnB1pKXpvjiFzHFA
         VYCVsmKzS3cipmmpHO02zO/oLBb3sQX5JWLKG0tEN13r+/hXo5JhvCj1IVf2tFlbKxq7
         POfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686871913; x=1689463913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYCrQY+vD5Zhy3XYtfstQ901gmXcf6Fa7FD0xvyG1mA=;
        b=CVZFcGaEmEkivlCUGGNZ1Xiym70fBzsnfLFRkw2xXEuZbK30739Pv4lPutU215326n
         eYsIBHJ53FT8I40zJWsWVcFMVHbqVfE0OK28AW4/7uHlVAwgeQwN2v9BjAAtVW2obEox
         dh4gZTE0CZIXLR+CJvtgQsjJ7gJXhuPZLwT3QOb8r/Dut8gjRZb91bSFJ4aj9IM4JFxx
         EAlLOd4KniqiVg+aIrnUV4Z22Iwr82MVZN51RJHz3udFLNwJZ24ECBdCNvqlWaJdwShk
         Oc1zi+ah6FbI027wmSaHtwO8HMFsOy8cwDazV7Q+lN9yALiOd5ZQCWE48shD7MXQjjt/
         gvYw==
X-Gm-Message-State: AC+VfDxNKHrY4v+yiLRJwcY7sDgei8or34CrPKLVO8Anowz+MHiRILxN
        IM+S7iBUuak49z1OiBlqDNTkNQ==
X-Google-Smtp-Source: ACHHUZ67+RO4aZ/zllxkh6V7HrysWfqRH2iujxqDDBvPqKh9/DHLw/Kh5WD70xMyopEPLhoc1BpBfg==
X-Received: by 2002:a19:8c44:0:b0:4f6:2c03:36b0 with SMTP id i4-20020a198c44000000b004f62c0336b0mr104795lfj.26.1686871912504;
        Thu, 15 Jun 2023 16:31:52 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003f736735424sm435340wmk.43.2023.06.15.16.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 16:31:51 -0700 (PDT)
Date:   Fri, 16 Jun 2023 00:31:50 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     pawan.kumar.gupta@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, jordyzomer@google.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cdrom: Fix spectre-v1 gadget
Message-ID: <ZIufZn+reW0rza1H@equinox>
References: <20230612110040.849318-1-jordyzomer@google.com>
 <20230612110040.849318-2-jordyzomer@google.com>
 <20230615163125.td3aodpfwth5n4mc@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615163125.td3aodpfwth5n4mc@desk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 09:31:25AM -0700, Pawan Gupta wrote:
> On Mon, Jun 12, 2023 at 11:00:40AM +0000, Jordy Zomer wrote:
> > This patch fixes a spectre-v1 gadget in cdrom.
> > The gadget could be triggered by,
> >  speculatviely bypassing the cdi->capacity check.
> > 
> > Signed-off-by: Jordy Zomer <jordyzomer@google.com>
> > ---
> >  drivers/cdrom/cdrom.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 416f723a2dbb..ecf2b458c108 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -264,6 +264,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/kernel.h>
> >  #include <linux/mm.h>
> > +#include <linux/nospec.h>
> >  #include <linux/slab.h> 
> >  #include <linux/cdrom.h>
> >  #include <linux/sysctl.h>
> > @@ -2329,6 +2330,9 @@ static int cdrom_ioctl_media_changed(struct cdrom_device_info *cdi,
> >  	if (arg >= cdi->capacity)
> >  		return -EINVAL;
> >  
> > +	/* Prevent arg from speculatively bypassing the length check */
> > +	barrier_nospec();
> 
> On a quick look it at the call chain ...
> 
> sr_block_ioctl(..., arg)
>   cdrom_ioctl(..., arg)
>     cdrom_ioctl_media_changed(..., arg)
> 
> .... it appears maximum value cdi->capacity can be only 1:
> 
> sr_probe()
> {
> ...
> 	cd->cdi.capacity = 1;
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/sr.c?h=v6.4-rc6#n665
> 
> If we know that max possible value than, instead of big hammer
> barrier_nospec(), its possible to use lightweight array_index_nospec()
> as below:
> ...

Hi Pawan and Jordy,

I've now looked at this. It is possible for cdi->capacity to be > 1, as
it is set via get_capabilities() -> cdrom_number_of_slots(), if the
device is an individual or cartridge changer.

Therefore, I think using CDI_MAX_CAPACITY of 1 is not the correct
approach. Jordy's V2 patch is fine therefore, but perhaps using
array_index_nospec() with cdi->capacity is still better than a
do/while loop from a performance perspective, given it would be cached
etc. at that point, so possibly quicker. Thoughts? (I'm no expert on
spectre-v1 I'll admit).

Regards,
Phil
