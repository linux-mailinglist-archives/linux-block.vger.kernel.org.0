Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF52B0E17
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 20:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgKLTbD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 14:31:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:47264 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgKLTbD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 14:31:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 628ABAB95;
        Thu, 12 Nov 2020 19:31:02 +0000 (UTC)
Date:   Thu, 12 Nov 2020 20:31:00 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
Subject: Re: loop uevent fix
Message-ID: <20201112193100.GC14767@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20201112165005.4022502-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112165005.4022502-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Christoph,

> Hi Peter and Jens,

> this is how I'd slightly respin the patch from Petr on top of the
> set_capacity_revalidate_and_notify I need for 5.11.  Let me know what
> you think.

+1, thanks.

From your discussion on my original patch I understand that these 2 fixes will
make it to v5.10-rc4. Will they go also to v5.9 stable tree? (it affects also
v5.8, but that version is EOL).

Kind regards,
Petr
