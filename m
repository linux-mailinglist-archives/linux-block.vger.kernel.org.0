Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04F1EE07A5
	for <lists+linux-block@lfdr.de>; Tue, 22 Oct 2019 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfJVPmf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Oct 2019 11:42:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730141AbfJVPmf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 11:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571758953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHUjeSW+OQPq+sc+A88fJ+/QQEBkysWzrSaHp9k75do=;
        b=OyejphQpYSsgzUWubEwFX7pAC6OWtaKD3dHlB+raYZdE7NmFwoupOBSF7dGO3XPChnAG2p
        QwSj5LMzFGX0RNnduOmekp6tRq4aXQ9j1sJKjrsEt1+01+BlYwA1zd6zhcpbN4WBhOF+Ec
        nEqpOsX6tysXEayKhtp+ZTdoy0kblIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-duVXvBAvNBGY_2YeQmWhzA-1; Tue, 22 Oct 2019 11:42:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6C001800DD0;
        Tue, 22 Oct 2019 15:42:28 +0000 (UTC)
Received: from [10.10.123.180] (ovpn-123-180.rdu2.redhat.com [10.10.123.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E64B560C5E;
        Tue, 22 Oct 2019 15:42:27 +0000 (UTC)
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
To:     Dave Chinner <david@fromorbit.com>
References: <20191021214137.8172-1-mchristi@redhat.com>
 <20191021225234.GC2642@dread.disaster.area>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DAF2363.2070204@redhat.com>
Date:   Tue, 22 Oct 2019 10:42:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191021225234.GC2642@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: duVXvBAvNBGY_2YeQmWhzA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/2019 05:52 PM, Dave Chinner wrote:
> On Mon, Oct 21, 2019 at 04:41:37PM -0500, Mike Christie wrote:
>> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
>> amd nbd that have userspace components that can run in the IO path. For
>> example, iscsi and nbd's userspace deamons may need to recreate a socket
>> and/or send IO on it, and dm-multipath's daemon multipathd may need to
>> send IO to figure out the state of paths and re-set them up.
>>
>> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
>> memalloc_*_save/restore functions to control the allocation behavior,
>> but for userspace we would end up hitting a allocation that ended up
>> writing data back to the same device we are trying to allocate for.
>=20
> I think this needs to describe the symptoms this results in. i.e.
> that this can result in deadlocking the IO path.
>=20
>> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
>> with prctl during their initialization so later allocations cannot
>> calling back into them.
>>
>> Signed-off-by: Mike Christie <mchristi@redhat.com>
>> ---
>=20
> ....
>> +=09case PR_SET_MEMALLOC:
>> +=09=09if (!capable(CAP_SYS_ADMIN))
>> +=09=09=09return -EPERM;
>=20
> Wouldn't CAP_SYS_RAWIO (because it's required by kernel IO path
> drivers) or CAP_SYS_RESOURCE (controlling memory allocation
> behaviour) be more appropriate here?

I think I misread a review comment last posting. I will use
CAP_SYS_RESROUCE on the next resend if people do not have any objections.

>=20
> Which-ever is selected, the use should be added to the list above
> the definition of the capability in include/linux/capability.h...
>=20

Will do. Thanks.

> Otherwise looks fine to me.
>=20
> Cheers,
>=20
> Dave.
>=20

