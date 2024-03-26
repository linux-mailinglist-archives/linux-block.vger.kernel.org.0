Return-Path: <linux-block+bounces-5084-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE788BAA1
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659141F3943E
	for <lists+linux-block@lfdr.de>; Tue, 26 Mar 2024 06:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1928839FC;
	Tue, 26 Mar 2024 06:45:15 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780397EF09;
	Tue, 26 Mar 2024 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435515; cv=none; b=arL6owFFxlThREgxYyuXSvkxDuWDjrkX/B0i1xvipEOmxE4prAkQLhz0oGjRqYc52I41G9LlpDcND3+E938t0RwlQkl2C0bAgUcOKoD8fdYii3PMLMxG36/GLkTDtXzH3Mp0E919w6234gE8n8ybdFsb3k3AG2yH/19h+jIteRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435515; c=relaxed/simple;
	bh=ckmjKTjh2SuhKaA8KYYCt9SxxAGgOSxEhGOOvkXXARs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8HQbmQSfNofxK7dVav422bm+rBbHV5l1iG61JLsrOwiyI2KKT9nZpwAgO66Y4GXev3rrGHXk0RzbISg81RXxDwJp3Tcmk7HM28V1IYXv3Rc9OCVt7SI4sfu09vVmJ4VH7k3tNuIZ+cSS1lak9RK3BAUJLiOTeC399/8ul4yKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE77668D37; Tue, 26 Mar 2024 07:45:10 +0100 (CET)
Date: Tue, 26 Mar 2024 07:45:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 19/28] nvmet: zns: Do not reference the gendisk
 conv_zones_bitmap
Message-ID: <20240326064509.GA7986@lst.de>
References: <20240325044452.3125418-1-dlemoal@kernel.org> <20240325044452.3125418-20-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325044452.3125418-20-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 25, 2024 at 01:44:43PM +0900, Damien Le Moal wrote:
> The gendisk conventional zone bitmap is going away. So to check for the
> presence of conventional zones on a zoned target device, always use
> report zones.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

