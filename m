Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019043D2C70
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhGVS2B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:28:01 -0400
Received: from verein.lst.de ([213.95.11.211]:35661 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhGVS17 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:27:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0261867373; Thu, 22 Jul 2021 21:08:32 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:08:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/24] block: add a queue_max_sectors_bytes helper
Message-ID: <20210722190831.GA14921@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-13-hch@lst.de> <f09654a9-a3aa-d75b-0f2a-666cdb02917e@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09654a9-a3aa-d75b-0f2a-666cdb02917e@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 10:37:36AM -0700, Bart Van Assche wrote:
> On 7/11/21 10:48 PM, Christoph Hellwig wrote:
>> +static inline int queue_max_sectors_bytes(struct request_queue *q)
>> +{
>> +	return min_t(unsigned int, queue_max_sectors(q), INT_MAX >> 9) << 9;
>> +}
>
> Should this function return a signed or an unsigned integer? I'm asking 
> because I see 'unsigned int' as the first argument for min_t().

Yes, it really should be unsigned.
