Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7A71DA5C2
	for <lists+linux-block@lfdr.de>; Wed, 20 May 2020 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgESXoq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 May 2020 19:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgESXop (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 19:44:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60613C061A0E
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:44:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id m11so1863536qka.4
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l2sL1SuOB0Bwoh3rp7+GqKpOELWuc6ZuQ7vSlzcsMBE=;
        b=iFlqm/M9J3nwY7cxchj42OacLXK5ohOEesABtw0fSf/vL6HReI8WyMrmSPTL0oy8ym
         kFk7GBJbKToh6jrpED9mgjFNQmjPzETw3m4OErn2Bt6xBOrN+BT/ffVcXM/RnT4tRPkS
         0/R0svtdCM/PkwDcxBLVz3D/nY89Tda4pdHmbZscMfN0dJrhblTVlSfn/jHQsvT/Uri4
         ozuyF8ejM+2gyKgnoHToo5W57H3LdY85+LBEtGmuGSgWqf8KpOm9hdLjG/5bMXhxWlZb
         Ltsc9NYiw/gtoWktRxBUOwMAiBypmXMO7/Iw7YUYu4ULAqHMS/I0ELNnrL9BFkFPX1W/
         O+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l2sL1SuOB0Bwoh3rp7+GqKpOELWuc6ZuQ7vSlzcsMBE=;
        b=NIPb/dfu8xHrhFJ850cLYOA8kWFinsdMjTQAJaxYVGy3c3doq+z18ALKSwQyzPJxtD
         IaSimljzxandcIzLnMvv4va/e/Cs8VBySJ7H/dZyvQYOcjey+8uFfr9wOyKXI77T1YSD
         UIdJyDFueoK+ugbjMlJ3n5JGxgZca5knV6GXE1Cx+t8MrDk1PlaGHPVykW4cKogRdxPs
         jWo0lepma3ZHIP3pkDyNoSO1Q6oSWiP3ozcehSRdjz6Ekn/pmADm3kqZ57mH02Lmvj7C
         drwEq5eYxtXOUQFJJBq2SNZARKQqJ+KRDgIIpdsSZSD0tKirtAO2TccY255P4cls2+og
         UYbg==
X-Gm-Message-State: AOAM533Y9UXuTgaWhWhuSoj2oKSpeiEyUvBCfDQYAkLeNhNTDKO0pEcW
        EBEAkBa5MMLZikbW9yKcVGEjIQ==
X-Google-Smtp-Source: ABdhPJyqzRlLG6w3O2K4GgGWlPTq0J5WCXLjnydkSlHtNZdebPL9AT7MR4Vtxwwj1z4lp/8Kd5h4kw==
X-Received: by 2002:a37:506:: with SMTP id 6mr1965568qkf.159.1589931884672;
        Tue, 19 May 2020 16:44:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id n206sm914132qke.20.2020.05.19.16.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:44:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBud-0007yh-PW; Tue, 19 May 2020 20:44:43 -0300
Date:   Tue, 19 May 2020 20:44:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-next@vger.kernel.org, axboe@kernel.dk, dledford@redhat.com,
        bvanassche@acm.org, leon@kernel.org, jinpu.wang@cloud.ionos.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] rnbd/rtrs: pass max segment size from blk user to the
 rdma library
Message-ID: <20200519234443.GB30609@ziepe.ca>
References: <20200519084812.GP188135@unreal>
 <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519111419.924170-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 01:14:19PM +0200, Danil Kipnis wrote:
> When Block Device Layer is disabled, BLK_MAX_SEGMENT_SIZE is undefined.
> The rtrs is a transport library and should compile independently of the
> block layer. The desired max segment size should be passed down by the
> user.
> 
> Introduce max_segment_size parameter for the rtrs_clt_open() call.
> 
> Fixes: f7a7a5c228d4 ("block/rnbd: client: main functionality")
> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Fixes: cb80329c9434 ("RDMA/rtrs: client: private header with client structs and functions")
> Fixes: b5c27cdb094e ("RDMA/rtrs: public interface header to establish RDMA connections")
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> ---
> v1->v2 Add Fixes lines.

Applied to for-next, thanks

Jason
