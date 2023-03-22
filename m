Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6A46C4F36
	for <lists+linux-block@lfdr.de>; Wed, 22 Mar 2023 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCVPRU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Mar 2023 11:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjCVPRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 11:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2402637C6
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679498189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LEcUHZJxOFtUyVvQqcIBD8l6d7KyekSvuTkHpJnJZps=;
        b=PId1eQnB3g6br+roVZrV6dnZ68pRx06c3Kuwwu0EY4pTTVpdS56ltanb9V5JLHuTPV2+JV
        sVMvN8UNQ9IWLbQHMnM80IkZk5WvEpkSI3a+NoTssspAqWlA5vgfGv89O2fssOmFvXF7AF
        J1s82fV313sA9v5KTqEobRD2PSI6K2U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-m_-fCENBNa2Rx1VOpkXP9g-1; Wed, 22 Mar 2023 11:16:20 -0400
X-MC-Unique: m_-fCENBNa2Rx1VOpkXP9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BEF63C0ED4E;
        Wed, 22 Mar 2023 15:16:20 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E71F451FF;
        Wed, 22 Mar 2023 15:16:18 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, rafael.antognolli@intel.com,
        Ondrej Kozina <okozina@redhat.com>
Subject: [PATCH 0/5] sed-opal: add command to read locking range attributes
Date:   Wed, 22 Mar 2023 16:15:59 +0100
Message-Id: <20230322151604.401680-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set aims to add ability to user authorities to read locking
range attributes.

It's achieved in two steps (except SUM enabled drives):

1) Patch IOC_OPAL_ADD_USR_TO_LR command so that user authority (together with
OPAL_ADMIN1) is added in ACE that allows getting locking range attributes.

2) Add new ioctl command IOC_OPAL_GET_LR_STATUS to get locking range
attributes to user authority assigned to specific locking range.

libcryptsetup plans to support OPAL2 drives and needs to verify locking
range parameters before device activation (LR unlock) takes place since
it's considered undesirable to have (for example) partition mapped beyond
locking range boundaries.

Ondrej Kozina (5):
  sed-opal: do not add user authority twice in boolean ace.
  sed-opal: add helper for adding user authorities in ACE.
  sed-opal: allow user authority to get locking range attributes.
  sed-opal: add helper to get multiple columns at once.
  sed-opal: Add command to read locking range parameters.

 block/opal_proto.h            |   1 +
 block/sed-opal.c              | 263 ++++++++++++++++++++++++++++------
 include/linux/sed-opal.h      |   1 +
 include/uapi/linux/sed-opal.h |  11 ++
 4 files changed, 233 insertions(+), 43 deletions(-)

-- 
2.31.1

