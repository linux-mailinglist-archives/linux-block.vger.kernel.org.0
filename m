Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC60D585188
	for <lists+linux-block@lfdr.de>; Fri, 29 Jul 2022 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiG2O0M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 Jul 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbiG2O0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 10:26:10 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E22183A
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 07:26:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8205068AA6; Fri, 29 Jul 2022 16:26:05 +0200 (CEST)
Date:   Fri, 29 Jul 2022 16:26:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chao Leng <lengchao@huawei.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
Message-ID: <20220729142605.GA395@lst.de>
References: <20220729073948.32696-1-lengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729073948.32696-1-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Why can't we have a per-tagset quiesce flag and just wait for the
one?  That also really nicely supports the problem with changes in
the namespace list during that time.
