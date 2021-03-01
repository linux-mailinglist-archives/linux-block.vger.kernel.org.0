Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962A0327604
	for <lists+linux-block@lfdr.de>; Mon,  1 Mar 2021 03:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhCACKu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 28 Feb 2021 21:10:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbhCACKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Feb 2021 21:10:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DpkFM009vzjLYJ;
        Mon,  1 Mar 2021 10:08:22 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Mar 2021
 10:09:52 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC:     <josef@toxicpanda.com>, <ming.lei@redhat.com>, <hch@lst.de>,
        <bvanassche@acm.org>, <yuyufen@huawei.com>
Subject: [RFC PATCH 0/2] blk-mq: improve blk_mq_tag_to_rq()
Date:   Sun, 28 Feb 2021 21:14:42 -0500
Message-ID: <20210301021444.4134047-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
   The first patch try to improve blk_mq_tag_to_rq().
   The second patch will cleanup code.

Yufen Yu (2):
  blk-mq: test tags bitmap before get request
  blk-mq: blk_mq_tag_to_rq() always return null for sched_tags

 block/blk-mq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.25.4

