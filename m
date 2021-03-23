Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029CA3466E7
	for <lists+linux-block@lfdr.de>; Tue, 23 Mar 2021 18:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCWR4H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Mar 2021 13:56:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:40790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhCWRzt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 13:55:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15D1BAD38;
        Tue, 23 Mar 2021 17:55:48 +0000 (UTC)
Date:   Tue, 23 Mar 2021 10:55:39 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] block/umem: convert tasklet to threaded irq
Message-ID: <20210323175539.tizzqsfxrdjunph3@offworld>
References: <20210323004856.10206-1-dave@stgolabs.net>
 <20210323172437.GA2463754@infradead.org>
 <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0d26434e-36e2-58f2-16b4-ef0fa4292c6e@kernel.dk>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 23 Mar 2021, Jens Axboe wrote:

>Me too, I'd be surprised if anyone has used it in... forever. We can
>probably drop it - I really dislike making core changes to something
>that can't even be tested. Davidlohr, assuming you had no way of
>testing this change?

No, no way of testing these changes - I got here via git grep.
