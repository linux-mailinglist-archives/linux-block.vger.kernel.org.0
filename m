Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99A6FFC8D
	for <lists+linux-block@lfdr.de>; Mon, 18 Nov 2019 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfKRArl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 17 Nov 2019 19:47:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726284AbfKRArl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:47:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574038060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iaw42PQTKqUOzHZeY+DSOljnBLfhLiKUW8VmWPD15bI=;
        b=QKXom8C4lwTT9zOAcH5TmtNm/AfvT/qTuUOvTbnN7qfORbvOVVbdrr4X7Z0Gr47+h4y95m
        pjBXaBbWZ/GGVTGN3KWNKDE9B+/QPRPNBulPHizgodDn5utVhYxsvwYL2mqy81LM9blfSv
        KZJN3k2bVw5g3lkBfzINjZVcW7hnWXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Emd0mRQSOr2w4K49wH7L-Q-1; Sun, 17 Nov 2019 19:47:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90C5E801FCF;
        Mon, 18 Nov 2019 00:47:34 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E2018784;
        Mon, 18 Nov 2019 00:47:26 +0000 (UTC)
Date:   Mon, 18 Nov 2019 08:47:21 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Long Li <longli@microsoft.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] scsi: core: only re-run queue in scsi_end_request() if
 device queue is busy
Message-ID: <20191118004721.GB30795@ming.t460p>
References: <20191117080818.2664-1-ming.lei@redhat.com>
 <BYAPR04MB5816F43072584F8F20EF4292E74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5816F43072584F8F20EF4292E74D0@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Emd0mRQSOr2w4K49wH7L-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Damine,

On Mon, Nov 18, 2019 at 12:18:48AM +0000, Damien Le Moal wrote:
> On 2019/11/17 17:08, Ming Lei wrote:
> > Now the requeue queue is run in scsi_end_request() unconditionally if b=
oth
> > target queue and host queue is ready. We should have re-run request que=
ue
> > only after this device queue becomes busy for restarting this LUN only.
> >=20
> > Recently Long Li reported that cost of run queue may be very heavy in
> > case of high queue depth. So improve this situation by only running
> > requesut queue when this LUN is busy.
>=20
> s/requesut/request
>=20
> Also, shouldn't this patch have the tag:
>=20
> Reported-by: Long Li <longli@microsoft.com>
>=20
> ?

Will do that in V2.

>=20
> Another remark is that Long's approach is generic to the block layer
> while your patch here is scsi specific. I wonder if the same problem
> cannot happen with other drivers too ?

Not sure what you meant about the same problem.

It is definitely bad to unconditionally call blk_mq_run_hw_queues()
in driver's IO completion handler from performance viewpoint.

This patch simply addresses this SCSI specific issue, since blk_mq_run_hw_q=
ueues()
shouldn't be called from scsi_end_request() when the device queue isn't bus=
y.

If other driver has such kind of issue, I believe it should have been fixed=
 in
driver too.

So my patch isn't contradictory with Long's patch which improves generic bl=
k-mq's
run queue.

Thanks,
Ming

