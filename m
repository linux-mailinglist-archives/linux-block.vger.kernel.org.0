Return-Path: <linux-block+bounces-7794-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD198D1016
	for <lists+linux-block@lfdr.de>; Tue, 28 May 2024 00:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED41AB21D75
	for <lists+linux-block@lfdr.de>; Mon, 27 May 2024 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3CE161B58;
	Mon, 27 May 2024 22:12:15 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from mx.ewheeler.net (mx.ewheeler.net [173.205.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811A52F6D
	for <linux-block@vger.kernel.org>; Mon, 27 May 2024 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.205.220.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847935; cv=none; b=pKpKN/hgMwAFiHxDrVMBajDplkNYjYEqoZPG3UOIriAs+bBBcQAMg2lHzXVOnZbvglAj9XJOtVx6nNrLr88i2hG9cLnm+bl7iEtvAJLo3jseEaS/HNXMRfoaAR0FA3lQ0uVt/zYsSxnNgQ2WhNiFUSlrbZlFBSJGubdGDCTSITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847935; c=relaxed/simple;
	bh=K6nhJkdLk32NLMRWXvuG1EBEh5ADmK3U7M1QmtpFNyE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VRWHFkeus4RkcPcT1MUEcjUu0NB3Dlg6jxJixST7IJNqGCgGYQw0o/rMbRP4+VcthlNyo7XUL1wuwfp2qWT0d0irxG00woQ0os4viQQWa9B4YHikl+uqID6xleBDf/Vw9Uv1WcNHL+Rk1HiIK1TBe4RtWXxNWJhtAi9Tbpx5EnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net; spf=none smtp.mailfrom=lists.ewheeler.net; arc=none smtp.client-ip=173.205.220.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.ewheeler.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.ewheeler.net
Received: from localhost (localhost [127.0.0.1])
	by mx.ewheeler.net (Postfix) with ESMTP id EBEA287;
	Mon, 27 May 2024 15:12:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at ewheeler.net
Received: from mx.ewheeler.net ([127.0.0.1])
	by localhost (mx.ewheeler.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 8prv4BcT0aEo; Mon, 27 May 2024 15:12:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.ewheeler.net (Postfix) with ESMTPSA id F181948;
	Mon, 27 May 2024 15:12:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx.ewheeler.net F181948
Date: Mon, 27 May 2024 15:12:05 -0700 (PDT)
From: Eric Wheeler <dm-devel@lists.ewheeler.net>
To: Mikulas Patocka <mpatocka@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: Re: [RFC PATCH 0/2] dm-crypt support for per-sector NVMe metadata
In-Reply-To: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
Message-ID: <206cd9fc-7dd0-f633-f6a9-9a2bd348a48e@ewheeler.net>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 May 2024, Mikulas Patocka wrote:
> Hi
> 
> Some NVMe devices may be formatted with extra 64 bytes of metadata per 
> sector.
> 
> Here I'm submitting for review dm-crypt patches that make it possible to 
> use per-sector metadata for authenticated encryption. With these patches, 
> dm-crypt can run directly on the top of a NVMe device, without using 
> dm-integrity. These patches increase write throughput twice, because there 
> is no write to the dm-integrity journal.
> 
> An example how to use it (so far, there is no support in the userspace 
> cryptsetup tool):
> 
> # nvme format /dev/nvme1 -n 1 -lbaf=4
> # dmsetup create cr --table '0 1048576 crypt 
> capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256 
> 01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298 
> 0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'

Thats really an amazing feature, and I think your implementation is simple 
and elegant.  Somehow reminds me of 520/528-byte sectors that big 
commercial filers use, but in a way the Linux could use.

Questions:

- I see you are using 32-bytes of AEAD data (out of 64).  Is AEAD always 
  32-bytes, or can it vary by crypto mechanism?

- What drive are you using? I am curious what your `nvme id-ns` output 
  looks like. Do you have 64 in the `ms` value?

        # nvme id-ns /dev/nvme0n1 | grep lbaf
        nlbaf   : 0
        nulbaf  : 0
        lbaf  0 : ms:0   lbads:9  rp:0 (in use)
                     ^         ^512b

--
Eric Wheeler



> 
> Please review it - I'd like to know whether detecting the presence of 
> per-sector metadata in crypt_integrity_ctr is correct whether it should be 
> done differently.
> 
> Mikulas
> 
> 
> 

