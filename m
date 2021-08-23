Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A5F3F45B1
	for <lists+linux-block@lfdr.de>; Mon, 23 Aug 2021 09:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhHWHSv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Aug 2021 03:18:51 -0400
Received: from verein.lst.de ([213.95.11.211]:46643 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234861AbhHWHSv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 03:18:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AB206736F; Mon, 23 Aug 2021 09:18:07 +0200 (CEST)
Date:   Mon, 23 Aug 2021 09:18:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: Use-after-free related to dm_put_table_device()
Message-ID: <20210823071807.GA22543@lst.de>
References: <a5057305-9864-df8c-0657-ff33c85dc4f6@acm.org> <f340d947-501a-6076-8f43-8ac65c2ea47a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f340d947-501a-6076-8f43-8ac65c2ea47a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 22, 2021 at 06:17:50PM -0700, Bart Van Assche wrote:
> On 8/21/21 8:12 PM, Bart Van Assche wrote:
> > If I run blktests nvmeof-mp/012 then a KASAN use-after-free complaint
> > appears. Since I haven't seen this warning with previous kernel versions,
> > I think this is a regression. Given the presence of bd_unlink_disk_holder()
> > in the call trace, can you take a look Christoph?
> 
> (replying to my own e-mail)
> 
> Reverting commit fbd9a39542ec ("block: remove the extra kobject reference
> in bd_link_disk_holder") makes the KASAN complaints disappear.

The block tree has had a manual revert since Friday.

> However, the
> srp tests and one other test fail with that commit reverted:

Can you send the output?  My usual blktest setup can't run these tests.
