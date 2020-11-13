Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D398B2B1772
	for <lists+linux-block@lfdr.de>; Fri, 13 Nov 2020 09:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMIoV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Nov 2020 03:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKMIoV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 03:44:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3588FC0613D1
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 00:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHFCTHDbNHxHHIZOTYBQKPHWGh67J2CAfsD3U7TYFvI=; b=AjA2eWHltCyyQ7JlP/2Kh/K+lZ
        5KLF9MFxHf4CRaGuxqmUv6xLKu6HknhvNpoySIvI8Vp5wdteoDHf9P5Y+qzTQ5WZumRB/v0Aq2FXO
        yhPuQ/x2e8XzO/0ijSKEz57UqfggoLiMoBNmfwYePgd1N0tEd/HfkkGgkog1YViiOU62+NjplMv2g
        b24N+qfTiM4bftGr/vrasM/YSO6pB33O+YyvtHZJ+PWUBf1Tfk7rr/Dg3jaCeaUzbEhmt8wOQzQvj
        NiV5KxAOZ0wKEuvWoX/QDLzykTI7K7NVzkCTXgFSBCTsTyLbrkbkTJcCLIbUx06synFvE1uCD7vL7
        JLUnBrng==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUgt-0000CA-8D; Fri, 13 Nov 2020 08:44:19 +0000
Date:   Fri, 13 Nov 2020 08:44:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     J??rgen Gro?? <jgross@suse.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC] Enhancement of loop driver?
Message-ID: <20201113084419.GA32694@infradead.org>
References: <1a5ccfd6-d7c1-28d5-3562-05178f44ed3d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5ccfd6-d7c1-28d5-3562-05178f44ed3d@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 13, 2020 at 07:59:23AM +0100, J??rgen Gro?? wrote:
> a large customer is asking for storage migration of the disk images of
> their virtual machines. They don't want to migrate the VM to another
> host, but only the disk image from one filer to another while the VM
> keeps running.
> 
> The natural way to setup something like this would be LVM and use
> mirroring, but the problem is that this requires to copy the image to
> a LVM enabled disk first, and this is no option due to time constraints
> (copying many GB of data takes too long, and in the end I'd like to be
> able to do the switch from the original image to the LVM backed with
> the VM kept running).
> 
> So my idea was to enhance the loop driver to be capable to support a
> list of backing files instead of only one and use a small prepended
> file for storing the needed LVM metadata, resulting in the ability to
> keep the existing disk image.
> 
> Would such an addition be acceptable?

Just use device mapper on top of the loop device, no need for changes
to the loop driver itself.  Also qemu has some interesting migration
features that you might want to look into as they might suit you.
