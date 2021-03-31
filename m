Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3234677E
	for <lists+linux-block@lfdr.de>; Tue, 23 Mar 2021 19:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhCWSXS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 14:23:18 -0400
Received: from verein.lst.de ([213.95.11.211]:33678 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhCWSWs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 14:22:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C958A68B02; Tue, 23 Mar 2021 19:22:44 +0100 (CET)
Date:   Tue, 23 Mar 2021 19:22:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323182244.GA16649@lst.de>
References: <20210322073726.788347-1-hch@lst.de> <20210322073726.788347-3-hch@lst.de> <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me> <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me> <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com> <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me> <20210323161544.GA13402@lst.de> <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 11:13:13AM -0700, Sagi Grimberg wrote:
> The deadlock in this patchset reproduces upstream. It is not possible to
> update the kernel in the env in the original report.
>
> So IFF we assume that this does not reproduce in upstream (pending
> proof), is there something that we can do with stable fixes? This will
> probably go back to everything that is before 5.8...

The direct_make_request removal should be pretty easily backportable.
In old kernels without the streamlined normal path it might cause minor
performance degradations, but the actual change should be trivial.
