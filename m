Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E069762B36E
	for <lists+linux-block@lfdr.de>; Wed, 16 Nov 2022 07:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKPGlB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Nov 2022 01:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiKPGkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 01:40:46 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B240B60E5;
        Tue, 15 Nov 2022 22:40:45 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CDCE68AA6; Wed, 16 Nov 2022 07:40:43 +0100 (CET)
Date:   Wed, 16 Nov 2022 07:40:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/4] nvme: Convert NVMe errors to PR errors
Message-ID: <20221116064042.GC19581@lst.de>
References: <20221115212825.7945-1-michael.christie@oracle.com> <20221115212825.7945-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115212825.7945-5-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 15, 2022 at 03:28:25PM -0600, Mike Christie wrote:
> This converts the NVMe errors we commonly see during PR handling to PR_STS
> errors or -Exyz errors. pr_ops callers can then handle scsi and nvme errors
> without knowing the device types.

Looks fine, although the improvement suggested by Chaitanya would be
nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>
