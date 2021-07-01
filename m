Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC73B9004
	for <lists+linux-block@lfdr.de>; Thu,  1 Jul 2021 11:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhGAJvt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 1 Jul 2021 05:51:49 -0400
Received: from verein.lst.de ([213.95.11.211]:47010 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235300AbhGAJvs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 1 Jul 2021 05:51:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88A836736F; Thu,  1 Jul 2021 11:49:16 +0200 (CEST)
Date:   Thu, 1 Jul 2021 11:49:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: grab a device refcount in disk_uevent
Message-ID: <20210701094915.GA2066@lst.de>
References: <20210701081638.246552-1-hch@lst.de> <20210701081638.246552-2-hch@lst.de> <YN2CrbtFEKwDGff0@T590> <20210701090232.GA31321@lst.de> <YN2IIiKUvquxqx6k@T590> <YN2KiYTtA0ribi9i@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN2KiYTtA0ribi9i@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 05:27:37PM +0800, Ming Lei wrote:
> 
> Maybe the reason is that sending uevent needs the device/kobject not
> 'released' in viewpoint of driver core world, other device resource(such
> as device name) may be referred but have been freed.
> 
> If that is the reason, this patch looks fine, and
> kobject_get_unless_zero() may be replaced with get_device() since the
> referred memory isn't freed yet.

Yes, sorry.  Braino while looking up the cause.  But there isn't much
of a point in sending a uevent to a partition already deleted, so
I think the unless_zero here still makes sense.
