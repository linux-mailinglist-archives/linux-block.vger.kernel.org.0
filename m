Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3DB3D8849
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhG1GyG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Jul 2021 02:54:06 -0400
Received: from verein.lst.de ([213.95.11.211]:52571 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232798AbhG1GyG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jul 2021 02:54:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 683BD67357; Wed, 28 Jul 2021 08:54:03 +0200 (CEST)
Date:   Wed, 28 Jul 2021 08:54:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/8] block: support delayed holder registration
Message-ID: <20210728065403.GA4815@lst.de>
References: <20210725055458.29008-1-hch@lst.de> <20210725055458.29008-5-hch@lst.de> <YQAu7KKyKnCm+tlf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQAu7KKyKnCm+tlf@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 12:06:04PM -0400, Mike Snitzer wrote:
> This header starts to shine some light on what is motivating this
> series by touching on "all kinds of bad side effects" being fixed.
> Any chance you could elaborate what you've noticed/found/hit?

The proble mis that it leaves the queue in a weird half state.  The
normal states for a gendisk are:

 1) allocated		(after *alloc_disk)
 2) registered		(after add_disk*)
 3) unregistered	(after del_gendisk)

the delayed queue registration adds a weird half state where it is
sort of registered, except for in sysfs and the elevator.  I have
some pretty big changes between how the disk and queue interact
that tripped over it, but even right now code has to be very careful
in the takedown path to deal with the half-initialized disks.
