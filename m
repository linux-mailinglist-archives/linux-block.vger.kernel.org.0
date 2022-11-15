Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895036292CC
	for <lists+linux-block@lfdr.de>; Tue, 15 Nov 2022 08:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbiKOH6B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Nov 2022 02:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiKOH5v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Nov 2022 02:57:51 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DDC186C5
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 23:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=0WNlDzWmFMY3O6fQLAv9QhLuu1
        Ln6mepJV+KKC8hfzqRg/QAgGOau+DkocLvbzMUkDQPE/VOYyyUl9o6samDVGCRQyiIwhvhgjK5iC4
        CmzKK0Ybt5f4Geoc8m+/Qw/0qpMZJI4aknEm/mHGogr6XeKMPnhkkvJvvolWarOgYxDKAx/65CBT5
        lUMDVgPtiEqRy+8Zx66yrZMZGEkLE0kCFlYzoeyzA14MwTybu3B/igYnJ1rv7199ZqyDT+uyQ4QxT
        pslPcCCIDvnmAz28V2iScu8lPqrzARIQnUdI3KRHWWG/yoRpMhV57JSLUshIS7Bz3dixoPOIrobYq
        Gi0zjvqw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouqpK-008nnA-42; Tue, 15 Nov 2022 07:57:50 +0000
Date:   Mon, 14 Nov 2022 23:57:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chris Mason <clm@fb.com>
Cc:     hch@infradead.org, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, riel@surriel.com, hannes@cmpxchg.org
Subject: Re: [PATCH] blk-cgroup: properly pin the parent in blkcg_css_online
Message-ID: <Y3NGfng0gNnbnbRS@infradead.org>
References: <20221114181930.2093706-1-clm@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114181930.2093706-1-clm@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
