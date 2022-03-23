Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0524E56C5
	for <lists+linux-block@lfdr.de>; Wed, 23 Mar 2022 17:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiCWQrR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Mar 2022 12:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245542AbiCWQrE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Mar 2022 12:47:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747DB5FF29;
        Wed, 23 Mar 2022 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O6SFKONUTvLIQdQzfaDKFf4xslPRUYzgRdkwBAJy9AU=; b=F4bY1Ko8RtdLoTqRAtzKuUTF04
        J4sfCqUaTCB7QFLrhyYUi+pV3sT6yV2XcC5i/mNuLOwkC4NVgmaoLyMcPUM4r7IEKCSqzjJNm5Aw3
        u//0QeuZ+BGuAeSupgDQqjpHLdXUeRrwv9F2kltz0ql8mkB/mGE0PIstMn9r16vkswUHcIWHNUVvH
        n8tsBPOhe3SMRp/xEv4JhF5F5o9Yr5dBpBe7/cnTe6W5G0Bq8PXPga5CTE7syNTrLyk/J8GSAvGWA
        tt8ulAOL6+KZX3F1NnP9TpqbUe+Ibqk/7l/536dwpW4/1FnzY3TlRWjh1016z4o517klXtc0e2ObQ
        oqJTMGqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX46v-00EHrK-6J; Wed, 23 Mar 2022 16:45:25 +0000
Date:   Wed, 23 Mar 2022 09:45:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, target-devel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        xuyu@linux.alibaba.com, bostroesser@gmail.com
Subject: Re: [RFC 1/3] mm/memory.c: introduce vm_insert_page(s)_mkspecial
Message-ID: <YjtOpf1bf0qH87HD@infradead.org>
References: <20220318095531.15479-1-xiaoguang.wang@linux.alibaba.com>
 <20220318095531.15479-2-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318095531.15479-2-xiaoguang.wang@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I relaly don't think we should add this amount of overhead to the
core VM for a (relatively) irrelevant driver.
