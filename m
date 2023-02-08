Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CB768F1B1
	for <lists+linux-block@lfdr.de>; Wed,  8 Feb 2023 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjBHPMk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 8 Feb 2023 10:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjBHPMj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 10:12:39 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C32107
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 07:12:36 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B445668C7B; Wed,  8 Feb 2023 16:12:31 +0100 (CET)
Date:   Wed, 8 Feb 2023 16:12:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-cgroup: delay calling blkcg_exit_disk until
 disk_release
Message-ID: <20230208151231.GA16018@lst.de>
References: <20230208063514.171485-1-hch@lst.de> <Y+NRgI+99Gz33BvQ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+NRgI+99Gz33BvQ@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 08, 2023 at 03:38:40PM +0800, Ming Lei wrote:
> > This now can cause a case where disk_release is called on a disk
> > that hasn't been added.  That's mostly harmless, except for a case
> > in blk_throttl_exit that now needs to check for a NULL ->td pointer.
> 
> With this way, blkcg_init_disk() could be called before q->root_blkg
> is released in disk unbind & rebind use case, then memory leak?

q->root_blkg is now disk->root_blkg.  So in an unind and rebind case
a different disk will be involved.

