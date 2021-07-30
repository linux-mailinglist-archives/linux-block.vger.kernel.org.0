Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01B903DB73A
	for <lists+linux-block@lfdr.de>; Fri, 30 Jul 2021 12:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhG3KjD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Jul 2021 06:39:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43188 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbhG3KjD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jul 2021 06:39:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8AEE222303;
        Fri, 30 Jul 2021 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627641537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IL3gKsLKu1Htgmjw2itJagsBsJXMj/k7+BJ8VjbP5yU=;
        b=UKueawrOS2soO7K5pdL84trOzFfkOx0Hcp7NKWCsWTWCXtEKXzHJUi7DJrvBTN1ejjqWNO
        MJCgQuOWOyBbWgaCOmwkBxXGdb3HYvi+gOep54ehKXUvMzjAoY1RA4oCDnuibim2K0x9/m
        9XvQ099RvClbgfflBomn/U9sfezMyyw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 49C9F1332A;
        Fri, 30 Jul 2021 10:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OkDREMHWA2HPOAAAGKfGzw
        (envelope-from <jgross@suse.com>); Fri, 30 Jul 2021 10:38:57 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/3] xen: harden blkfront against malicious backends
Date:   Fri, 30 Jul 2021 12:38:51 +0200
Message-Id: <20210730103854.12681-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Xen backends of para-virtualized devices can live in dom0 kernel, dom0
user land, or in a driver domain. This means that a backend might
reside in a less trusted environment than the Xen core components, so
a backend should not be able to do harm to a Xen guest (it can still
mess up I/O data, but it shouldn't be able to e.g. crash a guest by
other means or cause a privilege escalation in the guest).

Unfortunately blkfront in the Linux kernel is fully trusting its
backend. This series is fixing blkfront in this regard.

It was discussed to handle this as a security problem, but the topic
was discussed in public before, so it isn't a real secret.

It should be mentioned that a similar series has been posted some years
ago by Marek Marczykowski-Górecki, but this series has not been applied
due to a Xen header not having been available in the Xen git repo at
that time. Additionally my series is fixing some more DoS cases.

Changes in V3:
- patch 3: insert missing unlock in error case (kernel test robot)
- patch 3: use %#x as format for printing wrong operation value
  (Roger Pau Monné)

Changes in V2:
- put blkfront patches into own series
- some minor comments addressed

Juergen Gross (3):
  xen/blkfront: read response from backend only once
  xen/blkfront: don't take local copy of a request from the ring page
  xen/blkfront: don't trust the backend response data blindly

 drivers/block/xen-blkfront.c | 126 +++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 42 deletions(-)

-- 
2.26.2

