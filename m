Return-Path: <linux-block+bounces-16009-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3CA039C7
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 09:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62175160A59
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 08:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF11DF726;
	Tue,  7 Jan 2025 08:26:59 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916058634D;
	Tue,  7 Jan 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238419; cv=none; b=j1dN8I1vLWbf5OJGm7dhj9scc3nENXf6kKwhIw2NxyRFRP7WWIffTKnl67HyYsgL14QgZx0OdAVIq4GoVGjdkUlrrNUbXR/uMBtQCbl6AHZuhydsFtDy8BBrWLRdpt8S1JPTUmuIpOSPLiDESDaAd9noCz9lnVlDZZRTni0U6Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238419; c=relaxed/simple;
	bh=TLS4jY/JGx7AKLrY6t16YpBsqZunXPhItZk9CAinwyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7KCA1mhoeUaG/GabFPQa/lG5ixBNZ/yuIs25Oq8zu/SBLbNmnp0jvodGjYK01ony2BZNG2Jyk4esjlW7gkswqomUlJMFucmZya1HhRA0IokxdDnq5cvX85jmC7d/6mDpFpiZUPrLK19TTRVH3ERW6HMi4BmMnsAXfISE8AfCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C69B68AFE; Tue,  7 Jan 2025 09:26:52 +0100 (CET)
Date: Tue, 7 Jan 2025 09:26:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 4/8] block: add a store_limit operations for sysfs
 entries
Message-ID: <20250107082651.GA16196@lst.de>
References: <20250107063120.1011593-1-hch@lst.de> <20250107063120.1011593-5-hch@lst.de> <Z3zXANbFk6GBZg_z@fedora> <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae6b7727-64d6-4d9e-9bf5-951e38d8a768@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Nilay,

this is a friendly reminder to reply without quoting the entire mail.
I did not find any content after scrolling half a dozen page of
full quote and gave up.


