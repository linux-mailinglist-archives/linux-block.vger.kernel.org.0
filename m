Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4024E3D44
	for <lists+linux-block@lfdr.de>; Tue, 22 Mar 2022 12:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiCVLLr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Mar 2022 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiCVLLr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 07:11:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF636E4E6
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 04:10:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C54E68AFE; Tue, 22 Mar 2022 12:10:17 +0100 (CET)
Date:   Tue, 22 Mar 2022 12:10:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        syzbot+6479585dfd4dedd3f7e1@syzkaller.appspotmail.com
Subject: Re: [PATCH 8/8] loop: don't destroy lo->workqueue in __loop_clr_fd
Message-ID: <20220322111017.GB28931@lst.de>
References: <20220316084519.2850118-1-hch@lst.de> <20220316084519.2850118-9-hch@lst.de> <20220316112522.7fvzz7hgnyogbkxj@quack3.lan> <dd4e3821-24cf-8b65-4851-f90b395a4557@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd4e3821-24cf-8b65-4851-f90b395a4557@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 16, 2022 at 10:24:20PM +0900, Tetsuo Handa wrote:
> Since this WQ is invoked when flushing data to disk, this WQ had better use
> WQ_MEM_RECLAIM flag when creating. A WQ created with WQ_MEM_RECLAIM flag has
> at least one "struct task_struct" in order to guarantee forward progress, but
> results in consuming more kernel resources. Therefore, it is preferable to
> destroy the WQ when clearing unbinding a loop device from a backing file.

Whіch then gets us into lock dependency problems.  A previously used
but lingering around device will use some resources, so what?  If you
care about the least used resources the only way to get there is to
destroy the device.
