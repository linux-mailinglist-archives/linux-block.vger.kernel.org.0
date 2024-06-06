Return-Path: <linux-block+bounces-8386-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A998FF55C
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 21:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EEB28306D
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2024 19:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645D54CB4E;
	Thu,  6 Jun 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/TKeurw"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5653F9C5
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702826; cv=none; b=MRPzKzG5fKEtH6XNOEP2EAo6nlDASGHy9NQaTLUwzCtGg57n2GMTa486KdD1zr60KDf7p7dTR27AjM/02lYH9VIWRGE3hHBKaOebfzLiwbEriwN1C16rlIQ5F+YEPnYBkg4z6eYGv4m2PECr95t8TAXKJw36B1jVXDPOdXIZHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702826; c=relaxed/simple;
	bh=vdDPgOETrlIUEHKIjDm7sqX4QOdjEmevinvwmI0xP0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRfU9lX7haRRrjh8zJ+H8exMwwleqXKJGctH6MF5DA25ZS526lRIAZCrZv5xW2gGIBIHm3Bo5nMt6ulMXfw0nMGYqhHuak9sZA7fZiqveemsgMoqaaxFkn78KdIx36Q3O7d3wHtuzwoOtFJ5l1oIwkJYm34INHPFU0SRQQrHqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C/TKeurw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717702823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdDPgOETrlIUEHKIjDm7sqX4QOdjEmevinvwmI0xP0U=;
	b=C/TKeurw/ieRX2nfkkW7YCho+6l1gzVYVPmn2peRG9gpdpptCa7BkIylUe4Uxwho6wTFkI
	koEtfGzUpMbIJBlisomQH4OMCXicUuc+DfpqAfVkQ5gpkekTXv5FOAA6g8bJaxv5Fm0fkP
	T2PQdiHolmyMDNYup9dI2T0BHiLBgBY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-_Odv6JU0M0CHFzP4gWpPlw-1; Thu,
 06 Jun 2024 15:40:22 -0400
X-MC-Unique: _Odv6JU0M0CHFzP4gWpPlw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66673C025B2;
	Thu,  6 Jun 2024 19:40:20 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7397C111D7A0;
	Thu,  6 Jun 2024 19:40:20 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.1) with ESMTPS id 456JeKkN653065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 15:40:20 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.17.2/8.17.2/Submit) id 456JeJIv653064;
	Thu, 6 Jun 2024 15:40:19 -0400
Date: Thu, 6 Jun 2024 15:40:19 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 2/4] dm: Call dm_revalidate_zones() after setting the
 queue limits
Message-ID: <ZmIQo9B9h3vLHs1c@redhat.com>
References: <20240606082147.96422-1-dlemoal@kernel.org>
 <20240606082147.96422-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606082147.96422-3-dlemoal@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>


