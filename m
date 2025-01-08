Return-Path: <linux-block+bounces-16120-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F73A0587F
	for <lists+linux-block@lfdr.de>; Wed,  8 Jan 2025 11:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8415D3A5B44
	for <lists+linux-block@lfdr.de>; Wed,  8 Jan 2025 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0431F4293;
	Wed,  8 Jan 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GAk3k8ln"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4371F2C50
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333074; cv=none; b=rKxvyOb1gTnERXtuHwDybYgydiVs/CuyjH/NryvFcE5qXGoCQBvBwkBYyfRm8lDb5IPYmWCPmwOZ2rGbCS/V2irKiUYnmXGT477f/nzXBMsZ00ITbWSBX4NeAt7eaSoi8F+yqmxSMsKTuz+/fene14Ru+8jJQ8OLrkTVnISo9zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333074; c=relaxed/simple;
	bh=ZUA9hXAvTO402Lqp6o9aZpjzmmWea7t6GMMUlrpj06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhR6uxalf0NtCNN4FjXUoJWl5pWX0vyxjdSm6q147eU1rlDl92E8GjHGMHy88xQuXueUuuk7zzRhEcvHemMN1e2VVt64R5HXwHfP9FbdhKgieenuFbNIKUChMfa1Lq1eOYcS03pCq51XikFEb1oJ/P6q1vi/3OuK8mXIfw3uu8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GAk3k8ln; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736333071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8+WjPvgGIbhzkcemmv78w2LxK9mcyjSw5bhvDUQPa8=;
	b=GAk3k8lnR9qJviC/5zuvfjFX/0mO19ixhpOcvibwDxoHbjQcewk1t8K/3Gmi9plCA4+j6A
	Gc61PabZvXrekkFNFfq1VacyX6XjbQlEfPbRxohNlnf6POvcD8+LnZ09vOBRtQNi49hmYg
	ZVglSZrXRkYBWv22IEaA+7NSWkCjFSg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-w-R51ZUcOOKsnr9FUL6S7Q-1; Wed,
 08 Jan 2025 05:44:30 -0500
X-MC-Unique: w-R51ZUcOOKsnr9FUL6S7Q-1
X-Mimecast-MFC-AGG-ID: w-R51ZUcOOKsnr9FUL6S7Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52C9A1944B2E;
	Wed,  8 Jan 2025 10:44:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78259195608D;
	Wed,  8 Jan 2025 10:44:22 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:44:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 10/10] loop: fix queue freeze vs limits lock order
Message-ID: <Z35W_iLqwXKUKr75@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-11-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 08, 2025 at 10:25:07AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper and document the callers that
> do not freeze the queue at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


