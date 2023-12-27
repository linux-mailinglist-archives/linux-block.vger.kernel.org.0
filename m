Return-Path: <linux-block+bounces-1473-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1181ED2D
	for <lists+linux-block@lfdr.de>; Wed, 27 Dec 2023 09:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE461C212E1
	for <lists+linux-block@lfdr.de>; Wed, 27 Dec 2023 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82296131;
	Wed, 27 Dec 2023 08:19:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4E5691
	for <linux-block@vger.kernel.org>; Wed, 27 Dec 2023 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 070FE68B05; Wed, 27 Dec 2023 09:19:19 +0100 (CET)
Date: Wed, 27 Dec 2023 09:19:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] loop: remove a pointless blk_queue_max_hw_sectors
 call
Message-ID: <20231227081918.GA22115@lst.de>
References: <20231226091405.206166-1-hch@lst.de> <a4c16b17-258c-3d49-ae44-241e95a14e4f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4c16b17-258c-3d49-ae44-241e95a14e4f@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 26, 2023 at 05:38:31PM +0800, Yu Kuai wrote:
> Hi,
>
> 在 2023/12/26 17:14, Christoph Hellwig 写道:
>> BLK_DEF_MAX_SECTORS is (as the name implies) already the default.
>
> Looks like this not true. From blk_set_default_limits():
>
> lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
>
> So, the default is not BLK_DEF_MAX_SECTORS. Or am I missing something?

No, you're not.  The naming and our code is just a desaster..


