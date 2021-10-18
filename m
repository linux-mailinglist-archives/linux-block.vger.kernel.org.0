Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFAD4321E0
	for <lists+linux-block@lfdr.de>; Mon, 18 Oct 2021 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhJRPIj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Oct 2021 11:08:39 -0400
Received: from verein.lst.de ([213.95.11.211]:34649 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233075AbhJRPIF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 11:08:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B48D068AFE; Mon, 18 Oct 2021 17:05:50 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:05:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Martijn Coenen <maco@android.com>, linux-block@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, Karel Zak <kzak@redhat.com>
Subject: Re: Is LO_FLAGS_DIRECT_IO by default a good idea?
Message-ID: <20211018150550.GA29993@lst.de>
References: <YW2CaJHYbw244l+V@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW2CaJHYbw244l+V@gardel-login>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 18, 2021 at 04:19:20PM +0200, Lennart Poettering wrote:
> A brief answer like "yes, please, enable by default" would already
> make me happy.

I thikn enabling it by default is a good idea.  The only good use
case I can think of for using buffered I/O is when the image has
a smaller block size than supported on the host file.
