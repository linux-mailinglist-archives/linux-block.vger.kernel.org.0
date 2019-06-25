Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC25545A
	for <lists+linux-block@lfdr.de>; Tue, 25 Jun 2019 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfFYQXH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Jun 2019 12:23:07 -0400
Received: from verein.lst.de ([213.95.11.211]:36124 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfFYQXH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jun 2019 12:23:07 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1399068B05; Tue, 25 Jun 2019 18:22:36 +0200 (CEST)
Date:   Tue, 25 Jun 2019 18:22:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190625162235.GA9203@lst.de>
References: <20190625024625.23976-1-damien.lemoal@wdc.com> <20190625024625.23976-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625024625.23976-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 25, 2019 at 11:46:23AM +0900, Damien Le Moal wrote:
> To allow the SCSI subsystem scsi_execute_req() function to issue
> requests using large buffers that are better allocated with vmalloc()
> rather than kmalloc(), modify bio_map_kern() to allow passing a buffer
> allocated with the vmalloc() function. To do so, simply test the buffer
> address using is_vmalloc_addr() and use vmalloc_to_page() instead of
> virt_to_page() to obtain the pages of vmalloc-ed buffers.

This is broken on architectures with VIVT caches.  You need to flush
and invalidate the caches based on the virtual address on those before
performing DMA operations.
