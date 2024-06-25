Return-Path: <linux-block+bounces-9291-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A143915DE7
	for <lists+linux-block@lfdr.de>; Tue, 25 Jun 2024 07:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B051F220CE
	for <lists+linux-block@lfdr.de>; Tue, 25 Jun 2024 05:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DF9143754;
	Tue, 25 Jun 2024 05:02:53 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F47748F
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 05:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719291773; cv=none; b=p564uz0z2E2BgzpCd5iRrEH2nlL1mXwXtclWG6zED2e+jIZkKiyJQA6JdlpXmf3ocl4ZQPsKInAJpa2ewF9r6PD9YrS97u+XSzDJ/Q0quCf5d7aDGCnQUFVfJDoPxLZmFm2WT5cG+qOPYI45Ff7JpWDdrIxKTR+JVRV9uXOTXT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719291773; c=relaxed/simple;
	bh=GPbGwtyI3ibfSbmY788pBsw6YlAn+XxeGZLDNtGSUnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+8QOUbje3ez5FhcCoFA1dMgaoA1wNnU880v09wVM9cI7Sv/8bZdgrvJR5GlNnUxPkTPf57p51GqxOPHoZRP8moLdkyztsfRfCf9jfMieOrOwlfwVYejdcKg5iFeue20wT0T1jFhpSC6Z19YrTr612YLeQgEOzy9Ai01xmjcmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A54CB68D08; Tue, 25 Jun 2024 07:02:46 +0200 (CEST)
Date: Tue, 25 Jun 2024 07:02:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Bryan Gurney <bgurney@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] dm/002: do not assume 512 byte block size
Message-ID: <20240625050246.GA928@lst.de>
References: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625025143.405254-1-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christoph Hellwig <hch@lst.de>

