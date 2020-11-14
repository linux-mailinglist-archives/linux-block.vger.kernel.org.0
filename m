Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770B2B2C62
	for <lists+linux-block@lfdr.de>; Sat, 14 Nov 2020 10:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgKNJS2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 14 Nov 2020 04:18:28 -0500
Received: from verein.lst.de ([213.95.11.211]:49799 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgKNJS1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Nov 2020 04:18:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A33067373; Sat, 14 Nov 2020 10:18:25 +0100 (CET)
Date:   Sat, 14 Nov 2020 10:18:25 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        linux-block@vger.kernel.org
Subject: Re: split hard read-only vs read-only policy
Message-ID: <20201114091825.GA18618@lst.de>
References: <20201113084702.4164912-1-hch@lst.de> <4f8190a8-55a3-bc2d-540f-75e666810dd4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8190a8-55a3-bc2d-540f-75e666810dd4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 13, 2020 at 11:51:38AM -0800, Sagi Grimberg wrote:
>
>> Hi Jens,
>>
>> this series resurrects a patch from Martin to properly split the flag
>> indicating a disk has been set read-only by the hardware vs the userspace
>> policy set through the BLKROSET ioctl.
>>
>
> Looks good,
>
> Doesn't this miss restoring the clear disk ro in nvme?

Yes, eventually.
