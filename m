Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A254B1E12C1
	for <lists+linux-block@lfdr.de>; Mon, 25 May 2020 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgEYQdU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 May 2020 12:33:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbgEYQdU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 May 2020 12:33:20 -0400
Received: from C02WT3WMHTD6 (unknown [199.255.45.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A99CF207D8;
        Mon, 25 May 2020 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590424400;
        bh=9vGGgPwFTtp61l7+yyZIZRz3tXvaAuHb3t1HBPuGqm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bq2nTgd7E8Hc+EDC5jSwA2ccO99RlYpCkZ3JL0UwrDioY5cXM5aiCyNHLSbDNrUA8
         dURsasbdyY34xe0Jk7v8Gxdb6kvzBu41oszIsNUNtKc2QvNfAOH5uIqHr+RD09qkPv
         UIgzY2QiLa4DY5HpmP1JR6wXY5T5E0kZ45a0CPuo=
Date:   Mon, 25 May 2020 10:33:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 3/6] blk-mq: move getting driver tag and bugget into
 one helper
Message-ID: <20200525163317.GA73686@C02WT3WMHTD6>
References: <20200525093807.805155-1-ming.lei@redhat.com>
 <20200525093807.805155-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525093807.805155-4-ming.lei@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 25, 2020 at 05:38:04PM +0800, Ming Lei wrote:
> Move code for getting driver tag and bugget into one helper, so

s/bugget/budget
