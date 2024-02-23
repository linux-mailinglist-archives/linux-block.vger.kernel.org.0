Return-Path: <linux-block+bounces-3603-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2983B860ADB
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 07:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1CBB1F263DD
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 06:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374B9168B9;
	Fri, 23 Feb 2024 06:36:27 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2FC168A4
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708670187; cv=none; b=lxhMUGwcawKu8R0c8T0VN/F1UQLFkQWYsHoDu11rGdE4WzY5X+W1ZzBUN0f2f9aP0yAfvpTbIJhTK/jIcoqz4pFoIFKadJJkcXaH1uW/Vt3XBhce9/wfnHULAdTSKlImeDiFkKbHjzouThGjQxBYcHFj2uud0/NyzmsjklU+A7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708670187; c=relaxed/simple;
	bh=feAxzI4gKGD+TNr6BsseqfxlDoe0e+5ms+76eZOPi6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg9TXFAWuNwLbzvg6gpEvIQ4Nad1cneLnyIMJi/KIVW6doDlZeh0x4QRWoQkOPzQHizbJ6YannRhRV1sfwaTkCZ1PHZr5+AtPZB6X9OMp26XyaBCR0Xv8RDa7DfqDX5i/6CuEYePdnUscWl/jSZIQh+0XsFq/PIthVSchGi6CNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4898B68C7B; Fri, 23 Feb 2024 07:36:21 +0100 (CET)
Date: Fri, 23 Feb 2024 07:36:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] null_blk: Delete nullb.{queue_depth, nr_queues}
Message-ID: <20240223063620.GA11004@lst.de>
References: <20240222083420.6026-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222083420.6026-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks,

this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

