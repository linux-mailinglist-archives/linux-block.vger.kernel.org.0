Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3395811A
	for <lists+linux-block@lfdr.de>; Thu, 27 Jun 2019 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0LEP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 07:04:15 -0400
Received: from verein.lst.de ([213.95.11.211]:51624 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfF0LEP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 07:04:15 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E703868B20; Thu, 27 Jun 2019 13:03:42 +0200 (CEST)
Date:   Thu, 27 Jun 2019 13:03:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     hch@lst.de, keith.busch@intel.com, sagi@grimberg.me,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 5/5] nvme: add support weighted round robin queue
Message-ID: <20190627110342.GA13612@lst.de>
References: <cover.1561385989.git.zhangweiping@didiglobal.com> <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com> <20190627103719.GC4421@minwooim-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627103719.GC4421@minwooim-desktop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 27, 2019 at 07:37:19PM +0900, Minwoo Im wrote:
> Hi, Maintainers
> 
> Would you guys please give some thoughts about this patch?  I like this
> feature WRR addition to the driver so I really want to hear something
> from you guys.

We are at the end of the merge window with tons of things to sort out.
A giant feature series with a lot of impact is not at the top of the
priority list right now.
