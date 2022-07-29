Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C59E585180
	for <lists+linux-block@lfdr.de>; Fri, 29 Jul 2022 16:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbiG2OYm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jul 2022 10:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiG2OYf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:24:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704837B372
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:24:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C2E8F68AA6; Fri, 29 Jul 2022 16:24:31 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:24:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/5] ublk_drv: cleanup ublksrv_ctrl_dev_info
Message-ID: <20220729142431.GE32321@lst.de>
References: <20220729072954.1070514-1-ming.lei@redhat.com> <20220729072954.1070514-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220729072954.1070514-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 03:29:54PM +0800, Ming Lei wrote:
> Remove all block device related info from ublksrv_ctrl_dev_info,
> meantime reduce its size into 64 bytes because:
> 
> 1) ublksrv_ctrl_dev_info becomes cleaner without including any
> block related info
> 
> 2) generic set/get parameter command can be used to set block
> related setting easily and cleanly
> 
> 3) generic set/get parameter command can be used for extending
> ublk without needing more info in ublksrv_ctrl_dev_info

This should condense the structure instead of spreading random
reserveѕ.

One more reason why we should not just merge half-baked UAPIs before
a few good rounds of review :(
