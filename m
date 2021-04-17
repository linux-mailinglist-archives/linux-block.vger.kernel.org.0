Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06874362C2E
	for <lists+linux-block@lfdr.de>; Sat, 17 Apr 2021 02:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhDQACg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 16 Apr 2021 20:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229719AbhDQACg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 20:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618617730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E28myxiZn1blaS13N56nvXLMFnB30qTzlnI725pXZWY=;
        b=IvgZdxjzKtAvPNMxTY7Vve+UrPFzh+/g0nRbfTvfHe5RLw+JSNrRoFyG9fOfGiZL6xJYXu
        mkbDjEdwrrBrjJlP091FM8QcDYzXeVmGQr1d4doC1s7lxUx1ZP9vSBXtqfNYeoAr7mfEwq
        G+aYRMAY+/hHicYdsq9RwV7sfwObpwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-AUTfOdcqOSWRan_r0QW4Ww-1; Fri, 16 Apr 2021 20:02:08 -0400
X-MC-Unique: AUTfOdcqOSWRan_r0QW4Ww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D5A10054F6;
        Sat, 17 Apr 2021 00:02:07 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D4C5D6D3;
        Sat, 17 Apr 2021 00:02:03 +0000 (UTC)
Date:   Fri, 16 Apr 2021 20:02:03 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210417000203.GA22241@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16 2021 at  7:53pm -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> Hi,
> 
> This patchset reflects changes needed to make NVMe error handling and
> ANA state updates work well with dm-multipath (which always sets
> REQ_FAILFAST_TRANSPORT).
> 
> RHEL8 has been carrying an older ~5.9 based version of this patchset
> (since RHEL8.3, August 2020).
> 
> RHEL9 is coming, would really prefer that these changes land upstream
> rather than carry them within RHEL.
> 
> All review/feedback welcome.
> 
> Thanks,
> Mike
> 
> v3 -> v4, less is more:
> - folded REQ_FAILFAST_TRANSPORT local retry and FAILUP patches
> - simplified nvme_failup_req(), removes needless blk_path_error() et al
> - removed comment block in nvme_decide_disposition()
> 
> v2 -> v3:
> - Added Reviewed-by tags to BLK_STS_DO_NOT_RETRY patch.
> - Eliminated __nvme_end_req() and added code comment to
>   nvme_failup_req() in FAILUP handling patch.
> 
> Mike Snitzer (3):
>   nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
>   nvme: allow local retry and proper failover for REQ_FAILFAST_TRANSPORT
>   nvme: decouple basic ANA log page re-read support from native
>     multipathing
> 
>  drivers/nvme/host/core.c      | 22 +++++++++++++++++++---
>  drivers/nvme/host/multipath.c | 16 +++++++++++-----
>  drivers/nvme/host/nvme.h      |  4 ++++
>  include/linux/blk_types.h     |  8 ++++++++
>  4 files changed, 42 insertions(+), 8 deletions(-)

Sorry for all the noise, but I had a cut-and-paste issue with this cover
letter; should've said "[PATCH v4 0/4] ..."

While I'm replying, I _think_ there is consensus that patch 1 is
worthwile and acceptable. Here is a combined diff of patches 2+3 to
illustrate just how minimalist these proposed changes are:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..83ca96292157 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -299,6 +299,7 @@ enum nvme_disposition {
 	COMPLETE,
 	RETRY,
 	FAILOVER,
+	FAILUP,
 };
 
 static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
@@ -306,15 +307,16 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
-	if (req->cmd_flags & REQ_NVME_MPATH) {
+	if (req->cmd_flags & (REQ_NVME_MPATH | REQ_FAILFAST_TRANSPORT)) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
-			return FAILOVER;
+			return (req->cmd_flags & REQ_NVME_MPATH) ?
+				FAILOVER : FAILUP;
 	} else {
 		if (blk_queue_dying(req->q))
 			return COMPLETE;
@@ -336,6 +338,14 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static inline void nvme_failup_req(struct request *req)
+{
+	nvme_update_ana(req);
+
+	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_end_req(req);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	trace_nvme_complete_rq(req);
@@ -354,6 +364,9 @@ void nvme_complete_rq(struct request *req)
 	case FAILOVER:
 		nvme_failover_req(req);
 		return;
+	case FAILUP:
+		nvme_failup_req(req);
+		return;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a1d476e1ac02..7d94250264aa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,23 +65,29 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+void nvme_update_ana(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
-	unsigned long flags;
-
-	nvme_mpath_clear_current_path(ns);
 
 	/*
 	 * If we got back an ANA error, we know the controller is alive but not
-	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * ready to serve this namespace.  Kick off a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
 	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
+}
+
+void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	unsigned long flags;
+
+	nvme_mpath_clear_current_path(ns);
+	nvme_update_ana(req);
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 07b34175c6ce..4eed8536625c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -664,6 +664,7 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
+void nvme_update_ana(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -714,6 +715,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_update_ana(struct request *req)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }

