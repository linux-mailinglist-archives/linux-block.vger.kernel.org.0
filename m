Return-Path: <linux-block+bounces-2117-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C15CB8386B5
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 06:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9D91F23ECB
	for <lists+linux-block@lfdr.de>; Tue, 23 Jan 2024 05:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613A4C67;
	Tue, 23 Jan 2024 05:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1/1nptH"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6FD4A3F;
	Tue, 23 Jan 2024 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705987622; cv=none; b=FBHCMmEwsQxL+voNFqbpsrbybUXjA0S4duq4Aq14dq7S1cR6Hx4HbOeFGDMwBkRBzcVzWWlGT6+F/8YElJAvuwlRRUJBK/Q+tepzDU1MhQe4RqHvCctN0lVa/vqU0xnfnqoufQ8JIHQfY4pjRahEjsJ8mPp9lh2eIh18OnFW1UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705987622; c=relaxed/simple;
	bh=rZlc/7iOpLCUjkjY0UJb5UkzbDeUBBdx2FDLEIZEjaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atZlqmvqQd/u/j0EW9O7MtZJupHyh/l3ZbZOWiD/tJMkd64ek7LA0lfbKcerOZvYMyYgJxSObHQvT06xlDJV7meCP9hyn2uqk6fjF5waLavds7eXbGhV6Y2AX0tNrQMuSw7vhyi2bVUe2hIW5kH7SyCtRqSWPrOkusPqFukQeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1/1nptH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F45C433C7;
	Tue, 23 Jan 2024 05:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705987621;
	bh=rZlc/7iOpLCUjkjY0UJb5UkzbDeUBBdx2FDLEIZEjaw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m1/1nptHwu2bz0rUt6GQk6T4dHLgUD6tXHKAITk89vrD+SNDqE1KXCKBy97Pr320t
	 a/ygkWf9KP5PcxTxqQywtFdlLq3968658zMZknlLho7M8UwKDuTK5DomcP6ywI0bDc
	 fFm7L1HWbjNoHqhp6JvouV8LxevD3km4/+gLRtr7WVojnoA2cobqAuIbl6LbHcJREW
	 kqawMBi4nrTp4XgtbP1IEODSR+tMKqQ0XW59w4RWvqlKhHgQOLUIqEV5TVdEiE2JPg
	 XLaGhRl3hrw+hQkFWI9dRSDnIA6fGaWBvFlsDMWA6zvck0SU/fyfDBNYoPbiL6BM+m
	 rX7ZKixe0Gadg==
Message-ID: <13cbd5e0-d690-4407-9718-cccc6ff94661@kernel.org>
Date: Tue, 23 Jan 2024 14:26:58 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] virtio_blk: split virtblk_probe
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-12-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122173645.1686078-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 02:36, Christoph Hellwig wrote:
> Split out a virtblk_read_limits helper that just reads the various
> queue limits to separate it from the higher level probing logic.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


