Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A8B52D596
	for <lists+linux-block@lfdr.de>; Thu, 19 May 2022 16:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiESOIV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 May 2022 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiESOIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 10:08:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C9F60DAA;
        Thu, 19 May 2022 07:08:19 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3313A68AFE; Thu, 19 May 2022 16:08:16 +0200 (CEST)
Date:   Thu, 19 May 2022 16:08:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: provide stubs for blkcg_get_fc_appid()
Message-ID: <20220519140816.GA21378@lst.de>
References: <20220519140021.6905-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519140021.6905-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 19, 2022 at 04:00:21PM +0200, Hannes Reinecke wrote:
> Provide stubs for blkcg_set_fc_appid() and  blkcg_get_fc_appid() to allow
> for compilation with cgroups disabled.
> 
> Fixes: db05628435aa ("blk-cgroup: move blkcg_{get,set}_fc_appid out of line")
> Signed-off-by: Hannes Reinecke <hare@suse.de>

No, it does not fix that commit, which is perfectly fine.  It fixes
the recently added second caller of blkcg_get_fc_appid, and James
has just resent a new version of that which fixes this properly.
