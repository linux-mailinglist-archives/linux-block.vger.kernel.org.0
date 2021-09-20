Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D6141111F
	for <lists+linux-block@lfdr.de>; Mon, 20 Sep 2021 10:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhITImF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Sep 2021 04:42:05 -0400
Received: from verein.lst.de ([213.95.11.211]:50553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbhITImD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 04:42:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C592E67373; Mon, 20 Sep 2021 10:40:34 +0200 (CEST)
Date:   Mon, 20 Sep 2021 10:40:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: genhd: fix double kfree() in
 __alloc_disk_node()
Message-ID: <20210920084034.GA467@lst.de>
References: <0000000000004a5adf05cc593ca9@google.com> <41766564-08cb-e7f2-4cb2-9ad102f21324@I-love.SAKURA.ne.jp> <3999c511-cd27-1554-d3a6-4288c3eca298@i-love.sakura.ne.jp> <20210920064028.GB26999@lst.de> <c5b78df8-1ab7-04fa-d6e8-c7270c3bc373@i-love.sakura.ne.jp> <20210920080547.GA30362@lst.de> <692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <692fdc1a-6396-dcf4-c700-2d822f161053@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
