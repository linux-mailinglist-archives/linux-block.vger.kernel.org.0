Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E0F71321F
	for <lists+linux-block@lfdr.de>; Sat, 27 May 2023 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjE0DRj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 May 2023 23:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjE0DRi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2023 23:17:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE24E1
        for <linux-block@vger.kernel.org>; Fri, 26 May 2023 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V5FuGtK8vYecfWktaj5XXG+3Xi8v42mkirG/OLnBAwo=; b=HtZldHBpxf9PQM5+O7/RXWXLY1
        Vvad2UyLf/8WhsJVFJM0veW3cUDFO4vdwoPy1iSOqEAU0A28lMHjt6/8elzVsF+LyRZHJIp44l+Kx
        pI4Xj8AePBJdgCU8J4mLjFK9lZe7A8ovnK4opFrTneV89lJKNe5jF9/rmKGUSLfHLJN54UwilJ8NX
        MjC0/Qwyy2zDzILljy9KHsuZ3BNRUhCtBTZ54NQ9dgtssWNLd/xuX/eHaP6wpka0XufFkx8GoCzVm
        jnb2eZAV9UW2xritWNPD0Slv0cNhxDdifV8WXl4gOPuHcsUiKGKLmiJS51HL4VKsNIDapLJXIooE1
        bGzkUJSQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2kQy-004iv9-1h;
        Sat, 27 May 2023 03:17:36 +0000
Date:   Fri, 26 May 2023 20:17:36 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, jyescas@google.com,
        Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 4/9] block: Make sub_page_limit_queues available in
 debugfs
Message-ID: <ZHF2UI0NaiEuGvhc@bombadil.infradead.org>
References: <20230522222554.525229-1-bvanassche@acm.org>
 <20230522222554.525229-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522222554.525229-5-bvanassche@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 22, 2023 at 03:25:36PM -0700, Bart Van Assche wrote:
> This new debugfs attribute makes it easier to verify the code that tracks
> how many queues require limits below the page size.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
