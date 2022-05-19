Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBCA52CC80
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 09:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiESHJ3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 03:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiESHJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 03:09:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A098868307;
        Thu, 19 May 2022 00:09:25 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00AED68AFE; Thu, 19 May 2022 09:09:21 +0200 (CEST)
Date:   Thu, 19 May 2022 09:09:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: cleanup blk_execute_rq*
Message-ID: <20220519070921.GA22301@lst.de>
References: <20220517064901.3059255-1-hch@lst.de> <28682d9a-ac58-ea19-6d51-73fbd87bfb5e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28682d9a-ac58-ea19-6d51-73fbd87bfb5e@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 18, 2022 at 04:40:55PM -0600, Jens Axboe wrote:
> On 5/17/22 12:48 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series cleans up the blk_execute_rq* helpers.  It simplifies the
> > plugging mess a bit, fixes the sparse __bitwise warnings and simplifies
> > the blk_execute_rq_nowait API a bit.
> 
> Looks good to me, but let's do this series post flushing out the
> initial bits. It ends up depending on the passthrough changes,
> yet also conflicts with the nvme changes on the driver side.

Ok.  I'll resend after the initial merged, the buildbot also complained
about a UFS hunk.
