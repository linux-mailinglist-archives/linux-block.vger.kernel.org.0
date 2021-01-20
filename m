Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2D82FCF54
	for <lists+linux-block@lfdr.de>; Wed, 20 Jan 2021 13:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbhATLWE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Jan 2021 06:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbhATJzP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 04:55:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC03AC061757;
        Wed, 20 Jan 2021 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NM/T+gSEcHGJpyRWPk/ZLeUv/hfwQU3QIG0KEzI2opU=; b=RTnnxcaldzONpEsV+dG55bFsHJ
        A4qarvDeRE8is4M5aTCdYF/JkDyLtAyzxawwrxpthUjUVoT8oZ7jUQ3+SRRpv9jxZVje5LVQaJJLh
        ucaGsATi/ICX1j47E5l3kmhEA9D8qDrF7A8tcqK1+v2TpFQutz8vOqtUtnhxsoza3QDSNWCi1eftU
        /m27SbcTI6JQd1dtkThNQR2uj98zSFB0AZNSr8TlfwooGFP5WuLXnhkio1CyTIR6c378byR3PjRnT
        MG/QJMyJblL5UGXq8swpbWtW8ZNzxgNuj1nEDfrLH6PVojm85OPE+OD28sPHmh1d8wbMW57Csw49Q
        /nQAsxpg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2ABl-00FVBq-VS; Wed, 20 Jan 2021 09:54:20 +0000
Date:   Wed, 20 Jan 2021 09:54:09 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Liu Xiang <liu.xiang@zlingsmart.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: introduce REQ_COMPLETE_WQ and add a workqueue to
 complete the request
Message-ID: <20210120095409.GB3694085@infradead.org>
References: <20210120021522.28584-1-liu.xiang@zlingsmart.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120021522.28584-1-liu.xiang@zlingsmart.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 20, 2021 at 10:15:22AM +0800, Liu Xiang wrote:
> The commit "40d09b53bfc557af7481b9d80f060a7ac9c7d314" has solved the
> irqsoff problem by completing the request in softirq. But it may cause
> the system to suffer bad preemptoff time.
> Introduce the REQ_COMPLETE_WQ flag and blk_complete workqueue.
> This flag makes the request to be completed in the blk_complete workqueue.
> It can be used for requests that want to cut down both irqsoff and
> preemptoff time.

In addition to bloating the request_queue and introducing the completion
fast path this seems to lack an actual user.
