Return-Path: <linux-block+bounces-1051-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB84810939
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 05:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C78D1C20AA9
	for <lists+linux-block@lfdr.de>; Wed, 13 Dec 2023 04:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E58C14F;
	Wed, 13 Dec 2023 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ww5bIRBN"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1619DC13B;
	Wed, 13 Dec 2023 04:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123CCC433C7;
	Wed, 13 Dec 2023 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702442732;
	bh=wAzQ6gyscE8Ihq0a6Mek/OCHIV4GQLIER2F9aDitQMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ww5bIRBNnQPaVkYZpHJbY3dLSrm1sJu0HfgxfCcmCVuVcLZlNg3DlKYcLr4zT5HWd
	 bciMBhudAYariFLueoHcmNOxu1AJ3r27mg5g+83h7vov2MlGllZ3VLKWTPyqIwziPp
	 S03U2B1N04P3proWizqvxMTgA3Rfg63LxOWp/xWTNoPXb36A3OfZiqnABhQL9rv5pQ
	 K0qivv6JNIPVaGkqYzK5tEYKPUPiwloKm4OLKDrdWX13KeL23RPL43fnru0At7eFkG
	 bvHC4cFiru9qamWa2ag8WVd9W6coWQgQ/76g2DuVec6DqkW9d/QRJ7qEMDDfn2sihY
	 fME+JquNsk/ag==
Date: Tue, 12 Dec 2023 20:45:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
	axboe@kernel.dk, zhiguo.niu@unisoc.com, ke.wang@unisoc.com,
	yibin.ding@unisoc.com, hongyu.jin@unisoc.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Fix I/O priority lost in device-mapper
Message-ID: <20231213044530.GB1127@sol.localdomain>
References: <ZXeJ9jAKEQ31OXLP@redhat.com>
 <20231212111150.18155-1-hongyu.jin.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111150.18155-1-hongyu.jin.cn@gmail.com>

On Tue, Dec 12, 2023 at 07:11:45PM +0800, Hongyu Jin wrote:
> From: Hongyu Jin <hongyu.jin@unisoc.com>
> 
> A high-priority task obtains data from the dm-verity device using the
> RT IO priority, during the verification, the IO reading FEC and hash
> by kworker loses the RT priority and is blocked by the low-priority IO.
> dm-crypt has the same problem in the process of writing data.
> 
> This is because io_context and blkcg are missing.
> 
> Move bio_set_ioprio() into submit_bio():
> 1. Only call bio_set_ioprio() once to set the priority of original bio,
>    the bio that cloned and splited from original bio will auto inherit
>    the priority of original bio in clone process.
> 
> 2. Make the IO priority of the original bio to be passed to dm,
>    and the dm target inherits the IO priority as needed.
> 

What commit does this patch series apply to?

- Eric

