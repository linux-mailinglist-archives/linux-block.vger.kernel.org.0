Return-Path: <linux-block+bounces-15950-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A64A02AC5
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2025 16:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4676B1650E1
	for <lists+linux-block@lfdr.de>; Mon,  6 Jan 2025 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86614159565;
	Mon,  6 Jan 2025 15:36:47 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75378F49;
	Mon,  6 Jan 2025 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177807; cv=none; b=SIqXTF+B/1JDv/trMwR7agN8KL/Jx452aMW4odx5Agp1zgtHrGkKTVZ10glQyp8BHDn2GOt3ghy64YVOUWb5Bb6ZRXIM+8h2/utHn/ZN1nxj1mtKjRQHbp7Lr1m6xag89iIw2qZs+9Uf3BC9K7iOiEPQEBMol3tWMnQTz5/PUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177807; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKVfEQXRdNwCNbAHmdVuh/hbXQKWcjl6dWYrGbdEG4MlK31gvm/xtERE70tyQnaUYqIExP1ImbFbuEDA8jMqRebaHkcW+PZtT6vvA6ONt44jACJ9J/LCFzAh9QqLMtknPvqnzexl9jFh/tNKTRK+7yWokcZPyWTGUk5geQga+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3073D68C7B; Mon,  6 Jan 2025 16:36:41 +0100 (CET)
Date: Mon, 6 Jan 2025 16:36:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, hch@lst.de,
	mpatocka@redhat.com, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] block: Ensure start sector is aligned for stacking
 atomic writes
Message-ID: <20250106153640.GA27864@lst.de>
References: <20250106124119.1318428-1-john.g.garry@oracle.com> <20250106124119.1318428-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106124119.1318428-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


