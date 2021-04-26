Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817536B58D
	for <lists+linux-block@lfdr.de>; Mon, 26 Apr 2021 17:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhDZPRk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Apr 2021 11:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZPRj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 11:17:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DD1461041;
        Mon, 26 Apr 2021 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619450218;
        bh=4Yn/mfaMho0PcS/JLVj/WsgPQuu9nCREYLZ2ygXW6O8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbVZTrTNhL09YE/4lCwX4x2zMYhd9XUyckYInILKLTgZvP/J6EtehWLcvi5dZbaRM
         Pt04Ofq1bxFtAftxBbSIPhVrihewKtOQ05mgcoOfKJSJ0HvcGzNxK46J7IN8ztYNvt
         ct9DIRntDt6hqiu1w0Ec5FsrPmdafONeA6TcaXjEMyj/LzrG30IMnBOBmpm8RmNFFd
         cfTxMFEtGU9s/jkaLXgO2re2jrMXdPFQvFjpcH9nGojnl5/QMBct4jORXlc2ATn8DA
         uE3EGAPZLVqn7VLSs6CGKsSmfWsbvxN/EbxCIKIjHn50yenGqRssEAcITkri+vXgXB
         YOYTWgq1B9ZOg==
Date:   Tue, 27 Apr 2021 00:16:55 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     taochiu <taochiu@synology.com>
Cc:     hch@lst.de, chaitanya.kulkarni@wdc.com, axboe@fb.com,
        sagi@grimberg.me, james.smart@broadcom.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Cody Wong <codywong@synology.com>,
        Leon Chien <leonchien@synology.com>
Subject: Re: [PATCH v2 1/2] nvme-core: Move nvmf queue ready check routines
 to core
Message-ID: <20210426151655.GC12593@redsun51.ssa.fujisawa.hgst.com>
References: <20210426025310.3005573-1-taochiu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426025310.3005573-1-taochiu@synology.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 26, 2021 at 10:53:10AM +0800, taochiu wrote:
> From: Tao Chiu <taochiu@synology.com>
> 
> queue_rq() in pci only checks if the dispatched queue (nvmeq) is ready,
> e.g. not being suspended. Since nvme_alloc_admin_tags() in reset flow
> restarts the admin queue, users are able to submit admin commands to a
> controller before reset_work() completes. Commands submitted under this
> condition may interfere with commands that performs identify, IO queue
> setup in reset_work(), and may result in a hang described in the
> following patch.
> 
> As seen in the fabrics, user commands are prevented from being executed
> under inproper controller states. We may reuse this logic to maintain a
> clear admin queue during reset_work().
> 
> Signed-off-by: Tao Chiu <taochiu@synology.com>
> Signed-off-by: Cody Wong <codywong@synology.com>
> Reviewed-by: Leon Chien <leonchien@synology.com>

The series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
