Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF894B05DF
	for <lists+linux-block@lfdr.de>; Thu, 10 Feb 2022 06:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbiBJFwN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 10 Feb 2022 00:52:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiBJFv5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Feb 2022 00:51:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D23810ED;
        Wed,  9 Feb 2022 21:51:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6A40F68B05; Thu, 10 Feb 2022 06:51:51 +0100 (CET)
Date:   Thu, 10 Feb 2022 06:51:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        target-devel@vger.kernel.org, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, manoj@linux.ibm.com, mrochs@linux.ibm.com,
        ukrishn@linux.ibm.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, drbd-dev@lists.linbit.com,
        dm-devel@redhat.com
Subject: Re: remove REQ_OP_WRITE_SAME v2
Message-ID: <20220210055151.GA3491@lst.de>
References: <20220209082828.2629273-1-hch@lst.de> <yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1wni3sz4k.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 09, 2022 at 01:00:26PM -0500, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > Now that we are using REQ_OP_WRITE_ZEROES for all zeroing needs in the
> > kernel there is very little use left for REQ_OP_WRITE_SAME.  We only
> > have two callers left, and both just export optional protocol features
> > to remote systems: DRBD and the target code.
> 
> No particular objections from me. I had a half-baked series to do the
> same thing.
> 
> One thing I would like is to either pull this series through SCSI or do
> the block pieces in a post merge branch because I'm about to post my
> discard/zeroing rework and that's going to clash with your changes.

I'd be fine with taking this through the SCSI tree.  Or we can wait
another merge window to make your life easier.
