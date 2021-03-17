Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8133F16E
	for <lists+linux-block@lfdr.de>; Wed, 17 Mar 2021 14:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhCQNrz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Mar 2021 09:47:55 -0400
Received: from casper.infradead.org ([90.155.50.34]:36218 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhCQNrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 09:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n9gpJp3MfKFJdNPEFX+55A5D1A/Dz8Nub1YscuY/IXU=; b=Sye/jPFoLP60HnIEL0WzjD3iya
        UqJ5IRCBjJxbr+hhrBGljIrPJa5dN1eNusv/ZK7+Lzbdcl/2BitOD7X8SqiUe+B0+No+pC46SuXSF
        FTXteB3LM5bXsfaK7AM+Tus37omdP++90osezBjJsNi2hs/3aGF/wO6Hg6P+IY9HcXP96ePJTjPEB
        FpR8jUv8VDgJQi6r5Xw2zRjbVAiOPN1tCE3ZOMejK4nYv4ODuSJdJB+7t5Aq05Hs5au0J12cnC+KY
        ImnwAmckxkMMv0tU5pdPTkhvTvPO+AevqfpSwuUxcBYrGpdXxJMyk47eVoTYQIFHrLQVrKPQpD8ES
        rg2S7Eaw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMWW3-001Wba-Uj; Wed, 17 Mar 2021 13:47:19 +0000
Date:   Wed, 17 Mar 2021 13:47:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Zdenek Kabelac <zkabelac@redhat.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: remove the "detected capacity change" message
Message-ID: <20210317134715.GA362913@infradead.org>
References: <alpine.LRH.2.02.2103170644080.32577@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2103170644080.32577@file01.intranet.prod.int.rdu2.redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No, it is everything but useless.  It is not needed during device
creation, but that is something that the GENHD_FL_UP check should catch.

You should probably audit the device mapper code why it sets the initial
capacity when the gendisk is up already, as that can cause all kinds of
problems.  If the setting of the initial capacity after add_disk is
indeed intentional you can switch to set_capacity(), but you should
probably document the rationale in a detailed comment.
