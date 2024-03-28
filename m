Return-Path: <linux-block+bounces-4191-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCC8741A1
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 22:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC3A282DAD
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 21:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42618B1B;
	Wed,  6 Mar 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FAMISjV3"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0C18EAB
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709759259; cv=none; b=SdBd5C4tilRYO/hYBNuscurJb1ehMRbflMb5N+BxfEax5YbiXVorGqGWXI1LXylg1Dl3KlHf4ObWois4Qwa48+Glkju38vnrdi8CrXjny1AtowylBoakSg8eUjZP952dz3hFWWMVe6yQZls2i6XeQ6B6khOPmHOb06feFuL+JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709759259; c=relaxed/simple;
	bh=tOibHT3KCAP4BwPHg+4cB3sRbEspBT3plGcLvPC1OBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHgpWxdMLUKPlgREc21TOtJlS3g46MHh1LDYNPch1+t1s/EC9jJio4Kbt68SqTYvrBZIESykMNFF6UQjy6GuUF1RCAqWfen7yrDiKkSguUhDpvxCtDvhdC6KY7OIU+KWEOMbEFFNNFnEbSvbSB5LZJ343v4fgDMlc5pjy6kTN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FAMISjV3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dc1ff58fe4so1453795ad.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 13:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709759257; x=1710364057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6cKpNpXZLRmjwKPyX505WV6iTHUPCFCbzUC5MpFQ4rY=;
        b=FAMISjV3bcjanAguuoPgbKa/0d+P3FPoWbuNEfK15Ta5xCbx5pffQAqBIG5i+NEXUY
         gOW5sk7Io3F+Rba7bZetTl2DoxWAUTXXZ4DcjLaA9EVWra6Ufpz7vuGmAO18Du8xYO6R
         94/YGEM7PlAVdmNRcM2N+57AqrzEiOfvRumai8LNrWuwZe0LMrNlcRRyEJmNbmHeqUey
         GSbO0gVufNKoQpTx3RPYrsntl6dd4DeJGesI+VRy+DgBQsV3jqthZMZiFsgzSh0s0xHw
         Aac2hQrOvIOJHh7Qh5g4841L6yEWuJatdOwrToMZxP3qUevkYSwga8D530AHJBOw5xGh
         Kesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709759257; x=1710364057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cKpNpXZLRmjwKPyX505WV6iTHUPCFCbzUC5MpFQ4rY=;
        b=TxMvAI+JbeuLyyLWDFfPRVPzekiVs3BDnWhD1p/iugBJHVTYbFrz8LNL1I0x7SVAHf
         L+0pw7fFhERCQW69I/dRu9wq8FS9pvtioZ7derAZUmbeHlxMCgj68QcoSVbCP9gvjTdD
         rgUjK7uuFcJxdl4tgH3HNMp0j0XHB+uvJzpeXyxM5NhzAMl6yV7e74+bPtodQkWPZeNf
         pluVFdVK2NybbGOTDxpRFfQyxE5oO6w7/S7Ev2kLMmJpbMx3sK4epcA1uJN1bRtO/cdf
         3khnnnF5n3YCzoH7VYlf+/eaRPyZCyKxfMuy5hAqXtWPpCmqvGGIUbGnbEK/e0itDuZg
         sFXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVefjXcyLkk4YF4rc+KstUTMexhYEOwtoogZ93HFVEcjwRIHUkCGf/cWD+L1GkdOSmtyiOXevBmvMTMRmXLNU3prwcvn+G5PUlqBos=
X-Gm-Message-State: AOJu0YyTN4sQ7GZqj6vLhGKHp359fbzfajHTHq5ZWiXhoD8j7oBtKp3g
	mj6CyYRIjabPuwt2rHFh3TAJbatq2IGjb/t8Qy4GGsIb583P6vxt/E2qxndWDHc=
X-Google-Smtp-Source: AGHT+IE/KKiwGtgTsCBG2SHhgsrJE+JCAYQSbIVE/BoI4o24/MkvgSRizsPTMOyQSO5zXN1P/mmluQ==
X-Received: by 2002:a17:902:e9d4:b0:1d9:a609:dd7e with SMTP id 20-20020a170902e9d400b001d9a609dd7emr5812131plk.55.1709759257059;
        Wed, 06 Mar 2024 13:07:37 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcc129cc2esm13009813plh.60.2024.03.06.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:07:36 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhyUA-00Fy2T-0J;
	Thu, 07 Mar 2024 08:07:34 +1100
Date: Thu, 7 Mar 2024 08:07:34 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 06/14] fs: xfs: Do not free EOF blocks for forcealign
Message-ID: <ZejbFuavNva4ut/3@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-7-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-7-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:20PM +0000, John Garry wrote:
> For when forcealign is enabled, we want the EOF to be aligned as well, so
> do not free EOF blocks.
> 
> Add helper function xfs_get_extsz() to get the guaranteed extent size
> alignment for forcealign enabled. Since this code is only relevant to
> forcealign and forcealign is not possible for RT yet, ignore RT.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_bmap_util.c |  7 ++++++-
>  fs/xfs/xfs_inode.c     | 14 ++++++++++++++
>  fs/xfs/xfs_inode.h     |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index c2531c28905c..07bfb03c671a 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
>  	 * forever.
>  	 */
>  	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
> +
> +	/* Do not free blocks when forcing extent sizes */

That comment seems wrong - this just rounds up where we start
trimming from to be aligned...

> +	if (xfs_get_extsz(ip) > 1)
> +		end_fsb = roundup_64(end_fsb, xfs_get_extsz(ip));
> +	else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
>  		end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);

I think this would be better written as:

	/*
	 * Forced extent alignment requires us to round up where we
	 * start trimming from so that result is correctly aligned.
	 */
	if (xfs_inode_forcealign(ip)) {
		if (ip->i_extsize > 1)
			end_fsb = roundup_64(end_fsb, ip->i_extsize);
		else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
			end_fsb = xfs_rtb_roundup_rtx(mp, end_fsb);
	}

Because we only want end-fsb alignment when forced alignment is
required.

Which then makes me wonder: truncate needs this, too, doesn't it?
And the various fallocate() ops like hole punching and extent
shifting?

> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 2c439df8c47f..bbb8886f1d32 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -65,6 +65,20 @@ xfs_get_extsz_hint(
>  	return 0;
>  }
>  
> +/*
> + * Helper function to extract extent size. It will return a power-of-2,
> + * as forcealign requires this.
> + */
> +xfs_extlen_t
> +xfs_get_extsz(
> +	struct xfs_inode	*ip)
> +{
> +	if (xfs_inode_forcealign(ip) && ip->i_extsize)
> +		return ip->i_extsize;
> +
> +	return 1;
> +}

This can go away - if it is needed elsewhere, then I think it would
be better open coded because it better documents what the code is
doing...

-Dave.

-- 
Dave Chinner
david@fromorbit.com

