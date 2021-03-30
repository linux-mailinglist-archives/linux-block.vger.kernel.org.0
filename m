Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08D434EF6A
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhC3R1L (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 13:27:11 -0400
Received: from verein.lst.de ([213.95.11.211]:59896 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhC3R05 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 13:26:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 319D368B05; Tue, 30 Mar 2021 19:26:54 +0200 (CEST)
Date:   Tue, 30 Mar 2021 19:26:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Ondrej Zary <linux@rainbow-software.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/8] advansys: remove ISA support
Message-ID: <20210330172653.GD13829@lst.de>
References: <20210326055822.1437471-1-hch@lst.de> <20210326055822.1437471-5-hch@lst.de> <f02b33b0-a898-505c-24f1-c84c35d21b78@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02b33b0-a898-505c-24f1-c84c35d21b78@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 29, 2021 at 08:31:21AM +0200, Hannes Reinecke wrote:
> >  #define ASC_IS_PCI          (0x0004)
> >  #define ASC_IS_PCI_ULTRA    (0x0104)
> 
> Any particular reason why the remaining ISA defines (like
> ASC_CHIP_MIN_VER_ISA etc) are being left intact?

I can do that.

> Please remove the 'isa_dma_channel' field from struct asc_dvc_cfg, too.

Sure.  This needs a little tweak as it seems to get written back to
the eeprom, though.
