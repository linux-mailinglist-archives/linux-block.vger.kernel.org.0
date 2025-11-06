Return-Path: <linux-block+bounces-29803-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4629C3AC0D
	for <lists+linux-block@lfdr.de>; Thu, 06 Nov 2025 13:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA746624B
	for <lists+linux-block@lfdr.de>; Thu,  6 Nov 2025 11:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D42A3164AF;
	Thu,  6 Nov 2025 11:52:05 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68D30DD3C
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429925; cv=none; b=S7BaP0M9msRJKj7pdVELDiJkqYIdMsEChEkFQkVxprSy4z0BjTtPtZSQbIQMXPA/gxKj4A06cpQ7DpkTbMae4d2/EbKVycxnBEnzPwZBBD/baYYvlQo5+RyuBeuzAJJHjsMNNy9tgEwhqj+s84nIlW1QFJq2LykLIpzXdc++pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429925; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyMOFANDL9WATNLpy7kLaiQeqiR+TgTAuBmTpFO97wjg9Yeq9vI3WxYlF2uPM2h/6UVr7HofSo/zudTkFpdDWMCSv98gCWxsZ0cKZPtQ4gUBB3kKrpTGByD9q+l1ykz2HKOFzevp514MQXjt+Wg4FbhiSB8o/9FXlRVNYoCqZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53DB7227AAE; Thu,  6 Nov 2025 12:52:00 +0100 (CET)
Date: Thu, 6 Nov 2025 12:51:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	dlemoal@kernel.org, hans.holmberg@wdc.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/4] null_blk: simplify copy_from_nullb
Message-ID: <20251106115159.GA2002@lst.de>
References: <20251106015447.1372926-1-kbusch@meta.com> <20251106015447.1372926-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106015447.1372926-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


