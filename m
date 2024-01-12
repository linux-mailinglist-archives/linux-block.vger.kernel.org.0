Return-Path: <linux-block+bounces-1798-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E5E82C3E1
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB2B1F24122
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0086D7763A;
	Fri, 12 Jan 2024 16:47:00 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B46DD08
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7255868CFE; Fri, 12 Jan 2024 17:46:47 +0100 (CET)
Date: Fri, 12 Jan 2024 17:46:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: ensure we hold a queue reference when using
 queue limits
Message-ID: <20240112164647.GA16766@lst.de>
References: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <575be19c-01f4-4159-874b-d1e5dcbdc935@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

