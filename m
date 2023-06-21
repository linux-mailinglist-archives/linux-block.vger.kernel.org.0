Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6473836B
	for <lists+linux-block@lfdr.de>; Wed, 21 Jun 2023 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjFUMNj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Jun 2023 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjFUMNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2023 08:13:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9D1733
        for <linux-block@vger.kernel.org>; Wed, 21 Jun 2023 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJ6aMao89kw04QUy0/JqLw3tiRnJ7tZ8x7GgW+IP8+0=; b=1iKNaLttZfW89my+DszE0wSaLz
        3iTgPmiJbY9ulm4tEmY9q+uzOBG9C0FAuJkIq3SeTTqymhPuuf3/8ZDxXwia2FzhYPjqr1/CYxb0F
        FZNrwGLxCCCSxsItwui2ZusZTblvBv8qbJxefK6wn24OlMe7ngHelTRF5UggmHfPeSP8s2M7rQ6Ce
        CtC4irb/lY4lFcaWJmLzDmrxCU2AnAh5n9IVZhgya/1Pq3Sjv8BPErClJKhF/OiNl2qLx3tkaGCx4
        YeRn57kBD6/hzbXUYohe8x9RwMZO0jj+RtYuOpQD4VTc8M+k3UjcquSQFbAVx/rqQxMDqFwhc6MeE
        q+vQdTFA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qBwi8-00EV4i-1o;
        Wed, 21 Jun 2023 12:13:20 +0000
Date:   Wed, 21 Jun 2023 05:13:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nvdimm@lists.linux.dev, virtualization@lists.linux-foundation.org,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, houtao1@huawei.com
Subject: Re: [PATCH] virtio_pmem: do flush synchronously
Message-ID: <ZJLpYMC8FgtZ0k2k@infradead.org>
References: <20230620032838.1598793-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620032838.1598793-1-houtao@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I think the proper minimal fix is to pass in a REQ_WRITE in addition to
REQ_PREFLUSH.  We can than have a discussion on the merits of this
weird async pmem flush scheme separately.

