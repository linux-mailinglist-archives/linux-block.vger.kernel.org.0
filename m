Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2161290D
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJ3IUg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 04:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJ3IUg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 04:20:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A75BE31;
        Sun, 30 Oct 2022 01:20:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1D8968AA6; Sun, 30 Oct 2022 09:20:20 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:20:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts
Message-ID: <20221030082020.GC4774@lst.de>
References: <20221026231945.6609-1-michael.christie@oracle.com> <20221026231945.6609-13-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026231945.6609-13-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 06:19:38PM -0500, Mike Christie wrote:
> To handle both cases and keep userspace compatibility, this patch adds a
> blk_status_t arg to the pr_ops callouts. The lower levels will convert
> their device specific error to the blk_status_t then the upper levels
> can easily check that code without knowing the device type. Adding the
> extra return value will then allow us to not break userspace which expects
> a negative -Exyz error code if the command fails before it's sent to the
> device or a device/driver specific value if the error is > 0.

I really hate this double error return.  What -E* statuses that matter
can be returned without a BLK_STS_* equivalent that we couldn't convert
to and from?
