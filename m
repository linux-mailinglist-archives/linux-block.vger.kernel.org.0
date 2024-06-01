Return-Path: <linux-block+bounces-8045-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B278D6E08
	for <lists+linux-block@lfdr.de>; Sat,  1 Jun 2024 07:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328AD1C21238
	for <lists+linux-block@lfdr.de>; Sat,  1 Jun 2024 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2FB64B;
	Sat,  1 Jun 2024 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJc4xUy3"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005B4C8C;
	Sat,  1 Jun 2024 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717219555; cv=none; b=Udl4h2/bwm9ZevGSmtcqELerA12/VPHaEkus1OalIU8mPdyMnQRvFlMKlH0NEzaz9lwmxvvk1DsVinh1EcY2Job2bE4BRTkLc+oA1nMoQWyU+EB7cQUMZ5dVqY00Wq4JLCe3sN9fuzao2pMqgLQDM2eA2bdsIwetpVhvj/lwLqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717219555; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvNcnvxCci/KittRCd+p3SR7k4v7UmbubOqYZkY4rnLX0a5C6UJPx/rnJkrx+wPQR3GxAReABio9dA0wyEWhA39ezTk3abNURaLjqr89eYM0Mam/t7mDtkhzpiJOQ+vvXewlOnQb/iERD3kOqR5jw+yBOmf/u3pZxFkcwpCd95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mJc4xUy3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=mJc4xUy3AyXVzLrhojTUCSpwD4
	jWb3swk0YRtvZ3VniuFY6qGtlaIZdw2TVPnAx0wBDR6z27n3NuEhYDo+ABDjezY5Hq0qpnQVwGDvg
	pwi29L2ebvyegYmuuE/GdAsXnh3CRMoRkkSRzoDXElEpThGpJkSWu3N3zQqa3sWaAfSXysSTq/4S4
	JuBdxgjuPV6V1rFEatr7zPxWF9lYArHA5txs52FG+EUUWdAPW+M/myEg+q5bgDtJXFAn/mdgwb1vF
	7+dcgFrEwnlHBjtOoiO+CHJhv2k2iskZn31NFyyWSy/dnl9ku0o76CPbqGG0u56ef7Bu9tOpHT9Da
	BB/7dThA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHFY-0000000C0P5-2lTo;
	Sat, 01 Jun 2024 05:25:52 +0000
Date: Fri, 31 May 2024 22:25:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH 1/4] null_blk: Do not allow runt zone with zone capacity
 smaller then zone size
Message-ID: <Zlqw4ChWx341QcXR@infradead.org>
References: <20240530054035.491497-1-dlemoal@kernel.org>
 <20240530054035.491497-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530054035.491497-2-dlemoal@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

