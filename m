Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E31C3F3F
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEDQAx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 12:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726578AbgEDQAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 12:00:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC281C061A0E;
        Mon,  4 May 2020 09:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BATpBtqBqL4zI1OrI7zzNo1CuDBthfYTyMzJ5Nwkppw=; b=vCjrVY7PzjjoLJQH9+P/guoOle
        GrYcFfLKsNvFqzN1KYQ8FDpBZ3Jxiohzi4no+ZSVaO+7aSHe7yErUWm4DlQQuvchC3QAY6Yq7pR0V
        4CRpk2v5o9GOoriXl1Wzzsjv3d24Mfjbt+V28gkD/op2PwfzRVb9USqaWllYakU3KHS01OBAEhUkT
        rd+s8T8W3WSZ3BXzilwq2Oa3ehrG7E2yWLtjsKeGUgE3bO+4kgR5hqCjdfOtL0IUgoPh/xN1jQxT+
        JWgoaHd++ntw8dQY5m45Pe50JjWRDzIaqQqDBZgl7AfeOaHsTMgFSBxKxpXZezVWOsozjktxKzqYm
        gkSJ5P5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVdWW-0006dS-LY; Mon, 04 May 2020 16:00:52 +0000
Date:   Mon, 4 May 2020 09:00:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 1/2] fs/iomap/direct-io: pass NOWAIT to bio flags
Message-ID: <20200504160052.GA8625@infradead.org>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158860769311.32485.8003552176738816448.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 06:54:53PM +0300, Konstantin Khlebnikov wrote:
> This is required to avoid waiting in lower layers.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This looks sensible.  Did you run this through xfstests?
