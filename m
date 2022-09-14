Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91385B8776
	for <lists+linux-block@lfdr.de>; Wed, 14 Sep 2022 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiINLrq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Sep 2022 07:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiINLro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 07:47:44 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE207AC24
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:47:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so2138879wmr.1
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jkjInFA4v6207rYNR9PZy7GQsLdw9JOAYyp4dYZPwKo=;
        b=gNw8KIHA1akV3WAIG3mTyAM9FwwfR45IWHpt7v8NJ/D3h8AuPnRAR4Fr9l6bY4Z+l+
         yBth3uvMnFhQguK7OFTCFEvob15XvvYYkQE6d5COR/F3dEL9EtIxWGeLd3Ti+huvh2AS
         UBiZdvfDAe2ffljdOWuaI7kc+tuNrsOiJfuhmKifgcExmxx2CxBo4QEmKguep2CjcgBi
         Mp80NzZ2QTsl+f2ooHri9mIxl/A9EFiJh010AdjbJ9RG0BFdICtooF0X4b+3YpOiUcxo
         PiaQDy5iGBG39jXagGb5CLj0tueVl6vvcptlPqe1xaYjbhuQ/GbIW0ZWRwxqmB33Cc8w
         iz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jkjInFA4v6207rYNR9PZy7GQsLdw9JOAYyp4dYZPwKo=;
        b=S9I2fEbdT9LFJFZ7fjuuGxlpckSvWmH3zWRsZ6CpBcJm3TGFsTy45KNq/6MzoNY47E
         Yo5+uIsLYOAhuurznmhdF3nyKrYo6GEBbT5ptKEVDJ0zZsqvNLpLHer+X8oLLhzfEEwY
         FcIL7myjZYWpRYIEm8zcL4U1ZO8EIZCXv6HTx1HYaF05X7WOR3W2klM56RnCbBJoq0pJ
         9dNJ8f8zS0e/GH60DwqDhNvU5M022aOGJOpYT7DC7ViRh1P/k7XW3WX4WA2SdJEu5wjT
         ZZC0pzHKzjVj1xmsDrfRu6epDcjpAbcOB5Nldze2p5OGca3+bISdh1b75vOitWW/Dmr7
         fFbA==
X-Gm-Message-State: ACgBeo3xM68kdysHLZCKnZ9nnKlTRJz7eUennbaikSxfSDtnE3lq6ojh
        cNUcedu8SMXRr52LR1bosHLcJQ==
X-Google-Smtp-Source: AA6agR6aSV3jXyKXuS6Lp8ysxs2qtNOBdPRNKt7wbfiui0ec8Ug1sA6v6mmiNfrSa5l3/MzmVoabgw==
X-Received: by 2002:a7b:c84c:0:b0:3b3:3faa:10c3 with SMTP id c12-20020a7bc84c000000b003b33faa10c3mr2800743wml.94.1663156061281;
        Wed, 14 Sep 2022 04:47:41 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id n9-20020a5d6609000000b0021e51c039c5sm13066031wru.80.2022.09.14.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:47:40 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:47:40 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] erofs: add manual PSI accounting for the compressed
 address space
Message-ID: <YyG/XKXFNxk+HfXf@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-5-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:57AM +0200, Christoph Hellwig wrote:
> erofs uses an additional address space for compressed data read from disk
> in addition to the one directly associated with the inode.  Reading into
> the lower address space is open coded using add_to_page_cache_lru instead
> of using the filemap.c helper for page allocation micro-optimizations,
> which means it is not covered by the MM PSI annotations for ->read_folio
> and ->readahead, so add manual ones instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
