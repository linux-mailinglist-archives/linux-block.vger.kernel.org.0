Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9603B1EFB51
	for <lists+linux-block@lfdr.de>; Fri,  5 Jun 2020 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgFEOZr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 5 Jun 2020 10:25:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgFEOQa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13F1BAB64;
        Fri,  5 Jun 2020 14:16:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B4CD1E1281; Fri,  5 Jun 2020 16:16:29 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] bfq: Two fixes and a cleanup for sequential readers
Date:   Fri,  5 Jun 2020 16:16:15 +0200
Message-Id: <20200605140837.5394-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

this patch series contains one tiny cleanup and two relatively simple fixes
for BFQ I've uncovered when analyzing behavior of four parallel sequential
readers on one machine. The fio jobfile is like:

[global]
direct=0
ioengine=sync
invalidate=1
size=16g
rw=read
bs=4k

[reader]
numjobs=4
directory=/mnt

The first patch fixes a problem due to which the four bfq queues were getting
merged without a reason. The third patch fixes a problem where we were unfairly
raising bfq queue think time (leading to clearing of short_ttime and subsequent
reduction in throughput).

What do people think about these?

								Honza
