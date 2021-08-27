Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DFD3F9CBC
	for <lists+linux-block@lfdr.de>; Fri, 27 Aug 2021 18:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhH0Qr3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 12:47:29 -0400
Received: from verein.lst.de ([213.95.11.211]:34553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhH0Qr2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:47:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A43B368AFE; Fri, 27 Aug 2021 18:46:37 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:46:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
Message-ID: <20210827164637.GA26631@lst.de>
References: <20210827163250.255325-1-hch@lst.de> <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk> <20210827164051.GA26147@lst.de> <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk> <20210827164325.GA26364@lst.de> <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 10:43:53AM -0600, Jens Axboe wrote:
> On 8/27/21 10:43 AM, Christoph Hellwig wrote:
> > On Fri, Aug 27, 2021 at 10:42:59AM -0600, Jens Axboe wrote:
> >> But what's the point? Why not just wait for 5.15, it's not like we're
> >> in a mad dash to get it removed.
> > 
> > Actually we kinda are :)
> 
> Because?

It causes trouble by interacting with the actual loop driver people
use in really weird ways, while beeing broken and not actually supported
by userspace tools for about a decade.
