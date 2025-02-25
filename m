Return-Path: <linux-block+bounces-17587-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3550DA437E2
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8383AE083
	for <lists+linux-block@lfdr.de>; Tue, 25 Feb 2025 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E98260A34;
	Tue, 25 Feb 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvPZh8YB"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9B25EF99
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473008; cv=none; b=CbCdbM7oAv4IxkRJP6BCpYFPCajpd2uadPKY9xr0BIYklMzz5s2POzBDskphdHgpjP2bH8fGniSWxH0qq+iIgba0snevlXI7wBAqiVkyVGqrDi6xK3UqdLLdQY7AyD8BBqHlIsUbrqVunp/YkjiwDjmIgru5nU3YPdLMEIC2Xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473008; c=relaxed/simple;
	bh=EwSkPiax2nQRrPCxpOsz0KDV78FcihwyUxTGvoGy4Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+e3FKsTSZQTQjb5kiIiDWyctWUNBEANPmqiQT0bSpOcgqqiJglJA2hzlgO5+SuJA9/0l3KK28C2hU1aw6vJEHAUyDEvB6JEQlDApFVVRCkjRgWrC5madYr3+nmVvV6qzcPoIC6HevWPhjJ9u2ZY3kMVBe2F59G5ySow7Mg1/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvPZh8YB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740473006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MiPu812lBAtvkJOlBNetdKjC9bnyjbYmyAww0yPGSUo=;
	b=hvPZh8YBZG3krZuZ358Lg5s/hb9dypwkaZbRmXP3NvFbv6cg6pgjKZFQOHrA000286Xcr6
	EUoZAq/r36tj6shV0hc8VZ3QuPfOgy2d8ti9Ae1UBzId8QZYjJzorBRDzorbn7GrSXkXdO
	xx1mD96yv5jrWaE2I+ZgJdIBIetP5YY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-ZkmL1k5kORSqIQhZvhfoXw-1; Tue,
 25 Feb 2025 03:43:22 -0500
X-MC-Unique: ZkmL1k5kORSqIQhZvhfoXw-1
X-Mimecast-MFC-AGG-ID: ZkmL1k5kORSqIQhZvhfoXw_1740472998
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7A0F1800876;
	Tue, 25 Feb 2025 08:43:18 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A97371955BD4;
	Tue, 25 Feb 2025 08:43:12 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:43:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 02/11] io_uring/nop: reuse req->buf_index
Message-ID: <Z72CmtMUuWyVNhaC@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-3-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-3-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Feb 24, 2025 at 01:31:07PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> There is already a field in io_kiocb that can store a registered buffer
> index, use that instead of stashing the value into struct io_nop.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming


