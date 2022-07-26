Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332385818BF
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiGZRo7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jul 2022 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiGZRo7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 13:44:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536F1001;
        Tue, 26 Jul 2022 10:44:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AFD5668AA6; Tue, 26 Jul 2022 19:44:54 +0200 (CEST)
Date:   Tue, 26 Jul 2022 19:44:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix double shift bug
Message-ID: <20220726174454.GA13897@lst.de>
References: <Yt/2R/+MJf/MSoyl@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt/2R/+MJf/MSoyl@kili>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

although as-is I would not call it a bug yet as we're not going out
of unsigned long range yet.
