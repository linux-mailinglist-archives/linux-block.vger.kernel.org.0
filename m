Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD7E39564C
	for <lists+linux-block@lfdr.de>; Mon, 31 May 2021 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhEaHk0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 May 2021 03:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230091AbhEaHkZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 May 2021 03:40:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C530160C3F;
        Mon, 31 May 2021 07:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622446726;
        bh=06TECy+YmcfYsEk7ugjW7LCflCl3kaCrYcMohPerJMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ/nOT/mIPjemJ8fEkbGZFkbw6I+wZ8Dv+ARY9QPGnY1RPq1LKoL/FuKZZ150gAN8
         fXn53Eg2Kt1H1EavYo9fTclbyu+QVxV+OwcGSNGv4+M3ekYtrQuxvfJJLRDQ5OrC8A
         G/2FIVFGTaATWGyaQG0wCiRAyM3PTlTR3JNiaIFk=
Date:   Mon, 31 May 2021 09:38:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, arnd@arndb.de, linux-block@vger.kernel.org
Subject: Re: [PATCH] remove the raw driver
Message-ID: <YLSSgyznnaUPmRaT@kroah.com>
References: <20210531072526.97052-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531072526.97052-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 31, 2021 at 10:25:26AM +0300, Christoph Hellwig wrote:
> The raw driver used to provide direct unbuffered access to block devices
> before O_DIRECT was invented.  It has been obsolete for more than a
> decade.

What?  Really?  We can finally do this?  Yes!

For some reason, I thought there was some IBM userspace tools that
relied on this device, if not, then great!

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

