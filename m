Return-Path: <linux-block+bounces-15819-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B379A005C1
	for <lists+linux-block@lfdr.de>; Fri,  3 Jan 2025 09:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482491882959
	for <lists+linux-block@lfdr.de>; Fri,  3 Jan 2025 08:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD091BEF9B;
	Fri,  3 Jan 2025 08:27:31 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D441BC099
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892851; cv=none; b=RS9a+HlLo6NEw85cjce7pizgeveF2U2gbW5QzyxsTbrpOSHPH9hKccoJKRIR+q4xmo64QNHpeIB310Jx3aTioOxuT92SF5KdDmzCZzixuxaDsyO8DKPCYNyuX+gIbuWoRTiYxVnXUceQq7biluahf+veU1JcOHy5qfGc+MYgfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892851; c=relaxed/simple;
	bh=POr+CrDZ5xpCPZexv4r+wFD0CLRUkJJo/1jHAmzSAHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeAr5jj4tiLp/kStgIZmD1O7H+ygZmSj2U1zZUjjbzFZc8hmdE3sNTxKYzahzVEdpL4YGmvNf/a7EfCyUlofVA48XQMvlzdctVhPaxctqIptcdIMkVl5zRN4Yx16QBK4ldoU2f8tZQuyCE0LFIA+A1GJ6m50/F3R0vZebnG672U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BED8E68BEB; Fri,  3 Jan 2025 09:27:23 +0100 (CET)
Date: Fri, 3 Jan 2025 09:27:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: Use enum for blk-mq tagset flags
Message-ID: <20250103082723.GA30419@lst.de>
References: <20250102144426.24241-1-john.g.garry@oracle.com> <20250103064427.GA27984@lst.de> <f3852e75-dff7-4cc9-b64c-01ebf1020808@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3852e75-dff7-4cc9-b64c-01ebf1020808@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 03, 2025 at 08:23:02AM +0000, John Garry wrote:
> - better to not have unused gaps

Who cares?

> - catch missing blk-mq debugfs array names
> 	- this has been a problem in the past

Again who really cares?

>
> Cons:
> - boilerplate
>
> A compromise could be to use some macro to evaluate the flags, like:
> #define BLK_MQ_F(flag) (1 << BLK_MQ_B_##flag)

Hell no.  The debugfs mess is already annoying as f**k because of
all that macro magic that makes it impossible to grep for.  Don't
add more of that crap that just makes life hell.


