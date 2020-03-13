Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB61845A7
	for <lists+linux-block@lfdr.de>; Fri, 13 Mar 2020 12:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCMLKh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Mar 2020 07:10:37 -0400
Received: from verein.lst.de ([213.95.11.211]:42020 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgCMLKh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 07:10:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EFBB068C4E; Fri, 13 Mar 2020 12:10:35 +0100 (CET)
Date:   Fri, 13 Mar 2020 12:10:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, axboe@kernel.dk,
        Chaitanya.Kulkarni@wdc.com, hch@lst.de
Subject: Re: [PATCH v3 3/5] xen-blkfront.c: Convert to use
 set_capacity_revalidate_and_notify
Message-ID: <20200313111035.GC8264@lst.de>
References: <20200313053009.19866-1-sblbir@amazon.com> <20200313053009.19866-4-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313053009.19866-4-sblbir@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 13, 2020 at 05:30:07AM +0000, Balbir Singh wrote:
> block/genhd provides set_capacity_revalidate_and_notify() for
> sending RESIZE notifications via uevents.
> 
> Signed-off-by: Balbir Singh <sblbir@amazon.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
