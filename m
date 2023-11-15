Return-Path: <linux-block+bounces-55-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606D7E5B22
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8B41C20863
	for <lists+linux-block@lfdr.de>; Wed,  8 Nov 2023 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B56D51D;
	Wed,  8 Nov 2023 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPlufv1C"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16F31FD6;
	Wed,  8 Nov 2023 16:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BBB5C433C9;
	Wed,  8 Nov 2023 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699460726;
	bh=qD+sFBOP9V2yUmYRqtOB3VeOWhm29ZlZGuTsoaz/cM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPlufv1C6M7u5dLJzwxcRCXpDA0+ZgvcRrTe2ZqGH3BLqehtRYCWR6i1cL1M2WZw3
	 zBqXj+z3CX/cBH0mDnRK+J3y9bRpJB+AcFtrOFH/pHZTrF9iNTm9MhA3mPNP1ZLCrg
	 FEWSGkxIKc8R1WGnKVEc95ZpJR1M1keMyLMEqFy5+Nszf0NVJAJPn31Q49OxnPuJif
	 AKSXzg7IZDHjEVpnUr3W/5oapj4V2707ml3npIpNNpbd+UIrSXLz4rXgza5C7gw5+R
	 dMGnyYtQktoMsnQJ7cG2oh3p8ETYGci8MdSih6O2J4dZ7OGUWG+F0UHsVU9qHJx+gv
	 8xKewJ9thyjmg==
Date: Wed, 8 Nov 2023 08:25:25 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: add and use a per-mapping stable writes flag v2
Message-ID: <20231108162525.GT1205143@frogsfrogsfrogs>
References: <20231025141020.192413-1-hch@lst.de>
 <20231108080518.GA6374@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108080518.GA6374@lst.de>

On Wed, Nov 08, 2023 at 09:05:18AM +0100, Christoph Hellwig wrote:
> Can we get at least patches 1 and 2 queued for for 6.7 given that
> they fix a regression?

I would say that all four should go in 6.7 because patches 3-4 fix wrong
behavior if the rtdev needs stablewrites but the datadev does not.

There probably aren't many users of a RHEL-disabled feature atop
specialty hardware, but IIRC it's still a data corruption vector.

(says me who blew up his last T10 PI drive last week :()

--D

