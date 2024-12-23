Return-Path: <linux-block+bounces-15687-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37239FB4A9
	for <lists+linux-block@lfdr.de>; Mon, 23 Dec 2024 20:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546BE1882D7F
	for <lists+linux-block@lfdr.de>; Mon, 23 Dec 2024 19:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4E28DA1;
	Mon, 23 Dec 2024 19:27:35 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FE9161328
	for <linux-block@vger.kernel.org>; Mon, 23 Dec 2024 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982055; cv=none; b=NwKvJkQZ1wHqdbwiH7/amGhPiGTeshTZlLqGi/jI5ZMJd2dtdM+VdjdMrIc69nvE8u14tNyxmtvQHRpkUoJtYMIJCpU03fprhSX5utZ/aCS8x6qtjD8WgyTDEIQsUvpPfeXujMU4EDhZT9cUp6GSOPRCR2MjgCzPkHhwlvXrksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982055; c=relaxed/simple;
	bh=82gfVtStQgffuGUiMk19rsaK8mRJjdACd51KvzPULK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQpycqgvXdjESb9HMJVUZDZT+jy7OeZChsRpBZl4YGgj3GkjXkshI6/BDU/9Tny+K5XZ/pIYpSqdizt/htPi2SAq4rICf9yrmNI2QQDnWJKKrSSRt8hkrlKR1KXLwowpwJjVUMiL09XZyPH0QpAA2RMPnz/r9r8lVdEJcFon1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADBF268BFE; Mon, 23 Dec 2024 20:27:27 +0100 (CET)
Date: Mon, 23 Dec 2024 20:27:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] block: Use enum for blk-mq tagset flags
Message-ID: <20241223192727.GA21363@lst.de>
References: <20241223104153.857953-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223104153.857953-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 23, 2024 at 10:41:53AM +0000, John Garry wrote:
> Use an enum for tagset flags, so that they don't need to be manually
> renumbered when modified.

They don't need to be renumbered.  Sparse bitfields work just fine
and are a lot simpler and cleaner than the indirection added here.


