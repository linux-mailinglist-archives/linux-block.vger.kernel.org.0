Return-Path: <linux-block+bounces-6235-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E18A56CC
	for <lists+linux-block@lfdr.de>; Mon, 15 Apr 2024 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0782B1C21036
	for <lists+linux-block@lfdr.de>; Mon, 15 Apr 2024 15:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DAE7F7E4;
	Mon, 15 Apr 2024 15:53:44 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813697F7DA
	for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196424; cv=none; b=K7xFPUHOUBOMB6LxcISZPXEmNKRfpnndMjhPU7zjHqD3gbiWEFYdlr8vAaEzue1eJMug+ltV6II4eLcV//q7ZnEdnqarDsbQzQxHavrch7uG1JGK3FbdWebmCFEVjHac7zjXh+t6dXbXxza2+sY5ATq2r9ixGred1qAO884pMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196424; c=relaxed/simple;
	bh=YiQjWJpzdavvT8xdQ9oAiiYmz0r9Ih+L53BAr+/F5Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRueHLAt+QE9K666jSADfyQ4YRB3CXmwSOf9fg73rZ3RX6/8Yova62PLUfVak/w0vo0wo+GYmsv8tPP4gBFp3+HClyI/Mh+Xn6e5bNtRhtWeqgiiHoFB3c7R1htfwObGmNl7y892yfDlokPeAQhH0iIWVmHNxS1448v6VSZCgqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b50b8239fso29448836d6.0
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2024 08:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713196421; x=1713801221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZq59D7CN8IyAio+UrGCoszHZ95ZUk1m4Cy8JPSP7JY=;
        b=lQo3U00NbItckQS54cl8A6WFUFqrLHnC2tnP1L3HPzlb2vPOEUFw5H8CoRoALUbIt3
         STr8fP7SbForouPCVJelJFnimGVu+KjsFDimQr9fbEC8H+uoumo8F4Hk6mJX5a0VfVPl
         dKMX0Ld012cswYFrnTMli+9VU9buOCa2Xr95HewMWIcRFhHwB64AbUjwsIAY7ICW1Jn3
         0juaM3Dq2kt3RLwi4KYfnUJOdXxYerQ7j8ldhYqswG4cFFn6uTUWW+ulTUldrbNLfC/j
         1X9QrOwA7chfBRjswBffQaW4dlWjk6FDUs/Hnq6kxINfYK4Gcdl5bAMUMJYkK65oLuGl
         nPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt3bfSme4RHUKG25gUAWxB//2bxxLTZDIp2zeBVknRK7pouRPXnEGQUqGSV7b/D1lcsdR0YXknxHIcR/7eO4E2HnWnUHznwmb5Vjk=
X-Gm-Message-State: AOJu0YyLIxZQRuCZM0RXGl0uMfcYue1aKwlAALlCR1QUVy7/z29NlyLX
	NArZJrLxMQwMVbbtqL+a0aniUs3qawakwfP0DPJa/XiyHBwKXO6RJghUlz+QHw==
X-Google-Smtp-Source: AGHT+IG47NcQiFkABQEss43aPCNBl6bAMBkER4pxXkwkNBWvGUcY2M2YjQz7yfo8xKZy4ihq6yrasw==
X-Received: by 2002:a05:6214:2b49:b0:696:4086:5e1 with SMTP id jy9-20020a0562142b4900b00696408605e1mr151924qvb.2.1713196421499;
        Mon, 15 Apr 2024 08:53:41 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id kr5-20020a0562142b8500b0069b7929cdfcsm1794585qvb.111.2024.04.15.08.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:53:41 -0700 (PDT)
Date: Mon, 15 Apr 2024 11:53:40 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2 04/34] md: port block device access to file
Message-ID: <Zh1NhM1ow11I03hX@redhat.com>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-4-adbd023e19cc@kernel.org>
 <Zhzyu6pQYkSNgvuh@fedora>
 <20240415-haufen-demolieren-8c6da8159586@brauner>
 <Zh07Sc3lYStOWK8J@fedora>
 <20240415-neujahr-schummeln-c334634ab5ad@brauner>
 <Zh1Dtvs8nst9P4J2@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh1Dtvs8nst9P4J2@fedora>

On Mon, Apr 15, 2024 at 11:11:50PM +0800, Ming Lei wrote:
> On Mon, Apr 15, 2024 at 04:53:42PM +0200, Christian Brauner wrote:
> > On Mon, Apr 15, 2024 at 10:35:53PM +0800, Ming Lei wrote:
> > > On Mon, Apr 15, 2024 at 02:35:17PM +0200, Christian Brauner wrote:
> > > > On Mon, Apr 15, 2024 at 05:26:19PM +0800, Ming Lei wrote:
> > > > > Hello,
> > > > > 
> > > > > On Tue, Jan 23, 2024 at 02:26:21PM +0100, Christian Brauner wrote:
> > > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > > ---
> > > > > >  drivers/md/dm.c               | 23 +++++++++++++----------
> > > > > >  drivers/md/md.c               | 12 ++++++------
> > > > > >  drivers/md/md.h               |  2 +-
> > > > > >  include/linux/device-mapper.h |  2 +-
> > > > > >  4 files changed, 21 insertions(+), 18 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > > > > index 8dcabf84d866..87de5b5682ad 100644
> > > > > > --- a/drivers/md/dm.c
> > > > > > +++ b/drivers/md/dm.c
> > > > > 
> > > > > ...
> > > > > 
> > > > > > @@ -775,7 +778,7 @@ static void close_table_device(struct table_device *td, struct mapped_device *md
> > > > > >  {
> > > > > >  	if (md->disk->slave_dir)
> > > > > >  		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> > > > > > -	bdev_release(td->dm_dev.bdev_handle);
> > > > > > +	fput(td->dm_dev.bdev_file);
> > > > > 
> > > > > The above change caused regression on 'dmsetup remove_all'.
> > > > > 
> > > > > blkdev_release() is delayed because of fput(), so dm_lock_for_deletion
> > > > > returns -EBUSY, then this dm disk is skipped in remove_all().
> > > > > 
> > > > > Force to mark DMF_DEFERRED_REMOVE might solve it, but need our device
> > > > > mapper guys to check if it is safe.
> > > > > 
> > > > > Or other better solution?
> > > > 
> > > > Yeah, I think there is. You can just switch all fput() instances in
> > > > device mapper to bdev_fput() which is mainline now. This will yield the
> > > > device and make it able to be reclaimed. Should be as simple as the
> > > > patch below. Could you test this and send a patch based on this (I'm on
> > > > a prolonged vacation so I don't have time right now.):
> > > 
> > > Unfortunately it doesn't work.
> > > 
> > > Here the problem is that blkdev_release() is delayed, which changes
> > > 'dmsetup remove_all' behavior, and causes that some of dm disks aren't
> > > removed.
> > > 
> > > Please see dm_lock_for_deletion() and dm_blk_open()/dm_blk_close().
> > 
> > So you really need blkdev_release() itself to be synchronous? Groan, in
> 
> At least the current dm implementation relies on this way sort of, and
> it could be addressed by forcing to mark DMF_DEFERRED_REMOVE in
> remove_all().

You floated that earlier in this thread, etc: no, that would change
the interface.  DMF_DEFERRED_REMOVE gives people options to allow for
async device closes, etc.  But I don't want to impose it as some faux
equivalent to the sync model remove_all has always provided.

And what about simple 'dmsetup remove'? remove_all just loops doing
remove... so isn't 'dmsetup remove' also being forced to be async as
of commit a28d893eb3270 ("md: port block device access to file")?

dm.c:dm_put_device -> dm_put_table_device -> close_table_device

> > that case use __fput_sync() instead of fput() which ensures that this
> > file is closed synchronously.
> 
> I tried __fput_sync(), but the following panic is caused:

Ok, so more work needed.  But we need to preserve the existing sync
interface for DM device removal.

Mike

