Return-Path: <linux-block+bounces-23859-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB6AFC0D0
	for <lists+linux-block@lfdr.de>; Tue,  8 Jul 2025 04:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34384238C6
	for <lists+linux-block@lfdr.de>; Tue,  8 Jul 2025 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74B21D5BB;
	Tue,  8 Jul 2025 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9Hi+X9c"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5421CC5A
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751941667; cv=none; b=kXmEj5y/WW/UlUPsI5YbLmn7YCwo8bCPj5R/nsjyejpkjgKvZLLu/3rDBJOXIFkaxZUwwH9j6MEbwjCabOPv+06GX1TKM7LhN3hN2gx2amUrcQ4nZSjHKD604uUpOt3gw/JnE2eCoXkX6w/v4AAdCMwRxcBnbmhuJea4nU43PhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751941667; c=relaxed/simple;
	bh=01pWccaiT/a3nvWnmcclCumAkVqj/xd68Zh8X2khoIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS7zqodQGu+K9spptkg+hF8u7OMlNIFjCBvB6A6hpH4aoqAdNwYl94Tka+dc3jZ/9SETlQyjDdhDo/0PyVeeEcUBJdNwl3cUBe8U1JuyVoxA91BmT5cwvTRZH6vpk89Z6KhduESmQspLFGabZA7bLWrCI+JeAvsY6ZH9y7HDPHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9Hi+X9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C60C4CEE3;
	Tue,  8 Jul 2025 02:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751941665;
	bh=01pWccaiT/a3nvWnmcclCumAkVqj/xd68Zh8X2khoIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L9Hi+X9cD5E7akEXAU0QbGsKkA67wgvWCrIVK1bf24lZzV1uBaiaQlwwanNqM4x10
	 0hFSos+T/UqUMd9XzUjKUUCzZArtly01DSDT+ggVGjEs8GSUBMpI87yvPLU0kKkInQ
	 lYrnJ9mcJLC4foqZ78KjGXzuEB293pyge5I9Cb7tWfzULUxKvn33oTHQ+OmHF1VPse
	 gS3bifBOoiC9EvCO/HSjnyLk1Kfcd0rmpXUbfOAfIncdOBnideNh1OBZRlz5MXJaCd
	 37pGCefGAStdG3R5IdOZFWtMFxrhoZjtdCumq+od+sWr+U/7X+8mOiRv/XrLML5wrj
	 e1VGzgB/xC3LQ==
Date: Mon, 7 Jul 2025 20:27:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: What should we do about the nvme atomics mess?
Message-ID: <aGyCH8TOQgVY3AP9@kbusch-mbp>
References: <20250707141834.GA30198@lst.de>
 <aGxz6s9oUp2FkbyX@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGxz6s9oUp2FkbyX@fedora>

On Tue, Jul 08, 2025 at 09:27:06AM +0800, Ming Lei wrote:
> On Mon, Jul 07, 2025 at 04:18:34PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > I'm a bit lost on what to do about the sad state of NVMe atomic writes.
> > 
> > As a short reminder the main issues are:
> > 
> >  1) there is no flag on a command to request atomic (aka non-torn)
> >     behavior, instead writes adhering to the atomicy requirements will
> >     never be torn, and writes not adhering them can be torn any time.
> >     This differs from SCSI where atomic writes have to be be explicitly
> >     requested and fail when they can't be satisfied
> >  2) the original way to indicate the main atomicy limit is the AWUPF
> >     field, which is in Identify Controller, but specified in logical
> >     blocks which only exist at a namespace layer.  This a) lead to
> 
> If controller-wide AWUPF is a must property, the length has to be aligned
> with block size.

What block size? The controller doesn't have one. Block sizes are
properties of namespaces, not controllers or subsystems. If you have 10
namespaces with 10 different block formats, what does AUWPF mean? If the
controller must report something, the only rational thing it could
declare is reduced to the greatest common denominator, which is out of
sync with the true value reported in the appropriately scoped NAUWPF
value.

