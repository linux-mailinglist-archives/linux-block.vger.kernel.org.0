Return-Path: <linux-block+bounces-1778-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A30BC82BA70
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 05:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA7D1F258BD
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 04:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2656C5B5AE;
	Fri, 12 Jan 2024 04:39:25 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078EB5B5AA;
	Fri, 12 Jan 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 08BE068CFE; Fri, 12 Jan 2024 05:39:16 +0100 (CET)
Date: Fri, 12 Jan 2024 05:39:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Ed Tsai <ed.tsai@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH v6 1/4] block: Make fair tag sharing configurable
Message-ID: <20240112043915.GA5664@lst.de>
References: <20231130193139.880955-1-bvanassche@acm.org> <20231130193139.880955-2-bvanassche@acm.org> <58f50403-fcc9-ec11-f52b-f11ced3d2652@huaweicloud.com> <8372f2d0-b695-4af4-90e6-e35b86e3b844@acm.org> <c1658336-f48e-5688-f0c2-f325fd5696c3@huaweicloud.com> <1d3866af-ffca-4f97-914d-8084aca901ab@acm.org> <69b17db7-e9c9-df09-1022-ff7a9e5e04dd@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b17db7-e9c9-df09-1022-ff7a9e5e04dd@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 12, 2024 at 09:08:25AM +0800, Yu Kuai wrote:
> Yes, I realized that, handle the new flag in blk_mq_allow_hctx() is
> good, how about following chang?

Who would make that decision and on what grounds?


