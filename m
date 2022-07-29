Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39AD585178
	for <lists+linux-block@lfdr.de>; Fri, 29 Jul 2022 16:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiG2OWb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jul 2022 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiG2OWa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:22:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31F36C138
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:22:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6DB7168AA6; Fri, 29 Jul 2022 16:22:26 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:22:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/5] ublk_drv: add SET_PARAM/GET_PARAM control
 command
Message-ID: <20220729142226.GC32321@lst.de>
References: <20220729072954.1070514-1-ming.lei@redhat.com> <20220729072954.1070514-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729072954.1070514-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 29, 2022 at 03:29:52PM +0800, Ming Lei wrote:
> The parameter passed from userspace is added to one array, and the type is
> used as index of the array. The following patch will add two parameter
> types: basic(covers basic queue setting and misc settings which can't be grouped

A bunch of overly long lines here.

But I still think this is the wrong design.  The number of potential
parameter is very limited, so splitting them over multiple ioctls
and data structure for no good reason is really a de-optimization
that makes the code more complex and slower.
