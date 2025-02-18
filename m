Return-Path: <linux-block+bounces-17320-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0750DA396A2
	for <lists+linux-block@lfdr.de>; Tue, 18 Feb 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE06188718A
	for <lists+linux-block@lfdr.de>; Tue, 18 Feb 2025 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530C20CCE2;
	Tue, 18 Feb 2025 09:12:16 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B861DD886
	for <linux-block@vger.kernel.org>; Tue, 18 Feb 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869936; cv=none; b=h/K1+fCieHJ+WJ8H1U5jhc0f9ILRfeRdD+34EyRVA7gpx5r0wxeicUtyCewd13mdzFVu0KAmlSLNDugqHnmoh6GKSVQZrKT7L1u8DWeBYh37qYNd39RiTHBE4IkiH7TXqqsxpw47Bo+cKyjAgEAyFbXxfaYi3cDKtaFD2zEoMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869936; c=relaxed/simple;
	bh=DxmJNzeN0ajbgrE+9wI5GRCvZf3QYIX8lzQfvqKmEJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ2gNy/9hEEgqTwhKJNuQsGwOMb/q8uUZjJcEvU6woqZ07KXZHi96vXpJ+O1FN6eMbKSKYzI5JUewr6sqi4dQ8oWsrINliCEVMcPDYnShKBEnGobFXgCT0DP+3d89Rdi4WzRgGAeYKqJLdvKbQREDsyptOYtH69YjxjZqlOAkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EF7C068C7B; Tue, 18 Feb 2025 10:12:09 +0100 (CET)
Date: Tue, 18 Feb 2025 10:12:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com,
	dlemoal@kernel.org, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCHv2 6/6] blk-sysfs: protect read_ahead_kb using
 q->limits_lock
Message-ID: <20250218091209.GA13262@lst.de>
References: <20250218082908.265283-1-nilay@linux.ibm.com> <20250218082908.265283-7-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218082908.265283-7-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	/*
> +	 * We don't use atomic update helper queue_limits_start_update() and
> +	 * queue_limits_commit_update() here for updaing ra_pages bacause
> +	 * blk_apply_bdi_limits() which is invoked from  queue_limits_commit_
> +	 * update() can overwrite the ra_pages value which user actaully wants
> +	 * to store here. The blk_apply_bdi_limits() sets value of ra_pages
> +	 * based on the optimal I/O size(io_opt).
> +	 */

Maybe replace this with:

	/*
	 * ra_pages is protected by limit_lock because it is usually
	 * calculated from the queue limits by queue_limits_commit_update.
	 */


