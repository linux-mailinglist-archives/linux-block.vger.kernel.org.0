Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC236268A
	for <lists+linux-block@lfdr.de>; Fri, 16 Apr 2021 19:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238555AbhDPRSI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Apr 2021 13:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235011AbhDPRSI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 13:18:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6950C6117A;
        Fri, 16 Apr 2021 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618593463;
        bh=9hxK/R+s2EU4kR7kshGTeZycGVsVIiRTG9wD/ajjcm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NygsV5CnESJgpSeDCfg/n4rmxI5KDQXNTe63ckgX4DcH+pes3gH3CAxm6Hz77FYbW
         XATkeBuvClbbPQknSy4qHNHB6wc5PO0qeTxt/XcGtf9t/Qjks95POJmljNtKsaAOK8
         hCt1ZkP1HkYeC8cRmQHjZjRSsi4r844XdvCVJMYHhKcaiYxycv51OT99CpcUUSRsjg
         3zbNyoJzlY5nfXSFOBpYPaoYlaV4gs0MhiaVmNF4dQh+l9b97FjIl8fIkKeliPaP0k
         hfolU+G7XRxeCkHrFRfB0g9oz+irn50Xyu6gDyN+mrcfF9067CChi+p6GaTn1RKqjH
         Plb5eJhsREsdg==
Date:   Sat, 17 Apr 2021 02:17:35 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yuanyuan Zhong <yzhong@purestorage.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Message-ID: <20210416171735.GA32082@redsun51.ssa.fujisawa.hgst.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
 <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AMecG=8TTdsdYtaV=H+hKm2poKYhyh_Tvf0Tc0PZvbVXf_iA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 10:12:11AM -0700, Yuanyuan Zhong wrote:
> >         if (poll)
> >                 nvme_execute_rq_polled(req->q, NULL, req, at_head);
> You may need to audit other completion handlers for blk_execute_rq_nowait().

Why? Those callers already provide their own callback that directly get
the error.

> How to get error ret from polled rq?

Please see nvme_end_sync_rq() for that driver's polled handler callback.
It already has the error.
