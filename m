Return-Path: <linux-block+bounces-6793-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D38B8475
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 05:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8421C213DB
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2024 03:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512EB249FE;
	Wed,  1 May 2024 03:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjxmyO7d"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC34A1C69A
	for <linux-block@vger.kernel.org>; Wed,  1 May 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714532848; cv=none; b=IbPA1Ea2U+81Rui/bdpBxmJZLfcKBVRQs0t1GQDvy2A3ARErI1Ljjs3kUwFn55BTQDOyowMJhyfEJmGXc2l9E5mkLJhCM8ps8FOXKMtqauJhahtL283Fbne3yiEu3MHKaJ1fXGtqttukB563lppaFw50WZBdI6lFqbHN7tY4N8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714532848; c=relaxed/simple;
	bh=wSUc2FwTDfPPE6WP4CvvzO1/ZMAEYZ9j5bVuglWkl4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATGC4CJeQ0Vcj0e/TzPtkY7usTbx7dQDguNU3KYtrue1SLX/AN+dPSJD6ZGl5McXvSD6AdOjWUjSES57Wu6On742NDKattEz4Bhlm/6RYaoVPsfPijS5c8lj8ojK8Vy8vduFKTj7mAhIDDHltgQs6XXNEOacVfZkciO+DVkdcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjxmyO7d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714532845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sju1Ab7ZCysbObAJ/nrqrXkGolEBNJ+eeY6KCDXLgHs=;
	b=PjxmyO7dlM/qExEArKps7prwnIozLcpplsaEg3trIDYbSIKGHiaeNsbFdupD1+87ytNdJo
	BwbhugiMkP4EHMwSyWWc8OZE5j4gNiMJqC/5fFdXyzxCazQFvn9QnxZhLMCYEEg5JYP9Z7
	eIR+W9H0CEe6SBdVGEvZl6UXdgxBuuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-AFCjJW5APYaMUdWysAPCOA-1; Tue, 30 Apr 2024 23:07:22 -0400
X-MC-Unique: AFCjJW5APYaMUdWysAPCOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D1831011A14;
	Wed,  1 May 2024 03:07:21 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D73DA202450F;
	Wed,  1 May 2024 03:07:20 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1) with ESMTPS id 44137Kom2345106
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 23:07:20 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.1/8.17.1/Submit) id 44137Kcx2345105;
	Tue, 30 Apr 2024 23:07:20 -0400
Date: Tue, 30 Apr 2024 23:07:20 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 01/14] dm: Check that a zoned table leads to a valid
 mapped device
Message-ID: <ZjGx6EpCIx5QnmT5@redhat.com>
References: <20240501000935.100534-1-dlemoal@kernel.org>
 <20240501000935.100534-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501000935.100534-2-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Wed, May 01, 2024 at 09:09:22AM +0900, Damien Le Moal wrote:
> +static int dm_check_zoned(struct mapped_device *md, struct dm_table *t)
> +{
> +	struct gendisk *disk = md->disk;
> +	unsigned int nr_conv_zones = 0;
> +	int ret;
> +
> +	/* Revalidate only if something changed. */
> +	md->zone_revalidate_map = t;
> +	ret = dm_blk_report_zones(disk, 0, UINT_MAX,
> +				  dm_check_zoned_cb, &nr_conv_zones);

Aside from not really understanding what that comment is getting at, it
looks good.

Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>


