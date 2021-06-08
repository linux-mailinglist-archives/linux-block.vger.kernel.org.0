Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4539FC31
	for <lists+linux-block@lfdr.de>; Tue,  8 Jun 2021 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbhFHQQV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Jun 2021 12:16:21 -0400
Received: from verein.lst.de ([213.95.11.211]:51530 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhFHQQS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 12:16:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DE1667373; Tue,  8 Jun 2021 18:14:23 +0200 (CEST)
Date:   Tue, 8 Jun 2021 18:14:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [EXT] Re: [PATCH v5 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <20210608161422.GA10298@lst.de>
References: <20210120121047.2601-1-bbudiredla@marvell.com> <20210120121047.2601-2-bbudiredla@marvell.com> <CAPDyKFoF7jz-mbsY8kPUGca5civFKRRyPpHbRkj9P=xevRRfbA@mail.gmail.com> <CY4PR1801MB2070F43EFCB9139D8168164FDE3A9@CY4PR1801MB2070.namprd18.prod.outlook.com> <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrVQbALjSeFBckaZQgkgwcBVuwHy563pdBxHQNA7bxRnQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given that Kees was unwilling to take the series to unbreak the pstore
block support I've sent a patch to Jens to mark it broken and thus
effectively disable it.  We can't really let this spread any further.
