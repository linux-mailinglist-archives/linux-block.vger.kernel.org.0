Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133055112E
	for <lists+linux-block@lfdr.de>; Mon, 20 Jun 2022 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239205AbiFTHOn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jun 2022 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbiFTHOh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 03:14:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6908E08E;
        Mon, 20 Jun 2022 00:14:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1010868AA6; Mon, 20 Jun 2022 09:14:34 +0200 (CEST)
Date:   Mon, 20 Jun 2022 09:14:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        snitzer@kernel.org, hch@lst.de, axboe@kernel.dk,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Add PR callouts for read keys and
 reservation
Message-ID: <20220620071433.GF11418@lst.de>
References: <20220603065536.5641-1-michael.christie@oracle.com> <20220603065536.5641-5-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603065536.5641-5-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 03, 2022 at 01:55:29AM -0500, Mike Christie wrote:
> Add callouts for reading keys and reservations.
> 
> Note: This only initially adds the struct definitions in the kernel as I'm
> not sure if we wanted to export the interface to userspace yet. We may
> want to refine internally for LIO and when we can enable it for NVMe then
> add the finished interface to userspace.

Yes, this sounds like a good plan.  I can see how they would be useful
for userspace, but I'm also perfectly fine with us not locking ourselves
into an ABI quite yet.
