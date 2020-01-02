Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76CE012E9DB
	for <lists+linux-block@lfdr.de>; Thu,  2 Jan 2020 19:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgABSX6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jan 2020 13:23:58 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37897 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgABSX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 13:23:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so35262864qtp.5
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 10:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAwqsRR5p0WQ1FXAD94ssaK9uFiL3MMXtJkj40Y5ME4=;
        b=BbBQ8pHxMSCg1FRK2/9Xmge46DvZ5pwR6dQgQSqPyKWaSX7skW6fo+eapjhmTaGZVe
         HgbdRwsGddZnRBTZ9ol07RyiJFe5oQTm10XNPdQFLcMycphSPZIBF7ZIZlMQQPNZjH+W
         PiXPnRynCswGNrk5s8mVsQnmeJE7XTsuIJkpdnVjSFDqi61p/OpKvyz6ATc0emGr4UVZ
         z3IrEIdfXrXOGeLAoihJL0Lc5U+zNjxhnVmR2NO9OyFcTs5XUBWfnFdobWzh9chWY0L5
         vjJ3oW9Pn2lXXjNYjslpGXMCrFKWMjQwZhiqWLelNpwQkQNZsG56EtKWyI9l+XGKL7mr
         0HYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAwqsRR5p0WQ1FXAD94ssaK9uFiL3MMXtJkj40Y5ME4=;
        b=QZjncJ2sLrLbBPOqbT4LJusBziH0r21aumltkNXzf5OozpJC5ggkEXB1Ytb3YszRv6
         kPgiXuA+vbTjaWpoHjmoavzuBmY44al3ebkMuR28OJkUHFOp0YIw65pyONzUc1f9pN2b
         5iaLb2aqsP7d4hYfkSXqt7WqjXIQ7r+zlFvEzrm/nfBZde6sSwIIkwX2vzW6dbXBBvZW
         DxnpIajpvyyI1nMnf8vPgJ4TYir1QJz2741fE3hx2nDUvzieyxmDQmTa3nCnXyR+sfWQ
         pszZbkxMbra4HMPFeGuFG/QNiP6rzoseaG20oXQM8BZ04G505XSAezOCBkAC6bgs9v4I
         HFmA==
X-Gm-Message-State: APjAAAVAfDz518CRLoUMbupp4yaqenCTg9CawHsVy7HNZ7Au0NJNq0BN
        IGpe3dvPNp/CIfZ/3W6QvSU+wQ==
X-Google-Smtp-Source: APXvYqzlkWLLP2XjfL2M0f5z2qad2eqD1MLtK2QP0ABvzi+Up6KAgHVirMSsFqRfcngstb+4Qbunjw==
X-Received: by 2002:ac8:3703:: with SMTP id o3mr60602438qtb.208.1577989437359;
        Thu, 02 Jan 2020 10:23:57 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i6sm15312719qkk.7.2020.01.02.10.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:23:56 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in58W-0003Pg-HN; Thu, 02 Jan 2020 14:23:56 -0400
Date:   Thu, 2 Jan 2020 14:23:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, axboe@kernel.dk, hch@infradead.org,
        sagi@grimberg.me, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: Re: [PATCH v6 06/25] rtrs: client: main functionality
Message-ID: <20200102182356.GD9282@ziepe.ca>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-7-jinpuwang@gmail.com>
 <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e242c08f-68e0-49b7-82e6-924d0124b792@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 30, 2019 at 03:53:10PM -0800, Bart Van Assche wrote:
> > +	if (req->sg_cnt) {
> > +		if (unlikely(req->dir == DMA_FROM_DEVICE && req->need_inv)) {
> > +			/*
> > +			 * We are here to invalidate RDMA read requests
> > +			 * ourselves.  In normal scenario server should
> > +			 * send INV for all requested RDMA reads, but
> > +			 * we are here, thus two things could happen:
> > +			 *
> > +			 *    1.  this is failover, when errno != 0
> > +			 *        and can_wait == 1,
> > +			 *
> > +			 *    2.  something totally bad happened and
> > +			 *        server forgot to send INV, so we
> > +			 *        should do that ourselves.
> > +			 */
> 
> Please document in the protocol documentation when RDMA reads are used.
> 
> What does "server forgot to send INV" mean?
> 
> Additionally, if I remember correctly Jason considers it very important
> that invalidation happens from the submitting context because otherwise
> the RDMA retry mechanism can't work.

I think my point has usually been you can't use completions on the RQ
to deduce the state of the SQ

But if you are doing inv by posting it on the same SQ then things will
get ordered OK as the HW shouldn't progress the INV until any work
touching that rkey is also concluded.

Jason
