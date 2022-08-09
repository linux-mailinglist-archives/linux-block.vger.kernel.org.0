Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD6258D476
	for <lists+linux-block@lfdr.de>; Tue,  9 Aug 2022 09:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbiHIHV7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Aug 2022 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHIHV6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 03:21:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E2220F66;
        Tue,  9 Aug 2022 00:21:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 330FA68C7B; Tue,  9 Aug 2022 09:21:55 +0200 (CEST)
Date:   Tue, 9 Aug 2022 09:21:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        hch@lst.de, linux-nvme@lists.infradead.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 12/20] block,nvme,scsi,dm: Add blk_status to pr_ops
 callouts.
Message-ID: <20220809072155.GF11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-13-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-13-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 08, 2022 at 07:04:11PM -0500, Mike Christie wrote:
> To handle both cases, this patch adds a blk_status_t arg to the pr_ops
> callouts. The lower levels will convert their device specific error to
> the blk_status_t then the upper levels can easily check that code
> without knowing the device type. It also allows us to keep userspace
> compat where it expects a negative -Exyz error code if the command fails
> before it's sent to the device or a device/tranport specific value if the
> error is > 0.

Why do we need two return values here?
