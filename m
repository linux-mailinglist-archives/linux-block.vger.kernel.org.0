Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C631112E9E6
	for <lists+linux-block@lfdr.de>; Thu,  2 Jan 2020 19:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgABS0z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jan 2020 13:26:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43166 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgABS0z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jan 2020 13:26:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so32549746qtj.10
        for <linux-block@vger.kernel.org>; Thu, 02 Jan 2020 10:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ANPrUozhLVe+ERMaAjPezhK2FpYHmz/ZK6CktW+rYI=;
        b=OiLbqCgVK8ztiRki/GcLxWEuO5DQg0ZkSMV+2Sc3MgffnUKac2Ad1WqQJx3nmo7TD1
         XeeKjC04iSgZlK9LHmoJZ+NQ+TJpKxmLgnPOLxp/Ap+89X9wnL+JdWE1DPR3rv8khbE4
         VYx51N52mN5ZVoxlruu6f7T8L1nSSNaEEc5pY7HGRxsFLLz6daQm7gdDz7aMifLER0Le
         BKb7B0cpI89tS0oAhdpUoUR95hj2EW01SNcmd/dt+PqFMaJZs3R17TeusDnvzLOmuLH+
         c48jFEbSMvqHv6Ny8jdndodmQ5Z8/7squ45OPfWUfSClfvgjPzqyf2oMH3Wvom78VNRt
         rlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ANPrUozhLVe+ERMaAjPezhK2FpYHmz/ZK6CktW+rYI=;
        b=ov4AznNpuMeTT2ZBqx4HWfOkWK2PTvPvubgrmOAIjnegS/sR3Ob9c4bxGpnX6RCupl
         r9w0geqHMLU3xlmtiaNkwnkiapnIHXvdikSJsXnMCjZcAC2x41k/BQO+C4Z4dGGuRTuC
         sgbISSIjdnCL3U7xEk4Mw1g0DlRf5C35ydNRQYVC2Nd5UPcifYUASJY9X0a6rgRFPToG
         L+SDJ0PirmGHncsPqORiMY+sljYbv/hy8kzM1ixpkyLvL5LCAvCKbttif6PInD4uIZD7
         nY9aF77VRN6jmALMUep2FETfW9DqCwOK84cNNHws8Qty3xbBmIw0AdZhyyZO2IcA2S3M
         Luuw==
X-Gm-Message-State: APjAAAXj9cWv3Y+50vOHKaDrzJ3t+LYTC52NkbShBxQ8Pn+CudifOO9s
        G3ABs7e82PmagjJBrpeM10Quhw==
X-Google-Smtp-Source: APXvYqwMJqHGJ2PN3vAIFGjuy6eIvEWgb0csdncv6eeWefCzsb9tu/s/AoFbnu0ArN4qvBvi20nepQ==
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr60349266qtn.256.1577989614651;
        Thu, 02 Jan 2020 10:26:54 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 4sm15292480qki.51.2020.01.02.10.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jan 2020 10:26:54 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1in5BN-0003Zi-Lt; Thu, 02 Jan 2020 14:26:53 -0400
Date:   Thu, 2 Jan 2020 14:26:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Subject: Re: [PATCH v6 03/25] rtrs: private headers with rtrs protocol
 structs and helpers
Message-ID: <20200102182653.GE9282@ziepe.ca>
References: <20191230102942.18395-1-jinpuwang@gmail.com>
 <20191230102942.18395-4-jinpuwang@gmail.com>
 <b13eccdd-09a2-70d5-1c78-3c4dbf1aefe8@acm.org>
 <CAMGffEmC3T9M+RmeOXX4ecE3E01azjD8fz2Lz8kHC9Ff-Xx-Aw@mail.gmail.com>
 <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51f2aec2-db24-ce7b-b3e8-68f9561a584b@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 02, 2020 at 09:00:53AM -0800, Bart Van Assche wrote:

> > > > +/**
> > > > + * struct rtrs_msg_conn_req - Client connection request to the server
> > > > + * @magic:      RTRS magic
> > > > + * @version:    RTRS protocol version
> > > > + * @cid:        Current connection id
> > > > + * @cid_num:    Number of connections per session
> > > > + * @recon_cnt:          Reconnections counter
> > > > + * @sess_uuid:          UUID of a session (path)
> > > > + * @paths_uuid:         UUID of a group of sessions (paths)
> > > > + *
> > > > + * NOTE: max size 56 bytes, see man rdma_connect().
> > > > + */
> > > > +struct rtrs_msg_conn_req {
> > > > +     u8              __cma_version; /* Is set to 0 by cma.c in case of
> > > > +                                     * AF_IB, do not touch that.
> > > > +                                     */
> > > > +     u8              __ip_version;  /* On sender side that should be
> > > > +                                     * set to 0, or cma_save_ip_info()
> > > > +                                     * extract garbage and will fail.
> > > > +                                     */
> > > 
> > > The above two fields and the comments next to it look suspicious to me.
> > > Does RTRS perhaps try to generate CMA-formatted messages without using
> > > the CMA to format these messages?
> > The problem is in cma_format_hdr over-writes the first byte for AF_IB
> > https://www.spinics.net/lists/linux-rdma/msg22397.html
> > 
> > No one fixes the problem since then.
> 
> How about adding that URL to the comment block above struct
> rtrs_msg_conn_req?

Or just fixing whatever the problem is..

Jason
