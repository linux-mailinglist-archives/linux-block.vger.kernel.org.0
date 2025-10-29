Return-Path: <linux-block+bounces-29141-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE3BC1969D
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D214353B99
	for <lists+linux-block@lfdr.de>; Wed, 29 Oct 2025 09:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6783002C1;
	Wed, 29 Oct 2025 09:38:40 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C24232862C
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730720; cv=none; b=auWlwUbP5KByRjI69NKig7jupqdkWfvvIsZVzJDSl2t9dxiGzJKiaQmqK0BOiSuUPa8JefCWoNJnYsRwKLt1ZzbihNf2d3r0IavyQKAVh2GCQyHRDm9rcmM8jXSouMGTBPwxbtQPcEPXg+fVtB0U/PffGAvcpUi03XghfA1Q79Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730720; c=relaxed/simple;
	bh=tZ+YAujjNF0UrsFTtyLZ34KgTQEvz9OPZf3sxSR24iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTCO2hyy8RJdxjpRrlMX0pwm/wXqcWI7N1z7aA9ds6vrzaVUM4qi1UL5TTaO95Pt9hFRwEbk6+KLNrCAKwh4Ckoztc2EAngpPRlle359/OjnzVphtfkIcNtD43YodbM8b24y3r2cJ13AKHmo1O+oQw9ZD7lmaQglwcdkVt0AhJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64670227A8E; Wed, 29 Oct 2025 10:38:33 +0100 (CET)
Date: Wed, 29 Oct 2025 10:38:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue
 attributes
Message-ID: <20251029093833.GA1066@lst.de>
References: <20250702182430.3764163-1-bvanassche@acm.org> <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org> <20250708095707.GA28737@lst.de> <b23c05be-2bde-424a-a275-811ccc01567c@acm.org> <20250710080341.GA8622@lst.de> <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com> <20251029085810.GA32474@lst.de> <91b583c2fad9f1e72ed5dc794a709289de363a39.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91b583c2fad9f1e72ed5dc794a709289de363a39.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 10:36:30AM +0100, Martin Wilck wrote:
> Consider it a "trylock" type of operation, which is a valid method to
> avoid deadlocks, AFAIK.

Only if the operation is an optimistic optimization.  I don't see how
setting an attribute would ever qualify ﬅor that.


