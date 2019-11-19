Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCBF10121F
	for <lists+linux-block@lfdr.de>; Tue, 19 Nov 2019 04:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKSDUB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Nov 2019 22:20:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfKSDUB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 22:20:01 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811A42230F;
        Tue, 19 Nov 2019 03:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574133600;
        bh=3H8618+VZUATiI2/5A4JcV1lJ5zgJKbaPCe1NM/Frhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+ZSeX7WtzWw+bDNgjLTNoRFPKHkyXIzhwHNBrBg5uwCRy7Z672TtlGUuudTab4UN
         oO+2ESxb6DFOD1OOVp5DMCs9Dqtm1DRoy/taFfPcKwmWJbobkWsHnBRtppZCRZxr7f
         FeRlA5SGbLqbR4WZ3IilPr8U1/Dss5Bgb2XHf01c=
Date:   Mon, 18 Nov 2019 19:19:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Sun Ke <sunke32@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nbd:fix memory leak in nbd_get_socket()
Message-ID: <20191119031959.GK3147@sol.localdomain>
References: <1574133408-77202-1-git-send-email-sunke32@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574133408-77202-1-git-send-email-sunke32@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 19, 2019 at 11:16:48AM +0800, Sun Ke wrote:
> Before return NULL,put the sock first.
> 
> Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")

Since this commit went to stable kernels, can you add Cc stable to this one?

Thanks,

- Eric
