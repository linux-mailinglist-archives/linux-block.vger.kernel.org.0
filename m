Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0811E50DA6D
	for <lists+linux-block@lfdr.de>; Mon, 25 Apr 2022 09:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiDYHw0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Apr 2022 03:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiDYHwY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 03:52:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEB0D0
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 00:49:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 06AA868AA6; Mon, 25 Apr 2022 09:49:19 +0200 (CEST)
Date:   Mon, 25 Apr 2022 09:49:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
Message-ID: <20220425074918.GA10320@lst.de>
References: <20220423143952.3162999-1-ming.lei@redhat.com> <20220423143952.3162999-3-ming.lei@redhat.com> <20220423162937.GA28340@lst.de> <YmUXPA4EE5jOo1yz@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmUXPA4EE5jOo1yz@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 24, 2022 at 05:24:12PM +0800, Ming Lei wrote:
> > As the debugfs directory use the name of the gendisk, the lifetime rules
> > should simply match those of the gendisk.  If anyone wants to trace
> > SCSI commands sent before probing the gendisk or after removing it
> > they can use blktrace on the /dev/sg node.
> 
> Not sure blktrace can trace on /dev/sg since blktrace works on
> block_device.

Unless someone broke it recently it does.  Take a look at all the mess
it causes in the blktrace code.
