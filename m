Return-Path: <linux-block+bounces-20582-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78716A9CBB0
	for <lists+linux-block@lfdr.de>; Fri, 25 Apr 2025 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822DC463D11
	for <lists+linux-block@lfdr.de>; Fri, 25 Apr 2025 14:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17D22E3E1;
	Fri, 25 Apr 2025 14:29:32 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C0642A96
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591371; cv=none; b=nYuGe8QhRLEANsRp7a9NwJFkEMBk9Psu/r5St1jyaUDuWxcQj+YTm9pwAs22YYlvSkvLOHL/5zX6t8HpLjD+lO4SJyFyFq4PzKRQ6TvZ25Hdo9GYZK2NTsQah/nZHE4D2PnPvkFSLFz3LBadGnIUOUomYogJAUT3mIHN6bd/Vuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591371; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dkv+8FoV9SelMmNoPMQTJEqFJzsAnfkmZAQ3C635z0TxmieyVzs2jyESUHwvcqqD9Ko6Y9MyTHXuAHoZlHZs1edhG1NkuQjmeL8AWkh9gFalQf9PVMTOK9nowKLB3OlMHKGsnCtiHuYDOwrvhKGsdiYxnO/VB3BrS6AOkXKCXW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 288D168BEB; Fri, 25 Apr 2025 16:29:26 +0200 (CEST)
Date: Fri, 25 Apr 2025 16:29:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V3 03/20] block: don't call freeze queue in
 elevator_switch() and elevator_disable()
Message-ID: <20250425142925.GB11082@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com> <20250424152148.1066220-4-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424152148.1066220-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


