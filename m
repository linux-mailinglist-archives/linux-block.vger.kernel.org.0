Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC443453B
	for <lists+linux-block@lfdr.de>; Wed, 20 Oct 2021 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTGjg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Oct 2021 02:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGjf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:39:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA6BC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u/HJpyZTumYYBAecANhFdrhQl06E63HKzeNiDMSg6+g=; b=AiBpddxeKTdl0lrz+V6brnCJpM
        ZdK3e19oSV1KCkBbAC3pz5B2QXRntEATsfZZCQ2kDpMzQsna5BGq+whNTLlFKPUVQw8pgdSxeAVh3
        0Ri9UMo5m7/AC0+fomwp8WDQOOHWAkR4TOL+iT4eIfRQsipuw4h7e3b1UNDZCGOZvy/pSANLl3J6Y
        jt0PtpmQXqYk15qF+vwq0R5fGBj4akJgYN+Li2wVPv6FAl3jJqQ2EQ4mD5DoZH5uEDxNrT4ufSymL
        0NqomTrn42K3TkRfhC7PDnSlfrqpC7StuoohPUxEZ60Ei2ln6qdYHkS8fyML1+h/Pd3C3FcQAGspg
        +S46xupQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md5E1-003U5L-Ns; Wed, 20 Oct 2021 06:37:21 +0000
Date:   Tue, 19 Oct 2021 23:37:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 13/16] block: add async version of bio_set_polled
Message-ID: <YW+5Ic7v++qXiGXw@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <673fc6ca8f2e761586d21c709348642113f13f86.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <673fc6ca8f2e761586d21c709348642113f13f86.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:22PM +0100, Pavel Begunkov wrote:
> If we know that a iocb is async we can optimise bio_set_polled() a bit,
> add a new helper bio_set_polled_async().

This avoids a single if.  Why?  I'm really worried about all these
micro-optimizations that just make the code harder and harder to
maintain.
