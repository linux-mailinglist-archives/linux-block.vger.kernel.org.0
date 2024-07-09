Return-Path: <linux-block+bounces-9874-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801E92B0D7
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2024 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797B11C20F02
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2024 07:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01C13A24B;
	Tue,  9 Jul 2024 07:08:15 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE813AD20;
	Tue,  9 Jul 2024 07:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508895; cv=none; b=ixWCiHAkLl8gfqqy7pYFRdxG+rEX2EqVD9fsWsCoGnBHKnL0yRPAaaM8/SquX3G9yASwKNdguyCmbxR1NV3uDilfxMy7TRpjvZQbNAXr+R2YX2plWrjHvwdVmozpnf9lci8aGO1UtHpZYIesllHTE80U/3S567da3mMZFlTyhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508895; c=relaxed/simple;
	bh=hOhpCAA8Pzsg6jOCQem2wBYOsnqy23tS2Ss0BLY8RJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgKM0t1dac89a46sTz6O3x64N5n6QVivN4aU6f0LynmBr19vhpCXu6UZrcCk5TD7LsNZ2bCbzddnfnaNqIiYY+pKM0BvGdEBbNRsl6Kh4LMrCNUWxHNZo4XEnFiQBSuM4cqe97GrlmEs7u3kZuclWfvvPPPN4bfBnYMz8XxkLrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 869BD68AFE; Tue,  9 Jul 2024 09:08:08 +0200 (CEST)
Date: Tue, 9 Jul 2024 09:08:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: fine-grained PI control
Message-ID: <20240709070808.GA18993@lst.de>
References: <20240705083205.2111277-1-hch@lst.de> <CACzX3AvXAhcjE0PEB_PO7B2e0pRB7mj2QMdw5Gj_sNH-acTfYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACzX3AvXAhcjE0PEB_PO7B2e0pRB7mj2QMdw5Gj_sNH-acTfYg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 08, 2024 at 07:47:59PM +0530, Anuj gupta wrote:
> > Last but not least the fact that all reads and writes on PI enabled
> > devices by default check the guard (and reference if available for the
> > PI type) tags leads to a lot of annoying warnings when the kernel or
> > userspace does speculative reads.
> In the current series the application can choose not to specify the
> GUARD check flag, which would disable the guard checking even for PI
> enabled devices. Did you still encounter errors or am I missing
> something here?

Well, this is for probing reads from libblkid, the partition parser
or file system mount routines.  So we'll need a flag for the case where
PI is not controlled by the user, as we don't really want all the callers
to actually deal with PI.

