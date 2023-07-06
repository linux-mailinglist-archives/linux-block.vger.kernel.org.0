Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16DB74A10B
	for <lists+linux-block@lfdr.de>; Thu,  6 Jul 2023 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjGFPcG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jul 2023 11:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjGFPcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 11:32:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0DBBA;
        Thu,  6 Jul 2023 08:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OcmDcA2w/L1lHnlZrwRLksnmZ52AfyCMFAOcR/tiwrg=; b=CnZWUl66G57JWeMq3Cumm9nGHy
        v5NuUfSTp48+X5P0+Mpr6wABQnANv6kh5ZvyaKkxHVVXymOryBWC+NdeDQHFkgwlzl+sdXRKNfoES
        dm6adObEyutfkZXL3b47P+961rwnxXp+05kxhnVkGsV7jjZRzwqHyd/QTB2MOsqpWIX+GD637oFjh
        4KW7JsHk1PRz2zWxEgJOYgnkR9IKZfeKMlRO+4QAqo7ACn6RV8hfl6WOh5d/QRf6OZx3E9Mh8E+UJ
        o6fdzAczPKvtWkSrAx24Bxq5YFmjMyz6Wv+u+n4gBXmxQ4CsxL+icvARitB0PgCKsZojcNI4K0Lfs
        tGMUhcxQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHQxT-0020wj-1O;
        Thu, 06 Jul 2023 15:31:51 +0000
Date:   Thu, 6 Jul 2023 08:31:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC PATCH 08/11] iov_iter: Drop iov_iter_rw() and fold in last
 user
Message-ID: <ZKbeZ3yq5y8ORCZH@infradead.org>
References: <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-9-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152524.661208-9-dhowells@redhat.com>
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

On Fri, Jun 30, 2023 at 04:25:21PM +0100, David Howells wrote:
> Drop the last usage of iov_iter_rw() into __iov_iter_get_pages_alloc().

Well, if we can't just drop this check entirely, the rest of the prep
work is just churn and not actually very useful.  Shouldn't we go
all the way and kill ITER_DEST/SOURCE?

