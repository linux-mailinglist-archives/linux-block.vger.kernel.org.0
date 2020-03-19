Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57C6818B696
	for <lists+linux-block@lfdr.de>; Thu, 19 Mar 2020 14:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgCSN1J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Mar 2020 09:27:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46127 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730853AbgCSN1I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 09:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584624427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qJORlbiWhEj3RSIFG742oRN1ZY7gtu/Y3YwK5syY9Kw=;
        b=c54pq/KLMPj2nX+z5x7D4W1pTDrOYP2cGozg2SJfm0+YZDJCXACGjc6YQOdsGXlnYJ8glt
        b3NkKGOxAhutxqqNHtFecSKLCA1wqHasSAiJW8N00NWNd94iE9UvcuQNSDuvLlMzvz4dss
        K0ULMNFW3CmGpyjOD0NWLaiv7kkNDy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-mUn8W0OGNZqdbefR4Ny2Vg-1; Thu, 19 Mar 2020 09:27:04 -0400
X-MC-Unique: mUn8W0OGNZqdbefR4Ny2Vg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECD89801E6C;
        Thu, 19 Mar 2020 13:27:02 +0000 (UTC)
Received: from localhost (ovpn-113-148.ams2.redhat.com [10.36.113.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A79A8385;
        Thu, 19 Mar 2020 13:26:59 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 0/2] spec: RPM spec file changes for liburing-0.5
Date:   Thu, 19 Mar 2020 13:26:56 +0000
Message-Id: <20200319132658.8552-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

VGhlc2UgcGF0Y2hlcyBmaXggaXNzdWVzIHdpdGggdGhlIGxpYnVyaW5nLTAuNSBSUE0gc3BlYyBm
aWxlLiAgSSBlbmNvdW50ZXJlZAp0aGVtIHdoZW4gcGFja2FnaW5nIGl0IGZvciBGZWRvcmEuCgpT
dGVmYW4gSGFqbm9jemkgKDIpOgogIHNwZWM6IHVzZSAib3IiIGluc3RlYWQgb2YgIi8iIGluIExp
Y2Vuc2UgbGluZQogIHNwZWM6IGFkZCAuL2NvbmZpZ3VyZSAtLWxpYmRldmRpcj0gZm9yIGRldmVs
b3BtZW50IHBhY2thZ2UgZmlsZXMKCiBsaWJ1cmluZy5zcGVjIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKLS0gCjIuMjQuMQoK

