Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F56A62242A
	for <lists+linux-block@lfdr.de>; Wed,  9 Nov 2022 07:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKIGwz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Nov 2022 01:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIGwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 01:52:53 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA759175A2;
        Tue,  8 Nov 2022 22:52:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B28FB68AFE; Wed,  9 Nov 2022 07:52:49 +0100 (CET)
Date:   Wed, 9 Nov 2022 07:52:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: Convert SCSI errors to PR_STS errors
Message-ID: <20221109065249.GB11097@lst.de>
References: <20221109031106.201324-1-michael.christie@oracle.com> <20221109031106.201324-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109031106.201324-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 09:11:05PM -0600, Mike Christie wrote:
> This converts the SCSI errors we commonly see during PR handling to PT_STS
> errors, so pr_ops callers can handle scsi and nvme errors without knowing
> the device types.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
