Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DB253B33A
	for <lists+linux-block@lfdr.de>; Thu,  2 Jun 2022 08:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiFBF7y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jun 2022 01:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiFBF7x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 01:59:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB1326A080
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 22:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gvONZNFJ5efdKOst7ykmu9vxi6heST6wkjPy0jZBt7I=; b=QPVw5pWj8uj60rKun07pI1CYWf
        GGO2Ood5aLxPtCObXtzijw3Qgr2P0iOu7JNfIID6Wyga49824McHYjsg/RfgfwkgDjXK0PDHrD2Fe
        lkVyaHwxvsLnPwsgwG+sVZ7o7NSf6nbVZf6024THIZxdQ0SBXK55MndCz05bKAEoBqW8LKLY1m/KS
        BChg3wZ5jTfqzQGbsaDEEJEuIwZQ/0gxC0kB8Yr48wAninOOLm8iEXCg1FK/uxEhyMGfVs3VtCABP
        XO5O3D14pkG6OIQHfbNkZE0SA5JeFQlEg6UH8jWAN0vJHGnt/kLZtSCV4/10lnX7AwLIUhUY2VQSR
        nQjPUiaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwds7-001asg-7L; Thu, 02 Jun 2022 05:59:51 +0000
Date:   Wed, 1 Jun 2022 22:59:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-block <linux-block@vger.kernel.org>
Subject: Re: Q: fsync on a blockdev fd worked in 5.15, but no longer does.
 Should it?
Message-ID: <YphR19tJNqFuB/xh@infradead.org>
References: <cca51ad8-052c-769d-62cc-99a3e3efe4f0@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cca51ad8-052c-769d-62cc-99a3e3efe4f0@applied-asynchrony.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 01, 2022 at 10:19:40PM +0200, Holger Hoffstätte wrote:
> Obviously if anybody (Jens, Christoph..?) has an idea what changed this
> behaviour and thinks it's a bug I'm more than happy to test a fix,
> however for now I'd be happy to understand what's going on.

I just tested fsync on SCSI disk and NVMe SSDs and they make it down
perfectly fine to the driver and device as Synchronize Cache / Flush
commands, including the block device node for a partition.

Everything else would be really horrible for data integrity anyway..
