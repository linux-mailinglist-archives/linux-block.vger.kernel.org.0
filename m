Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B70E5B8760
	for <lists+linux-block@lfdr.de>; Wed, 14 Sep 2022 13:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiINLmI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 14 Sep 2022 07:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiINLmI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2022 07:42:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DF7B2BF
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:42:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g3so4351312wrq.13
        for <linux-block@vger.kernel.org>; Wed, 14 Sep 2022 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=htDGENuQtq43qhmWgK7QIRMzYBo6296bz8Vfw5UgOVKZ1mcdLlzO99Kys9b4mbzGYE
         4DpKNNyMMJeUEPUvTkivHDmudn9erl8Xl5QVjIrvZjxSjlkpNcWcrLq7NqMqezjBFJ59
         cwiC7FtsOZESPb+E3lPsrCe/6DfsuS/zqHVNiXDQ7oB6WYaRGsY8jEvQs5HGRNYErn91
         /bxE6hl6HRLgl4dbe/rxfCiM5GKxQEs8nbbVUkBRhr3Ns9712JwjQ393UNHnFDAx9LR6
         tJyFmwqQZf6iIlSL0WaJBKA0bHpRHYUuBlWUR/tm18RG6me+1gj2hyg/OH06AhyC8lq4
         0KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ljBV21/rt7xHP9hdJuGiN1G45ZLlbidyAGuNrkqe6Lk=;
        b=tra5IIGhFCvIlBkvAw6pgaSNG1ZhxHd8S9n96q3Tc/BwHIcLP2K1mU/NsemiU2X1Ul
         Nmb58NeIMTVPw8Gt60Q+/YWC9ZrY0BH2Nt/od0Wscf2/dvEG4V0lmq4KpHG1TD5x9gg5
         uzNJTF3iu+MuW501iZ+Xgff0PT2UrfjNFPycxGdDGlLimzHkG1Zj5AGyUyYlxIXuoVFf
         MQa8QIRrZrZDPKdGreQfBhwoOl2eZIViTW/DXtFkFgBysKQRJJwJRoTHmmE35m06buVY
         Fw7Zjd5zSOe8BVe0iQhqrBS31cUmdqiJuyPs1x4JSajbkznccN0oOiCHPEJIkjdvOngf
         ygTA==
X-Gm-Message-State: ACgBeo1b8EqIlOfENHoSXYWmOrlyB7XanHp3O3wV0BHS5adxZXwenfTj
        RnF9OWlTH+yFqtQQ43SqswXZlQ==
X-Google-Smtp-Source: AA6agR6IfcvPiHVBT59W7/ls00SW+xc7QmxOy9km38ZHpiVJXWOLMisG8CvkNAYucyBoYWbKMvVNgQ==
X-Received: by 2002:adf:a28e:0:b0:22a:7428:3b04 with SMTP id s14-20020adfa28e000000b0022a74283b04mr10099863wra.75.1663155724464;
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Received: from localhost ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b003a2e92edeccsm5210267wms.46.2022.09.14.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 04:42:04 -0700 (PDT)
Date:   Wed, 14 Sep 2022 12:42:03 +0100
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
Subject: Re: [PATCH 2/5] sched/psi: export psi_memstall_{enter,leave}
Message-ID: <YyG+C+z1n8d1Alty@cmpxchg.org>
References: <20220910065058.3303831-1-hch@lst.de>
 <20220910065058.3303831-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910065058.3303831-3-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Sep 10, 2022 at 08:50:55AM +0200, Christoph Hellwig wrote:
> To properly account for all refaults from file system logic, file systems
> need to call psi_memstall_enter directly, so export it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
