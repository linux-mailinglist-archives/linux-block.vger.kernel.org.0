Return-Path: <linux-block+bounces-18949-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91DBA70F4C
	for <lists+linux-block@lfdr.de>; Wed, 26 Mar 2025 04:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16ED67A54E6
	for <lists+linux-block@lfdr.de>; Wed, 26 Mar 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B94E15B546;
	Wed, 26 Mar 2025 03:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eA9I/XUd"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB10E156236
	for <linux-block@vger.kernel.org>; Wed, 26 Mar 2025 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742958538; cv=none; b=eDt0ysbRICVKUkE2rZeAP1Z9clxUYNr86w32mHHPyF3YZPlaVU4KGy3uPH9f4sE9VufHLp6bHlZVfJV/eNf3tejgos4Iqs8U238NVorsoXHEy9arRGXcKNGOnoYfHNh1yDjO3yizvzNOT0a8YjVfImpTdRw7rYtqPB3bHaUctPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742958538; c=relaxed/simple;
	bh=JxMAH3fEf/dJeU9yku6nmMkKjIOiN2tGQV4Byl5vRnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyCHvx+JhaNx5jEw3LBLyZkdOcH9X0u7J7Px1XTOAohWN1XJptmHKOSCJPPU1+XQAFwY//iDlVJcZVQVjrd/FQDUec+5XswNexuet7XvPn2H29UFNubk0x5HUHhOHxNs1TwUHgjGMHUgHCp5Bis+fPIbAr17U4nPrUG6iLlonr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eA9I/XUd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742958535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t+YQ41MzT7Qo/WV4Xr3JF55HUBxUNDHByiLu3RRvc7c=;
	b=eA9I/XUdDA0z3iE4Pi+Tzu7lSXQMOFrshN1vDeaYfEj6uhm7E1BxAh8po5dLLb39Tw2a8C
	IOhq7rI+twm6yI88CEM1iPeqK07iYk0TPyUoQv0Zm9Q0xexiOqdxg3axjGqrsp4jpskLBQ
	AB+21NImiXrDyPnN2dARISQIPOJOUAo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-L9KAD2hxMpewu3PHSXp-_A-1; Tue,
 25 Mar 2025 23:08:52 -0400
X-MC-Unique: L9KAD2hxMpewu3PHSXp-_A-1
X-Mimecast-MFC-AGG-ID: L9KAD2hxMpewu3PHSXp-_A_1742958531
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C54D619373D7;
	Wed, 26 Mar 2025 03:08:50 +0000 (UTC)
Received: from fedora (unknown [10.72.120.18])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 887F419560AB;
	Wed, 26 Mar 2025 03:08:45 +0000 (UTC)
Date: Wed, 26 Mar 2025 11:08:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] selftests: ublk: kublk: fix an error log line
Message-ID: <Z-NvtjsGBb_O5QvI@fedora>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
 <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325-ublk_timeout-v1-2-262f0121a7bd@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Mar 25, 2025 at 04:19:32PM -0600, Uday Shankar wrote:
> When doing io_uring operations using liburing, errno is not used to
> indicate errors, so the %m format specifier does not provide any
> relevant information for failed io_uring commands. Fix a log line
> emitted on get_params failure to translate the error code returned in
> the cqe->res field instead.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> ---
>  tools/testing/selftests/ublk/kublk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
> index b17eee643b2dbfd59903b61718afcbc21da91d97..ded1b93e7913011499ae5dae7b40f0e425982ee4 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
>  
>  	ret = ublk_ctrl_get_params(dev, &p);
>  	if (ret < 0) {
> -		ublk_err("failed to get params %m\n");
> +		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
>  		return;

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


