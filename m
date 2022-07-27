Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7E3582AC3
	for <lists+linux-block@lfdr.de>; Wed, 27 Jul 2022 18:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiG0QXQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jul 2022 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiG0QWl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:22:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27884D167
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:22:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CEFA68AA6; Wed, 27 Jul 2022 18:22:34 +0200 (CEST)
Date:   Wed, 27 Jul 2022 18:22:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 3/5] ublk_drv: add SET_PARAM/GET_PARAM control
 command
Message-ID: <20220727162234.GB18969@lst.de>
References: <20220727141628.985429-1-ming.lei@redhat.com> <20220727141628.985429-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727141628.985429-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As stated in the previous discussion I think this is a very bad idea
that leads to a lot of boiler plate code.  If you don't want to rely
on zeroed fields we can add a mask of valid fields, similar to how
e.g. the statx API works.
