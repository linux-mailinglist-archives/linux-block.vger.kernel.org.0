Return-Path: <linux-block+bounces-17043-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1870A2D057
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 23:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57ED188BE69
	for <lists+linux-block@lfdr.de>; Fri,  7 Feb 2025 22:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34461C75E2;
	Fri,  7 Feb 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QseQKzWf"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7CB42069
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966468; cv=none; b=PxtQ8KBa5R+rC4WV0+NeeEadRtO0F4MOq5G7SogLISHceudDBqPp2qgscIlsi63AgoXgE5Ypg1bvU6cEvxA/igHRqVIQHmSb3NiBZ3pszRprbKLY17EOD8C8PXlQC718drp8TdrwCFYLhYdKWMZmBYExk3RFm/l2FQZWaqR2Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966468; c=relaxed/simple;
	bh=v3E7aOAj1RolbZ+G8rpmqWsn67q8WYxDr1SczyjymHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWqMRclM8Onb1c/nYoIOyCx3g7aMTUGsz4Lu1g0MNBuf9VsF7Ip67XxQyqLLx23Vg+24KpjSUD+EeXqU+LU7l7iz59NbPX2uHXmm8JH51a3kjAio4xrnfqopGAxtyBqv2ZGAFn7mdeNhE7u+id3cVGUfKABjyKA+JlE02Zwx+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QseQKzWf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738966466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JQYDZ5jzno7rrMD91/odghBo6lSgHHkIDBVq0SzOmo=;
	b=QseQKzWfxUCtnKY2xe4CyB2K+UC/uV/p+cwr7V12fZZ5kvF5zoUuui4x62mwU4jYluY9fu
	YRI7rLcCViq30sjwOr2cw9aN2nitGc74A1Srz/skvKmNyV4A/hE4Z2G/6ZG3hieeQ6G0qj
	ZgIvtrM1IUrJlKSuYXDusfC2OsPg5u8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-QyO-n5Z1MT68fscLH0adPg-1; Fri,
 07 Feb 2025 17:14:19 -0500
X-MC-Unique: QyO-n5Z1MT68fscLH0adPg-1
X-Mimecast-MFC-AGG-ID: QyO-n5Z1MT68fscLH0adPg
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 437711956095;
	Fri,  7 Feb 2025 22:14:16 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 56BCE1800360;
	Fri,  7 Feb 2025 22:14:14 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 517MEDga725105
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 17:14:13 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 517MECmM725090;
	Fri, 7 Feb 2025 17:14:12 -0500
Date: Fri, 7 Feb 2025 17:14:12 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, tytso@mit.edu,
        djwong@kernel.org, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC PATCH v2 4/8] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP support
Message-ID: <Z6aFtJzGWMNhILJW@redhat.com>
References: <20250115114637.2705887-1-yi.zhang@huaweicloud.com>
 <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115114637.2705887-5-yi.zhang@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Jan 15, 2025 at 07:46:33PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> default. This feature shall be disabled if any underlying device does
> not support it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-table.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index bd8b796ae683..58cce31bcc1e 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
>  static void dm_set_stacking_limits(struct queue_limits *limits)
>  {
>  	blk_set_stacking_limits(limits);
> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  

dm_table_set_restrictions() can set limits->max_write_zeroes_sectors to
0, and it's called after dm_calculate_queue_limits(), which calls
blk_stack_limits(). Just to avoid having the BLK_FEAT_WRITE_ZEROES_UNMAP
still set while a device's max_write_zeroes_sectors is 0, it seems like
you would want to clear it as well if dm_table_set_restrictions() sets
limits->max_write_zeroes_sectors to 0.

-Ben

>  /*
> -- 
> 2.39.2
> 


