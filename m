Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A663D2C52
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGVSYj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:24:39 -0400
Received: from verein.lst.de ([213.95.11.211]:35636 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230262AbhGVSYj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:24:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C81268AFE; Thu, 22 Jul 2021 21:05:11 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:05:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 01/24] bsg: remove support for SCSI_IOCTL_SEND_COMMAND
Message-ID: <20210722190511.GA14806@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-2-hch@lst.de> <07be7708-2084-d682-15f8-626ad0a5753f@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07be7708-2084-d682-15f8-626ad0a5753f@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 10:31:13AM -0700, Bart Van Assche wrote:
>> +				current->comm);
>> +		return -EINVAL;
>>   	default:
>>   		return -ENOTTY;
>>   	}
>
> The Fixes: tag will cause this patch to be backported to stable trees. Is 
> that intentional?

Yes, as this ioctl actively does the wrong thing for non-scsi queues.
