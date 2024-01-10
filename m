Return-Path: <linux-block+bounces-1627-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD7A826815
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 07:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F411F21CE0
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 06:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDB510FF;
	Mon,  8 Jan 2024 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="oXqpqOWB"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147938BF3
	for <linux-block@vger.kernel.org>; Mon,  8 Jan 2024 06:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d4df66529bso2264785ad.1
        for <linux-block@vger.kernel.org>; Sun, 07 Jan 2024 22:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704695990; x=1705300790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2z/LFrpUod4EQohAwYfd01URT3cRlVCm2VHTnvRW44=;
        b=oXqpqOWBkxWGibS2JUFozjD56u+bjsGpuFfhbYXjXgIy0gQKRUY6qtRqNydQFrfRwU
         MLRRejeUgl517irdzCjPLV2vajn65w5ZtJHhFN0slF9FnYjnJTIGENK8w0pR/uayW90w
         HC8EXRgjNgp8lQWt2WkyY/HJzRKE2A5htGjJ9uE7A4RKk0mZztcNuSFm60vuHXjDAt61
         SenCwf+ZQg/bpnTPoXsl0rwLXybcEgNIH/GIJUxvi06O3LXP3jp7gfEJyvca1wiKNv0h
         oOXjxBx3AWcjBdKJhLvn5s6i3Lj9vkhUL2njjRx632JCh48dPw6xfbHFYnyEgb45IGuI
         P5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704695990; x=1705300790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2z/LFrpUod4EQohAwYfd01URT3cRlVCm2VHTnvRW44=;
        b=Sx9eH8YCC9Qb44ElbwflFFemKdzqyllzsepUZVyy7tLEU8q59ZAJiagjumR6MDX+QC
         TzYs7ge6kEYCJhe5fOyVYj/EaH7DMd7Tl943m8sCO1AW58vLS0KJNAiN7m/A6pIVrYoH
         zdIJWhQp4+oDpXSbdpyp/MqPzd8x/ozaadCTyZ7hJUFtzjMkfxkFFH4DrBpQ+Ef3WGDk
         sjhZQGOtYCYYDuVHXHlhFJrogRTiSQYNEPm37iKYtTP5bq/ZpuFr9UbmNtXWEz4aIk+K
         6QMgK0Whucsyvfx9TJvYjp0tTZNgZ23f7GVOkSBvXx53Eo6KPlrpTq0zOitrpU+nZdgD
         /mSQ==
X-Gm-Message-State: AOJu0Yw4t0MGdcQRdo/Dcj2AaJAYI6fwB6MdFn2aPYCu0GEGJezgkRey
	5ppR9urVW3TotDGmpRC/A62a5V0X9ybcVw==
X-Google-Smtp-Source: AGHT+IEd5DltWMH/+FqCfCYBhgKXl9nxlvdK57zqowQUpnyKj7XaJTN1HbiuX5Fx9BCEtBJDAymiig==
X-Received: by 2002:a17:902:be13:b0:1d4:3d04:cdd with SMTP id r19-20020a170902be1300b001d43d040cddmr791720pls.32.1704695990264;
        Sun, 07 Jan 2024 22:39:50 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001d4e05828a9sm5421115plx.260.2024.01.07.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:39:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rMjIY-007WiN-2y;
	Mon, 08 Jan 2024 17:39:46 +1100
Date: Mon, 8 Jan 2024 17:39:46 +1100
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZuYspqO7bZUE3vG@dread.disaster.area>
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZcgXI46AinlcBDP@casper.infradead.org>

On Thu, Jan 04, 2024 at 09:17:16PM +0000, Matthew Wilcox wrote:
> This is primarily a _FILESYSTEM_ track topic.  All the work has already
> been done on the MM side; the FS people need to do their part.  It could
> be a joint session, but I'm not sure there's much for the MM people
> to say.
> 
> There are situations where we need to allocate memory, but cannot call
> into the filesystem to free memory.  Generally this is because we're
> holding a lock or we've started a transaction, and attempting to write
> out dirty folios to reclaim memory would result in a deadlock.
> 
> The old way to solve this problem is to specify GFP_NOFS when allocating
> memory.  This conveys little information about what is being protected
> against, and so it is hard to know when it might be safe to remove.
> It's also a reflex -- many filesystem authors use GFP_NOFS by default
> even when they could use GFP_KERNEL because there's no risk of deadlock.

