Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE74A43450D
	for <lists+linux-block@lfdr.de>; Wed, 20 Oct 2021 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhJTGT6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 20 Oct 2021 02:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhJTGT5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 02:19:57 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6EC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 23:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MHCBmXM4adPPRFg/ASRizWy5uvSxkUNzautzMzedUnk=; b=mE5mQGhyXhJOeVEAxo5ylwcpwj
        QJrZegXCXVEQ8VLwm8JNF45vqKE4nd8QK3p/aIWkCvsibiwXNgL1cUhTG4wdZkB0ZrzDvGPF5kDYI
        9cEit7aN6z6++dMnIWd4G8yl4V7h1TNrq2FjW/ng7GMYy86e//yQeqCPijq7ViPnI75uAyTNocBXt
        eelOFkfHu3q0V9auW1y7cHxzjprK0GH3q+30uY2ankGW8VNtxIIcA1Zg6u1exlfb0sI8li06hc8FF
        NrZjJzfBIe1VUFwRrtW3Yjm5xOkovIjLiHvl/AmFa6ej/D51lHb1vR3pe+aYNTRjPe3C9mLMjuFlJ
        4wGdO0jw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md4v1-003T26-VP; Wed, 20 Oct 2021 06:17:43 +0000
Date:   Tue, 19 Oct 2021 23:17:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 07/16] blocK: move plug flush functions to blk-mq.c
Message-ID: <YW+0h4nARoKeonn2@infradead.org>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb6fe6de2fe6bd69ccf9bc8af049ffedcf52bda0.1634676157.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Spelling error in the subject.

On Tue, Oct 19, 2021 at 10:24:16PM +0100, Pavel Begunkov wrote:
> Flushing is tightly coupled with blk-mq and almost all
> blk_flush_plug_list() callees are in blk-mq.c. So move the whole thing
> there, so the compiler is able to apply more optimisations and inline.

No, it isn't.  The whole callback handling is all about bio based
drivers.
