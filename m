Return-Path: <linux-block+bounces-11196-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F51796AEDB
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 828BF1C20F16
	for <lists+linux-block@lfdr.de>; Wed,  4 Sep 2024 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3484205D;
	Wed,  4 Sep 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/CqsaLe"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270B442AB0
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418664; cv=none; b=TEUY8WGli84O3L16A4GcRT+Up7758AOh/6kTxxFGthFjjvEyKUSJvTFFSVADFml34K00KQbkCq0Rc27WbHPSWZBQ9YuVgQU/254yO/xBWRHys2ZyZzCYSfZEOkbv5BRnDyZQz/4v/i4BV6KFDZms7DP+uQSLIqBtyvIbo9epCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418664; c=relaxed/simple;
	bh=foqF30mnXx1GcKY7zbYXFFy3NBR51yPMKQzsrC74LuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCs1qvu7GgS4jLJ4GNYpkypAGxGJKZQe2+rSWSfUbbkmJyk236NcvI6Nlo+JXoI9p9aBmmme4of6pULS8GzboJKH9FnFnwATEpgxq8aBFJjhge77vo1yy5XP0db17gmAe20ZN3K3a729bFkqVV3m9cLihmonOaqH6hfB7lI11Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/CqsaLe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725418661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZg1+Cu2DLlxPh/lu/2PGq1H6RdumTvMLcval/dS4I4=;
	b=E/CqsaLetxTDwswiPp44GE4edFIMjwz9QHontQuvaTCFB5gA+vGLr6UALyv765Inzk2jts
	2yZFDwRgxUYR+gnlwfaA+jwrmrKiIE2Oszaed0tTKHIe59jHRe12vBHbLsvoouQl4YeW43
	wKjDTIMopAPflZDCe4B9OSaQHRmzoQ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-PAA9kXFiOxaza9zn4QhoQg-1; Tue,
 03 Sep 2024 22:57:38 -0400
X-MC-Unique: PAA9kXFiOxaza9zn4QhoQg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5D2E1955BEE;
	Wed,  4 Sep 2024 02:57:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 147E330001A4;
	Wed,  4 Sep 2024 02:57:28 +0000 (UTC)
Date: Wed, 4 Sep 2024 10:57:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jinyoung Choi <j-young.choi@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	ming.lei@redhat.com
Subject: Re: [PATCH] bio-integrity: don't restrict the size of integrity
 metadata
Message-ID: <ZtfMkzqP3ONMCZL0@fedora>
References: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41b3b8e-16c2-70cb-97cb-881234bb200d@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Sep 03, 2024 at 09:47:59PM +0200, Mikulas Patocka wrote:
> Hi Jens
> 
> I added dm-integrity inline mode in the 6.11 merge window. I've found out
> that it doesn't work with large bios - the reason is that the function
> bio_integrity_add_page refuses to add more metadata than
> queue_max_hw_sectors(q). This restriction is no longer needed, because
> big bios are split automatically. I'd like to ask you if you could send
> this commit to Linus before 6.11 comes out, so that the bug is fixed
> before the final release.
> 
> Mikulas
> 
> 
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> bio_integrity_add_page restricts the size of the integrity metadata to
> queue_max_hw_sectors(q). This restriction is not needed because oversized
> bios are split automatically. This restriction causes problems with
> dm-integrity 'inline' mode - if we send a large bio to dm-integrity and
> the bio's metadata are larger than queue_max_hw_sectors(q),
> bio_integrity_add_page fails and the bio is ended with BLK_STS_RESOURCE
> error.
> 
> An example that triggers it:
> 
> # modprobe brd rd_size=1048576
> # dmsetup create in1 --table '0 1847320 integrity /dev/ram0 0 64 D 1 fix_padding'
> # dmsetup create in2 --table '0 1847312 integrity /dev/mapper/in1 0 64 I 1 internal_hash:sha512'
> # dd if=/dev/zero of=/dev/mapper/in2 bs=1M oflag=direct status=progress
> dd: error writing '/dev/mapper/in2': Cannot allocate memory
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.00169291 s, 0.0 kB/s
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: fb0987682c62 ("dm-integrity: introduce the Inline mode")
> Fixes: 0ece1d649b6d ("bio-integrity: create multi-page bvecs in bio_integrity_add_page()")

Firstly meta size is always < bio size.

Secondly the check isn't needed either bio_integrity_add_page() is called on
to-be-splited bio(DM), or splited bio(blk-mq).

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


