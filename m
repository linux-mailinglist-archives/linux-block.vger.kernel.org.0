Return-Path: <linux-block+bounces-1200-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1F8815779
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 05:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5FFB211E5
	for <lists+linux-block@lfdr.de>; Sat, 16 Dec 2023 04:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2117494;
	Sat, 16 Dec 2023 04:33:33 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91C13B14C;
	Sat, 16 Dec 2023 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9B3C68CFE; Sat, 16 Dec 2023 05:33:28 +0100 (CET)
Date: Sat, 16 Dec 2023 05:33:28 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] hfsplus: Really remove hfsplus_writepage
Message-ID: <20231216043328.GF9284@lst.de>
References: <20231215200245.748418-1-willy@infradead.org> <20231215200245.748418-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215200245.748418-9-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 08:02:39PM +0000, Matthew Wilcox (Oracle) wrote:
> The earlier commit to remove hfsplus_writepage only removed it from
> one of the aops.  Remove it from the btree_aops as well.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although I had some reason to be careful back then.  hfsplus should
be testable again that the hfsplus Linux port is back alive.  Is there
any volunteer to test hfsplus on the fsdevel list?


