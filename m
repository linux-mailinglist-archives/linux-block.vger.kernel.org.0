Return-Path: <linux-block+bounces-26727-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98013B4318F
	for <lists+linux-block@lfdr.de>; Thu,  4 Sep 2025 07:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57A664860CC
	for <lists+linux-block@lfdr.de>; Thu,  4 Sep 2025 05:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A3023B638;
	Thu,  4 Sep 2025 05:25:42 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A3C22C355
	for <linux-block@vger.kernel.org>; Thu,  4 Sep 2025 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963542; cv=none; b=PwXDv+lAAENBcJTR6V+/vd/ReM950HfoeWQxCqeZNxMnnyc/nPJG5GrVLIh8nOR2dfANwa8oQvyyB9/oa4AwDkVCbuDj87knFuGqMdjja6iqrf/lTX+ZUYP5cF5amALzHnkKUB0KXef7S3a+8VM1JubN/HJnBW7ddV43NG5gLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963542; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXGjs4FKiTiD9XckCoRNV9AIdF31N8s4qW4AGrj6uKHR/09SItJlTG/RYyrOYP61PkLcZAhSWH+pReOsh/cQSbEoP7XN0XN5gd/khKpqgLN6k6Ah7II7Rji8eXBu6fxAxxNkmUUlwPivsTdvcPdznMPEadihalloLtu6hatkj8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0581D68AA6; Thu,  4 Sep 2025 07:25:35 +0200 (CEST)
Date: Thu, 4 Sep 2025 07:25:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-map: provide the bdev to bio if one exists
Message-ID: <20250904052534.GA27516@lst.de>
References: <20250903202746.3629381-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903202746.3629381-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


