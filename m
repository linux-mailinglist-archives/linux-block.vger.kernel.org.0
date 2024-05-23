Return-Path: <linux-block+bounces-7631-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D88CCA80
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 03:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF2A1F213CE
	for <lists+linux-block@lfdr.de>; Thu, 23 May 2024 01:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830ABA34;
	Thu, 23 May 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhsHcc9w"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9921879
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716429175; cv=none; b=bYxOVCS+Wvzk2rtVFFn4IONC8x33ojyTGNDRQaAa8t1j/BljHMfSQx7J5ABE/HaLLEuE5FX/RU3vaD1L4xveI5dGuEBstVYT6Cw6fG6BJ3W066YFhBTdH88MM1aTuAcCC6cQvSM3xISHJmneZVjGNg0vWanHBEv/Ydczvy/n7UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716429175; c=relaxed/simple;
	bh=rw3mIi2XQ473pNjiTeN1/fD22GkNBUJYgoxFZjQskhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+LLSCoEyaH+LxendGdkAz78GQZNOVG1UwojN5b7/H/5qj/lO3VK+aLPcgJpewBAYGJS/NuPOKSpouDaEf8rhGKsrolHCfwDDBi+LsvtUpG/mT5ylZCJi4+OTaWEZsVus7xC6F0tY5UVLk4lhZX3Dm6+VobxvTAhBG2aNjx15mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhsHcc9w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716429172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XEolw1eTofFhzFRzXVEKYI8sDa8B5zCIV0/1n4eHcc=;
	b=YhsHcc9wRpTjzrNFUNaDStvvabmiZi2/nhCPRTItoGMJulNay1EhC+992pLzu11NE6tfd6
	sK18nPatrxsliu0eTL9Sr/gcOsxxsgFX/KyCIveJnri4DkCbHBhfv9Ux0ko6uMCEQE7X5w
	zR+hZbdkwCn2pKWnaVHipuIrMlj34X4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-3giBrACxNViHk6IrkuMBaA-1; Wed,
 22 May 2024 21:52:49 -0400
X-MC-Unique: 3giBrACxNViHk6IrkuMBaA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF3B13802265;
	Thu, 23 May 2024 01:52:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.54])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E98BE491034;
	Thu, 23 May 2024 01:52:44 +0000 (UTC)
Date: Thu, 23 May 2024 09:52:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: dm: retain stacked max_sectors when setting queue_limits
Message-ID: <Zk6haNVa5JXxlOf1@fedora>
References: <20240522025117.75568-1-snitzer@kernel.org>
 <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4h-6f2M0XmraJV@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, May 22, 2024 at 12:48:59PM -0400, Mike Snitzer wrote:
> On Wed, May 22, 2024 at 04:24:58PM +0200, Christoph Hellwig wrote:
> > On Tue, May 21, 2024 at 10:51:17PM -0400, Mike Snitzer wrote:
> > > Otherwise, blk_validate_limits() will throw-away the max_sectors that
> > > was stacked from underlying device(s). In doing so it can set a
> > > max_sectors limit that violates underlying device limits.
> > 
> > Hmm, yes it sort of is "throwing the limit away", but it really
> > recalculates it from max_hw_sectors, max_dev_sectors and user_max_sectors.
> 
> Yes, but it needs to do that recalculation at each level of a stacked
> device.  And then we need to combine them via blk_stack_limits() -- as
> is done with the various limits stacking loops in
> drivers/md/dm-table.c:dm_calculate_queue_limits

This way looks one stacking specific requirement, just wondering why not
put the logic into blk_validate_limits() by passing 'stacking' parameter?
Then raid can benefit from it oo.

thanks,
Ming


