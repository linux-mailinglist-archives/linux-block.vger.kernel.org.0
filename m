Return-Path: <linux-block+bounces-18670-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B60DA67FA2
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 23:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26403B1F61
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAA205E0F;
	Tue, 18 Mar 2025 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9YfVkUN"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161011DED53
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336412; cv=none; b=lT4Xr0+CbvKGra+TP2Ld0dP0m/zwny10E8VyWjuCDr62YN1UKZcFCJf4xw2jfvqWDrqbGbQnEdLnogZZL1mnuUJyXKGKYn/ruJodsT7OX89gki2f2SVgFgDJaGUvunk0rF5eFQPkHfV9LQAZ3r9v3aTkctBKS0JVzrYRUw8GaTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336412; c=relaxed/simple;
	bh=TWZj3Mw45zn2VXIzP8sraaaNZNB/cEnHlpSeD98i794=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=f8s/syGtHYb3INsd8YvPz3DAeoFLpmpKe+WQNw3Zvbi6LHEl9qP2lriFfSCIl26aYJSpf6EFkhjMH5jlC4cTKvqmg1aw7xRnofHQlOZ3LK1ACS/uo3aNhTFO8KTDsrFFkB5S9Nl7C9vp+50BpGnVHuhz6z6zKGZtu400oDLHCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9YfVkUN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Kx21nX/gkF5GaxkUaNtj1HuTVMmotSCsY3DKAEdq4c=;
	b=A9YfVkUNUhM4UlqzGZg/MJlNlzmkJci2OR8TZ8k6Fz1lX4o3EzTtBwfBocRHxSbpt3uCdd
	0mgZK3KVTBpPFuud+g8MIRHx0jBmb/LVEtjYjHUmH9nb/59GKT+mgPYjURnNnr9HIbf8OU
	t5iq+yrgkO6ZJtfg+jJn8IGg2qr3Qts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-241-6NoW2OxZOciLwfCO03q0AQ-1; Tue,
 18 Mar 2025 18:20:04 -0400
X-MC-Unique: 6NoW2OxZOciLwfCO03q0AQ-1
X-Mimecast-MFC-AGG-ID: 6NoW2OxZOciLwfCO03q0AQ_1742336401
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED151801A00;
	Tue, 18 Mar 2025 22:20:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5E1F18001F6;
	Tue, 18 Mar 2025 22:19:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <794de36bce4867d8cd39dd0ed2bfc70b96ec07ce.camel@ibm.com>
References: <794de36bce4867d8cd39dd0ed2bfc70b96ec07ce.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-18-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 17/35] libceph, rbd: Use ceph_databuf encoding start/stop
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2680645.1742336396.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Mar 2025 22:19:56 +0000
Message-ID: <2680646.1742336396@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > -		ceph_encode_string(&p, end, buf, len);
> > +		BUG_ON(p + sizeof(__le32) + len > end);
> =

> Frankly speaking, it's hard to follow why sizeof(__le32) should be in th=
e
> equation. Maybe, it make sense to introduce some constant? The name of
> constant makes understanding of this calculation more clear.

Look through the patch.  It's done all over the place, even on parts I hav=
en't
touched.  However, it's probably because of the way the string is encoded
(4-byte LE length followed by the characters).

It probably would make sense to use a calculation wrapper for this.  I hav=
e
this in fs/afs/yfsclient.c for example:

	static size_t xdr_strlen(unsigned int len)
	{
		return sizeof(__be32) + round_up(len, sizeof(__be32));
	}

> > +	BUG_ON(sizeof(__le64) + sizeof(__le32) + wsize > req->request->front=
_alloc_len);
> =

> The same problem is here. It's hard to follow to this check by involving
> sizeof(__le64) and sizeof(__le32) in calculation. What these numbers mea=
n here?

Presumably the sizes of the protocol elements in the marshalled data.  If =
you
want to clean all those up in some way, I can add your patch into my
series;-).

David


