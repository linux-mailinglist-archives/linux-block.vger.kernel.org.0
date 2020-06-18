Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF27D1FF4D0
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgFROft (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 10:35:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFROft (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:35:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4B39BAC5E;
        Thu, 18 Jun 2020 14:35:47 +0000 (UTC)
Date:   Thu, 18 Jun 2020 16:35:47 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infrdead.org
Subject: Re: [PATCH 01/12] blk-mq: merge blk-softirq.c into blk-mq.c
Message-ID: <20200618143547.xdhciho7fu6ykrtw@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-2-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:41AM +0200, Christoph Hellwig wrote:
> __blk_complete_request is only called from the blk-mq code, and
> duplicates a lot of code from blk-mq.c.  Move it there to prepare
> for better code sharing and simplifications.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
