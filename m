Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0744344F0
	for <lists+linux-block@lfdr.de>; Wed, 20 Oct 2021 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTGLZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Oct 2021 02:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGLZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:11:25 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A394C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6UIAcujU1cZB+KwxCtDpzQat6VQ042+UO5gERAZhMhM=; b=oPn7xnQrg4xMifFP8ILtDC1d3g
        vJ3Sh4IVDQHRd77hw6iOiLskiQMRAZV8pTp0in+33Rzts1l3zrYVXrMTMZkyaiFLrV2gVQJxjIiSi
        UkPpTwXDXbMNAHo6SfsA/GRucQOVRM0A90IzkRba9p05d3MCUJjzl2u/TNAm2Bt3/tdyWKrdtV3Qx
        U2ssLB3F/h8ykJvf3UHpRLIlNvnMy50afP6rlNYO5Zg/T3LxgdisdlfDDBRtcWT2LICpQ1KTjh2IR
        KS1RnwxjLINSxmFO+CWtwn2jqP7TGbU/i3WO0/VUl5mEA4EneEvQ5eE3eCXc6zhQkDrxkkXl/uzob
        Rz5eDCFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4ml-003SU0-A8; Wed, 20 Oct 2021 06:09:11 +0000
Date:   Tue, 19 Oct 2021 23:09:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 01/16] block: turn macro helpers into inline functions
Message-ID: <YW+yhzwUCHZggh16@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <a6dbe9a09b7e0695803a944a7f27ecb8480a7409.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6dbe9a09b7e0695803a944a7f27ecb8480a7409.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 19, 2021 at 10:24:10PM +0100, Pavel Begunkov wrote:
> Replace bio_set_dev() with an identical inline helper and move it
> further to fix a dependency problem with bio_associate_blkg(). Do the
> same for bio_copy_dev().

Looks fine.

Reviewed-by: Christoph Hellwig <hch@lst.de>
