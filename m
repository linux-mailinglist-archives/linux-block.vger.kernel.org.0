Return-Path: <linux-block+bounces-814-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D835807F9A
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 05:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2358B20A56
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 04:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9EE101F5;
	Thu,  7 Dec 2023 04:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oDUUFt1f"
X-Original-To: linux-block@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660310C8
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 20:31:37 -0800 (PST)
Date: Wed, 6 Dec 2023 23:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701923492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W1UdbO3j7o3P3hR6C+3bDAPYg7BZKWXWFTBRUWw0djo=;
	b=oDUUFt1fAlzbKquS6eMWSPo1pFqGGWNjYGBqHJ30g6OZ5vx8ay510Q9E7YknP2rUCn8HzO
	twlXhVnHDsTKLOUplgl3K04R6WtR8zd2L5TPZK2AVMhchuRZ54OpVNIlsoaTM+l4SA/lrh
	U8yb+LqO/d6wHtLKSHfVfqtMy7GvCcg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-cachefs@redhat.com, dhowells@redhat.com, gfs2@lists.linux.dev,
	dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] lib/dlock-list: Make sibling CPUs share the same
 linked list
Message-ID: <20231207043129.cswpxpwow43b35lj@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-5-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206060629.2827226-5-david@fromorbit.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 06, 2023 at 05:05:33PM +1100, Dave Chinner wrote:
> From: Waiman Long <longman@redhat.com>
> 
> The dlock list needs one list for each of the CPUs available. However,
> for sibling CPUs, they are sharing the L2 and probably L1 caches
> too. As a result, there is not much to gain in term of avoiding
> cacheline contention while increasing the cacheline footprint of the
> L1/L2 caches as separate lists may need to be in the cache.
> 
> This patch makes all the sibling CPUs share the same list, thus
> reducing the number of lists that need to be maintained in each
> dlock list without having any noticeable impact on performance. It
> also improves dlock list iteration performance as fewer lists need
> to be iterated.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

We badly need this done in a more generic way. Besides shared caches,
I've done a bunch of percpu algorithms where "amount of x stranded on
percpu lists" is a major consideration and this would be preferable over
percpu lists (including in fs/aio.c).

