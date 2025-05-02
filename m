Return-Path: <linux-block+bounces-21067-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C151AA6AE1
	for <lists+linux-block@lfdr.de>; Fri,  2 May 2025 08:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EFF3B5017
	for <lists+linux-block@lfdr.de>; Fri,  2 May 2025 06:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57ED265CCF;
	Fri,  2 May 2025 06:48:48 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27BA265624
	for <linux-block@vger.kernel.org>; Fri,  2 May 2025 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746168528; cv=none; b=bG60Gdo1MESIjGV8Xvjjn5yIPdGKpaUpIW+CyWBU17jxlkvnRyItUbD89BT8b0AQwHA1WTOOgvQcxkHRDXsizcHEScXSSgImCN3ucL3hBQFH8IKTe8iWSoL/wxynph5g2Yj+Hnd2iett2BiKds+y9IQSj2TZNWKBrSI/gId30mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746168528; c=relaxed/simple;
	bh=qUnmZUPpc8Z6KfGuH4sKB7fapZ7UD46ppB7xYzdk4Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWLs8uBS53B23c93PpmwMeK1lhAZaSIZBeiXuRXDlzXBcmdOt5yYYgUodr+LwVbhyFv69rTIi5wMtEKA1mGcOAzAGxHvtzFwgv70qE9AtoRUx/pObILp7k/opWNsXFwPkFYdtU1bfdjLHfOQQ1QmyBwq7ys0g8YGliJ6b0pBqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 229F968BEB; Fri,  2 May 2025 08:48:40 +0200 (CEST)
Date: Fri, 2 May 2025 08:48:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH] block: use writeback_iter
Message-ID: <20250502064839.GA8185@lst.de>
References: <20250424082752.1967679-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424082752.1967679-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Can I get someone to review this mostly trivial patch?


