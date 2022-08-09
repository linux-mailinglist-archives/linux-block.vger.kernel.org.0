Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF958D46E
	for <lists+linux-block@lfdr.de>; Tue,  9 Aug 2022 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiHIHUu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Aug 2022 03:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiHIHUe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Aug 2022 03:20:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B96DFAB;
        Tue,  9 Aug 2022 00:20:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8814668C4E; Tue,  9 Aug 2022 09:20:29 +0200 (CEST)
Date:   Tue, 9 Aug 2022 09:20:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        hch@lst.de, linux-nvme@lists.infradead.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: Re: [PATCH v2 08/20] nvme: Add helper to convert to a pr_ops PR
 type
Message-ID: <20220809072029.GE11161@lst.de>
References: <20220809000419.10674-1-michael.christie@oracle.com> <20220809000419.10674-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809000419.10674-9-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 08, 2022 at 07:04:07PM -0500, Mike Christie wrote:
> This adds a helper to go from the NVMe spec PR type value to the block
> layer pr_type, so for Reservation Report support we can convert from its
> value.

Without a user this is going to create a compiler warning.
