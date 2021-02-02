Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B6730C7A2
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhBBR0k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 12:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbhBBRYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 12:24:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5195C0612F2
        for <linux-block@vger.kernel.org>; Tue,  2 Feb 2021 09:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=77rkhRrIr9DZhPmu/74bAY3zywmUqXx8FB/LeLDhJ1U=; b=m7lOEK4G8Oor30VMIXyB+fF9o/
        h5XEjflipRPfleojH1r0+4ypBClN+5A+jKJVkmom8O2x1CHnjUmZZ9KJpsdypCD0SL2JjaKY34R9t
        XIet8YrEBbMfuYFy/Pn9UouSITFFdXn1UewDrlKhxAiC6A9LgsL1mSNP7k1jQFIgjrFo0wTRBdTf2
        PZIcpPr9nRc/dxgQdtlReUjyDvdvt1aeIunzz+Yn1k3R1zQ92uL5Yu/3rh8EDYweY7mOmNGsv24Q6
        KNpFWJjKotZ+FCdWKgo1+ujUTRg+vNGUIMAdExAoT3Tiv23D76k0MkpQitzacltbHshiuo1HnCkgd
        3ITbkP6A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6zPK-00FWKV-JI; Tue, 02 Feb 2021 17:24:06 +0000
Date:   Tue, 2 Feb 2021 17:24:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matias Bj??rling <mb@lightnvm.io>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: fix unnecessary NULL check warnings
Message-ID: <20210202172406.GA3699007@infradead.org>
References: <1612230105-31365-1-git-send-email-tiantao6@hisilicon.com>
 <BYAPR04MB4965F95707D5C87608B4ADEA86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
 <f76e7f84-5f4a-c69a-e203-117102164335@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f76e7f84-5f4a-c69a-e203-117102164335@lightnvm.io>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 02, 2021 at 05:00:34PM +0100, Matias Bj??rling wrote:
> Thanks, Tian and Chaitanya. I'll queue it up.

Didn't we plan to kill off lightnvm?
