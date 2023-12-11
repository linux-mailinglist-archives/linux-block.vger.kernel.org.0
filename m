Return-Path: <linux-block+bounces-959-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3E80D2A8
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0E761F21525
	for <lists+linux-block@lfdr.de>; Mon, 11 Dec 2023 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7242574D;
	Mon, 11 Dec 2023 16:46:24 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8481498;
	Mon, 11 Dec 2023 08:46:22 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB27F68B05; Mon, 11 Dec 2023 17:46:19 +0100 (CET)
Date: Mon, 11 Dec 2023 17:46:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v5 05/17] fs: Restore kiocb.ki_hint
Message-ID: <20231211164619.GC25306@lst.de>
References: <20231130013322.175290-1-bvanassche@acm.org> <20231130013322.175290-6-bvanassche@acm.org> <20231207174633.GE31184@lst.de> <1e71a6bf-ac2f-41bc-8931-8b4fb7371118@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e71a6bf-ac2f-41bc-8931-8b4fb7371118@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 01:40:29PM -1000, Bart Van Assche wrote:
>> Same comment as for the previous one.
>
> If kiocb.ki_hint is not restored, the kiocb users will have to use the
> kiocb ki_filp member to obtain the write hint information. In other
> words, iocb->ki_hint will have to be changed into
> file_inode(iocb->ki_filp)->i_write_hint. Is that what you want me to do?

Yes.

