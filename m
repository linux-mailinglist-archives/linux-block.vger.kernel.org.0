Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241BF3BD982
	for <lists+linux-block@lfdr.de>; Tue,  6 Jul 2021 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhGFPKh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Jul 2021 11:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhGFPKc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 11:10:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAE0C0613F0;
        Tue,  6 Jul 2021 07:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bSvpjhgP5fvU7Z2BF9vcIsjwyKe1ERgOZ9N55mXjHwc=; b=UYupbu5NLDLW4TTr0d4kO8BvUb
        7h/MCAAQwCiwKIrBxoZgbd1VAykBP4fpe5lAo/vX9oC9uIdsr79kJYm84aiVMWjIdS/QT8BU/vLt5
        8T9eBF8nFwMlDQeyBgDR6uElyq+Fwk31f62wWr4BYhMh5nlmb7QX7OYuYOynhZg/yZAFnvS0gvTCw
        tPdJX55mmzgT8wWhhPJdMEYP1Kyva/qLatAB6wF7UySoUvCilh7PgcPG4wXK0oRp1DE44bvIQW3HU
        9Kx9dZi/5GAt/9HNX/dQnT1aHonUTiFoc/omY8pgZD1YjssBvRJrXU/mGvncheD/jRl1HGqnOiEZW
        seGq8YAQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0lcD-00BRRy-Vk; Tue, 06 Jul 2021 13:59:59 +0000
Date:   Tue, 6 Jul 2021 14:59:57 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        kbuild@lists.01.org, lkp@intel.com
Subject: Re: [PATCH v3] block: Removed a warning while compiling with a cross
 compiler for parisc
Message-ID: <YORh3XGNiRKzjDbS@infradead.org>
References: <20210706111912.97611-1-abd.masalkhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706111912.97611-1-abd.masalkhi@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  #ifdef CONFIG_PROC_FS
> +static noinline u64 call_div_u64(u64 dividend, u32 divisor)
> +{
> +	return div_u64(dividend, divisor);
> +}

Do you have any information on how much this reduces stack usage?
As it looks a little silly given the div_u64 implementation.

