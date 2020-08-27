Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D473F2542AA
	for <lists+linux-block@lfdr.de>; Thu, 27 Aug 2020 11:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgH0Joe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Aug 2020 05:44:34 -0400
Received: from verein.lst.de ([213.95.11.211]:37529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbgH0Joe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 05:44:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 583E768B02; Thu, 27 Aug 2020 11:44:32 +0200 (CEST)
Date:   Thu, 27 Aug 2020 11:44:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] block: Remove blk_mq_attempt_merge() function
Message-ID: <20200827094432.GB16058@lst.de>
References: <cover.1597727255.git.baolin.wang@linux.alibaba.com> <5fa8de665d398cf49fd7c70fb427bb066556c764.1597727255.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fa8de665d398cf49fd7c70fb427bb066556c764.1597727255.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 01:45:30PM +0800, Baolin Wang wrote:
> The small blk_mq_attempt_merge() function is only called by
> __blk_mq_sched_bio_merge(), just open code it.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
