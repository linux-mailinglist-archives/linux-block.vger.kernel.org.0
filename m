Return-Path: <linux-block+bounces-74-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00007E6D65
	for <lists+linux-block@lfdr.de>; Thu,  9 Nov 2023 16:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F71728108D
	for <lists+linux-block@lfdr.de>; Thu,  9 Nov 2023 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5020311;
	Thu,  9 Nov 2023 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D441200C1;
	Thu,  9 Nov 2023 15:26:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE03358C;
	Thu,  9 Nov 2023 07:26:19 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67A9F67373; Thu,  9 Nov 2023 16:26:15 +0100 (CET)
Date: Thu, 9 Nov 2023 16:26:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 17/21] fs: xfs: iomap atomic write support
Message-ID: <20231109152615.GB1521@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-18-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-18-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Sep 29, 2023 at 10:27:22AM +0000, John Garry wrote:
> Ensure that when creating a mapping that we adhere to all the atomic
> write rules.
> 
> We check that the mapping covers the complete range of the write to ensure
> that we'll be just creating a single mapping.
> 
> Currently minimum granularity is the FS block size, but it should be
> possibly to support lower in future.

I really dislike how this forces aligned allocations.  Aligned
allocations are a nice optimization to offload some of the work
to the storage hard/firmware, but we need to support it in general.
And I think with out of place writes into the COW fork, and atomic
transactions to swap it in we can do that pretty easily.

That should also allow to get rid of the horrible forcealign mode,
as we can still try align if possible and just fall back to the
out of place writes.


