Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7846E2C509D
	for <lists+linux-block@lfdr.de>; Thu, 26 Nov 2020 09:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgKZIgB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Nov 2020 03:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727039AbgKZIgB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606379760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dW3rfbZkE6X0qbCIBLnHYwBzP5g00qxHtPirXb8Lcwk=;
        b=SpqWhs2yqq3ohMnV7y/bpYY8cYYoKtWLi/W9nwaQ9+bod5fVqwRVMP/eb1UOEFXUB7FMBF
        1wZc+3zQL7e+s8VgwfyYrmi7ZHGaKRBmHhvgrkRa/dhRCGquNJhurMfhQh9xC8DH6DlOBi
        R0cFt3XMWEGfgfYzIk/V0noJBjoFzWc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-lWIof1RhN12owbQdCKyNFA-1; Thu, 26 Nov 2020 03:35:55 -0500
X-MC-Unique: lWIof1RhN12owbQdCKyNFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AA839A229;
        Thu, 26 Nov 2020 08:35:54 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE59519C71;
        Thu, 26 Nov 2020 08:35:52 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     osandov@osandov.com, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me
Subject: [PATCH V3 blktests 0/5] nvmeof-mp/srp/nvme-rdma misc fix and enhancement 
Date:   Thu, 26 Nov 2020 16:35:27 +0800
Message-Id: <20201126083532.27509-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

This patch series addressed some failures when I run nvmeof-mp/srp
test and also add suport to use siw for nvme-rdma/nvmeof-mp/srp  testing
from cmdline, like this:

$ use_siw=1 nvme-trtype=rdma ./check nvme
$ use_siw=1 ./check nvmeof-mp
$ use_siw-1 ./check srp

V3:
Use sed to output the scheduler from sysfs directly in patch 3

V2:
Update the ib_srpt module path in patch 1, avoid to use ls
Update the SKIP_REASON in patch 2
Introduce get_scheduler_list, fix nvmeof-mp/012 and srp/012 in patch 3
Typo fix in patch 4

Yi Zhang (5):
  tests/srp/rc: update the ib_srpt module name
  tests/nvmeof-mp/rc: run nvmeof-mp tests if we set multipath=N
  nvmeof-mp/012, srp/012: fix the scheduler list
  common/rc: _have_iproute2 fix for "ip -V" change
  common/multipath-over-rdma: allow to set use_siw

 common/multipath-over-rdma | 13 ++++++++++++-
 common/rc                  |  2 +-
 tests/nvmeof-mp/012        | 10 ++++++----
 tests/nvmeof-mp/rc         |  8 +++++---
 tests/srp/012              | 10 ++++++----
 tests/srp/rc               |  4 ++--
 6 files changed, 32 insertions(+), 15 deletions(-)

-- 
2.21.0

