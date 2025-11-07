Return-Path: <linux-block+bounces-29850-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA2C3E12E
	for <lists+linux-block@lfdr.de>; Fri, 07 Nov 2025 02:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFBB188A921
	for <lists+linux-block@lfdr.de>; Fri,  7 Nov 2025 01:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65472D7DC8;
	Fri,  7 Nov 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcXEaAbM"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A062BF3CC
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477422; cv=none; b=exkcxQCEM06CdZMsRtu/A7T9i3Cx7/8zWx0V9H8qiXiy2QkuZ8Avd4qpCEfCuAaIW9Fw+jUH8dH7EKXuNkYYUVMPknHLdQ5j5QDHZqXHTgqTOjz+OF2fdU1mU+2m5yWkNMxW+N0S+N4/WwFlum1wzs0fCB9KMhz3KDEYHdZJgmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477422; c=relaxed/simple;
	bh=+HhYARz3EZwNGGVtjHrJkFBc1gkDphzYvlM37ezBWVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8s0DEm2LZ5jRmvsuMqmaZdCQWXyuN4UytgjZhyt/SNRKyrejzs7n9SJnQjNOpF15c2bzUW0kHIJIJSVtnH1UTBs2NXrTa49uVpaLpiu1Tc7I7wxkJ0apv3GqY2HYitzgO55WhlnG7E1zkXwT8F9edyu47wSGD972+N+FvFiuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcXEaAbM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C3BC4CEF7;
	Fri,  7 Nov 2025 01:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762477422;
	bh=+HhYARz3EZwNGGVtjHrJkFBc1gkDphzYvlM37ezBWVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcXEaAbM67bQ9ftQvYheZdHMja+IMJzw+G/+jzaVo21RLLNXyINXhlTw3tNXCrEMk
	 MkwTk93K9tAMHBEBG1+CuLo9v5DsfMsRKyWFn3QE62+FJTHUSqQbIbEayua6k+EMDY
	 EiD0zC6S1gJjFuo6zRmuR1WBPy+lOJXkzOyzwAOQRDWqa74lgDcIc86dJSBK9DO9XH
	 D7I8fIX4OQghNWZiAHE78JZ+GQU+pRcmGDDhkKO4S5Xbumog28fVUIsHNws1dSHmjX
	 mFndmLEzA1Appzv4CtxWki0oMf5tvqaQNBJQCN8UWFDdcJ6LDwSrTbVeiqgMOpCS6e
	 Tq3aO3XwKir1g==
Date: Thu, 6 Nov 2025 18:03:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 0/2] block, nvme: removing virtual boundary mask
 reliance
Message-ID: <aQ1Fa7hPssIFOBLg@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014150456.2219261-1-kbusch@meta.com>

On Tue, Oct 14, 2025 at 08:04:54AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The purpose is to allow optimization decisions to happen per IO, and
> flexibility to utilize unaligned buffers for hardware that supports it.

Hi Jens,

Did you have a chance to consider this one? Thanks,

