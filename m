Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A434B21688C
	for <lists+linux-block@lfdr.de>; Tue,  7 Jul 2020 10:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGGIqI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Jul 2020 04:46:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725944AbgGGIqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jul 2020 04:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594111567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+dWhlbnG3YkaVPNnUfy6Js8AJqmNMKcii1NGFb1JOYw=;
        b=UR6NXhC4xL8uPPe8cx/I0to8SIMzEsQox61ARH0i1ENWUGs7rqbncT7HQV2nC+heqHfTVZ
        99VhbJuuel0gqtMp/DbSUiAnhzdHfZe6KU770oyMXwhJ4Tje6hW1KfE4V3ybSRZ+6avgea
        QRVAUNobeRXqtfm+VaW+yOQJRrfrhKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-E2pnnnGDNYGAPyzbwofKzg-1; Tue, 07 Jul 2020 04:46:05 -0400
X-MC-Unique: E2pnnnGDNYGAPyzbwofKzg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F63805EE6;
        Tue,  7 Jul 2020 08:46:04 +0000 (UTC)
Received: from localhost (ovpn-12-188.pek2.redhat.com [10.72.12.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2325473FE4;
        Tue,  7 Jul 2020 08:46:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/2] block: loop: delete partitions after clearing & changing fd
Date:   Tue,  7 Jul 2020 16:45:50 +0800
Message-Id: <20200707084552.3294693-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch cleans up __loop_clr_fd a bit.

The 2nd patch fixes one issue which may make ghost partitions even
though after fd is cleared or changed.


Ming Lei (2):
  block: loop: share code of reread partitions
  block: loop: delete partitions after clearing & changing fd

 drivers/block/loop.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.25.2

