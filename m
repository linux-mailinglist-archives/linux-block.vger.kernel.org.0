Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D3F1C3C00
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgEDOAp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgEDOAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 10:00:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02D6C061A0E;
        Mon,  4 May 2020 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wqRs4xFR7Bb6dZZZor/oQuuXpGGQ7dzVkmMwy13+NkU=; b=d4W2iGCpJ162OipZVbL4uSrYd9
        32qjCj0tTVdPZTO+AI62NhxVpzyJW7I7i/rKKlDzqVxKWzH/bxUl/Tz0tKvs8/yz/LMSilgyynFIH
        iw4K18nF0VxBil3g1mKt96K8n7vAi803N2ggKToZ2K+UJ2kcRCjpuJLDPiLyACUOPvMp73tD5lhGb
        JIHWjIU9EVVIn5MGawtsjxd+8q8BcUCrJyoz/xjmKUmwR9l8HsriXvrX3voQ04Ycqn05HR/FegjNn
        sPrOB25PBY7JioUawa5V4tUtMta5qufcW3vv5nIrY5+a1nKuxjDUXsB8+lGqdcRFoSe0kKUlH3aFj
        XvD2sfTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVbeG-0001tc-2P; Mon, 04 May 2020 14:00:44 +0000
Date:   Mon, 4 May 2020 07:00:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block/part_stat: remove rcu_read_lock() from
 part_stat_lock()
Message-ID: <20200504140044.GA29020@infradead.org>
References: <158859896942.19836.15240144203131230746.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158859896942.19836.15240144203131230746.stgit@buzz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 04, 2020 at 04:29:29PM +0300, Konstantin Khlebnikov wrote:
> RCU lock is required only in blk_account_io_start() to lookup partition.
> After that request holds reference to related hd_struct.
> 
> Replace get_cpu() with preempt_disable() - returned cpu index is unused.
> 
> Non-SMP case also needs preempt_disable, otherwise statistics update could
> be non-atomic. Previously that was provided by rcu_read_lock().
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks good,

Signed-off-by: Christoph Hellwig <hch@lst.de>

although I wonder if we should just kill off part_stat_lock and
part_stat_unlock.
