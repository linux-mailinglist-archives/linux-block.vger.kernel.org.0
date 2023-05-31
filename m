Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A266271758F
	for <lists+linux-block@lfdr.de>; Wed, 31 May 2023 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjEaE2D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 May 2023 00:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjEaE1h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 00:27:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B24A1BD;
        Tue, 30 May 2023 21:26:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 89F1768B05; Wed, 31 May 2023 06:26:51 +0200 (CEST)
Date:   Wed, 31 May 2023 06:26:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com
Subject: Re: [PATCH v6 18/20] block: add __bio_add_folio
Message-ID: <20230531042651.GO32705@lst.de>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com> <5a142a7663a4beb2966d82f25708a9f22316117c.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a142a7663a4beb2966d82f25708a9f22316117c.1685461490.git.johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 30, 2023 at 08:49:21AM -0700, Johannes Thumshirn wrote:
> Just like for bio_add_pages() add a no-fail variant for bio_add_folio().

Can we call this bio_add_folio_nofail?  I really regret the __ prefix for
bio_add_page these days - it wasn't really intended to be used as widely
originally..

> +void __bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);

.. and please spell out the parameters.
