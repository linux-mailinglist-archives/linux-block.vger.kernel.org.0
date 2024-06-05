Return-Path: <linux-block+bounces-8242-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858668FC3E5
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 08:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 014BBB28FEA
	for <lists+linux-block@lfdr.de>; Wed,  5 Jun 2024 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663926CDB1;
	Wed,  5 Jun 2024 06:45:29 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9050A6D
	for <linux-block@vger.kernel.org>; Wed,  5 Jun 2024 06:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717569929; cv=none; b=tQDOEsXBkSubur/pQ6FYHqz24OAtH6tiQoNeiMjbjQjNQfAVdqywe68PO1bhmmfMyKBPYi52XjZO2WBTHSkF+94bPFV7Ib8BXOnE3x7JeoaUebao9FDOJYRoIjwrP3QK45CZRF8P2JdWop6mCCxIoxV3ktF9oPjbgbGldb6N9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717569929; c=relaxed/simple;
	bh=6hgMr2Q8lRZny41unKTXN1/Y5JZ8e/7bs+VvnieYnj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8LAQaoyfE8K59b9w8DBAQiJDaqHPhFRWUxNaPOHr28F1PmVQrsvICsyfpYCDIEP7GbKH5dVN0/nFpZ6kP+3IIDKWfxNpmkxNV82nlaqx7zmNGd7gipgMUtrG6noyZFaE2/iInSXtOglC3U4qwf7Q26sG2avkdL4/CWaa7YAaK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A85768D7E; Wed,  5 Jun 2024 08:45:17 +0200 (CEST)
Date: Wed, 5 Jun 2024 08:45:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Benjamin Marzinski <bmarzins@redhat.com>
Subject: Re: [PATCH v3 1/2] block: Imporve checks on zone resource limits
Message-ID: <20240605064516.GA14642@lst.de>
References: <20240605063907.129120-1-dlemoal@kernel.org> <20240605063907.129120-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605063907.129120-2-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

The misspelling of improve in the subject is still there.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

