Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53A92E723C
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 17:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgL2QUY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Dec 2020 11:20:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgL2QUY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 11:20:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD57621D7F;
        Tue, 29 Dec 2020 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609258784;
        bh=A1jx13ftTwdEvZmFahFU8A4yvWO55L+zZ/kYgkN8mKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QuaBaWOmgh1vK+T9mrWqlPaRZtLBRQ8t8Zt/964EiItA3L8I5BRVSJH1VUBJ6fSh8
         xmlyl07Z3hO9aFpojjTGE7tQw8lG1fY26ZC3eManz84Qc6VNjw6nF9StW7De+ndfbH
         dnJ8284yZusVFaeVSptrqvMhQ6P/5gi1Z4YhWECf9cCu21uEMtICljY8tYqDwRK3/X
         lMPx1Pnf6W1NsxjmvsoabQgx7MySyuaxgys1bI5YxOhG43oYnkFD2Ck20rT/oSTozp
         J2uy+UjtvvIf/JjZRso6jw/xjcae2/dHSRzzUKS060146tqoXqlrHk5NYpu36aOH63
         Jj201Q2BkXM8A==
Date:   Tue, 29 Dec 2020 08:19:41 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Stefan Lederer <lederers@hs-furtwangen.de>
Cc:     linux-block@vger.kernel.org
Subject: Re: How to utilize a PCIE4.0 SSD?
Message-ID: <20201229161941.GA1018362@dhcp-10-100-145-180.wdc.com>
References: <eeaa8871-59f5-a56a-f4e5-723c91ac8d5a@hs-furtwangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeaa8871-59f5-a56a-f4e5-723c91ac8d5a@hs-furtwangen.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 29, 2020 at 02:40:57PM +0100, Stefan Lederer wrote:
> Hello dear list,
> 
> (I hope I do not annoy you as a simple application programmer)
> 
> for a seminar paper at my university we reproduced the 2009 paper
> "Pathologies of big data" by Jacobs, where he basically reads a
> 100GB file sequentially from a HDD with some light processing.
> 
> We have a PCIE4.0 SSD with up to 7GB/s reading (Samsung 980) but
> nothing we programmed so far comes even close to that speed (regular
> read(), mmap() with optional threads, io_uring, multi-process) so we
> wonder if it is possible at all?
> 
> According to iostat mmap is the fastest with 4GB/s and a queue depth
> of ~3. All other approaches do not go beyond 2.5GB/s.
> 
> Also we get some strange effects like sequential read() with 16KB
> buffers being faster than one with 16MB and io_uring being alot
> slower than mmap (all tested on Manjaro with kernel 5.8/5.10 and ext4).
> 
> So, now we are quite lost and would appreciate a hint into the right
> direction :)
> 
> What is neccesary to simply read 100GB of data at 7GB/s?

Is your device running at gen4 speed? Easiest way to tell with an nvme
ssd (assuming you're reading from /dev/nvme0n1) is something like:

 # cat /sys/block/nvme0n1/device/device/current_link_speed

If it says less than 16GT/s, then it can't read at 7GB/s.
