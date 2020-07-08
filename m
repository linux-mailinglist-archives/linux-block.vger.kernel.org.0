Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12963219187
	for <lists+linux-block@lfdr.de>; Wed,  8 Jul 2020 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgGHUcG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Jul 2020 16:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgGHUcG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Jul 2020 16:32:06 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E36BC20720;
        Wed,  8 Jul 2020 20:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594240326;
        bh=Phr+m9logqBbeGjOMUdUtNLbZiR9Q8OLEMn3mWsvao8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qhUtPzDPYysvTjVFW40ey+9VkdAW+90/1lX07VNQuDb78Itivr4ZHuD275dXwOn3G
         mjFs3V/IUr6W+IeM2I2eq9sAABwc7wOdgftlw5Z7FMpAuJ0n4TOCGBWYPXXr9HOy7F
         bZwnwfQtdxk6h5um4Jel7s91n9ksWc0qNt/vduSA=
Date:   Wed, 8 Jul 2020 13:32:04 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     mchristi@redhat.com, josef@toxicpanda.com, axboe@kernel.dk,
        navid.emamdoost@gmail.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH v4] nbd: Fix memory leak in nbd_add_socket
Message-ID: <20200708203204.GB35321@sol.localdomain>
References: <20200629012349.26641-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629012349.26641-1-zhengbin13@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 09:23:49AM +0800, Zheng Bin wrote:
> When adding first socket to nbd, if nsock's allocation failed, the data
> structure member "config->socks" was reallocated, but the data structure
> member "config->num_connections" was not updated. A memory leak will occur
> then because the function "nbd_config_put" will free "config->socks" only
> when "config->num_connections" is not zero.
> 
> Fixes: 03bf73c315ed ("nbd: prevent memory leak")
> Reported-by: syzbot+934037347002901b8d2a@syzkaller.appspotmail.com
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> ---

Reviewed-by: Eric Biggers <ebiggers@google.com>
