Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF83DFB20
	for <lists+linux-block@lfdr.de>; Wed,  4 Aug 2021 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbhHDFfn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 01:35:43 -0400
Received: from verein.lst.de ([213.95.11.211]:45953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234557AbhHDFfn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 01:35:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2443B67373; Wed,  4 Aug 2021 07:35:28 +0200 (CEST)
Date:   Wed, 4 Aug 2021 07:35:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
Message-ID: <20210804053527.GA5711@lst.de>
References: <20210803182304.365053-1-bvanassche@acm.org> <20210803182304.365053-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803182304.365053-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
> We noticed that the user interface of Android devices becomes very slow
> under memory pressure. This is because Android uses the zram driver on top
> of the loop driver for swapping,

Sorry, but that is just amazingly stupid.  If you really want to swap
to compressed files introduce that support in the swap code instead of
coming up with dumb driver stacks from hell.
