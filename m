Return-Path: <linux-block+bounces-3646-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFC8619EE
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124D5282787
	for <lists+linux-block@lfdr.de>; Fri, 23 Feb 2024 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E6143C6B;
	Fri, 23 Feb 2024 17:31:01 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2C13EFEC
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709461; cv=none; b=prQo7NT2Prh3Xv0IA88CXOKC5PtLDXoH1PnrFzNuep6FFpXavQp8k4VlAfhjWyaVMhg/MqfrNWrezKownml/Og0oCD+JEY7S8umMMWlzoex0cnk8OPOYTVmMn9yohcpehEapMOEcb9WfQVjtfowEwAQidZ/KWTRRFsScC6hCScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709461; c=relaxed/simple;
	bh=kk9USHa3Igm+4RJya8josHopx6Qb1FmJAPmqrV6cP8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfoaO9CIx0h5iiZPUG17BeknV9x5jXBtQ+Vypg5PiBVSew7FPQ8QBhnb1Sce7M72NNeAfyFB1KkIEFPjY3KjnWQkJO4QfFWJSQkopD48cPqNLfyU3j0mKVPER0dXHPnGX/w+AWU0AgK8O0MSAYfTMKPtdHzOfcnV1FYugi61CJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-787ac650561so56969385a.3
        for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 09:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708709458; x=1709314258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVdmESG4PxkwASoqLragfY2GZJ2QdcB8GuhgUXgWRzg=;
        b=WrBdOlGEdWwW1PjCNioCxKQ4ii3KHtBRrftW2MYPH+sqKBNP3ZjC/M/8R2EMtQQNdq
         4TPCmUJAq/IiN+LZlOJyvMsj4ifsXqVaXaZZ4bFvXb5c7xqBrLV7NDQv794B5SnDsLi0
         wkGTorr25laaqPcypRu17nvdsKq3ZSnRgr95w7ORFYpZa8rr8TZou5oPtACkcoFJfZJq
         mF6MTW2fhxfXKIM9HoA2/48YFKQyA9XmdE8WtDHoHMB2VBEIhbNNiAg5bJUtIJ9kgjbE
         FePEazOC94fJL+GOFcO4y5rNEgr+K7P2mKqHQ9O5pTVLr5hhi1St0Iqr+rOgXvGJA9kH
         qn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/zDXfgon0wQu+GpvZpFiC6Ila5CVWCr74WerYchJfGsJ316MTXV1TsfcgGpx3Xx7KLK4H3OjVfbeU6+bzNmhWFfShyE3Cxd/644U=
X-Gm-Message-State: AOJu0YxJ1L12rLnoUYoc2944zQO+ObwqyAzT7z6GtVR3LocgfcUYy8QR
	Wy/zuRlgaTr078tmA9LgZ5jV80Cex9d2LSGX0GhqR93BU/nmMv9QIda2IIv4tA==
X-Google-Smtp-Source: AGHT+IEiN2DRNfZ9o9l6t4npd0H7WRs0vXB44XzHTTVVeoGiXBOzkyqAnD2/8Y1Y40PYCiOWrBICOg==
X-Received: by 2002:a0c:e113:0:b0:68f:3452:584 with SMTP id w19-20020a0ce113000000b0068f34520584mr377462qvk.59.1708709458689;
        Fri, 23 Feb 2024 09:30:58 -0800 (PST)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id nw5-20020a0562143a0500b0068d38023e35sm7035400qvb.112.2024.02.23.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:30:58 -0800 (PST)
Date: Fri, 23 Feb 2024 12:30:57 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH 3/9] dm: use queue_limits_set
Message-ID: <ZdjWUdwrwmPT0mX1@redhat.com>
References: <20240223161247.3998821-1-hch@lst.de>
 <20240223161247.3998821-4-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223161247.3998821-4-hch@lst.de>

On Fri, Feb 23 2024 at 11:12P -0500,
Christoph Hellwig <hch@lst.de> wrote:

> Use queue_limits_set which validates the limits and takes care of
> updating the readahead settings instead of directly assigning them to
> the queue.  For that make sure all limits are actually updated before
> the assignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

