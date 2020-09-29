Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD5027BD3A
	for <lists+linux-block@lfdr.de>; Tue, 29 Sep 2020 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgI2GhX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Sep 2020 02:37:23 -0400
Received: from verein.lst.de ([213.95.11.211]:38340 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2GhX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 02:37:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 53AF86736F; Tue, 29 Sep 2020 08:37:21 +0200 (CEST)
Date:   Tue, 29 Sep 2020 08:37:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: change the hash used for looking up block
 devices
Message-ID: <20200929063721.GA1839@lst.de>
References: <20200927071115.372289-1-hch@lst.de> <20200928222116.GG1340@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928222116.GG1340@sol.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 28, 2020 at 03:21:16PM -0700, Eric Biggers wrote:
> Doesn't ->bd_dev still need to be set somewhere?

Yes.  This was fixed in the next patch in my series which isn't
quite ready..
