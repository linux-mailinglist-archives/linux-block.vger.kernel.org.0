Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4731E2F1B61
	for <lists+linux-block@lfdr.de>; Mon, 11 Jan 2021 17:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbhAKQsF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Jan 2021 11:48:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:51510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388582AbhAKQsD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 11:48:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A950AAB3E;
        Mon, 11 Jan 2021 16:47:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C10C1E081B; Mon, 11 Jan 2021 17:47:21 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v3] blk-mq: Improve performance of non-mq IO schedulers with multiple HW queues
Date:   Mon, 11 Jan 2021 17:47:15 +0100
Message-Id: <20210111164717.21937-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello!

This patch series aims to fix a regression we've noticed on our test grid when
support for multiple HW queues in megaraid_sas driver was added during the 5.10
cycle (103fbf8e4020 scsi: megaraid_sas: Added support for shared host tagset
for cpuhotplug). The commit was reverted in the end for other reasons but I
believe the fundamental problem still exists for any other similar setup. The
problem manifests when the storage card supports multiple hardware queues
however storage behind it is slow (single rotating disk in our case) and so
using IO scheduler such as BFQ is desirable. See the second patch for details.

Changes since v2
* Modified code to avoid useless sbitmap_any_set() calls on submit path

Changes since v1
* Fixed queue running code to don't leave pending requests that bypass IO
  scheduler.


								Honza
