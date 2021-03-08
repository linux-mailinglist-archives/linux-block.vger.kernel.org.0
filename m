Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD8C331643
	for <lists+linux-block@lfdr.de>; Mon,  8 Mar 2021 19:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhCHSiE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 8 Mar 2021 13:38:04 -0500
Received: from verein.lst.de ([213.95.11.211]:57001 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229646AbhCHShy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Mar 2021 13:37:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5D6C768B02; Mon,  8 Mar 2021 19:37:51 +0100 (CET)
Date:   Mon, 8 Mar 2021 19:37:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Martin Wilck <mwilck@suse.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Suppress uevent for hidden device when removed
Message-ID: <20210308183751.GA17380@lst.de>
References: <20210303171201.8432-1-dwagner@suse.de> <66a9b7ff4958ab990f58a3dad8152d00c59775ce.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66a9b7ff4958ab990f58a3dad8152d00c59775ce.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 03, 2021 at 06:30:34PM +0100, Martin Wilck wrote:
> I wonder if it wouldn't be wiser to remove this code
> 
>         if (disk->flags & GENHD_FL_HIDDEN) {
>                 dev_set_uevent_suppress(ddev, 0);
>                 return;
>         }
> 
> from register_disk(). The way you did it now, we would receive neither
> "add" nor "remove" events in user space, but there might be change
> events in between ?

Well, we'll need to keep the return.  That being said keepign the
uevents supressed entirely might be a good idea.
