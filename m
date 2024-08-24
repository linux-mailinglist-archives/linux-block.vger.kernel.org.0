Return-Path: <linux-block+bounces-10857-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3821095DCF0
	for <lists+linux-block@lfdr.de>; Sat, 24 Aug 2024 10:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAD1BB22335
	for <lists+linux-block@lfdr.de>; Sat, 24 Aug 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E541C72;
	Sat, 24 Aug 2024 08:31:23 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9709F5680;
	Sat, 24 Aug 2024 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724488283; cv=none; b=QpLZ7xD0TYm4+X81VQWmlFsB91mak2NJ4BnljkZ/ZlzGHjrTmE6d6oEylj3e1YmXDIJpp5GK1RF/iEGhW0SqN6IDcAcGOV4CtGLqleEBziUamw+EpBO8DlvweyIk3X1nLfM9eyxnqTUoWxbAfeq5hyC2dUTTbtQJkjcLlUEb0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724488283; c=relaxed/simple;
	bh=NgsA1Z3PXcNb4c/XCMYTD00EmE1g2f4/7vNahwm03Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gt9OgsinXXeVU6PjeO77gEq/S+GZ4bDoStBuimY0ZvbVjmZKumyJrec26Xf8Yo1Sg2kJsJ2AwcxhIPbbetTqiT8ApXcjHRtP+rtIWswoZaKpMdsE55yPtm2VATT192aOaSfEEilvHYOP1QzTSbFnzBRp6HdFsIkp8jmdFN3h72s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3176A227A87; Sat, 24 Aug 2024 10:31:17 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:31:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 03/10] block: handle split correctly for user meta
 bounce buffer
Message-ID: <20240824083116.GC8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104620epcas5p2118c152963d6cadfbc9968790ac0e536@epcas5p2.samsung.com> <20240823103811.2421-4-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-4-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Aug 23, 2024 at 04:08:03PM +0530, Anuj Gupta wrote:
> Copy back the bounce buffer to user-space in entirety when the parent
> bio completes.

This looks odd to me.  The usual way to handle iterating the entire
submitter controlled data is to just iterate over the bvec array, as
done by bio_for_each_segment_all/bio_for_each_bvec_all for the bio
data.  I think you want to do the same here, probably with a
similar bip_for_each_bvec_all or similar helper.  That way you don't
need to stash away the iter.  Currently we have the field for that,
but I really want to split up struct bio_integrity_payload into
what is actually needed for the payload and stuff only needed for
the block layer autogenerated PI (bip_bio/bio_iter/bip_work).

