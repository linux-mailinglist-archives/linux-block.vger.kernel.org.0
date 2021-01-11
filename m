Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D852F100F
	for <lists+linux-block@lfdr.de>; Mon, 11 Jan 2021 11:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbhAKK1q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Jan 2021 05:27:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:36674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728683AbhAKK1q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 05:27:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 393D1ACBA;
        Mon, 11 Jan 2021 10:27:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EF1F61E086B; Mon, 11 Jan 2021 11:27:04 +0100 (CET)
Date:   Mon, 11 Jan 2021 11:27:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: Backport of commit "io_uring: grab ->fs as part of async preparation"
Message-ID: <20210111102704.GA808@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I have a question regarding your backport of the commit ff002b30181d
"io_uring: grab ->fs as part of async offload" to 5.4-stable tree. Nicolai
has noticed that the handling of 'old_fs_struct' variable in
io_sq_wq_submit_work() looks fishy. The code looks like:

old_fs_struct = current->fs;

do {
...
	if (req->fs != current->fs && current->fs != old_fs_struct) {
		task_lock(current);
		if (req->fs)
			current->fs = req->fs;
		else
			current->fs = old_fs_struct;
		task_unlock(current);
	}
	...
} while (req);

And the problem with this is that the condition can never be true because
current->fs will never become different from old_fs_struct. I think the
condition should be just 'req->fs != current->fs' - we then either set the
new req->fs, or revert to the original old_fs_struct... What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
