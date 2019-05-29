Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5632E5E9
	for <lists+linux-block@lfdr.de>; Wed, 29 May 2019 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2UQJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 May 2019 16:16:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfE2UQI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 16:16:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D330236887;
        Wed, 29 May 2019 20:16:08 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-41.rdu2.redhat.com [10.10.122.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FCD819C70;
        Wed, 29 May 2019 20:16:08 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: [PATCH 0/2] nbd: block/dev size changes
Date:   Wed, 29 May 2019 15:16:04 -0500
Message-Id: <20190529201606.14903-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 29 May 2019 20:16:08 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is just Xiubo's zero blksize patch from here:

https://marc.info/?l=linux-kernel&m=155893597828674&w=2

and my resize patch.

Xiubo's zero blksize patch and my resize patch conflicted, so
I fixed the issue mentioned in the link so his patch does "goto out"
instead of returning while holding resources, and rebuilt my patch
over his. I also fixed a issue in my resize patch so we only call
nbd_size_set if a value has changed.


