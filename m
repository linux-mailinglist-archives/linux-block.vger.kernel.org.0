Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA94822E06D
	for <lists+linux-block@lfdr.de>; Sun, 26 Jul 2020 17:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgGZPKh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 26 Jul 2020 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGZPKh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 11:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89795C0619D2;
        Sun, 26 Jul 2020 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kcuMXgFNFtIkl0GDj0p20pjT96YpQLVHcMeUCcbH19o=; b=ultu3nd1Zhi8vL8FqmXKkj+BID
        BNIjw/hg0UdljRqFd7Rt8DJFCCNdkCL2ihNeIiatBgZyRIqxDR6Ba/cDaTgqG1bMdFY31yVUv6uil
        SdZoK9WXeKq9uleEJF7W/Acu6G4jvO2q3dj304dy28OndAm0VqiftzEVfBiOQEAamCdfAihZ4Xko0
        y7eWnsGb6A1EqyThHab2Qv2VtpG+i6dvEISnNqdeayq4QgK5HeozbiGbHKnXcbIQKX6l+tNF/0qDQ
        Aym2A8NtFTDoCKCd0/Z/gjFWYb7xaeUEU3/pu2dUNJ0vgXWvonCEyRcxlMWnVIJAhCYP674xLg9Xm
        j2LQEwfg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jziIN-0006JY-E5; Sun, 26 Jul 2020 15:10:35 +0000
Date:   Sun, 26 Jul 2020 16:10:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tony Asleson <tasleson@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, b.zolnierkie@samsung.com,
        axboe@kernel.dk
Subject: Re: [v4 00/11] Add persistent durable identifier to storage log
 messages
Message-ID: <20200726151035.GC20628@infradead.org>
References: <20200724171706.1550403-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724171706.1550403-1-tasleson@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FYI, I think these identifiers are absolutely horrible and have no
business in dmesg:

Nacked-by: Christoph Hellwig <hch@lst.de>
