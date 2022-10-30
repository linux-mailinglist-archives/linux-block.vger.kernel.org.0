Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBC361296D
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 10:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJ3J2P (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJ3J2O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 05:28:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F2E248
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 02:28:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FFEF68AA6; Sun, 30 Oct 2022 10:28:09 +0100 (CET)
Date:   Sun, 30 Oct 2022 10:28:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme: remove the NVME_NS_DEAD check in
 nvme_validate_ns
Message-ID: <20221030092808.GD5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-8-hch@lst.de> <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acc757b0-2d4d-6f1a-504e-73eadef59d35@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 03:52:25PM +0300, Sagi Grimberg wrote:
>
>> We never rescan namespaces after marking them dead, so this check is dead
>> now.
>
> scan_work can still run, I'd keep this one.

At this time the controller already has a non-live state, so the
command won't make it anywhere and thus except for a tiny race we
won't even get to this call.

That being said if we flush the scan_work earlier this will all become
moot anyway.
