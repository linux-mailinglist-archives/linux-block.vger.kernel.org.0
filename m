Return-Path: <linux-block+bounces-853-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9E080844D
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 10:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7751C21F6C
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720E2125B7;
	Thu,  7 Dec 2023 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDedERFd"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984441FC3
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 01:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701940904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ysmw6UsiKHy2gGS8u+9DI4BFMvU33orVcIVubIvVg5s=;
	b=VDedERFdLWPuYlS7c/JrFoSsspGmAsYzpeyMvEqh0Nuetx73GXjxPBwDZEY2Qt7tSmkRBT
	vNQ9Eor0dBbu+1Qb3cyVQrlGevAGmWZWcd4uPQN1ogTc3OndtKRIvRojDFuDiHjulqEL85
	NywlssX7luFCWUPP0azTPQ59hHY98Vs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-487--sXTltJoO1S9YMAfbcK0KA-1; Thu,
 07 Dec 2023 04:21:40 -0500
X-MC-Unique: -sXTltJoO1S9YMAfbcK0KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9FE93813BD2;
	Thu,  7 Dec 2023 09:21:39 +0000 (UTC)
Received: from fedora (unknown [10.72.120.10])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A42240C6EB9;
	Thu,  7 Dec 2023 09:21:36 +0000 (UTC)
Date: Thu, 7 Dec 2023 17:21:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: Add documentation for bio iterator macros
Message-ID: <ZXGOnE5vEZw8sFsu@fedora>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231122232818.178256-3-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-3-kent.overstreet@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Nov 22, 2023 at 06:28:15PM -0500, Kent Overstreet wrote:
> We've now got 3x2 interfaces for iterating over bios: by page, by bvec,
> or by folio, and variants that iterate over what bi_iter points to, or
> the entire bio as created by the filesystem/originator.
> 
> This adds more detailed kerneldoc comments for each variant.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: linux-block@vger.kernel.org
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming


