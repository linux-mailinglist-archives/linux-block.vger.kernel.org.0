Return-Path: <linux-block+bounces-5591-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D454895583
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639FCB2B30D
	for <lists+linux-block@lfdr.de>; Tue,  2 Apr 2024 13:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708784A21;
	Tue,  2 Apr 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i3AvT8+Z"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A181742
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064686; cv=none; b=KcrhrV/2q4rcnRCjrVKHd+UI9yQC27j9nV1Q1syehnAP09J1NIyfy/VahnpN/vqp+Y9R23IDxn++GcTJPI4hC+KF/IMLyHotHXCAyz7nL6yakQx4cY3SDk1OIE6b0qYnt5g5hDF/zeY4mIIsD+8VbwwojEm4zR3Y+FenFI/aCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064686; c=relaxed/simple;
	bh=kcQoxH0jxIgJ/P84Xua+U3nNWiWfpKTH/xOh3LWBl1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfO1P05BTVF1G3qIWwmhx8e+4ibP2hGPxWLFnAoQPUrNrgVV/GF+QsoWOIFBvNIiF3Ehm6iSqT1yS/uhEotJvZ4aQ21gQaxpkvr9SroLfbPCFNY/D5In9fOkm9YQhtzvDDxGy2/HCvvlE23ptwXQke5WxlVsJAsHw1/IPgF/+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i3AvT8+Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712064683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GTjl1nh440a+DglsfE5+x1ZIRvYKsGb3C02MGXgaUA0=;
	b=i3AvT8+ZRzZPqi8aCVyJUT4P4sBN1pNnFt8uUkj8d0Sl2wTewW2+rk8MQWnsTZjCwlpzW/
	uMVqeMJ3AyOfAj+tsGv+Ig8vjqVpvDmUGDGblSs1nzlqzVEKFEIYpJNLgaGRiUo5Xse+U6
	MBYsXqPEmtcvLVv8ypx8A2JoxKK766g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-L19wE6C2MtyeSXI-n9B4Mw-1; Tue,
 02 Apr 2024 09:31:20 -0400
X-MC-Unique: L19wE6C2MtyeSXI-n9B4Mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CB0A1C0AF45;
	Tue,  2 Apr 2024 13:31:17 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.64])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CB0811C060D6;
	Tue,  2 Apr 2024 13:31:14 +0000 (UTC)
Date: Tue, 2 Apr 2024 08:31:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, David Teigland <teigland@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 0/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Message-ID: <6yjbfcrsmdmibrfs2pcseehrcbjkn67qzanyhlrduocguqvoaq@jjwntpqtsmpc>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240402122617.GA30720@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402122617.GA30720@lst.de>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On Tue, Apr 02, 2024 at 02:26:17PM +0200, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 04:39:01PM -0400, Stefan Hajnoczi wrote:
> > In the block device world there are similar concepts to holes:
> > - SCSI has Logical Block Provisioning where the "mapped" state would be
> >   considered data and other states would be considered holes.
> 
> But for SCSI (and ATA and NVMe) unmapped/delallocated/etc blocks do
> not have to return zeroes.  They could also return some other
> initialization pattern pattern.  So they are (unfortunately) not a 1:1
> mapping to holes in sparse files.

Yes, and Stefan already answered that:

https://lore.kernel.org/dm-devel/e2lcp3n5gpf7zmlpyn4nj7wsr36sffn23z5bmzlsghu6oapi5u@sdkcbpimi5is/t/#m58146a45951ec086966497e179a2b2715692712d

>> SCSI initiators can check the Logical Block Provisioning Read Zeroes
>> (LBPRZ) field to determine whether or not zeroes are guaranteed. The sd
>> driver would only rely on the device when LPBRZ indicates that zeroes
>> will be read. Otherwise the driver would report that the device is
>> filled with data.

As well as my question on whether the community would be open to
introducing new SEEK_* constants to allow orthogonality between
searching for zeroes (known to read as zero, whether or not it was
allocated) vs. sparseness (known to be unallocated, whether or not it
reads as zero), where the existing SEEK_HOLE seeks for both properties
at once.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


