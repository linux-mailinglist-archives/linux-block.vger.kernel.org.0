Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573D436B500
	for <lists+linux-block@lfdr.de>; Mon, 26 Apr 2021 16:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhDZOhD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Apr 2021 10:37:03 -0400
Received: from verein.lst.de ([213.95.11.211]:41533 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhDZOhD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 10:37:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8832768C4E; Mon, 26 Apr 2021 16:36:20 +0200 (CEST)
Date:   Mon, 26 Apr 2021 16:36:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Subject: Re: [PATCHv2 3/5] block: return errors from blk_execute_rq()
Message-ID: <20210426143620.GC20668@lst.de>
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-4-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423220558.40764-4-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 03:05:56PM -0700, Keith Busch wrote:
> The synchronous blk_execute_rq() had not provided a way for its callers
> to know if its request was successful or not. Return the errno from the
> dispatch status.

Same comments on the accidentally sent other version of the patch.
