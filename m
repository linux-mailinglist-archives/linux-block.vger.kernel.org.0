Return-Path: <linux-block+bounces-1147-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A68140F4
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 05:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1D5B2238A
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 04:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EFD1C13;
	Fri, 15 Dec 2023 04:33:04 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057EA5697;
	Fri, 15 Dec 2023 04:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F189168AFE; Fri, 15 Dec 2023 05:32:58 +0100 (CET)
Date: Fri, 15 Dec 2023 05:32:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Song Liu <song@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Neil Brown <neilb@suse.de>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Mateusz Grzonka <mateusz.grzonka@intel.com>,
	Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
Message-ID: <20231215043258.GA15593@lst.de>
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214222107.2016042-2-song@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

