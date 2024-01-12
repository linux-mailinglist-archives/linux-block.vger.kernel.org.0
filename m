Return-Path: <linux-block+bounces-1800-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B5182C44F
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 18:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B5F1F243BD
	for <lists+linux-block@lfdr.de>; Fri, 12 Jan 2024 17:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60BC1B5B2;
	Fri, 12 Jan 2024 17:10:17 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1151B595;
	Fri, 12 Jan 2024 17:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7130268CFE; Fri, 12 Jan 2024 18:10:10 +0100 (CET)
Date: Fri, 12 Jan 2024 18:10:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Song Liu <song@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Neil Brown <neilb@suse.de>, Guoqing Jiang <guoqing.jiang@linux.dev>,
	Mateusz Grzonka <mateusz.grzonka@intel.com>,
	Jes Sorensen <jes@trained-monkey.org>
Subject: Re: [PATCH 1/3] md: Remove deprecated CONFIG_MD_LINEAR
Message-ID: <20240112171010.GA18360@lst.de>
References: <20231214222107.2016042-1-song@kernel.org> <20231214222107.2016042-2-song@kernel.org> <CAMuHMdUtzhwHLa_DTtH00YsZ6t_CefZjZj6oS_mpckHDNXpYWw@mail.gmail.com> <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW6KVN1c=dB1RXVQjygBevVcb_1qQJoLz3zA-qTVVmbCAw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 12, 2024 at 09:08:04AM -0800, Song Liu wrote:
> Thanks for the heads-up. I honestly don't know about this use case.
> Where can I find/get more information about it?

What NAS uses md linear?

Either way you can always set up a dm-linear table to get at the
data.


