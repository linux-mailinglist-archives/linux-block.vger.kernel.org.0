Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA20F256C96
	for <lists+linux-block@lfdr.de>; Sun, 30 Aug 2020 09:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgH3HbE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Aug 2020 03:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgH3HbE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Aug 2020 03:31:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3D92076D;
        Sun, 30 Aug 2020 07:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598772663;
        bh=Njak4YdzyT7v+1QG7LqknfkUzrGFlfnnqodG9TgquRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyDd/cCH3v1Dgpme+wDyQY+dFiQsRmeNrb4pZPJM0xobXoMRYA9BK88ehcFPPEATS
         pXjxQcnbtI56saQxhJGOot31HPm5spAVXFITvjaQeTRea0uOuwUu/EOAI3eyMNDqep
         qN9awzfygJzs6Si6Oz9dZ6rox0mURFFov8/mpcbc=
Date:   Sun, 30 Aug 2020 09:31:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 01/19] char_dev: replace cdev_map with an xarray
Message-ID: <20200830073101.GA112265@kroah.com>
References: <20200830062445.1199128-1-hch@lst.de>
 <20200830062445.1199128-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830062445.1199128-2-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 30, 2020 at 08:24:27AM +0200, Christoph Hellwig wrote:
> None of the complicated overlapping regions bits of the kobj_map are
> required for the character device lookup, so just a trivial xarray
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
