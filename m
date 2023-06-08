Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FC7276E2
	for <lists+linux-block@lfdr.de>; Thu,  8 Jun 2023 07:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbjFHFqP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Jun 2023 01:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjFHFqO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 01:46:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD282695;
        Wed,  7 Jun 2023 22:46:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4534D6732D; Thu,  8 Jun 2023 07:46:11 +0200 (CEST)
Date:   Thu, 8 Jun 2023 07:46:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     mwilck@suse.com
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 5/8] scsi: don't wait for quiesce in
 scsi_stop_queue()
Message-ID: <20230608054611.GC11554@lst.de>
References: <20230607182249.22623-1-mwilck@suse.com> <20230607182249.22623-6-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607182249.22623-6-mwilck@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.  Per the discussion on the last patch it probably makes
sense to move this patch before the replacement for patch 2.

Btw, your mail address for Bart is very, very outdated.
