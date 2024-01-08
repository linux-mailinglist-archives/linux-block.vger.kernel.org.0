Return-Path: <linux-block+bounces-1640-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3882750C
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 17:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BB73B221CF
	for <lists+linux-block@lfdr.de>; Mon,  8 Jan 2024 16:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AC952F6C;
	Mon,  8 Jan 2024 16:26:50 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F573524C7;
	Mon,  8 Jan 2024 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16E2168C4E; Mon,  8 Jan 2024 17:26:42 +0100 (CET)
Date: Mon, 8 Jan 2024 17:26:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH RFC 00/34] Open block devices as files & a bd_inode
 proposal
Message-ID: <20240108162641.GA7842@lst.de>
References: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-vfs-bdev-file-v1-0-6c8ee55fb6ef@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 03, 2024 at 01:54:58PM +0100, Christian Brauner wrote:
> I wanted to see whether we can make struct bdev_handle completely
> private to the block layer in the next cycle and unexport low-level
> helpers such as bdev_release() - formerly blkdev_put() - completely.

I think we can actually kill bdev_handle entirely.  We can get the
bdev from the bdev inode using I_BDEV already, so no need to store
the bdev.  We don't need the mode field as we known an exlusive
open is equivalent to having a holder.  So just store the older in
file->private_data and the bdev_handle can be removed again.


