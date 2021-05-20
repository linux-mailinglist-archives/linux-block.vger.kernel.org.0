Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03C638B981
	for <lists+linux-block@lfdr.de>; Fri, 21 May 2021 00:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhETWfZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 May 2021 18:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:39198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231466AbhETWfY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 18:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E356ABCD;
        Thu, 20 May 2021 22:34:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 31B521F2C73; Fri, 21 May 2021 00:34:01 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Khazhy Kumykov <khazhy@google.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2] block: Fix deadlock when merging requests with BFQ
Date:   Fri, 21 May 2021 00:33:51 +0200
Message-Id: <20210520223353.11561-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

This patch series fixes a lockdep complaint and a possible deadlock that
can happen when blk_mq_sched_try_insert_merge() merges and frees a request.

								Honza
