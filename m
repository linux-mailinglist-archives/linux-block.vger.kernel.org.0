Return-Path: <linux-block+bounces-5173-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984F988DBE1
	for <lists+linux-block@lfdr.de>; Wed, 27 Mar 2024 12:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F38297E40
	for <lists+linux-block@lfdr.de>; Wed, 27 Mar 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68047A7D;
	Wed, 27 Mar 2024 11:03:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA683208A8;
	Wed, 27 Mar 2024 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711537434; cv=none; b=meVgjjYEodwhVXNk36+NfXOkndH8yjUzPu11K1HuEKxraemdTmtmxWOoYVcfovK71rSSRCdQL2s+31+SzPVDq53MjANfCRhqm4oinXHShiciby/swU+nBMxQE0qCuG2n5HbooMsgFpaxYd0ksnrbeY29NYGyIDvOkgZTAxdRNtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711537434; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQKtt6X2swPNuBmCw2jB543zyLJ8rFbLapuqvpiViNNgHLo1Q/rRxHDR4BTSbW5xKHcZVOlec6WKeRaYJcyPTcUDBKuDnyRcYADIu5hiflnbn6euIOzLR1xi6o8kJ+nT68S7Ju9i8tK+JD0GnohBXwNxro3Jm7lQqjqJHhi3Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5010B68D17; Wed, 27 Mar 2024 12:03:41 +0100 (CET)
Date: Wed, 27 Mar 2024 12:03:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com,
	hch@lst.de, linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] blk-throttle: Only use seq_printf() in
 tg_prfill_limit()
Message-ID: <20240327110340.GA22053@lst.de>
References: <20240327094020.3505514-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327094020.3505514-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

