Return-Path: <linux-block+bounces-18673-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C5A67FDA
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 23:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958CA422BEB
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88EB207640;
	Tue, 18 Mar 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aeb3o4Hv"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148822063C7
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742337400; cv=none; b=XO2LJ0eGf9WWmueMN0d0PAHFE5IxKFLhdKs3hLuFoHdIhROLe5RkjJBq75yeLxFw1KLBmNvW8ejZFGX6kJbbGWQDZ0i0YDB7rnOZt2fRb8q87+0XJKZfEr/I0vN8lXf4F7IAhqP/QZ0WnMiLw8mhkmOX1JchdXUEAtAOtQ19wq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742337400; c=relaxed/simple;
	bh=RcrbS/0cvKeFq0VHnvdKx9U5gcBVqcap9xaA76NX5UY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=nfNgK6NfQAnkhTtHpzvMXypxFqI9oNxbH2rX/6fXkkdnpx/kU56ifn7AW4JVRuI4xjOjZKBhKAnbu3xSzSPh59/EXM300XEGjDt5V1W4x0ZrSHWMHtpNmI4PXrrg2nS+1boNDr7UCGDUbJSLVGUF8/ktuPWMuvfcM5tWEf57+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aeb3o4Hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742337397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sUfdBswyWQVZKBqjTUSF+HgpIQhYgENsHS6lzHk2ocg=;
	b=Aeb3o4HvOETJXfU2XWQ+IXbL6ZZM4F4l+l8wI9lelJWDgHDsnZn+eE1Vqe1KjJfBuc43U8
	am9geuSCys6B/xATs/2DkgDdR2IDgdUTdI8K4fRIGJ7ynDsHEQhxbVfJX9fZJ4RIvZYdRl
	9WQEifie9rYB4hYTZwA6qkasyb1WF3s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-a3XHYFoDMz2M5KIy0620og-1; Tue,
 18 Mar 2025 18:36:36 -0400
X-MC-Unique: a3XHYFoDMz2M5KIy0620og-1
X-Mimecast-MFC-AGG-ID: a3XHYFoDMz2M5KIy0620og_1742337394
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521901956048;
	Tue, 18 Mar 2025 22:36:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42F6019560AD;
	Tue, 18 Mar 2025 22:36:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <229984a0b00679cc2f1bbfb42df4174c6c896fd2.camel@ibm.com>
References: <229984a0b00679cc2f1bbfb42df4174c6c896fd2.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-22-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 21/35] libceph: Make notify code use ceph_databuf_enc_start/stop
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2681245.1742337390.1@warthog.procyon.org.uk>
Date: Tue, 18 Mar 2025 22:36:30 +0000
Message-ID: <2681246.1742337390@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > @@ -4852,20 +4854,19 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
> >  	if (!lreq)
> >  		return -ENOMEM;
> >  
> > -	lreq->request_pl = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
> > +	lreq->request_pl = ceph_databuf_req_alloc(0, 3 * 4 + payload_len,
> 
> The same question... :)
> 
> Thanks,
> Slava.
> 
> > +						  GFP_NOIO);
> >  	if (!lreq->request_pl) {
> >  		ret = -ENOMEM;
> >  		goto out_put_lreq;
> >  	}
> >  
> > -	ret = ceph_databuf_encode_32(lreq->request_pl, 1); /* prot_ver */
> > -	ret |= ceph_databuf_encode_32(lreq->request_pl, timeout);
> > -	ret |= ceph_databuf_encode_32(lreq->request_pl, payload_len);
> > -	ret |= ceph_databuf_append(lreq->request_pl, payload, payload_len);
> > -	if (ret) {
> > -		ret = -ENOMEM;
> > -		goto out_put_lreq;
> > -	}
> > +	p = ceph_databuf_enc_start(lreq->request_pl);
> > +	ceph_encode_32(&p, 1); /* prot_ver */
> > +	ceph_encode_32(&p, timeout);
> > +	ceph_encode_32(&p, payload_len);
> > +	ceph_encode_copy(&p, payload, payload_len);
> > +	ceph_databuf_enc_stop(lreq->request_pl, p);

I think the answer is obvious from that.  You have 3 protocol LE32 words plus
the payload.  Previously, ceph just allocated a whole page, whether or not we
needed anywhere near that much, and then would dynamically add pages as it
went along if one was insufficient.  By allocating up front, we get to make
use of the bulk allocator.

However, if we don't need all that much space, it affords us the opportunity
to make use of a page fragment allocator.

David


