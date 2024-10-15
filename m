Return-Path: <linux-block+bounces-12587-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B876399DF67
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2024 09:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08131C2114E
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2024 07:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718F17DFE3;
	Tue, 15 Oct 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6s6YzLV"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F752AE94
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 07:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978044; cv=none; b=qqdRnJhAlW/3afkYNzuk5Cf2f9FaCIexkYfoGCDjQdcuqlUydo6RMNBy8VBV9C2vH3oDOmBOXNxBeyvzPdA8HZI6Wu4ug4eL7jWB6/n/crp+tXmX1N/4g4fz/UnGV7kYbJ2ozJ1TsXqU1BS4vhgtXuMmU0EZmgwUWNDSLsZ1LuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978044; c=relaxed/simple;
	bh=75YXEgfhVxmVvqkglTlOd3Hoon/k2wLrSm+Yrmv/aGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjqNhpB+VBeWEoRPEYs2hjRJG63LCkZmPBZusSfMsJNNwO7+zqGYQX8s2DIxqBl0f4REngWdwkthabSdz0U417XHKOrhJpPdSQzUxtOOfxeVntoFT+8l1NaTU8pDXZRag4gjKQsXOqweWivgkMF8AjdUBnrV1OOONURom8TeFKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y6s6YzLV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728978041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUM9xt7Ssqk+VrwdFomi+mdTFeWpiU/lOCyhtNFd2vU=;
	b=Y6s6YzLVCVD8Dn6MlwVKv1zptfRXd67FMqLC7UIljJThHy444UYjc9sBaez407VR5SkryY
	Otcj6gBSchCb2RHeU0kQpBW57ACk3Ns1o+RpoZ9o2PK+2a/YWlvCprI/UquADhnqbTRQaC
	45wgr/z0vWNpEkwTFktp820LzENyTK4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-m-W-4jiSMFm2x1JWriD1UA-1; Tue,
 15 Oct 2024 03:40:40 -0400
X-MC-Unique: m-W-4jiSMFm2x1JWriD1UA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39F51195608F;
	Tue, 15 Oct 2024 07:40:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D651E3000198;
	Tue, 15 Oct 2024 07:40:31 +0000 (UTC)
Date: Tue, 15 Oct 2024 15:40:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>, Hannes Reinecke <hare@suse.de>,
	Hamza Mahfooz <someguy@effective-light.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-raid@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
Message-ID: <Zw4camcCvclL4Q_6@fedora>
References: <ZwxzdWmYcBK27mUs@fedora>
 <426b5600-7489-43a7-8007-ac4d9dbc9aca@suse.de>
 <20241014074151.GA22419@lst.de>
 <ZwzPDU5Lgt6MbpYt@fedora>
 <7411ae1d-5e36-46da-99cf-c485ebdb31bc@arm.com>
 <20241015045413.GA18058@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015045413.GA18058@lst.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Oct 15, 2024 at 06:54:13AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 07:09:08PM +0100, Robin Murphy wrote:
> >>> The only case I fully understand without looking into the details
> >>> is raid1, and that will obviously map the same data multiple times
> >>
> >> The other cases should be concurrent DIOs on same userspace buffer.
> >
> > active_cacheline_insert() does already bail out for DMA_TO_DEVICE, so it 
> > returning -EEXIST to tickle the warning would seem to genuinely imply these 
> > are DMA mappings requesting to *write* the same cacheline concurrently, 
> > which is indeed broken in general.
> 
> Yes, active_cacheline_insert only complains for FROM_DEVICE or
> BIDIRECTIONAL mappings.  I can't see how raid 1 would trigger that
> given that it only reads from one leg at a time.
> 
> Ming, can you look a bit more into what is happening here?

All should be READ IO which is FROM_DEVICE, please see my reply:

https://lore.kernel.org/linux-block/Zw3MZrK_l7DuFfFd@fedora/

And the raid1 warning is actually from raid1_sync_request().


Thanks,
Ming


