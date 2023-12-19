Return-Path: <linux-block+bounces-1314-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7328193C9
	for <lists+linux-block@lfdr.de>; Tue, 19 Dec 2023 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E011C25549
	for <lists+linux-block@lfdr.de>; Tue, 19 Dec 2023 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A293D0AF;
	Tue, 19 Dec 2023 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsuAeCkX"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3753D0A4;
	Tue, 19 Dec 2023 22:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3310DC433C8;
	Tue, 19 Dec 2023 22:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703025989;
	bh=O0mz1d6CfvE4M7idrChoO3qGfbbAh4mTX5BLUbu5/j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YsuAeCkX0LroZ2rLYjVjMQdkk1LCqISsETOdiYRzCEtHC7Z+tm2dIZeR1KotnLnMS
	 XZ3WOEhtY92JUYQkw19IPVHXgpWKaR2yao8XIjc13tAmKjBcnV1qQGxwQKunel53PU
	 s20LoIO/5zDqY9zX8B88uex3VzBuZG4nt7JB192ioEgBSTJ6gaLdJ+9A6sWLeFeZu3
	 sDw1MF3qOkMb8KTzsLE+Jso66sb0kU1b9akzCwtcDjgiyrC+LS/HqJ5laupkrpYxRm
	 dtnpQGlJJOExjL5qyUJwpN/XYfIB2i2lCKu2KdAggQa9UtlWP4ELJGQ22I3GkVDl1Z
	 jRnpT2Zg04bzA==
Date: Tue, 19 Dec 2023 15:46:26 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 3/5] dm-bufio: Support I/O priority
Message-ID: <20231219224626.GB38652@quark.localdomain>
References: <CAMQnb4O15c=JC-zkCJD0U9GWwWko+Hez1iU7+cc3vhNSG86p9w@mail.gmail.com>
 <20231218012746.24442-1-hongyu.jin.cn@gmail.com>
 <20231218012746.24442-4-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218012746.24442-4-hongyu.jin.cn@gmail.com>

On Mon, Dec 18, 2023 at 09:27:44AM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> Add I/O priority parameter for dm_bufio_read() and
> dm_bufio_prefetch().

Needs an explanation for why this is useful.

- Eric

