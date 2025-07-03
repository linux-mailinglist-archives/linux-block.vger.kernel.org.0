Return-Path: <linux-block+bounces-23659-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766AAF6E09
	for <lists+linux-block@lfdr.de>; Thu,  3 Jul 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C5F1C21BA7
	for <lists+linux-block@lfdr.de>; Thu,  3 Jul 2025 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDA2D3A72;
	Thu,  3 Jul 2025 09:02:06 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CF72D0292;
	Thu,  3 Jul 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533326; cv=none; b=Iz9yUThGQXdJPJqt2PN5U9sFUOHW7G6adZapc7o28RT6AknyYmIh9gpkoa5QiHIRnzRDRh+GQrpHyH69CLzthhp+Po1JPw4GxG8SrDuFNo4OTTFn5kLQDAf7LsGXnHRBTYeWqNH0nfruoo2qGCd3T+grsiJ3wLYShB2XILhUx7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533326; c=relaxed/simple;
	bh=Z/vGvgrrbVAMLzRiS2g0fkIcUa1mFzXAS23RSaYh68I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdUqe7jFtPQ0X/FEDtvrbEBhMKAOydm99QJsD+vTklE4LM+Ryho6aoJolocGzSqdPVxOQ7WzTfVoC4U70nR3WYzZuNgCTjBLcTGkQW0AnDr1J8Sh4WNWGBu2GNevzzohu0JY+1kaBwVFjhI6wSjH8jj0Sw9xl7sq5dOpupc4lMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD66168B05; Thu,  3 Jul 2025 11:01:58 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:01:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, storagedev@microchip.com,
	virtualization@lists.linux.dev,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH v7 08/10] blk-mq: use hk cpus only when
 isolcpus=io_queue is enabled
Message-ID: <20250703090158.GA4757@lst.de>
References: <20250702-isolcpus-io-queues-v7-0-557aa7eacce4@kernel.org> <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-isolcpus-io-queues-v7-8-557aa7eacce4@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 02, 2025 at 06:33:58PM +0200, Daniel Wagner wrote:
>  const struct cpumask *blk_mq_possible_queue_affinity(void)
>  {
> +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE))
> +		return housekeeping_cpumask(HK_TYPE_IO_QUEUE);
> +
>  	return cpu_possible_mask;
>  }

I'm no expert on the housekeeping stuff, but why isn't the
housekeeping_enabled check done in housekeeping_cpumask directly so
that the drivers could use housekeeping_cpumask without a blk-mq
wrapper?


