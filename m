Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DC6726158
	for <lists+linux-block@lfdr.de>; Wed,  7 Jun 2023 15:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbjFGNe4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Jun 2023 09:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbjFGNey (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 09:34:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2511D1993;
        Wed,  7 Jun 2023 06:34:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B8376732D; Wed,  7 Jun 2023 15:34:49 +0200 (CEST)
Date:   Wed, 7 Jun 2023 15:34:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 3/3] scsi: simplify scsi_stop_queue()
Message-ID: <20230607133449.GB20840@lst.de>
References: <20230606193845.9627-1-mwilck@suse.com> <20230606193845.9627-4-mwilck@suse.com> <20230607052710.GC20052@lst.de> <c0563161eb613f9500e6a1cccdcff6fc64efffad.camel@suse.com> <e982c95ad7ee29f80e8c0ba88f0cece837e344b9.camel@suse.com> <20230606193845.9627-1-mwilck@suse.com> <20230606193845.9627-4-mwilck@suse.com> <20230607052710.GC20052@lst.de> <c0563161eb613f9500e6a1cccdcff6fc64efffad.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e982c95ad7ee29f80e8c0ba88f0cece837e344b9.camel@suse.com> <c0563161eb613f9500e6a1cccdcff6fc64efffad.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 07, 2023 at 11:26:04AM +0200, Martin Wilck wrote:
> > cleanups:
> > 
> >   1) remove scsi_internal_device_block and fold it into device_block
> 
> ok
> 
> >   2) move the scsi_internal_device_block in what was
> 
> You mean scsi_stop_queue() here, right?

Yes.

> The reason is simple: I wasn't certain if dev_to_shost() could return
> NULL, and preferred skipping the wait over an Oops. I hear you say that
> dev_to_shost() can't go wrong, so I'll remove the NULL test.

Well, the parent device can't really go away while we have a reference
to a child.  So the only case where it can return NULL is if the
passed in device isn't the child of a SCSI host, which would be a grave
programming error.

> 
> > Btw, as far as I can tell scsi_target_block is never called for
> > a device that is a target device.  It might be worth throwing in
> > another patch to remove support for that case and simplify things
> > further.
> 
> Can we do this separately, maybe? 

Sure.  Would be nice to just tack into onto the end of this series
if you touch the area, though.

> On Wed, 2023-06-07 at 11:26 +0200, Martin Wilck wrote:
> > On Wed, 2023-06-07 at 07:27 +0200, Christoph Hellwig wrote:
> > > 
> > >   3) remove scsi_stop_queue and open code it in the two callers,
> > > one
> > >      of which currently wants nowait semantics, and one that
> > > doesn't.
> > ok
> 
> Hm, scsi_stop_queue() pairs with scsi_start_queue(), do we really want
> to open-code it?

Oh well, feel free to keep it if you prefer it that way.
