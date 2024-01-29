Return-Path: <linux-block+bounces-2500-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F483FE1B
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 07:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECF72810C5
	for <lists+linux-block@lfdr.de>; Mon, 29 Jan 2024 06:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054E94C3BC;
	Mon, 29 Jan 2024 06:18:47 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF79481A8;
	Mon, 29 Jan 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509126; cv=none; b=hRX5xc/y9qixvhTMtP1Igg2f+eQD2yWZw+q86Bmj1rUYnJd1Nhsx5Dvvh9PbXFnxSBHojLt78TxiogND+I90JYpK0BVGSbzkhD8HSWfP505AO9McxhwqYoNGNZPu5JyHcaSxt3iv7Y67Own89hsQxHljSOF3NBnJydySYvBTV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509126; c=relaxed/simple;
	bh=iLpEdDE6InzdDXGGrxVIg4AmUjhWWLwDfkc1GEga70c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT6CDxAX+s4nVl9DKkvbLZDIV2UHOc/bT94fz9eOEG4B7fnInlRUz+GaLdqoUieOz/VJANjgBmf1RjDJHViXnLwbiQe0pjRQZrVjuSaCcYcHMmL7THrGEnzu7ZShT79afwv28JbLVVNZdhWNy54L70HBCtqUWZJhK+UmNAhlo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DD9E68C4E; Mon, 29 Jan 2024 07:18:39 +0100 (CET)
Date: Mon, 29 Jan 2024 07:18:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org
Subject: Re: [PATCH v3 00/15] block atomic writes
Message-ID: <20240129061839.GA19796@lst.de>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Do you have a git tree with all patches somewhere?


