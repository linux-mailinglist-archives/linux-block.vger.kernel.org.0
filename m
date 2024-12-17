Return-Path: <linux-block+bounces-15417-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1C9F41B0
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2024 05:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5440416760D
	for <lists+linux-block@lfdr.de>; Tue, 17 Dec 2024 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE961FDF;
	Tue, 17 Dec 2024 04:21:40 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359F20EB
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409299; cv=none; b=H/nt/hIHfXHivhNtELHu9a9EGzScL8lq+4P5Tn8GZXJF3DW6HWJfjoPAK1wRZCSbM3lYp31Ue+84uH7K3hgiN9WMKVEfy/mmPED0BqGJ6jmhi/tP5/n9W50BNOiRLEW6UArqtrRe6Br5pJ13k2E13xFDpUhz3dgEAA/yqhc+zZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409299; c=relaxed/simple;
	bh=PgMQI4cGveAGR4X9R+5oAU60Vf9KiwSuTro/JA7UUTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw7N3Bo6Vf/oMb4jbbuTJU+s9AYLODtcIsKTUXO2xKb+SMJmOImUmk77b29umR+Z2ejxwKKasITCxU2Q5sZSjCv4fiyM1mxCGfcc6ZXQufR0feuZ4z3ArdHfsoXkSKBzTqV1ZpXTlPFdtEnKxgOnx+eXvR2ktzyO1PrQQ6FHDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD47768BEB; Tue, 17 Dec 2024 05:21:34 +0100 (CET)
Date: Tue, 17 Dec 2024 05:21:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 3/6] blk-zoned: Document locking assumptions
Message-ID: <20241217042134.GC15358@lst.de>
References: <20241216210244.2687662-1-bvanassche@acm.org> <20241216210244.2687662-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216210244.2687662-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 16, 2024 at 01:02:41PM -0800, Bart Van Assche wrote:
> Document which functions expect that their callers must hold a lock.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


