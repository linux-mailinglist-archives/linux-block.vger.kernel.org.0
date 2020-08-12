Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E39A242BEB
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgHLPJn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 11:09:43 -0400
Received: from verein.lst.de ([213.95.11.211]:43617 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLPJm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 11:09:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A9996736F; Wed, 12 Aug 2020 17:09:39 +0200 (CEST)
Date:   Wed, 12 Aug 2020 17:09:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/3] nvme-core: fix io interrupt caused by non path
 error
Message-ID: <20200812150939.GA29544@lst.de>
References: <20200812081837.22144-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812081837.22144-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 04:18:37PM +0800, Chao Leng wrote:
> For nvme multipath configured, just fail over to retry IO for path error,
> but maybe blk_queue_dying return true, IO can not be retry at current
> path, thus IO will interrupted.
> 
> For nvme multipath configured, blk_queue_dying and path error both need
> fail over to retry. We need check whether path-related errors first, and
> then retry local or fail over to retry.

Err, no.  None of this really makes any sense.  The existing code
actually works perfectly well unless you really insist on trying to
use a completley unsupported multipathing configuration.  I would
storngly recommend to not use dm-multipath with nvme, but if you
insist please fix your problems without impacting the fully supported
native path.
