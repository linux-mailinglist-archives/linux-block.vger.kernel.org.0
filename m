Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545C83FD2FC
	for <lists+linux-block@lfdr.de>; Wed,  1 Sep 2021 07:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbhIAFhx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Sep 2021 01:37:53 -0400
Received: from verein.lst.de ([213.95.11.211]:46130 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242008AbhIAFhw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Sep 2021 01:37:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 895BD68AFE; Wed,  1 Sep 2021 07:36:53 +0200 (CEST)
Date:   Wed, 1 Sep 2021 07:36:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Hillf Danton <hdanton@sina.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] loop: reduce the loop_ctl_mutex scope
Message-ID: <20210901053653.GA14913@lst.de>
References: <2642808b-a7d0-28ff-f288-0f4eabc562f7@i-love.sakura.ne.jp> <20210827184302.GA29967@lst.de> <73c53177-be1b-cff1-a09e-ef7979a95200@i-love.sakura.ne.jp> <20210828071832.GA31755@lst.de> <c5e509ec-2361-af25-ec73-e033b5b46ebb@i-love.sakura.ne.jp> <33a0a1e5-a79f-1887-6417-c5a81f58e47d@i-love.sakura.ne.jp> <cc5c215f-4b3b-94e9-560b-a02d0e23c97c@i-love.sakura.ne.jp> <20210830071350.GB2498@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830071350.GB2498@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 30, 2021 at 09:13:50AM +0200, Christoph Hellwig wrote:
> Hi Tetsuo,
> 
> this generally looks fine to me.  The only issue is that I remember is
> that cmpxchg did historically not work on bool on all architectures.
> I'm not sure if this has been fixed since.

Looks like that still is an issue based on the buildbot reports on
linux-kernel.  I'd suggest to resend with idr_visible as an int.
