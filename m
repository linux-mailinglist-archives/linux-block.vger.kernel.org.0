Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DC2512D5
	for <lists+linux-block@lfdr.de>; Tue, 25 Aug 2020 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgHYHPw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Aug 2020 03:15:52 -0400
Received: from verein.lst.de ([213.95.11.211]:57746 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729194AbgHYHPv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 03:15:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3CA0868BEB; Tue, 25 Aug 2020 09:15:49 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:15:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, axboe@fb.com
Subject: Re: [PATCH 2/3] nvme-core: fix deadlock when reconnect failed due
 to nvme_set_queue_count timeout
Message-ID: <20200825071548.GG29268@lst.de>
References: <20200820035406.1720-1-lengchao@huawei.com> <20200821075034.GB30216@lst.de> <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf66315-9e36-2105-535e-a90352ec5306@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 21, 2020 at 01:20:44PM -0700, Sagi Grimberg wrote:
>>> Many functions which call __nvme_submit_sync_cmd treat error code in two
>>> modes: If error code less than 0, treat as command failed. If erroe code
>>> more than 0, treat as target not support or other and continue.
>>> NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both are cancled io
>>> by host, is not the real error code return from target. So we need set
>>> the flag:NVME_REQ_CANCELLED. Thus __nvme_submit_sync_cmd translate
>>> the error to INTR, nvme_set_queue_count will return error, reconnect
>>> process will terminate instead of continue.
>>
>> But we could still race with a real completion.  I suspect the right
>> answer is to translate NVME_SC_HOST_ABORTED_CMD and
>> NVME_SC_HOST_PATH_ERROR to a negative error code in
>> __nvme_submit_sync_cmd.
>
> So the scheme you suggest is:
> - treat any negative status or !DNR as "we never made it to
> the target"
> - Any positive status with DNR is a "controller generated status"
>
> This will need a careful audit of all the call-sites we place such
> assumptions...

No.  negative error means never made it to the controller, and we need
to map the magic NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR
errors to negative error codes if we want to keep using them (and IIRC
we started because it solved an issue, by my memory is foggy).  All the
real NVMe status codes come from the controller, so the commmand must
have made it there.
