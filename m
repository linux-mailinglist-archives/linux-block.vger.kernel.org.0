Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95A4536AC9
	for <lists+linux-block@lfdr.de>; Sat, 28 May 2022 06:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiE1Ewk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 28 May 2022 00:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiE1Ewj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 00:52:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E2111CB4B
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 21:52:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AE78E68B05; Sat, 28 May 2022 06:52:33 +0200 (CEST)
Date:   Sat, 28 May 2022 06:52:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: take destination bvec offsets into account in
 bio_copy_data_iter
Message-ID: <20220528045233.GA13168@lst.de>
References: <20220524143919.1155501-1-hch@lst.de> <a1e6fd92-ed3d-f94c-43a7-ff4fca27b759@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e6fd92-ed3d-f94c-43a7-ff4fca27b759@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 27, 2022 at 08:36:47PM -0600, Jens Axboe wrote:
> On 5/24/22 8:39 AM, Christoph Hellwig wrote:
> > Appartly bcache can copy into bios that do not just contain fresh
> > pages but can have offsets into the bio_vecs.  Restore support for tht
> > in bio_copy_data_iter.
> > 
> > Fixes: 8b679a070c53 ("block: rewrite bio_copy_data_iter to use bvec_kmap_local and memcpy_to_bvec")
> 
> Applied, but where is this sha from? The upstream one is f8b679a070c5.

Apparently from my copy and pasting discarding the initial f of that..
