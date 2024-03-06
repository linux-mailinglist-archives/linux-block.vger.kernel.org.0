Return-Path: <linux-block+bounces-4195-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 026DF874207
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 22:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E621F23C23
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 21:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4475E1B81B;
	Wed,  6 Mar 2024 21:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="hhENJq7W"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EB1B7EB
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760827; cv=none; b=eziPb179/c44soIR5z84L5iaC2kLLYORxt/A5ySE+ieHzUCeGuEjweV44OllE5YFRDHYg7S/OaKLIMnS//bwyvGDnqn6opCW3ZP8QCNaQDxFlgRveJmsatUh0H2ZASfTxCMuRlpIjsg33DQJ2deyJY2QQSyevuSASiQJAQfRBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760827; c=relaxed/simple;
	bh=lBeqi1Od8aqjQdE+h3spg51GfhBgU0Ber9/L+CC45Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvisrN4fuAdlTwVqtit6yLM0J4JJCR1T4nvjo37dtrfy7JvPLeQYZE0ZxGOw+oLzchfQFsfsXK5WE9E2h+rZKBtrZJ/FlMV9y4vrZhztw8lZ+ULa+d04w1DhYQjuzcSrjB2u1mfXHU6J79waIJgV3Nqv9jSDhS3nhpPZhxbMSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=hhENJq7W; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so161923b3a.1
        for <linux-block@vger.kernel.org>; Wed, 06 Mar 2024 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1709760824; x=1710365624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5XtgztaKVWtYTslZylN4UoDvfDDXKyZIYsCtne6/Pc=;
        b=hhENJq7WcQK6g+GwBOB/0FAu4PpZIFAvnhCkdkR0LoQ1R75cyqcrF3zo36yxvAgP3Y
         qj6+Je9KxqUszfpLlkUsA1fLBp/iLm5HZZX6PGILVfGVi7pGDJyw0kAbpG/6eCSFxsTE
         xrVyFyWXwYoQy7WkwYGnLD4YcQSV1UekO3S3lCvP1u9GhjRadRCYWYiz2SJ8PQuuHKs4
         8cek7Vk0kVhvc2hfIMfoURfW4a/BfEUffPRZDKBAvHbN8njab9o5wl1f34W0+LEPYggJ
         WI0oRfmkQVZxii0dxoyx6b+i3RN1nZr1Th2hh5Efkr7ftuo1uaJT4/3rYAJK1BU0kZ3D
         yO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709760824; x=1710365624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5XtgztaKVWtYTslZylN4UoDvfDDXKyZIYsCtne6/Pc=;
        b=lo5ZdIdBwbiFnmwEHo3reYGJTCthFSkkVrFya9IIhuuXuCxOjIPdvWhctxvJDN/Sll
         CUprfL9bFHkPgMu0iJR3PPY9SPwMF1EaWQi9fc1h65CywMFhG6Lv5c0ajR/9s2kqXrRM
         Wv0+Tz8y/OuPmhl/c7KcsqvezpuDx4Eqc5D7F1scH+akX7RxprRQiJt0psQKRmhiLyZ0
         AeISvW4drOVztblPufv2bXipiH5YJuKmBlUi+4cir394FzNGr/eWUBRiGGq8AV9BsTOg
         0ohj6QBNc14KNBkfjThdpBSEcn3TElxdHCyOBSZhV/r51wkqJ73d+tVoG4z1nGHm156E
         y9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWnB0Gu2OIYB3mlTaiXWlyRVhC89thIbxiVBmiZe0gstthsXmdwZiOfCAxffGtmzcIjKUwANIQuoF+7GWbrFOURUx6fQOOYSNuKP8I=
X-Gm-Message-State: AOJu0YzD/jOLMnR+hUBAocC3cLk6NCzBrqKkqIf0C4vZLOT9Uz5dne7B
	sDlM/KpOwkrjeSmn08YaczbYtgdobzq8nD8/bmAcDl16A0uPYl2vVny8nxHAQTQ=
X-Google-Smtp-Source: AGHT+IGGisoLgIMtm0iBqCZFt7j/7kMuccUJOnzA9FKXYbvHwlmRQJECj+lxpWWTCUOV1fCaYoS9bQ==
X-Received: by 2002:a05:6a00:178d:b0:6e6:35c5:8c42 with SMTP id s13-20020a056a00178d00b006e635c58c42mr8040141pfg.28.1709760823859;
        Wed, 06 Mar 2024 13:33:43 -0800 (PST)
Received: from dread.disaster.area (pa49-179-47-118.pa.nsw.optusnet.com.au. [49.179.47.118])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b005dc9ab425c2sm10013378pgb.35.2024.03.06.13.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 13:33:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rhytQ-00FyZq-2o;
	Thu, 07 Mar 2024 08:33:40 +1100
Date: Thu, 7 Mar 2024 08:33:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 14/14] fs: xfs: Support setting FMODE_CAN_ATOMIC_WRITE
Message-ID: <ZejhNMW5o0JSCgqW@dread.disaster.area>
References: <20240304130428.13026-1-john.g.garry@oracle.com>
 <20240304130428.13026-15-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304130428.13026-15-john.g.garry@oracle.com>

On Mon, Mar 04, 2024 at 01:04:28PM +0000, John Garry wrote:
> For when an inode is enabled for atomic writes, set FMODE_CAN_ATOMIC_WRITE
> flag. We check for direct I/O and also check that the bdev can actually
> support atomic writes.
> 
> We rely on the block layer to reject atomic writes which exceed the bdev
> request_queue limits, so don't bother checking any such thing here.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_file.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index cecc5428fd7c..e63851be6c15 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1234,6 +1234,25 @@ xfs_file_remap_range(
>  	return remapped > 0 ? remapped : ret;
>  }
>  
> +static bool xfs_file_open_can_atomicwrite(
> +	struct inode		*inode,
> +	struct file		*file)
> +{
> +	struct xfs_inode	*ip = XFS_I(inode);
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +
> +	if (!(file->f_flags & O_DIRECT))
> +		return false;
> +
> +	if (!xfs_inode_atomicwrites(ip))
> +		return false;
> +
> +	if (!bdev_can_atomic_write(target->bt_bdev))
> +		return false;

Again, this is static blockdev information - the inode atomic write
flag should not be set if the bdev cannot do atomic writes. It
should be checked at mount time - the filesystem probably should
only mount read-only if it is configured to allow atomic writes and
the underlying blockdev does not support atomic writes...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

