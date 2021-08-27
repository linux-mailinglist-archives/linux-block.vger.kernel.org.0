Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60AB3F9CEC
	for <lists+linux-block@lfdr.de>; Fri, 27 Aug 2021 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhH0QvQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Aug 2021 12:51:16 -0400
Received: from verein.lst.de ([213.95.11.211]:34562 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235635AbhH0QvL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:51:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 93AA868AFE; Fri, 27 Aug 2021 18:50:19 +0200 (CEST)
Date:   Fri, 27 Aug 2021 18:50:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
Message-ID: <20210827165019.GB26631@lst.de>
References: <20210827163250.255325-1-hch@lst.de> <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk> <20210827164051.GA26147@lst.de> <cc2108b6-c688-cceb-a953-f156ad21c3a5@kernel.dk> <20210827164325.GA26364@lst.de> <c7e538b3-e669-1963-b6c5-475285e96784@kernel.dk> <20210827164637.GA26631@lst.de> <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5724b5a9-e8e9-d05d-83fe-8a0920261573@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 27, 2021 at 10:48:09AM -0600, Jens Axboe wrote:
> I don't disagree with that, but that's not a new situation. Hence my
> question on why there's this sudden mad rush to get it queued up for
> removal, literally a few days before a kernel release.

Because this allows the very useful deprecation warning to go out
ASAP.  It's not like printing a message and adding a little Kconfig
text has any risk.
