Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD623F2F65
	for <lists+linux-block@lfdr.de>; Fri, 20 Aug 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbhHTP1W (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 20 Aug 2021 11:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241147AbhHTP1O (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 11:27:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0FC0698C7
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbJvv4A9FM8VIR/Ol6q6b/S4QPVrH1l7eAzEUZ1W24U=; b=brI2tc488hLBXHNhQ7egC9s5SE
        XsmmbufcXHtjZDc2VaTdQwxgZ1L1o15CFnlbUV90z/GfO/KZFYAeyawKPieVq39i+gGZ3On0c63Qs
        TKVY64cMPWc1Rg2ONjmaZzBaA68fmJVHlBFayBsaXM+pLQW2DLYSMLytER8U57eaiJpxMrBBYlbTn
        oZxoLPCpmTGDXmIz/ffrXwkZmec83PibkGGuh03oKghNOlCMt6T73CCARSHIh04ELUEQWH1YbDm8Z
        mD6uYgVMxrLVYoErZlY52gjvp4nMtX6volbr+4+hiol7wsXBAiN0V5tK5uhRTLCAvPbkkl9bziLUv
        uBKGfeNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH6Ka-006dic-UC; Fri, 20 Aug 2021 15:21:52 +0000
Date:   Fri, 20 Aug 2021 16:21:16 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Douglas Miller <dougmill@linux.vnet.ibm.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH RESEND] block: sed-opal: Add ioctl to return device status
Message-ID: <YR/IbHc5Mv826TQk@infradead.org>
References: <c43a9295-1dad-fa0a-590d-0182bba643a1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43a9295-1dad-fa0a-590d-0182bba643a1@linux.vnet.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 18, 2021 at 07:22:09AM -0500, Douglas Miller wrote:
> +++ b/block/sed-opal.c
> @@ -75,7 +75,11 @@ struct parsed_resp {
>  struct opal_dev {
>  	bool supported;
> +	bool locking_supported;
> +	bool locking_enabled;
> +	bool locked;
>  	bool mbr_enabled;
> +	bool mbr_done;

Please switch all these bools (or u8s in the user space ABI) to
flags with descriptive names on an u32 variable.
