Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110311E7D2B
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgE2M1s (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 08:27:48 -0400
Received: from verein.lst.de ([213.95.11.211]:32783 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgE2M1s (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 08:27:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92FFF68B02; Fri, 29 May 2020 14:27:46 +0200 (CEST)
Date:   Fri, 29 May 2020 14:27:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200529122746.GB28107@lst.de>
References: <20200528153441.3501777-1-kbusch@kernel.org> <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 09:36:23AM -0600, Jens Axboe wrote:
> On 5/28/20 9:34 AM, Keith Busch wrote:
> > For when drivers have a need to bypass error injection.
> 
> Acked-by: Jens Axboe <axboe@kernel.dk
> 
> Assuming this goes in through the NVMe tree.

Given that other drivers will need this as well, and the nvme queue for
5.8 is empty at the moment I think you should pick up the next version
once it has better naming and documentation.
