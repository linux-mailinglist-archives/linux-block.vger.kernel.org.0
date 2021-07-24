Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB03D4573
	for <lists+linux-block@lfdr.de>; Sat, 24 Jul 2021 08:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbhGXGRU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 24 Jul 2021 02:17:20 -0400
Received: from verein.lst.de ([213.95.11.211]:40317 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhGXGRU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Jul 2021 02:17:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0027B67373; Sat, 24 Jul 2021 08:57:49 +0200 (CEST)
Date:   Sat, 24 Jul 2021 08:57:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Christoph Hellwig <hch@lst.de>, Petr Vorel <pvorel@suse.cz>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v3] loop: reintroduce global lock for safe
 loop_validate_file() traversal
Message-ID: <20210724065749.GA2476@lst.de>
References: <20210702153036.8089-1-penguin-kernel@I-love.SAKURA.ne.jp> <288edd89-a33f-2561-cee9-613704c3da20@i-love.sakura.ne.jp> <20210706054622.GE17027@lst.de> <6049597b-693e-e3df-d4f0-f2cb43381b84@i-love.sakura.ne.jp> <521eb103-db46-3f34-e878-0cdd585ee8bd@i-love.sakura.ne.jp> <8031a79f-5f32-3306-821d-6c783bb73413@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8031a79f-5f32-3306-821d-6c783bb73413@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 23, 2021 at 10:19:39AM -0600, Jens Axboe wrote:
> I'll queue this up for next weeks merging. Christoph, are you happy with
> it at this point? Can't say it's a thing of beauty, but the problem does
> seem real.

Exactly my feelings.
