Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A426026BE
	for <lists+linux-block@lfdr.de>; Tue, 18 Oct 2022 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJRI04 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Oct 2022 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJRI0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 04:26:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB0A98C89
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 01:26:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3CB5868C4E; Tue, 18 Oct 2022 10:26:51 +0200 (CEST)
Date:   Tue, 18 Oct 2022 10:26:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 2/2] block: clear the holder releated fields on late
 disk_add failure
Message-ID: <20221018082651.GA26079@lst.de>
References: <20221018073822.646207-1-hch@lst.de> <20221018073822.646207-2-hch@lst.de> <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c5359e3-39ee-d363-9425-0cb8b716dcb0@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 18, 2022 at 04:00:36PM +0800, Yu Kuai wrote:
> 1) in del_gendisk: (add a new api kobject_put_and_test)
>
> if (kobject_put_and_test(bd_holder_dir/slave_dir))
> 	bd_holder_dir/slave_dir = NULL;
>
> 2) in bd_link_disk_holder, get bd_holder_dir first:
>
> if (!kobject_get_unless_zero(bd_holder_dir))
> 	return -ENODEV;
> ...
> bd_find_holder_disk()
>
> Do you think this is ok?

I'm not quite sure what the point is.

If you want to really clean this up a good thing would be to remove
the delayed holder registration entirely and just do them in dm
after add_disk and remove them before del_gendisk.  I've been wanting
to do that a few times but always gave up due to the mess in dm.
