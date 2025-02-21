Return-Path: <linux-block+bounces-17460-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527CAA3F1F9
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 11:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845991898327
	for <lists+linux-block@lfdr.de>; Fri, 21 Feb 2025 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0860204F90;
	Fri, 21 Feb 2025 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b="JMb1cjPz"
X-Original-To: linux-block@vger.kernel.org
Received: from mail98.out.titan.email (mail98.out.titan.email [54.147.227.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB7C1EE7BC
	for <linux-block@vger.kernel.org>; Fri, 21 Feb 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.147.227.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133706; cv=none; b=tPXVjA4AAzQrCkfp23ziUBPoVPtLC4eQnXptj9JDyBTI03oo1OSi/zukNwawiQRc37uMhEq3Yyg161IggvUnwDge4Q7yFZPHwpigsIoj8mdq+sSHq4ig6mjyyM/NW76pffK7kAEyZ27oWvIs0buAX8aRN07YscFNI5yBamlvho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133706; c=relaxed/simple;
	bh=88uwBBXufAtaQcvEse9Nf2OflZeEY/+ZdeDq35vNfXY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=REDORzLL8RII/PBU/gWU5O/PYBWEJTa64nIa9puLfHRW8h16GbrtcfKCdlF6LbDZQzX8C4YEUirNQpblC8SoIEJJ5Hh4RAcSZRttMvbJ/430UC0FxkkMNgFed6Ym12UuvbLMzNPoyW0KKlxf5fWcZZ2RJ8TCys1EMy4Qfk6W3xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li; spf=pass smtp.mailfrom=coly.li; dkim=pass (1024-bit key) header.d=t12smtp-sign004.email header.i=@t12smtp-sign004.email header.b=JMb1cjPz; arc=none smtp.client-ip=54.147.227.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coly.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coly.li
Received: from smtp-out.flockmail.com (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4DBD8140382;
	Fri, 21 Feb 2025 10:12:36 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=PpkrBXoFOyORs1lMVcREow+qzezp156LadshzoN79Os=;
	c=relaxed/relaxed; d=t12smtp-sign004.email;
	h=date:cc:to:mime-version:message-id:references:subject:from:in-reply-to:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1740132756; v=1;
	b=JMb1cjPzguFGas2VepbOgIqvTQb6AukhOW1x2FKY/ErkpqLfFf3YcUg3gPnYzU83A91CBZ83
	DogDD8VpSbPtHk2cyJuyrvTwWVGuAOQV6K1t1z2Rl3rXay3upVE54BEPzNJXLGKAGk97yB1s00Z
	FAyAGJJLhthaDwMYg+Qc675I=
Received: from smtpclient.apple (unknown [141.11.218.23])
	by smtp-out.flockmail.com (Postfix) with ESMTPA id 16EEE1403BA;
	Fri, 21 Feb 2025 10:12:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH 05/12] badblocks: return error if any badblock set fails
Feedback-ID: :i@coly.li:coly.li:flockmailId
From: Coly Li <i@coly.li>
In-Reply-To: <272e37ea-886c-8a44-fd6b-96940a268906@huaweicloud.com>
Date: Fri, 21 Feb 2025 18:12:14 +0800
Cc: Zheng Qixing <zhengqixing@huaweicloud.com>,
 axboe@kernel.dk,
 song@kernel.org,
 colyli@kernel.org,
 dan.j.williams@intel.com,
 vishal.l.verma@intel.com,
 dave.jiang@intel.com,
 ira.weiny@intel.com,
 dlemoal@kernel.org,
 yanjun.zhu@linux.dev,
 kch@nvidia.com,
 Hannes Reinecke <hare@suse.de>,
 zhengqixing@huawei.com,
 john.g.garry@oracle.com,
 geliang@kernel.org,
 xni@redhat.com,
 colyli@suse.de,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org,
 nvdimm@lists.linux.dev,
 yi.zhang@huawei.com,
 yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70D2392E-4F75-43C6-8C34-498AACC78E0C@coly.li>
References: <20250221081109.734170-1-zhengqixing@huaweicloud.com>
 <20250221081109.734170-6-zhengqixing@huaweicloud.com>
 <4qo5qliidycbjmauq22tqgv6nbw2dus2xlhg2qvfss7nawdr27@arztxmrwdhzb>
 <272e37ea-886c-8a44-fd6b-96940a268906@huaweicloud.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1740132756194826561.32605.1336086399975024175@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=bq22BFai c=1 sm=1 tr=0 ts=67b85194
	a=USBFZE4A2Ag4MGBBroF6Xg==:117 a=USBFZE4A2Ag4MGBBroF6Xg==:17
	a=IkcTkHD0fZMA:10 a=CEWIc4RMnpUA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8
	a=6wd6frUFB1wQldR6h7YA:9 a=QEXdDO2ut3YA:10
X-Virus-Scanned: ClamAV using ClamSMTP



> 2025=E5=B9=B42=E6=9C=8821=E6=97=A5 18:09=EF=BC=8CYu Kuai =
<yukuai1@huaweicloud.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hi,
>=20
> =E5=9C=A8 2025/02/21 17:52, Coly Li =E5=86=99=E9=81=93:
>> On Fri, Feb 21, 2025 at 04:11:02PM +0800, Zheng Qixing wrote:
>>> From: Li Nan <linan122@huawei.com>
>>>=20
>>> _badblocks_set() returns success if at least one badblock is set
>>> successfully, even if others fail. This can lead to data =
inconsistencies
>>> in raid, where a failed badblock set should trigger the disk to be =
kicked
>>> out to prevent future reads from failed write areas.
>>>=20
>>> _badblocks_set() should return error if any badblock set fails. =
Instead
>>> of relying on 'rv', directly returning 'sectors' for clearer logic. =
If all
>>> badblocks are successfully set, 'sectors' will be 0, otherwise it
>>> indicates the number of badblocks that have not been set yet, thus
>>> signaling failure.
>>>=20
>>> By the way, it can also fix an issue: when a newly set unack =
badblock is
>>> included in an existing ack badblock, the setting will return an =
error.
>>> =C2=B7=C2=B7=C2=B7
>>>   echo "0 100" /sys/block/md0/md/dev-loop1/bad_blocks
>>>   echo "0 100" /sys/block/md0/md/dev-loop1/unacknowledged_bad_blocks
>>>   -bash: echo: write error: No space left on device
>>> ```
>>> After fix, it will return success.
>>>=20
>>> Fixes: aa511ff8218b ("badblocks: switch to the improved badblock =
handling code")
>>> Signed-off-by: Li Nan <linan122@huawei.com>
>>> ---
>>>  block/badblocks.c | 16 ++++------------
>>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>>=20
>> NACK.   Such modification will break current API.
>=20
> Take a look at current APIs:
> - for raid, error should be returned, otherwise data may be corrupted.
> - for nvdimm, there is only error message if fail, and it make sense =
as
> well if any badblocks set failed:
>        if (badblocks_set(bb, s, num, 1))
>                dev_info_once(bb->dev, "%s: failed for sector %llx\n",
>                                __func__, (u64) s);
> - for null_blk, I think it's fine as well.
>=20
> Hence I think it's fine to return error if any badblocks set failed.
> There is no need to invent a new API and switch all callers to a new
> API.

So we don=E2=80=99t need to add a negative return value for partial =
success/failure?

Coly Li=

