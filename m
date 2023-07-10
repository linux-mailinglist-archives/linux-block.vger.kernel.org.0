Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5210A74CD4D
	for <lists+linux-block@lfdr.de>; Mon, 10 Jul 2023 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGJGlP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Jul 2023 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjGJGlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 02:41:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8211F1A5
        for <linux-block@vger.kernel.org>; Sun,  9 Jul 2023 23:41:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8385F6732D; Mon, 10 Jul 2023 08:41:09 +0200 (CEST)
Date:   Mon, 10 Jul 2023 08:41:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to
 calculate io queues
Message-ID: <20230710064109.GB24519@lst.de>
References: <20230708020259.1343736-1-ming.lei@redhat.com> <20230708020259.1343736-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708020259.1343736-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> Take blk-mq's knowledge into account for calculating io queues.
> 
> Fix wrong queue mapping in case of kdump kernel.
> 
> On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs.

That's simply broken.  Please fix the arch code to make sure
it does not return a bogus num_possible_cpus value for these
setups, otherwise you'll have to paper over it in all kind of
drivers.
