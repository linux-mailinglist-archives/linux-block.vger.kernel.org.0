Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5566BF858
	for <lists+linux-block@lfdr.de>; Sat, 18 Mar 2023 07:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCRG3Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 18 Mar 2023 02:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCRG3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Mar 2023 02:29:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BA1399C6
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 23:29:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80B8468C4E; Sat, 18 Mar 2023 07:29:09 +0100 (CET)
Date:   Sat, 18 Mar 2023 07:29:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/2] Submit split bios in LBA order
Message-ID: <20230318062909.GB24880@lst.de>
References: <20230317195938.1745318-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195938.1745318-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:59:36PM -0700, Bart Van Assche wrote:
> Hi Jens,
> 
> For zoned storage it is essential that split bios are submitted in LBA order.
> This patch series realizes this by modifying __bio_split_to_limits() such that
> it submits the first bio fragment and returns the remainder instead of
> submitting the remainder and returning the first bio fragment. Please consider
> this patch series for the next merge window.

Why are you sending large writes using REQ_OP_WRITE and not
using REQ_OP_ZONE_APPEND which side steps all these issues?
