Return-Path: <linux-block+bounces-18365-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F4A5F4B6
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 13:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1D619C00D2
	for <lists+linux-block@lfdr.de>; Thu, 13 Mar 2025 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C966478F59;
	Thu, 13 Mar 2025 12:41:32 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A46EB7C
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869692; cv=none; b=Mf+snEfeZvu9Eon4qLbJY23iEUx2fT0e9DXmspzTqTD904EWlrkP4nbYCPwDKTtLsSlzVztnKs7TzSb5Ul+1dUdctQsqrJ5dyoNaDRhTlR07OOaTQikOndZT8nQItpaxw4oSHq4roQMmmnFY9iUQYBETCesAxM+VyZi2VG7qI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869692; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2yQAldn+nQWswbTJx1KjnsepZKYu0pC9/q7I47JIpchXzpSfNiwjcFIUsn0Po71VUTNMDka6RMu+Adm6VEn8t/lV7gEFfhjoN8nevxHXCpgBohr9l1UjlgXom46aF44fFklZdVhPnU8WYoLnwiVrJV7ts+BbwNUycQugIj703E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9EAD967373; Thu, 13 Mar 2025 13:41:25 +0100 (CET)
Date: Thu, 13 Mar 2025 13:41:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 1/3] block: protect debugfs attrs using elevator_lock
 instead of sysfs_lock
Message-ID: <20250313124125.GB3841@lst.de>
References: <20250313115235.3707600-1-nilay@linux.ibm.com> <20250313115235.3707600-2-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313115235.3707600-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


