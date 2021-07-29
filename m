Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8B3DA921
	for <lists+linux-block@lfdr.de>; Thu, 29 Jul 2021 18:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhG2Qcq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Jul 2021 12:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhG2Qcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jul 2021 12:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627576362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbFw+xoO3h0Tqx3b8uM1PS4AxjRaaO0844YZWUhMwME=;
        b=DGC47XXAQHcywi8LA6W1+H4DoSjC1Vi8uD7ZM+vbl9prGIfhh668VXyNocXSnydSgEas1o
        aDh9fQ43ZXsnJddSnYxVTK+KC6tDli2Mo5ZHiNfu8cLOzWGF+zQd/ToFRp3uGLFMaUFdBU
        xQBUMPRMWkLz2PjPGA3Zm0ontLFG9Gs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-tQR3-dxoM5a-oQz4o13obg-1; Thu, 29 Jul 2021 12:32:41 -0400
X-MC-Unique: tQR3-dxoM5a-oQz4o13obg-1
Received: by mail-qv1-f70.google.com with SMTP id y10-20020a0cd98a0000b029032ca50bbea1so4203471qvj.12
        for <linux-block@vger.kernel.org>; Thu, 29 Jul 2021 09:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbFw+xoO3h0Tqx3b8uM1PS4AxjRaaO0844YZWUhMwME=;
        b=EV01jWdF91I0KS5tYZezNMhDWtwZ0sTZmt1gqUX/PR6HUoLu+XAt9KJfonKcdVLvr4
         +1iImIrKBubKnfVpLgasRmiEuGyk0VoPib8MAzAvTMD2Ns65Ilt06QIOVaS6qeYc1Y4Y
         GyUnBzjXHAO0GSrQ7rk+Xp9UWXprv0dVwiV3Z+ohi8jv/CKJFoYz0hwarxR3eI/0A+wx
         VxbZt1YLFZtpi48vXPyO1hGl6KXWesPjXH39chgaST+KuXGmiU146bFqugHkW1wGiFUH
         10VD3RxpttrEBjbwl1/0x4sqE07x1gUf/7NoJPq1TEMTOE71tqZYrI6QvsveZhhpdE1c
         LCSg==
X-Gm-Message-State: AOAM531ZRlHZ4uCNKm308hDiJtNWNF7oB1yNO8PRkiUyp/f5LC66HxGh
        2OL8JwSW2WhALsLgU06asaW1Qqi86XCDNp9mBb7FltnQUgu93ITCY5kaFHoPacHOuvmg8QLV3Kw
        xiyCi5zagpBnf9ZE1Ch5imw==
X-Received: by 2002:a05:620a:1904:: with SMTP id bj4mr3026822qkb.283.1627576361064;
        Thu, 29 Jul 2021 09:32:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtKAaVnJ7lXcNK6jx8oCRrhMgmbkvpt9K4BZHi/iPnG6xgooGOCOFzt8GqmKtFEET05sGagw==
X-Received: by 2002:a05:620a:1904:: with SMTP id bj4mr3026807qkb.283.1627576360908;
        Thu, 29 Jul 2021 09:32:40 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id 18sm2070772qkv.118.2021.07.29.09.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:32:40 -0700 (PDT)
Date:   Thu, 29 Jul 2021 12:32:39 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] block: support delayed holder registration
Message-ID: <YQLYJ3C5LVI3Lu1r@redhat.com>
References: <20210725055458.29008-1-hch@lst.de>
 <20210725055458.29008-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210725055458.29008-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jul 25 2021 at  1:54P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> device mapper needs to register holders before it is ready to do I/O.
> Currently it does so by registering the disk early, which has all kinds
> of bad side effects.  Support registering holders on an initialized but
> not registered disk instead by delaying the sysfs registration until the
> disk is registered.

Maybe expand "bad side effects" in header to include what you detailed here?:
https://listman.redhat.com/archives/dm-devel/2021-July/msg00130.html

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

