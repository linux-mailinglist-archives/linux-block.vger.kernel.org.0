Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036956F620F
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 01:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjECX0d (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 May 2023 19:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjECX0c (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2023 19:26:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614356E95
        for <linux-block@vger.kernel.org>; Wed,  3 May 2023 16:26:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6433c243287so895850b3a.3
        for <linux-block@vger.kernel.org>; Wed, 03 May 2023 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683156382; x=1685748382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hLF/XohEcFNqvnvCqaB5Hm1eLX3Ize1KonQ+CQXKJVw=;
        b=v9zPd7ZSzrmH/Z4pdXJn4iiTbRR4V72z8ItrQELaVnaXm47NYtVdQ46I7/Qk5prqEc
         SvmsN6cg+UQ4XtgAwtt+OiO7S91zyGgFjC/aDEM9LHSH4Q5dQ4Ty4kRvbsb+itqGhm4g
         1sCraGR1Ddlhtj0eX3OGftB0gMwadfkndLGTxbdhHzCpG6hw8CoiGKrZDqUnixDniOqf
         z8qUvRiqVU17m8TdkaQsjz8bL5sPpOO3h7xY5NmMWB+aQueIRrI73TJwdgDpDP0RvRuq
         iwdFlRlW0SegH/SfaNLK/EevvpWaahLVTD7fI90l1hFc7N0r0kfqEOAjRAktTc+MxF2Z
         L3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683156382; x=1685748382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLF/XohEcFNqvnvCqaB5Hm1eLX3Ize1KonQ+CQXKJVw=;
        b=hR8fdI9o2AqzFsdUwjq/GfVr44I8tzHqUD3DsMYryW+cTbooIXZtp3t1gkc4PpL376
         sD0O/gyTJPG89LO4tH3MiUI/yQZkNLKxk7AnEg6e64dsMzhWY4AtjqtjNDHYjvkbmMlU
         7oW/u22YOVY59hLXUe7Cuzm4fvhzcYFd7UMCxMKMVKiRyrPAZWLRZb09dIMszbYTxY09
         ldyTdtXHAsXd2SkEY1bnPLWrQwl21rx4uxZvtdZQ9F+VLY3FH2UZTmxwpLlI9tiw8bsD
         ZNUq1W4Ohkvoy7KPFzjq2UkQtF5GCspocnVNUuHEgkuppvbW08JP4zsJMoG2u/9SBdP8
         5suQ==
X-Gm-Message-State: AC+VfDzk6fH1B6KWObfPbQHowNDnJ7KvgibDrIPz5uTdcOEfpLwdXlEg
        /l6qIXhWMXmrXJji8XnWo1ybFQ==
X-Google-Smtp-Source: ACHHUZ5diKOfcpQ90loaTCwsAsNfI6e6FAnNwsQgCdTnnAlLLXDPm/yrGxfBJffrbIMoxrXjvtw2Gg==
X-Received: by 2002:a05:6a20:938a:b0:f2:1a72:2a8d with SMTP id x10-20020a056a20938a00b000f21a722a8dmr362232pzh.14.1683156381837;
        Wed, 03 May 2023 16:26:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id lx11-20020a17090b4b0b00b00246cc751c6bsm1886965pjb.46.2023.05.03.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 16:26:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1puLrU-00B2Ad-T8; Thu, 04 May 2023 09:26:16 +1000
Date:   Thu, 4 May 2023 09:26:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Allison Henderson <allison.henderson@oracle.com>,
        Catherine Hoang <catherine.hoang@oracle.com>
Subject: Re: [PATCH RFC 12/16] xfs: Add support for fallocate2
Message-ID: <20230503232616.GG3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-13-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503183821.1473305-13-john.g.garry@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 03, 2023 at 06:38:17PM +0000, John Garry wrote:
> From: Allison Henderson <allison.henderson@oracle.com>
> 
> Add support for fallocate2 ioctl, which is xfs' own version of fallocate.
> Struct xfs_fallocate2 is passed in the ioctl, and xfs_fallocate2.alignment
> allows the user to specify required extent alignment. This is key for
> atomic write support, as we expect extents to be aligned on
> atomic_write_unit_max boundaries.

This approach of adding filesystem specific ioctls for minor behavioural
modifiers to existing syscalls is not a sustainable development
model.

If we want fallocate() operations to apply filesystem atomic write
constraints to operations, then add a new modifier flag to
fallocate(), say FALLOC_FL_ATOMIC. The filesystem can then
look up it's atomic write alignment constraints and apply them to
the operation being performed appropriately.

> The alignment flag is not sticky, so further extent mutation will not
> obey this original alignment request.

IOWs, you want the specific allocation to behave exactly as if an
extent size hint of the given alignment had been set on that inode.
Which could be done with:

	ioctl(FS_IOC_FSGETXATTR, &fsx)
	old_extsize = fsx.fsx_extsize;
	fsx.fsx_extsize = atomic_align_size;
	ioctl(FS_IOC_FSSETXATTR, &fsx)
	fallocate(....)
	fsx.fsx_extsize = old_extsize;
	ioctl(FS_IOC_FSSETXATTR, &fsx)

Yeah, messy, but if an application is going to use atomic writes,
then setting an extent size hint of the atomic write granularity the
application will use at file create time makes a whole lot of sense.
This will largely guarantee that any allocation will be aligned to
atomic IO constraints even when non atomic IO operations are
performed on that inode. Hence when the application needs to do an
atomic IO, it's not going to fail because previous allocation was
not correctly aligned.

All that we'd then need to do for atomic IO is ensure that we fail
the allocation early if we can't allocate fully sized and aligned
extents rather than falling back to unaligned extents when there are
no large enough contiguous free spaces for aligned extents to be
allocated. i.e. when RWF_ATOMIC or FALLOC_FL_ATOMIC are set by the
application...

> In addition, extent lengths should
> always be a multiple of atomic_write_unit_max,

Yup, that's what extent size hint based allocation does - it rounds
both down and up to hint alignment...

....

> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 34de6e6898c4..52a6e2b61228 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -3275,7 +3275,9 @@ xfs_bmap_compute_alignments(
>  	struct xfs_alloc_arg	*args)
>  {
>  	struct xfs_mount	*mp = args->mp;
> -	xfs_extlen_t		align = 0; /* minimum allocation alignment */
> +
> +	/* minimum allocation alignment */
> +	xfs_extlen_t		align = args->alignment;
>  	int			stripe_align = 0;


This doesn't do what you think it should. For one, it will get
overwritten by extent size hints that are set, hence the user will
not get the alignment they expected in that case.

Secondly, args->alignment is an internal alignment control for
stripe alignment used later in the allocator when doing file
extenstion allocations.  Overloading it to pass a user alignment
here means that initial data allocations will have alignments set
without actually having set up the allocator parameters for aligned
allocation correctly.

This will lead to unexpected allocation failure as the filesystem
fills as the reservations needed for allocation to succeed won't
match what is actually required for allocation to succeed. It will
also cause problematic behaviour for fallback allocation algorithms
that expect only to be called with args->alignment = 1...

>  	/* stripe alignment for allocation is determined by mount parameters */
> @@ -3652,6 +3654,7 @@ xfs_bmap_btalloc(
>  		.datatype	= ap->datatype,
>  		.alignment	= 1,
>  		.minalignslop	= 0,
> +		.alignment	= ap->align,
>  	};
>  	xfs_fileoff_t		orig_offset;
>  	xfs_extlen_t		orig_length;

> @@ -4279,12 +4282,14 @@ xfs_bmapi_write(
>  	uint32_t		flags,		/* XFS_BMAPI_... */
>  	xfs_extlen_t		total,		/* total blocks needed */
>  	struct xfs_bmbt_irec	*mval,		/* output: map values */
> -	int			*nmap)		/* i/o: mval size/count */
> +	int			*nmap,
> +	xfs_extlen_t		align)		/* i/o: mval size/count */


As per above - IMO this is not the right way to specify aligment for
atomic IO. A XFS_BMAPI_ATOMIC flag is probably the right thing to
add from the caller - this also communicates the specific allocation
failure behaviour required, too.

Then xfs_bmap_compute_alignments() can pull the alignment
from the relevant buftarg similar to how it already pulls preset
alignments for extent size hints and/or realtime devices. And then
the allocator can attempt exact aligned allocation for maxlen, then
if that fails an exact aligned allocation for minlen, and if both of
those fail then we return ENOSPC without attempting any unaligned
allocations...

This also gets rid of the need to pass another parameter to
xfs_bmapi_write(), and it's trivial to plumb into the XFS iomap and
fallocate code paths....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
