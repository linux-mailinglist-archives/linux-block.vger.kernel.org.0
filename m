Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555C472D8AE
	for <lists+linux-block@lfdr.de>; Tue, 13 Jun 2023 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjFMEgL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Jun 2023 00:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFMEgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 00:36:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A410DC;
        Mon, 12 Jun 2023 21:36:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17C9968BFE; Tue, 13 Jun 2023 06:36:02 +0200 (CEST)
Date:   Tue, 13 Jun 2023 06:36:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>
Subject: Re: [PATCH v5 6/7] scsi: replace scsi_target_block() by
 scsi_block_targets()
Message-ID: <20230613043601.GC13400@lst.de>
References: <20230612165049.29440-1-mwilck@suse.com> <20230612165049.29440-7-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612165049.29440-7-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +scsi_block_targets(struct device *dev, struct Scsi_Host *shost)

I think the logical argument order would be to pass the shost first.

> -extern void scsi_target_block(struct device *);
> +extern void scsi_block_targets(struct device *dev, struct Scsi_Host *shost);

And please drop the pointless extern here.

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>

