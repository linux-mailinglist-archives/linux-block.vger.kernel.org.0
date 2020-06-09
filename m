Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169B41F3A56
	for <lists+linux-block@lfdr.de>; Tue,  9 Jun 2020 14:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgFIMEk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jun 2020 08:04:40 -0400
Received: from verein.lst.de ([213.95.11.211]:42135 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbgFIMEk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jun 2020 08:04:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6E0DE68AFE; Tue,  9 Jun 2020 14:04:37 +0200 (CEST)
Date:   Tue, 9 Jun 2020 14:04:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     brking@us.ibm.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: ipr crashes due to NULL dma_need_drain since cc97923a5bcc
 ("block: move dma drain handling to scsi")
Message-ID: <20200609120437.GB2140@lst.de>
References: <87zh9cftj0.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh9cftj0.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 09, 2020 at 08:00:35PM +1000, Michael Ellerman wrote:
> Hi all,
> 
> I'm seeing crashes on powerpc with the ipr driver, which I'm fairly sure
> are due to dma_need_drain being NULL.

Ooops, my changes completely forgot about SAS attached ATAPI devices.
I'll cook up a fix in a bit.
