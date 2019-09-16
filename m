Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20202B3615
	for <lists+linux-block@lfdr.de>; Mon, 16 Sep 2019 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfIPIBr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Sep 2019 04:01:47 -0400
Received: from verein.lst.de ([213.95.11.211]:42998 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfIPIBr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 04:01:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C377A68B05; Mon, 16 Sep 2019 10:01:42 +0200 (CEST)
Date:   Mon, 16 Sep 2019 10:01:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me,
        shlomin@mellanox.com, israelr@mellanox.com
Subject: Re: [PATCH v5 2/2] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190916080142.GA25898@lst.de>
References: <1568215397-15496-1-git-send-email-maxg@mellanox.com> <1568215397-15496-2-git-send-email-maxg@mellanox.com> <380932df-2119-ad86-8bb2-3eccb005c949@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380932df-2119-ad86-8bb2-3eccb005c949@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 11, 2019 at 04:01:11PM -0600, Jens Axboe wrote:
> While I like the idea of centralizing stuff like this, I'm also not
> happy with adding checks like this to the fast path. But I guess it's
> still better than stuff it in drivers.

Let's put it that way - we move the check from our two most commonly
drivers (one of those also is our most performance sensitive) to common
code.  I think this should generally be a net win?
