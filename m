Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A364C002E
	for <lists+linux-block@lfdr.de>; Tue, 22 Feb 2022 18:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiBVRaD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Feb 2022 12:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiBVRaC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 12:30:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2247F1704EE
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dZQ87jNcSibaMijJAzuGXRUbsF1UNcQwuDJmlmj6JJs=; b=XD+dnu2qViEO3UAI+urJRKJm3/
        rjO7MPOfD1D/mE/wCOhCHizDp9MVAiyYicVSU/vywVFjSyqh8wOAvmjdT0/BTaNHMP60vhe7+4cXB
        xDeKqBv0v1s8ee18lFqVEy4UhVZKYsh1umwbSBctSJzNeaTEs920jZGbtaGC9kmJTs6zgcDLOazrX
        VhX5xxcH36duE1aiPiEBDYbHLPePTPH+mIRVx2iYKsmkwQWcM1VJG+aX8sSES3/WgjXf/79eMLvdA
        pLYmYtV31VRWQQZwnSnPxnHeAkFFss1MsQdyISNwfa/qt35npgUe+m791ifYeVpy/OqQT/ctlMk6K
        1DUHG4jQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMYyk-00Azgh-NF; Tue, 22 Feb 2022 17:29:34 +0000
Date:   Tue, 22 Feb 2022 09:29:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YhUdfqXy0wCDQywm@infradead.org>
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
 <YhUbhsy+C7Q16ihM@infradead.org>
 <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 22, 2022 at 10:26:16AM -0700, Jens Axboe wrote:
> Hmm?
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=93e2c52d71a6067d08ee927e2682e9781cb911ef

Indeed.  I somehow had a stale block-5.17 branch locally.
