Return-Path: <linux-block+bounces-20689-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A280A9E330
	for <lists+linux-block@lfdr.de>; Sun, 27 Apr 2025 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A228A17BAF1
	for <lists+linux-block@lfdr.de>; Sun, 27 Apr 2025 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA2158545;
	Sun, 27 Apr 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtvar8yG"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFA84A35
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758908; cv=none; b=WmGAdN0+zRAd1/mJ4HSloa9kme/XW8gGrR3fRxFwDxiK+UwM4R6o0TrqV2QluNtupW4EOSNwVgWoaH3Q63Xl2OLPTbO9knRvwpe/kc0/0QovRWcAivcU2VDNWMkTyL6lnKzxRGQ9qhjBWXJEEXpk+v+aC7wAfGe+AVkSpLlYr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758908; c=relaxed/simple;
	bh=ZglE8CasNQkRyZwqQ07x19uhJCcBvo7NtP6MxqxWpbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WczCqJGwcBOfbTWPKXSEnkP8aJOUdyfJoTYCtfsEs3Oohl2gRYwFdVlQ52l/JnlbrPg1WNDyIuzwZr2Gs8izOYUqjBKxrQOfyH33pMLwBeMDrDg28cEiBx8pJQUjgYPzE9HgQzftCuOlQitLcOpDAKkT2OmioEG8lEBzRJYfTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gtvar8yG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745758904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XBmV6ADRgSJ8LWAWXhID2kwENoWgHwUt/9lB9Waom7Y=;
	b=gtvar8yGl1x2VebaixxyOewjXYLxvF468KaXdnVjFUFepL+JgRv9WSpl+nI6jS/wMMmuok
	kr9o7nrlwz5ImKz8jgkz2BFPTtTN+fA5+gW0DYr16X3/G20a/TjunrZRe9qU4+KbCCSThp
	hpPXMtvBGVyFKcv8l1GOmsMRnLS1IbE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-kXjJx-vhPeaIZojRNwztHQ-1; Sun,
 27 Apr 2025 09:01:40 -0400
X-MC-Unique: kXjJx-vhPeaIZojRNwztHQ-1
X-Mimecast-MFC-AGG-ID: kXjJx-vhPeaIZojRNwztHQ_1745758899
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0AF0195608A;
	Sun, 27 Apr 2025 13:01:39 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17FA3180045B;
	Sun, 27 Apr 2025 13:01:35 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:01:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] ublk: remove misleading "ubq" in
 "ubq_complete_io_cmd()"
Message-ID: <aA4qqwHaEM42pzN_@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Sat, Apr 26, 2025 at 10:57:58PM -0600, Caleb Sander Mateos wrote:
> ubq_complete_io_cmd() doesn't interact with a ublk queue, so "ubq" in
> the name is confusing. Most likely "ubq" was meant to be "ublk".
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


