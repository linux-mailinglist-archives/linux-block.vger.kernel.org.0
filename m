Return-Path: <linux-block+bounces-20688-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B99A9E327
	for <lists+linux-block@lfdr.de>; Sun, 27 Apr 2025 14:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92890179D23
	for <lists+linux-block@lfdr.de>; Sun, 27 Apr 2025 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1E542AA9;
	Sun, 27 Apr 2025 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSzWxPhi"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5592210942
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745758715; cv=none; b=IFp0S/wZdD0QxIHiwk5bIouh+kjipOacE1gc1N3BRdUSbg57gtLvEqxOdsDtsHX4DY1vfWXorP6Q8hqVWAeYnhREAQbbyjeF2E3MZyqPbHmgx02L8kJFVFkvWrjjw/NaSDnDVYDqzyrP3zET2+B7hC/Z4olBEJ1LCcupmKgN1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745758715; c=relaxed/simple;
	bh=LuIU5a4+RaKhmxjmGZ/A3rHG2uBu7Z2ONKOEnOeInjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovmp6Z/PsIY5w0QsSmj3rLHvs6W4IXFYkHyZJpgqphX6DdCl3YMGLjWH0bPlvB/L5kHTuzx2dBejeJU0tDaojPngahkA1sdtz7CT8jp2uJataamzRIjhKvaxssK226s8pXFoExV8q5vV7ptwOC70sJqM8MpfJP41Sn07o4oBLX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSzWxPhi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745758712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iWgEc8ufAgptgVygRVS205l4twTMcaOQPmrxzOh7Ubw=;
	b=HSzWxPhigFHyyPypIxlKsU897x90DXYJ5qGr16prIvKbSdSSEp8lwwZup8ycjC1NtH2CUo
	+29LjWkvIHdtZQY+4KL6UXRpP1el5dZnhmtX2yxVhxeYU4Qh3nhDNDcx8GeWgJf5gMdpp3
	PtNI22f54Te7IcMZEC5XA7xqce3T5H4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-8wBr4P9XMGuY3BAiGqhvaA-1; Sun,
 27 Apr 2025 08:58:28 -0400
X-MC-Unique: 8wBr4P9XMGuY3BAiGqhvaA-1
X-Mimecast-MFC-AGG-ID: 8wBr4P9XMGuY3BAiGqhvaA_1745758707
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CAFB180048E;
	Sun, 27 Apr 2025 12:58:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5A3A195608D;
	Sun, 27 Apr 2025 12:58:23 +0000 (UTC)
Date: Sun, 27 Apr 2025 20:58:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] ublk: fix "immepdately" typo in comment
Message-ID: <aA4p6n7eIX9-fhAM@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sat, Apr 26, 2025 at 10:57:57PM -0600, Caleb Sander Mateos wrote:
> Looks like "immediately" was intended.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


