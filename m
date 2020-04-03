Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9E19DA5F
	for <lists+linux-block@lfdr.de>; Fri,  3 Apr 2020 17:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgDCPmX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Apr 2020 11:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45828 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgDCPmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 11:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585928542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uGxOJunlxw46pzIKm4qpBYP9Z+z1L3NVwZv5aN7kdWs=;
        b=E8wdsBNmn8qFQZnJjmAxHys39p2YB24RahHPovUoRkWQeHNzpM7NllGeJqMJ18FhgtABff
        mED3zPjZlOnZku4UnFBtBnRG0O8iXhCDBsRJQRcuZQx6gQIR61B2AdW/0VqZhq8Pisz9sS
        rQTKF5pKhSG97WtyCDe0rspDRx/1+Mk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-C8yEcXU2MwybbqxXa76bvg-1; Fri, 03 Apr 2020 11:42:20 -0400
X-MC-Unique: C8yEcXU2MwybbqxXa76bvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9500BDBA5;
        Fri,  3 Apr 2020 15:42:19 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 986EA5DE79;
        Fri,  3 Apr 2020 15:42:14 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:42:13 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>
Subject: [git pull] device mapper fixes for 5.7
Message-ID: <20200403154213.GA18386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 81d5553d1288c2ec0390f02f84d71ca0f0f9f137:

  dm clone metadata: Fix return type of dm_clone_nr_of_hydrated_regions() (2020-03-27 14:42:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes

for you to fetch changes up to 120c9257f5f19e5d1e87efcbb5531b7cd81b7d74:

  Revert "dm: always call blk_queue_split() in dm_process_bio()" (2020-04-03 11:32:19 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix excessive bio splitting that caused performance regressions.

- Fix DM integrity warning on ppc64le due to missing cast.

----------------------------------------------------------------
Mike Snitzer (2):
      dm integrity: fix ppc64le warning
      Revert "dm: always call blk_queue_split() in dm_process_bio()"

 drivers/md/dm-integrity.c | 2 +-
 drivers/md/dm.c           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

