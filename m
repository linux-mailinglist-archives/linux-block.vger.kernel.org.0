Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B705725338
	for <lists+linux-block@lfdr.de>; Wed,  7 Jun 2023 07:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjFGFKc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Jun 2023 01:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFGFKa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 01:10:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F201726;
        Tue,  6 Jun 2023 22:10:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB01868AA6; Wed,  7 Jun 2023 07:10:24 +0200 (CEST)
Date:   Wed, 7 Jun 2023 07:10:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/3] bsg: increase number of devices
Message-ID: <20230607051024.GA20052@lst.de>
References: <20230606193845.9627-1-mwilck@suse.com> <20230606193845.9627-2-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606193845.9627-2-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 06, 2023 at 09:38:43PM +0200, mwilck@suse.com wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Larger setups may need to allocate more than 32k bsg devices, so
> increase the number of devices to the full range of minor device
> numbers.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>

Martin, if you send this on it also needs your signoff.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
