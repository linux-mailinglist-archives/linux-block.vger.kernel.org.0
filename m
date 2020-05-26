Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62AF1D6DCB
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 00:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEQWRi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 17 May 2020 18:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgEQWRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 18:17:38 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5191C061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 15:17:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id n22so4187188qtv.12
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 15:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtCqJbSzSTr/mOw+zKYStT6YhJmMRVpkZgqWDpAi5Rc=;
        b=N++WCpXD1D22zxXcHIsrPS8nLDn5EvvJtiwTQzSsRZEhwh0LHzSwsw8SQpsyXbGhhd
         M512aYEuRlvzCm7a1lOxh4OMUKbVsKxCseVpwzyZRI5hZbqv0j0Id6CaSM3PH++VsjoE
         jdYLYF+sk08HFfKpx18ViLDEXESDc+40y2cwdpAD1Nn5kwe0klahuoc75jRaPAt/zhXv
         qgvE+yTHcSAVsqG/cdjoX/41y46ovWBTQiyZoXcsWV8AdENFfAJjxle09f4oit58sYkQ
         bZe89i1yp0lB9ebCP/lLJwG2/ENX8RQLuM94b/GjrWkROJ77PzYbRwHF/HCxPCT8ELty
         8EpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtCqJbSzSTr/mOw+zKYStT6YhJmMRVpkZgqWDpAi5Rc=;
        b=L90dKosfkQjFfDgTavTa2Tu+VDlGSM6hptq+qkyQNMoQQrvfk2wMSRov4nvnx2pXIZ
         K+4FPpGjWcQdfCxfdmQZ63Rp9dPAhEBix5jlqITe5Bo6QGxnXEPa+FwqMPXQeWiZm6kH
         0JhnezfxvvJq4X6IELTKu80KPEgOQPdFtjK7yRhrm/iCQ3e+HwEi6IzGj/eCqB0YAV3J
         x/za/PufFwihEhpn00coKDZYnqZ4SZHU9NDY3kHuf9Q+5GWVgt41fsXfiUc3/zfuOYwk
         JesJJ2EyYUESOmStifLtPl6srnOmdj74Jv3c2DPJ/GC/+BV1E2meiFOjS6nZpBLehA+a
         laaw==
X-Gm-Message-State: AOAM532w/71jM2+XH9YIELfSEWAmEGjNUAw8AiFPWFvfw+TD8xn4U++n
        doelPcCaerWAB3A2d09a0rDiVA==
X-Google-Smtp-Source: ABdhPJy0NyBiPigc2ASavOe6gEb8l61SV5QZ4f5YpPfRhBRGoN8rY6fPnU2/L/8G76IL3eariMSSjQ==
X-Received: by 2002:aed:2fe2:: with SMTP id m89mr13895278qtd.124.1589753857029;
        Sun, 17 May 2020 15:17:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id p2sm6807869qkm.41.2020.05.17.15.17.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 May 2020 15:17:36 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jaRbD-0003RG-LP; Sun, 17 May 2020 19:17:35 -0300
Date:   Sun, 17 May 2020 19:17:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
Message-ID: <20200517221735.GA13057@ziepe.ca>
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 11, 2020 at 03:51:06PM +0200, Danil Kipnis wrote:
> Hi all,
>  
> Here is v15 of the RTRS (former IBTRS) RDMA Transport Library and the
> corresponding RNBD (former IBNBD) RDMA Network Block Device, which
> fixes the issues in Makefile in V14 reported-by
> the kbuild test robot (see changelog below). The patchset applies for
> kernel v5.7-rc5.

I don't particularly enjoy having another ULP for a single use case,
but I think Ionos has shown commitment to use and maintain this, so
lets go ahead.

Applied to for-next, with Jen's ack for the block part

There will be probably be a stream of complaints from linux next in
the next weeks or so. Remember the merge window is probably in 2
weeks, so deal with them promptly please.

Thanks,
Jason
