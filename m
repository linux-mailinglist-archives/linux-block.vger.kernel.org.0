Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08D5114F0EA
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgAaQyZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 31 Jan 2020 11:54:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45855 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgAaQyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 11:54:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so7151822qkl.12
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 08:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5O0NmvtxOCRBD6C//NMF69VfE9OSlCosAzQuN128Ro=;
        b=Z3Ug4eIYQzo5seKFAgwv6DETsrT3LXx4wuz/PCafwsiD8um5kGzYfAVqFDJ93xqV1M
         TAF6qWGdume7dkBYpouPxwrnygCIuGbMOolCwSR0sR4lmuaS50146gb/VSHPmFjcWDyG
         vnkfyqZj/fi16TFTBiq/uEshRDhsNw/i3TMFjeEX6T2mf+vFbwA+1kjif3p6EWpoFCKY
         GelTfY5y3e+i1udJqP+jThXciIVH7yMZiFKVPA47nbAdNDgacCNRcyXJsfvLeC/jirC9
         OaAbT9K5GRWm2oINluyJSQBHKvIYE0+zpYEWazDBZpuJUuoNHU/OohQV2415ZiZ3Jr5p
         xTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5O0NmvtxOCRBD6C//NMF69VfE9OSlCosAzQuN128Ro=;
        b=Nej2bsgw/koWEbxe5bES/XFqVFKgc8j3NCcg0TwEV9XXDofQWnE/njFM7STuynipiH
         bNAGYXkZtlnY0HdTaTyhU7HFVDoeTuSKEAVS2q93gpjGr4GRqCClgsnR4kkSw1RLcHfg
         xJzN1fvm0MtCGYs2tWrc2D5Z4L6rh0C+FuPa2SZYtI+Z4jUGIXMXm3txPSx/BaPqQfIo
         Vh6wsGxdzIg97do8znGclUL+tdbz7DWq39Rjg6oG5nKAbMzHCWp+aTWSNhZw0EWfsDzR
         vLKIk8XH4AUdni4Awk5CURuqMobIh2xqvNy4iiumGSiOwgTT0UJtasLFBSpoYSEXmXtu
         pUog==
X-Gm-Message-State: APjAAAXBZpgX7e1boCCmsLP68YgTur+IPmmBRePrJ3UH6rt8tQvqVWm2
        Wyx0Xj0IIiJIGchoscv5YRXJ8Q==
X-Google-Smtp-Source: APXvYqyLkxEfL+i/amhI5M21lDRyuxz4/MI5YfleT2Y0Ia71InXZKBHJRbWMYHO1N29/fXX2zXOJJw==
X-Received: by 2002:a37:9dc8:: with SMTP id g191mr11563871qke.171.1580489662201;
        Fri, 31 Jan 2020 08:54:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h12sm5143919qtn.56.2020.01.31.08.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 08:54:21 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ixZYj-0002Rv-2T; Fri, 31 Jan 2020 12:54:21 -0400
Date:   Fri, 31 Jan 2020 12:54:21 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200131165421.GB29820@ziepe.ca>
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
> Hi Doug, Hi Jason, Hi Jens, Hi All,
> 
> since we didn't get any new comments for the V8 prepared by Jack a
> week ago do you think rnbd/rtrs could be merged in the current merge
> window?

No, the cut off for something large like this would be rc4ish

Jason
