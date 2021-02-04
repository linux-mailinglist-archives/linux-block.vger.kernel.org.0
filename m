Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87230EDFD
	for <lists+linux-block@lfdr.de>; Thu,  4 Feb 2021 09:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhBDIFs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Feb 2021 03:05:48 -0500
Received: from verein.lst.de ([213.95.11.211]:54840 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234878AbhBDIF3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 03:05:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A77D768CEC; Thu,  4 Feb 2021 09:04:43 +0100 (CET)
Date:   Thu, 4 Feb 2021 09:04:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v5 0/3] avoid double request completion and IO error
Message-ID: <20210204080442.GA30542@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com> <20210203161455.GB4116@lst.de> <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d39e0a4-3765-85b8-aab5-b0ded93f8bec@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 04, 2021 at 01:56:34PM +0800, Chao Leng wrote:
> This looks good to me.
> Thank you very much.

Thanks a lot to you!

Please double check there version here:

http://git.infradead.org/nvme.git/shortlog/refs/heads/nvme-5.12
