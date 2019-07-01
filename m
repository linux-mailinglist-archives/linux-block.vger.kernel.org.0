Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FFCFB8E
	for <lists+linux-block@lfdr.de>; Tue, 30 Apr 2019 16:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfD3Ock (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Apr 2019 10:32:40 -0400
Received: from verein.lst.de ([213.95.11.211]:46875 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726916AbfD3Ock (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 10:32:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1FD9A67358; Tue, 30 Apr 2019 16:32:23 +0200 (CEST)
Date:   Tue, 30 Apr 2019 16:32:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Klaus Birkelund <klaus@birkelund.eu>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/15] nvme-pci: optimize mapping single segment
 requests using SGLs
Message-ID: <20190430143222.GA24666@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <20190321231037.25104-15-hch@lst.de> <20190430141722.GA19100@apples.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430141722.GA19100@apples.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 30, 2019 at 04:17:22PM +0200, Klaus Birkelund wrote:
> nvme_setup_sgl_simple does not set the PSDT field, so bypassing
> nvme_pci_setup_sgls causing controllers to assume PRP.
> 
> Adding `cmnd->flags = NVME_CMD_SGL_METABUF` in nvme_setup_sgl_simple
> fixes the issue.

Indeed.  Can you send the patch?

