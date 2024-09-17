Return-Path: <linux-block+bounces-11729-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DADF97B0D1
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3821F1F228F5
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2024 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9169015C14D;
	Tue, 17 Sep 2024 13:33:10 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E68166F25
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579990; cv=none; b=rz8xlIHUp9bxmDhm6pLfchUoNjLYZd4aplrq0xGUxPXeFKUcgd9fXmcfRZ5ahATWthrXKPMcx65ujKz1lmjxSIFgZtU4hT67/P0ANF9n7DcEECuWeIUFMhwk6hT5DO2gCaCtxt2HjVpOiObgTP+N4pe8lGevVNN/cFPkuVagpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579990; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayqrt3gp/Q1eU5Dv6xT58neitxW62DS7m1s3PiCdUny/QjnoaGmQTtfRi+f86GWWUCrg8n4dwQgkVJKDxrs5Zc9cp/6RXFoeKCo6xA53KFB4o6+91VcuvPS8awiLVdEwk9Zpl3VhJBGU6G7l8ibt79nNemrj/Lq/Nyl0bG1oZE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A52F9227ACC; Tue, 17 Sep 2024 15:33:03 +0200 (CEST)
Date: Tue, 17 Sep 2024 15:33:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] block: Fix elv_iosched_local_module handling of
 "none" scheduler
Message-ID: <20240917133303.GA1704@lst.de>
References: <20240917133231.134806-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917133231.134806-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