There are many uses in XFS where GFP_NOFS has been used because
__GFP_NOLOCKDEP did not exist. A large number of the remaining
GFP_NOFS and KM_NOFS uses in XFS fall under this category.

As a first step, I have a patchset that gets rid of KM_NOFS and
replaces it with either GFP_NOFS or __GFP_NOLOCKDEP:

$ git grep "GFP_NOFS\|KM_NOFS" fs/xfs |wc -l
64
$ git checkout guilt/xfs-kmem-cleanup
Switched to branch 'guilt/xfs-kmem-cleanup'
$ git grep "GFP_NOFS\|KM_NOFS" fs/xfs |wc -l
21

Some of these are in newly merged code that I haven't updated the
patch set to handle yet, others are in kthread/kworker contexts that
don't inherit any allocation context information. There isn't any
big issues remaining to be fixed in XFS, though.

> The new way is to use the scoped APIs -- memalloc_nofs_save() and
> memalloc_nofs_restore().  These should be called when we start a
> transaction or take a lock that would cause a GFP_KERNEL allocation to
> deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
> can see the nofs situation is in effect and will not call back into
> the filesystem.

Note that this is the only way to use vmalloc() safely with GFP_NOFS
context...

> This results in better code within your filesystem as you don't need to
> pass around gfp flags as much, and can lead to better performance from
> the memory allocators as GFP_NOFS will not be used unnecessarily.
> 
> The memalloc_nofs APIs were introduced in May 2017, but we still have

For everyone else who doesn't know the history of this, the scoped
GFP_NOFS allocation code has been around for a lot longer than this
current API. PF_FSTRANS was added in early 2002 so we didn't have to
hack magic flags into current->journal_info to defermine if we were
in a transaction, and then this was added:

commit 957568938d4030414d71c583bc261fe3558d2c17
Author: Steve Lord <lord@sgi.com>
Date:   Thu Jan 31 11:17:26 2002 +0000

    Use PF_FSTRANS to detect being in a transaction

diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index 08a17984..282b724f 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -396,16 +396,11 @@ linvfs_release_buftarg(

 static kmem_cache_t * linvfs_inode_cachep;

-#define XFS_TRANS_MAGIC 0x5452414E
-
 static __inline__ unsigned int gfp_mask(void)
 {
         /* If we're not in a transaction, FS activity is ok */
-        if (!current->journal_info) return GFP_KERNEL;
-        /* could be set from some other filesystem */
-        if ((int)current->journal_info != XFS_TRANS_MAGIC)
-                return GFP_KERNEL;
-        return GFP_NOFS;
+        if (current->flags & PF_FSTRANS) return GFP_NOFS;
+       return GFP_KERNEL;
 }

> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
> really sad).  This session is for filesystem developers to talk about
> what they need to do to fix up their own filesystem, or share stories
> about how they made their filesystem better by adopting the new APIs.
> 
> My interest in this is that I'd like to get rid of the FGP_NOFS flag.

Isn't that flag redundant? i.e. we already have mapping_gfp_mask()
to indicate what gfp mask should be used with the mapping
operations, and at least the iomap code uses that.

Many filesystems call mapping_set_gfp_mask(GFP_NOFS) already, XFS is
the special one that does:

	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));

so it doesn't actually use GFP_NOFS there.

Given that we already have a generic way of telling mapping
operations the scoped allocation context they should run under,
perhaps we could turn this into scoped context calls somewhere in
the generic IO/mapping operation paths? e.g.
call_read_iter()/call_write_iter()

> It'd also be good to get rid of the __GFP_FS flag since there's always
> demand for more GFP flags.  I have a git branch with some work in this
> area, so there's a certain amount of conference-driven development going
> on here too.

Worry about that when everything is using scoped contexted. Then
nobody will be using GFP_NOFS or __GFP_FS externally, and the
allocator can then reclaim the flag.

> We could mutatis mutandi for GFP_NOIO, memalloc_noio_save/restore,
> __GFP_IO, etc, so maybe the block people are also interested.  I haven't
> looked into that in any detail though.  I guess we'll see what interest
> this topic gains.

That seems a whole lot simpler - just set the GFP_NOIO scope at
entry to the block layer and that should cover a large percentage of
the GFP_NOIO allocations...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

