Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDCE2875D7
	for <lists+linux-block@lfdr.de>; Thu,  8 Oct 2020 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbgJHOQt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 10:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730175AbgJHOQt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Oct 2020 10:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602166608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CpBZGaSJhi9YAV7HwVtzUAATqoh08ih7UK/jN0v3vrE=;
        b=LsVz21zp+Blvk8sKj++2TLZMrUdefGzzH5suQ2zuh+OWrrJm7VcrLvxQZFknnqjrreCA5t
        Z1lkleeAlewfwpovL3f9y0BGpO/PTamukRGqi8wH7Z5i8scBy5lUhFTr7O+PCujwbduDyH
        0mIC/e4f7/XTvQw+gxqBvPb1zuSj/kA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-mfvbnEqFOm2o_UrWwfK2_Q-1; Thu, 08 Oct 2020 10:16:44 -0400
X-MC-Unique: mfvbnEqFOm2o_UrWwfK2_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8743B18CBC47;
        Thu,  8 Oct 2020 14:16:41 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF8025D9E8;
        Thu,  8 Oct 2020 14:16:39 +0000 (UTC)
Date:   Thu, 8 Oct 2020 16:16:37 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 05/10] s390/dasd: Move duplicate code to separate
 function
Message-ID: <20201008161637.2dbb321c.cohuck@redhat.com>
In-Reply-To: <20201008131336.61100-6-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
        <20201008131336.61100-6-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu,  8 Oct 2020 15:13:31 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> From: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
>=20
> For storing retrieved path information both the if and else block in
> dasd_eckd_read_conf() use the same code. To avoid duplicate code this
> should be done after the if/else block. To further increase readability,
> move the code to a new function, dasd_eckd_store_conf_data().
>=20
> Signed-off-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_eckd.c | 42 ++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

