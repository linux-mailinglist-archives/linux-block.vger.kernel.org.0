Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3581BF901
	for <lists+linux-block@lfdr.de>; Thu, 30 Apr 2020 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgD3NN5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 30 Apr 2020 09:13:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40633 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgD3NN4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 09:13:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A164968D07; Thu, 30 Apr 2020 15:13:52 +0200 (CEST)
Date:   Thu, 30 Apr 2020 15:13:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <20200430131351.GA24813@lst.de>
References: <20200430111754.98508-1-sth@linux.ibm.com> <20200430111754.98508-2-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430111754.98508-2-sth@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 30, 2020 at 01:17:54PM +0200, Stefan Haberland wrote:
> Remove the calls to ioctl_by_bdev from the DASD partition detection code
> to enable the removal of the specific code.
> 
> To do so reuse the gendisk private_data pointer and not only provide a
> pointer to the devmap but provide a new structure containing a pointer
> to the devmap as well as all required information for the partition
> detection. This makes it independent from the dasd_information2_t
> structure.

I think sharing the data structure in private data is pretty dangerous.
In the meantime I thought of another idea - the partition code could
do a symbol_get of a symbol exported by the dasd driver and use that
to query the information.
