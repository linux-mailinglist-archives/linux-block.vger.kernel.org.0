Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A9A23128C
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 21:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgG1T3N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jul 2020 15:29:13 -0400
Received: from charlie.dont.surf ([128.199.63.193]:58774 "EHLO
        charlie.dont.surf" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgG1T3M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 15:29:12 -0400
X-Greylist: delayed 574 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Jul 2020 15:29:11 EDT
Received: from apples.localdomain (80-167-98-190-cable.dk.customer.tdc.net [80.167.98.190])
        by charlie.dont.surf (Postfix) with ESMTPSA id 03BB2BFB1A;
        Tue, 28 Jul 2020 19:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=irrelevant.dk;
        s=default; t=1595964046;
        bh=B9H9ATiGYLXTaCg3R0PnTNZx7UCp5k6ltv18EDpTlAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U20vcjfbnjC2uAuzsp2QFTET0cV67R+P6Y9xJrdtUmdkPk7+HsOn12HUoxEANFUoR
         FHkyX28aYu9/eGRayssgEiRxtTNChgBXW/dzNWctjuQwJB2e7utckYfm2nc6N+sj8f
         Pa2ttNzkJtYnClOfptxM6UB6ilNn4b8oKMtVK2WAE4wC3Jrb9Cz1M5PDzuWW4hlt2E
         jG8SFRT80pe4SU8yAQOi1QDtbpEQ93JxAOCm3hz4Y8TSWqswMWzLnQtfphe7nc0pY5
         dwnjphu7OEYjnod8FQeA+QqEw+tw5i1x+0+1Q+KI7G3Xq1N3nw2zIvGKDDZ4NSrWx7
         Im4nOfHPThEoA==
Date:   Tue, 28 Jul 2020 21:20:44 +0200
From:   Klaus Jensen <its@irrelevant.dk>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 5/5] zbd/002: Check write pointers only when
 zones have valid conditions
Message-ID: <20200728192044.GE103177@apples.localdomain>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-6-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728101452.19309-6-shinichiro.kawasaki@wdc.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 28 19:14, Shin'ichiro Kawasaki wrote:
> Per ZBC, ZAC and ZNS specifications, when zones have condition "read
> only", "full" or "offline", the zones may not have valid write pointers.
> In such a case, do not check validity of write pointers.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---

LGTM.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
