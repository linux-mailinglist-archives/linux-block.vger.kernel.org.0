Return-Path: <linux-block+bounces-866-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC90C808EF8
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 18:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769241F21113
	for <lists+linux-block@lfdr.de>; Thu,  7 Dec 2023 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E804AF92;
	Thu,  7 Dec 2023 17:45:34 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2524B193;
	Thu,  7 Dec 2023 09:45:32 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92398227A87; Thu,  7 Dec 2023 18:45:29 +0100 (CET)
Date: Thu, 7 Dec 2023 18:45:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5 03/17] fs/f2fs: Restore the whint_mode mount option
Message-ID: <20231207174529.GC31184@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-4-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130013322.175290-4-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 29, 2023 at 05:33:08PM -0800, Bart Van Assche wrote:
> Restore support for the whint_mode mount option by reverting commit
> 930e2607638d ("f2fs: remove obsolete whint_mode").

I know that commit sets a precedence by having a horribly short and
uninformative commit message, but please write a proper one for this
commit and explain why you are restoring the option.  Also if anything
changed since last year.

