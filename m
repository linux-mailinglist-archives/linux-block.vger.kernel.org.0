Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5623574F16
	for <lists+linux-block@lfdr.de>; Thu, 14 Jul 2022 15:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiGNNY3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 14 Jul 2022 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239982AbiGNNYH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:24:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9DA61D47
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lze+3Wn01EsHigxSSUOkxnhirHwRAnQW1/T0mRAH1wI=; b=UjVVTKQgkVC3Ij5+pC+pIFrV5Z
        OpBLvAhVbZJ8gMjWVa+MHeCw21TV+Cpp726hSx3z1sAIhYnqvasr4ytk9iMxmJfYpuowxdh1XZRoN
        FP2JeKIyDn1AxAO0ugQKymmW9E7nePmYWd+Lyhgw388l63dUWJs0srCi5LcbIGUUjbhZZp09fTn+q
        IxGE/mifCHOpMzVMLISrCHGagHGfnJsjFoWuWfYdAVTd3bDMdrYLhyb7wTekhzwiZpVgrm9PiFhdD
        yOA0/pgdoPgkO5wmRzG4+ObG9zQuLVDbCVEwD0BTo1OqiH/OmqDyNEbwMLcRGb1D74QELQFSpcEl1
        roSEVwcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oByoC-00EgPC-Gh; Thu, 14 Jul 2022 13:23:12 +0000
Date:   Thu, 14 Jul 2022 06:23:12 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] ublk_drv: fix request queue leak
Message-ID: <YtAYwH45Ewy3+aLr@infradead.org>
References: <20220714103201.131648-1-ming.lei@redhat.com>
 <YtAWhRdXrumYEsU+@infradead.org>
 <YtAYGMvQ+N4RsJRG@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtAYGMvQ+N4RsJRG@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 14, 2022 at 09:20:24PM +0800, Ming Lei wrote:
> The problem is that you moved part of blk_cleanup_queue() into
> del_gendisk().
> 
> Here, the issue Jens reproduced is that we don't add disk yet, so won't
> call del_gendisk(). The queue & disk is allocated & initialized correctly.
> 
> Then how to do the part done by original blk_cleanup_queue() without calling
> blk_mq_destroy_queue()?

What do you need to clean up?  put_disk is supposed to eventually
clean up everything allocated by blk_alloc_disk through disk_release.
If it fails to cleanup anything that is a bug we need to fix in the core
as it will affect all drivers.

