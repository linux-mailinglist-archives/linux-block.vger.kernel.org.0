Return-Path: <linux-block+bounces-1203-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E21815784
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 05:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DF4B24A86
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 04:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C945125B9;
	Sat, 16 Dec 2023 04:35:19 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125A11C97;
	Sat, 16 Dec 2023 04:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D96A468B05; Sat, 16 Dec 2023 05:35:14 +0100 (CET)
Date: Sat, 16 Dec 2023 05:35:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/14] fs: Convert block_write_full_page to
 block_write_full_folio
Message-ID: <20231216043514.GI9284@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-14-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-14-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:44PM +0000, Matthew Wilcox (Oracle) wrote:
> Convert the function to be compatible with writepage_t so that it
> can be passed to write_cache_pages() by blkdev.  This removes a call
> to compound_head().  We can also remove the function export as both
> callers are built-in.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

