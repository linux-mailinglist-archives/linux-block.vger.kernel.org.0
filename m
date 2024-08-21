Return-Path: <linux-block+bounces-10728-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36E3959E2F
	for <lists+linux-block@lfdr.de>; Wed, 21 Aug 2024 15:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D911C223A6
	for <lists+linux-block@lfdr.de>; Wed, 21 Aug 2024 13:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578A19994B;
	Wed, 21 Aug 2024 13:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNs4lSP3"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61E715FA92
	for <linux-block@vger.kernel.org>; Wed, 21 Aug 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245741; cv=none; b=C0W0L3PIXSIfLZNVjv5uRbS+f29k2bWqbk3hvRymfQdqDKT4unW6e8FnSYKgGRtXscHWgmZeJx3v7T0BzM4TSuor0gDy+hbx6VVflbk+vT7aPy2Qq2wqtwqV6kLKYmZUMWHMMfQ7nZGyotmbGYSb97WSKZ1nsUiN29M6tLTCmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245741; c=relaxed/simple;
	bh=ybJQR0hiEiFX55/zKRUixsPea5djDrknKPtGT0oPRGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/z7ijWZutEMM6xjsfMaanpAoB7KzTJ/+CcBS6ubUVjV/jGG0JvaYlc5WoaHEfg+y0jmv7C+aZXwvEbHEyEZNeKddDN14ZN9Zr+42GdFFW8zQmPEag82r4w9O6e1uS4zUGr71fKV4cM+iXGYng5FI5rQWWYUEpHVaGzUVx2+tWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNs4lSP3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724245736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftzy8wmPd1fIZosJOmF+YzPd6W3yB3pGQ4TDRBMo1RA=;
	b=WNs4lSP3VFgyWpt1qzP2LR/2HRTMdFZB6URR7l+0c42uWHQILhEwJ8Csa4TKRfTKiPWXOs
	Kr+s3MVrB9h4REjvVy+DPIOyM1AlDEHwqPKTZtd1SidyCdwERyE6UbaXNSHc1fmRBo3wfJ
	x8er2Xj7YmWDyhPATxsRFk4OQx80Je4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-SIV7iMHCOnWkrfCYlssVvw-1; Wed,
 21 Aug 2024 09:08:51 -0400
X-MC-Unique: SIV7iMHCOnWkrfCYlssVvw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F5F31954B2A;
	Wed, 21 Aug 2024 13:08:48 +0000 (UTC)
Received: from bfoster (unknown [10.22.33.147])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54F5C19560AA;
	Wed, 21 Aug 2024 13:08:45 +0000 (UTC)
Date: Wed, 21 Aug 2024 09:09:41 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/6] xfs: refactor xfs_file_fallocate
Message-ID: <ZsXnFYIwww-Y6JH8@bfoster>
References: <20240821063108.650126-1-hch@lst.de>
 <20240821063108.650126-7-hch@lst.de>
 <ZsXhL_pJhq2qyy-l@bfoster>
 <20240821125756.GA21319@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125756.GA21319@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Aug 21, 2024 at 02:57:56PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 21, 2024 at 08:44:31AM -0400, Brian Foster wrote:
> > > +	error = xfs_reflink_unshare(XFS_I(inode), offset, len);
> > > +	if (error)
> > > +		return error;
> > > +
> > 
> > Doesn't unshare imply alloc?
> 
> Yes, ooks like that got lost and no test noticed it
> 
> > > -	if (xfs_file_sync_writes(file))
> > > +	if (!error && xfs_file_sync_writes(file))
> > >  		error = xfs_log_force_inode(ip);
> > 
> > I'd think if you hit -ENOSPC or something after doing a partial alloc to
> > a sync inode, you'd still want to flush the changes that were made..?
> 
> Persistence behavior on error is always undefined.  And that's also
> what the current code does, as it jumps past the log force from all
> error exits.
> 

Ok, if this preserves existing behavior then I'm not too worried about
it. Thanks.

Brian


