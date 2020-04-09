Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585761A38A0
	for <lists+linux-block@lfdr.de>; Thu,  9 Apr 2020 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgDIRJ2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 9 Apr 2020 13:09:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgDIRJ2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 13:09:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CEF8ABEF;
        Thu,  9 Apr 2020 17:09:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E289D1E124D; Thu,  9 Apr 2020 19:09:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 RFC] bfq: Waker logic tweaks for dbench performance
Date:   Thu,  9 Apr 2020 19:09:13 +0200
Message-Id: <20200409170915.30570-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I was investigating why dbench performance (even for single dbench client) with
BFQ is significantly worse than it used to be CFQ. The culprit is the idling
logic in BFQ. The dbench workload is very fsync(2) heavy. In practice the time
to complete fsync(2) calls is what determines the overall performance. For
filesystems with a journal such as xfs or ext4 it is common that fsync(2)
involves writing data from the process runningg fsync(2) - dbench in this case
- and then waiting for the journalling machinery to flush out metadata from a
separate process (jbd2 process in ext4 case, worker thread in xfs case).
CFQ's heuristic was able to determine that it isn't worth to idle waiting for
either dbench or jbd2 IO. BFQ's heuristic is not able to determine this and
thus jbd2 process is often blocked waiting for idle timer of dbench queue to
trigger.

The first patch in the series is an obvious bugfix but is not enough to improve
performance. The second patch does improve dbench performance from ~80 MB/s
to ~200 MB/s on my test machine but I'm aware that it is probably way too
aggressive and probably a different solution is needed. So I just wrote that
patch to see the results and spark some discussion :). Any idea how to
improve the waker logic so that dbench performance doesn't drop so
dramatically?

								Honza
