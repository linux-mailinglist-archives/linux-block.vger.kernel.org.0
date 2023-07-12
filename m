Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F677508F5
	for <lists+linux-block@lfdr.de>; Wed, 12 Jul 2023 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjGLNAY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Jul 2023 09:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjGLNAX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 09:00:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE61982;
        Wed, 12 Jul 2023 06:00:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBA8167373; Wed, 12 Jul 2023 15:00:17 +0200 (CEST)
Date:   Wed, 12 Jul 2023 15:00:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-nvme@lists.infradead.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230712130017.GA12417@lst.de>
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712125455.1986455-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 12, 2023 at 08:54:48PM +0800, Ming Lei wrote:
> +/* Max nr_hw_queues for each hw queue type */
> +unsigned int blk_mq_max_nr_hw_queues(void)
> +{
> +	if (is_kdump_kernel())
> +		return 1;
> +	return nr_cpu_ids;

Again, these is_kdump_kernel hacks don't make any sense.   The amount
of maximum available CPU needs to come through a proper API, and we
need to use it, not add hacks like this.

The only thing that makes sense here is to find the last CPU
in cpu_possible_mask, and for kdump kernels to ensure that number
is 1 or whatever low value they want.

