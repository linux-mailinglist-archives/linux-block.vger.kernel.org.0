Return-Path: <linux-block+bounces-12394-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F8996E32
	for <lists+linux-block@lfdr.de>; Wed,  9 Oct 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882481F2219B
	for <lists+linux-block@lfdr.de>; Wed,  9 Oct 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D52126C16;
	Wed,  9 Oct 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YO/rgT1l"
X-Original-To: linux-block@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C343BBEB
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484607; cv=none; b=JovtFg/28St9Kl8k9pSRoIaDkC58qP+r77ZCqfz5UCpQ4dY9NJf3vKyBznF1Ad+jim+2709zJzH/vU9xRRJrqrGGIBKhMR0oTN/kjqHB6B/eJI2a82y0b8ECMC2E+EouL/Xx+ErR03fMDYe002QYFEY77E/LJxZZ9EQ6fn+/YQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484607; c=relaxed/simple;
	bh=vZep25XTzjzAljVJDQ8Z7h02N5y8r6vNHk/KieFt0uo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=DPqAhKnjijjYTBpDAJ55iwNO9fiAd2nn2HfoU5/V8ogjkcHlHD7u2XKGaEmELwZqvnKZoC3AsAPt+83DM1CcboBaGVwcdoGeCCUfweckbXAMbwuCKBjF3EqdQIFU5ZyBftVH/vTsjzPGPBc2CVj8cnv/KaxbrsBMHF1wOTZayqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YO/rgT1l; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241009143642euoutp01bcccba01a4588afafd6633fe91440d15~8z5aoFnVl1771217712euoutp01z
	for <linux-block@vger.kernel.org>; Wed,  9 Oct 2024 14:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241009143642euoutp01bcccba01a4588afafd6633fe91440d15~8z5aoFnVl1771217712euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728484603;
	bh=vZep25XTzjzAljVJDQ8Z7h02N5y8r6vNHk/KieFt0uo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=YO/rgT1lnKYpvj18FF4jhIPAHk5iBWf1LJ3mIhX4qqDuljlZNO/pnoOjdjFr5jUQL
	 bQ6WDhObhvuzGcbJoVyA8NBDcNwbelzCZl2CH37h61rV40S1WS5vB8b8TDW/CNPOs2
	 gx97KlG4oJAbiqoCdCrYR224GW+14ZC2NAEtJUxE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009143642eucas1p23c2e3321a84594fd0d846e6ddf6b21e2~8z5aJ5_6Y1124711247eucas1p2L;
	Wed,  9 Oct 2024 14:36:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.A7.09624.AF496076; Wed,  9
	Oct 2024 15:36:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241009143641eucas1p1f6075d856440adc27e2cf269e59aba6c~8z5ZsuywJ0502905029eucas1p1f;
	Wed,  9 Oct 2024 14:36:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241009143641eusmtrp25dd85d18e98285f15beb3113e525096c~8z5Zr9uby0932109321eusmtrp2y;
	Wed,  9 Oct 2024 14:36:41 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-7f-670694fa0297
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 89.F0.14621.9F496076; Wed,  9
	Oct 2024 15:36:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241009143641eusmtip2522c521d811a4b742137709796ae07f7~8z5Zf5L8n2044120441eusmtip2k;
	Wed,  9 Oct 2024 14:36:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (106.1.227.72) by
	CAMSVWEXC02.scsc.local (106.1.227.72) with Microsoft SMTP Server (TLS) id
	15.0.1497.2; Wed, 9 Oct 2024 15:36:41 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
	([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Wed, 9 Oct
	2024 15:36:41 +0100
From: Javier Gonzalez <javier.gonz@samsung.com>
To: Hans Holmberg <hans@owltronix.com>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>, "hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "brauner@kernel.org"
	<brauner@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jack@suse.cz" <jack@suse.cz>, "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
	"bcrl@kvack.org" <bcrl@kvack.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-aio@kvack.org" <linux-aio@kvack.org>, "gost.dev@samsung.com"
	<gost.dev@samsung.com>, "vishak.g@samsung.com" <vishak.g@samsung.com>
Subject: RE: [PATCH v7 0/3] FDP and per-io hints
Thread-Topic: [PATCH v7 0/3] FDP and per-io hints
Thread-Index: AQHbGWnMFahlOOmkRUWBz3B/P2gFpLJ+eLOA
Date: Wed, 9 Oct 2024 14:36:40 +0000
Message-ID: <97bd78a896b748b18e21e14511e8e0f4@CAMSVWEXC02.scsc.local>
In-Reply-To: <CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZduzned1fU9jSDZreClvMWbWN0WL13X42
	i65/W1gsXh/+xGgx7cNPZot3Tb9ZLOZOXc1qsWfRJCaLlauPMlm8az3HYjF7ejOTxZP1s5gt
	Jh26xmgxZVoTo8XeW9oWe/aeZLGYv+wpu8Xy4/+YLNa9fs9icf7vcVYHEY/LV7w9ds66y+5x
	/t5GFo/LZ0s9Nq3qZPPY9GkSu8fmJfUeu282sHl8fHqLxePwpkWsHu/3XWXzOLPgCFDydLXH
	501yHpuevGUK4I/isklJzcksSy3St0vgyljf852p4FJoxb9VGQ2MO4K7GDk4JARMJO42hHQx
	cnEICaxglDhyqpsdwvnCKHFuyj6WLkZOIOczo8Tfn0ogNkhD+8EPTBBFyxklZu9+B9UBVDR1
	4h8WCGcjo0Tb6gescINblq9kB+lnE9CXWLX9FCOILSKgJnH2RQfYLGaBb+wS7Qs6wBLCAgYS
	zUv2QRUZSrxbtpAR5FoRASOJrdtSQcIsAioS74/sBpvJK+Aq0bW0E6ycUyBQovvRLzYQm1FA
	VuLRyl9gNcwC4hK3nsxngvhBUGLR7D3MELaYxL9dD9kgbAOJrUshfpYQUJTom/+eBWQts4Cm
	xPpd+hBjFCWmdD+EWisocXLmE7CHJQQecEkc/3WNHaLXReJV83qoOcISr45vgYrLSPzfCXND
	tUTDyRNMExi1ZiE5bxbCullI1s1Csm4BI8sqRvHU0uLc9NRiw7zUcr3ixNzi0rx0veT83E2M
	wAR7+t/xTzsY5776qHeIkYmD8RCjBAezkgiv7kLWdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	qinyqUIC6YklqdmpqQWpRTBZJg5OqQYm/xS/NRbPIl+mPUzqePXx9rqUPPf+g8dMYw7635Hq
	UpM3VDW54TNbZIFORWb0+qn/F529m9F0TGXnjwnPm8sLXy97FfFOxsbrclTMHPHa1AX1pwL3
	mYqrvTLKW7Pya46Vz6Qplv98lymdbVPv2zy/7UBGz6mjrpwXjkzMq2pp3bLxq86fZ1rMTOfn
	5ShxVPWWGjftEmA1dV3WlfzubbrLy9zcd+vv/1NN3OExY8+qjo8VWyUrJ/p8W3WoK9LuzenU
	KR37XQ+Vp4ho14V8Fzhr4yD/eqN7X/LEJIm64uMbS+en+U15VWO31TzluJFXHtOnewdZNgTa
	W3NvsOreKrigLTxCJ2qencEK2xuKlblKLMUZiYZazEXFiQDctmTZHwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01SYUxbVRjdfe/1tQUansCyS7PNrTGoM2tpoXi74NRE8WUagzG6qEFs2KOg
	QGtfu0zBiJsKFNxYx9DVaRmDjpVsleIYo6wgoN3oCguMOYgwBiVjWwqUGZeyWS08jPw73z3f
	Oef7bj4BHhfmiQX5RQZGX6QukJBRhDfsmdgeqiE1ybfdaei4vQ2g5vFDJDKFfybQvd5FgGoX
	Qjia2/+QQD8cbeahznozhk43/4qhua8GCPT9twcw5HdYcGTuuQ5QTe1+gC6OPYM6L14mkNU2
	w0enPGEMnb03T6DBvz28FxLo4Wuv0hcs43x6cKKFoId9RtppryBp56KZT7c2fE67RktJOjgz
	RtC9znoePe8eIekrdX0R0ltM33dupp3+AJYZ+640Xa81GpgteVrW8JzkPTlSSOUqJFWkqqTy
	lGezdiiUEtnO9D1MQf5eRi/b+YE0z1H1ANMNvbUvbM8rBe1vmoBQAKlUWPbLAmYCUYI4qhHA
	pcpKwBEbYcufIzwOx8NH100k1xQEsOsnN48rWgAM3OjHuaIJwOE/bvCXJSQlg/bz/StWCVQS
	9M2Wr2Tg1F98WFZXvkLEU8nwQIN7tUkO52wnIlgQwQp4ro1ZfiaoJ+B8n2vFU0S9DE2NFYAL
	6yPg2Qe9xDIhpN6AlVNL5DIG1CY4dXppRYBTG+CY34pxO1CwoXMQ5/B6eGc6vLpbMjzX6CY4
	vBUetM4TyzPg1NPQ0SHjbLbCmspbqzM8Bi8f8xPVQGxZk2D5X2FZo7CsUdQBwg4SGCNbqClk
	5VJWXcgaizTSHG2hE0QOse23UGs7+PFuUNoDMAHoAVCASxJE20/wNHGiPepPPmX02my9sYBh
	e4Ay8i2HcfH6HG3kkosM2fK0ZKU8NU2VrFSlpUg2iDKGB3PjKI3awHzEMDpG/58OEwjFpZhB
	sEN2hh25NvHSrOmbp7oGvVczN71zBBsfi9ZNe+MTD/Mr7k94Yj4sSfLGDDxUrbuSX13v6j35
	mm/Sd+rSx43j7y8OBDre9moyAy5PxeSXMs/RlF3mjPREV9fVZt/Y1wvRs7U+i4Z3siw2//gR
	3U2NLilYxFYd+yJUn5v4XclBm/D2utZb3cHoMFYiadlNG3Mu+KczXsGfbx8wP2nruAOSbhL+
	phcXUzZ3AHL6kXujNbvOfr7YWT9q3pLrNMd+lhXIG8qKaWrrropqHb1kEy1tM4pl/OrJ1/vD
	M90Oq0yuVpZkWxakts7YM1NOxz+Kx2dJ4e59xXf3hoaqyn8/VC0h2Dy1fBuuZ9X/Av/39c8R
	BAAA
X-CMS-MailID: 20241009143641eucas1p1f6075d856440adc27e2cf269e59aba6c
X-Msg-Generator: CA
X-RootMTR: 20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b
References: <20241002151949.GA20877@lst.de>
	<yq17caq5xvg.fsf@ca-mkp.ca.oracle.com> <20241003125400.GB17031@lst.de>
	<c68fef87-288a-42c7-9185-8ac173962838@kernel.dk>
	<CGME20241004053129eucas1p2aa4888a11a20a1a6287e7a32bbf3316b@eucas1p2.samsung.com>
	<20241004053121.GB14265@lst.de>
	<20241004061811.hxhzj4n2juqaws7d@ArmHalley.local>
	<20241004062733.GB14876@lst.de>
	<20241004065233.oc5gqcq3lyaxzjhz@ArmHalley.local>
	<20241004123027.GA19168@lst.de>
	<20241007101011.boufh3tipewgvuao@ArmHalley.local>
	<CANr-nt3TA75MSvTNWP3SwBh60dBwJYztHJL5LZvROa-j9Lov7g@mail.gmail.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGFucyBIb2xtYmVyZyA8
aGFuc0Bvd2x0cm9uaXguY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDgsIDIwMjQgMTI6
MDcgUE0NCj4gVG86IEphdmllciBHb256YWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+DQo+
IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT47IEplbnMgQXhib2UgPGF4Ym9lQGtl
cm5lbC5kaz47IE1hcnRpbiBLLg0KPiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5j
b20+OyBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+Ow0KPiBLYW5jaGFuIEpvc2hpIDxq
b3NoaS5rQHNhbXN1bmcuY29tPjsgaGFyZUBzdXNlLmRlOyBzYWdpQGdyaW1iZXJnLm1lOw0KPiBi
cmF1bmVyQGtlcm5lbC5vcmc7IHZpcm9AemVuaXYubGludXgub3JnLnVrOyBqYWNrQHN1c2UuY3o7
IGphZWdldWtAa2VybmVsLm9yZzsNCj4gYmNybEBrdmFjay5vcmc7IGRob3dlbGxzQHJlZGhhdC5j
b207IGJ2YW5hc3NjaGVAYWNtLm9yZzsNCj4gYXNtbC5zaWxlbmNlQGdtYWlsLmNvbTsgbGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5v
cmc7IGlvLXVyaW5nQHZnZXIua2VybmVsLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1haW9Aa3ZhY2sub3JnOyBnb3N0LmRldkBzYW1zdW5nLmNvbTsgdmlzaGFrLmdA
c2Ftc3VuZy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwLzNdIEZEUCBhbmQgcGVyLWlv
IGhpbnRzDQo+IA0KPiBPbiBNb24sIE9jdCA3LCAyMDI0IGF0IDEyOjEw4oCvUE0gSmF2aWVyIEdv
bnrDoWxleiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24g
MDQuMTAuMjAyNCAxNDozMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+ID4gPk9uIEZyaSwg
T2N0IDA0LCAyMDI0IGF0IDA4OjUyOjMzQU0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6
DQo+ID4gPj4gU28sIGNvbnNpZGVyaWduIHRoYXQgZmlsZSBzeXN0ZW0gX2FyZV8gYWJsZSB0byB1
c2UgdGVtcGVyYXR1cmUgaGludHMgYW5kDQo+ID4gPj4gYWN0dWFsbHkgbWFrZSB0aGVtIHdvcmss
IHdoeSBkb24ndCB3ZSBzdXBwb3J0IEZEUCB0aGUgc2FtZSB3YXkgd2UgYXJlDQo+ID4gPj4gc3Vw
cG9ydGluZyB6b25lcyBzbyB0aGF0IHBlb3BsZSBjYW4gdXNlIGl0IGluIHByb2R1Y3Rpb24/DQo+
ID4gPg0KPiA+ID5CZWNhdXNlIGFwcGFyZW50bHkgbm8gb25lIGhhcyB0cmllZCBpdC4gIEl0IHNo
b3VsZCBiZSBwb3NzaWJsZSBpbiB0aGVvcnksDQo+ID4gPmJ1dCBmb3IgZXhhbXBsZSB1bmxlc3Mg
eW91IGhhdmUgcG93ZXIgb2YgMiByZWNsYWltIHVuaXQgc2l6ZSBzaXplIGl0DQo+ID4gPndvbid0
IHdvcmsgdmVyeSB3ZWxsIHdpdGggWEZTIHdoZXJlIHRoZSBBR3MvUlRHcyBtdXN0IGJlIHBvd2Vy
IG9mIHR3bw0KPiA+ID5hbGlnbmVkIGluIHRoZSBMQkEgc3BhY2UsIGV4Y2VwdCBieSBvdmVycHJv
dmlzaW9uaW5nIHRoZSBMQkEgc3BhY2UgdnMNCj4gPiA+dGhlIGNhcGFjaXR5IGFjdHVhbGx5IHVz
ZWQuDQo+ID4NCj4gPiBUaGlzIGlzIGdvb2QuIEkgdGhpbmsgd2Ugc2hvdWxkIGhhdmUgYXQgbGVh
c3QgYSBGUyBQT0Mgd2l0aCBkYXRhDQo+ID4gcGxhY2VtZW50IHN1cHBvcnQgdG8gYmUgYWJsZSB0
byBkcml2ZSBjb25jbHVzaW9ucyBvbiBob3cgdGhlIGludGVyZmFjZQ0KPiA+IGFuZCByZXF1aXJl
bWVudHMgc2hvdWxkIGJlLiBVbnRpbCB3ZSBoYXZlIHRoYXQsIHdlIGNhbiBzdXBwb3J0IHRoZQ0K
PiA+IHVzZS1jYXNlcyB0aGF0IHdlIGtub3cgY3VzdG9tZXJzIGFyZSBhc2tpbmcgZm9yLCBpLmUu
LCBibG9jay1sZXZlbCBoaW50cw0KPiA+IHRocm91Z2ggdGhlIGV4aXN0aW5nIHRlbXBlcmF0dXJl
IEFQSS4NCj4gPg0KPiA+ID4NCj4gPiA+PiBJIGFncmVlIHRoYXQgZG93biB0aGUgcm9hZCwgYW4g
aW50ZXJmYWNlIHRoYXQgYWxsb3dzIGhpbnRzIChtYW55IG1vcmUNCj4gPiA+PiB0aGFuIDUhKSBp
cyBuZWVkZWQuIEFuZCBpbiBteSBvcGluaW9uLCB0aGlzIGludGVyZmFjZSBzaG91bGQgbm90IGhh
dmUNCj4gPiA+PiBzZW1pbnRpY3MgYXR0YWNoZWQgdG8gaXQsIGp1c3QgYSBoaW50IElELCAjaGlu
dHMsIGFuZCBlbm91Z2ggc3BhY2UgdG8NCj4gPiA+PiBwdXQgMTAwcyBvZiB0aGVtIHRvIHN1cHBv
cnQgc3RvcmFnZSBub2RlIGRlcGxveW1lbnRzLiBCdXQgdGhpcyBuZWVkcyB0bw0KPiA+ID4+IGNv
bWUgZnJvbSB0aGUgdXNlcnMgb2YgdGhlIGhpbnRzIC8gem9uZXMgLyBzdHJlYW1zIC8gZXRjLCAg
bm90IGZyb20NCj4gPiA+PiB1cyB2ZW5kb3JzLiBXZSBkbyBub3QgaGF2ZSBuZWl0aGVyIGRldGFp
bHMgb24gaG93IHRoZXkgZGVwbG95IHRoZXNlDQo+ID4gPj4gZmVhdHVyZXMgYXQgc2NhbGUsIG5v
ciB0aGUgd29ya2xvYWRzIHRvIHZhbGlkYXRlIHRoZSByZXN1bHRzLiBBbnl0aGluZw0KPiA+ID4+
IGVsc2Ugd2lsbCBwcm9iYWJseSBqdXN0IGNvbnRpbnVlIHBvbGx1dGluZyB0aGUgc3RvcmFnZSBz
dGFjayB3aXRoIG1vcmUNCj4gPiA+PiBpbnRlcmZhY2VzIHRoYXQgYXJlIG5vdCB1c2VkIGFuZCBh
ZGQgdG8gdGhlIHByb2JsZW0gb2YgZGF0YSBwbGFjZW1lbnQNCj4gPiA+PiBmcmFnbWVudGF0aW9u
Lg0KPiA+ID4NCj4gPiA+UGxlYXNlIGFsd2F5cyBtZW50aW9uZWQgd2hhdCBsYXllciB5b3UgYXJl
IHRhbGtpbmcgYWJvdXQuICBBdCB0aGUgc3lzY2FsbA0KPiA+ID5sZXZlbCB0aGUgdGVtcGVyYXR1
ciBoaW50cyBhcmUgZG9pbmcgcXVpdGUgb2suICBBIGZ1bGwgc3RyZWFtIHNlcGFyYXRpb24NCj4g
PiA+d291bGQgb2J2aW91c2x5IGJlIGEgbG90IGJldHRlciwgYXMgd291bGQgYmUgY29tbXVuaWNh
dGluZyB0aGUgem9uZSAvDQo+ID4gPnJlY2xhaW0gdW5pdCAvIGV0YyBzaXplLg0KPiA+DQo+ID4g
SSBtZWFuIGF0IHRoZSBzeXNjYWxsIGxldmVsLiBCdXQgYXMgbWVudGlvbmVkIGFib3ZlLCB3ZSBu
ZWVkIHRvIGJlIHZlcnkNCj4gPiBzdXJlIHRoYXQgd2UgaGF2ZSBhIGNsZWFyIHVzZS1jYXNlIGZv
ciB0aGF0LiBJZiB3ZSBjb250aW51ZSBzZWVpbmcgaGludHMNCj4gPiBiZWluZyB1c2UgaW4gTlZN
ZSBvciBvdGhlciBwcm90b2NvbHMsIGFuZCB0aGUgbnVtYmVyIGluY3JlYXNlDQo+ID4gc2lnbmlm
aWNhbnRseSwgd2UgY2FuIGRlYWwgd2l0aCBpdCBsYXRlciBvbi4NCj4gPg0KPiA+ID4NCj4gPiA+
QXMgYW4gaW50ZXJmYWNlIHRvIGEgZHJpdmVyIHRoYXQgZG9lc24ndCBuYXRpdmVseSBzcGVhayB0
ZW1wZXJhdHVyZQ0KPiA+ID5oaW50IG9uIHRoZSBvdGhlciBoYW5kIGl0IGRvZXNuJ3Qgd29yayBh
dCBhbGwuDQo+ID4gPg0KPiA+ID4+IFRoZSBpc3N1ZSBpcyB0aGF0IHRoZSBmaXJzdCBzZXJpZXMg
b2YgdGhpcyBwYXRjaCwgd2hpY2ggaXMgYXMgc2ltcGxlIGFzDQo+ID4gPj4gaXQgZ2V0cywgaGl0
IHRoZSBsaXN0IGluIE1heS4gU2luY2UgdGhlbiB3ZSBhcmUgZG93biBwYXRocyB0aGF0IGxlYWQN
Cj4gPiA+PiBub3doZXJlLiBTbyB0aGUgbGluZSBiZXR3ZWVuIHJlYWwgdGVjaG5pY2FsIGZlZWRi
YWNrIHRoYXQgbGVhZHMgdG8NCj4gPiA+PiBhIGZlYXR1cmUgYmVpbmcgbWVyZ2VkLCBhbmQgdGVj
aG5pY2FsIG1pc2xlYWRpbmcgdG8gbWFrZSBwZW9wbGUgYmUgYQ0KPiA+ID4+IGJ1c3kgYmVlIGJl
Y29tZXMgdmVyeSB0aGluLiBJbiB0aGUgd2hvbGUgZGF0YSBwbGFjZW1lbnQgZWZmb3J0LCB3ZSBo
YXZlDQo+ID4gPj4gYmVlbiBkb3duIHRoaXMgcGF0aCBtYW55IHRpbWVzLCB1bmZvcnR1bmF0ZWx5
Li4uDQo+ID4gPg0KPiA+ID5XZWxsLCB0aGUgcHJldmlvdXMgcm91bmQgd2FzIHRoZSBmaXJzdCBv
bmUgYWN0dWFsbHkgdHJ5aW5nIHRvIGFkZHJlc3MgdGhlDQo+ID4gPmZ1bmRhbWVudGFsIGlzc3Vl
IGFmdGVyIDQgbW9udGguICBBbmQgdGhlbiBhZnRlciBhIGZpcnN0IHJvdW5kIG9mIGZlZWRiYWNr
DQo+ID4gPml0IGdldHMgc2h1dGRvd24gc29tZWhvdyBvdXQgb2Ygbm93aGVyZS4gIEFzIGEgbWFp
bnRhaW5lciBhbmQgcmV2aWV3IHRoYXQNCj4gPiA+aXMgdGhlIGtpbmRhIG9mIGNvbnRyaWJ1dG9y
cyBJIGhhdmUgYSBoYXJkIHRpbWUgdGFraW5nIHNlcmlvdXMuDQo+ID4NCj4gPiBJIGFtIG5vdCBz
dXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuIGluIHRoZSBsYXN0IHNlbnRlY2UsIHNvIEkg
d2lsbA0KPiA+IG5vdCByZXNwb25kIGZpbGxpbmcgYmxhbmtzIHdpdGggYSBiYWQgaW50ZXJwcmV0
YXRpb24uDQo+ID4NCj4gPiBJbiBzdW1tYXJ5LCB3aGF0IHdlIGFyZSBhc2tpbmcgZm9yIGlzIHRv
IHRha2UgdGhlIHBhdGNoZXMgdGhhdCBjb3ZlciB0aGUNCj4gPiBjdXJyZW50IHVzZS1jYXNlLCBh
bmQgd29yayB0b2dldGhlciBvbiB3aGF0IG1pZ2h0IGJlIG5lZWRlZCBmb3IgYmV0dGVyDQo+ID4g
RlMgc3VwcG9ydC4gRm9yIHRoaXMsIGl0IHNlZW1zIHlvdSBhbmQgSGFucyBoYXZlIGEgZ29vZCBp
ZGVhIG9mIHdoYXQgeW91DQo+ID4gd2FudCB0byBoYXZlIGJhc2VkIG9uIFhGUy4gV2UgY2FuIGhl
bHAgcmV2aWV3IG9yIGRvIHBhcnQgb2YgdGhlIHdvcmssDQo+ID4gYnV0IHRyeWluZyB0byBndWVz
cyBvdXIgd2F5IHdpbGwgb25seSBkZWxheSBleGlzdGluZyBjdXN0b21lcnMgdXNpbmcNCj4gPiBl
eGlzdGluZyBIVy4NCj4gDQo+IEFmdGVyIHJlYWRpbmcgdGhlIHdob2xlIHRocmVhZCwgSSBlbmQg
dXAgd29uZGVyaW5nIHdoeSB3ZSBuZWVkIHRvIHJ1c2ggdGhlDQo+IHN1cHBvcnQgZm9yIGEgc2lu
Z2xlIHVzZSBjYXNlIHRocm91Z2ggaW5zdGVhZCBvZiBwdXR0aW5nIHRoZSBhcmNoaXRlY3R1cmUN
Cj4gaW4gcGxhY2UgZm9yIHByb3Blcmx5IHN1cHBvcnRpbmcgdGhpcyBuZXcgdHlwZSBvZiBoYXJk
d2FyZSBmcm9tIHRoZSBzdGFydA0KPiB0aHJvdWdob3V0IHRoZSBzdGFjay4NCg0KVGhpcyBpcyBu
b3QgYSBydXNoLiBXZSBoYXZlIGJlZW4gc3VwcG9ydGluZyB0aGlzIHVzZSBjYXNlIHRocm91Z2gg
cGFzc3RocnUgZm9yIA0Kb3ZlciAxLzIgeWVhciB3aXRoIGNvZGUgYWxyZWFkeSB1cHN0cmVhbSBp
biBDYWNoZWxpYi4gVGhpcyBpcyBtYXR1cmUgZW5vdWdoIGFzIA0KdG8gbW92ZSBpbnRvIHRoZSBi
bG9jayBsYXllciwgd2hpY2ggaXMgd2hhdCB0aGUgZW5kIHVzZXIgd2FudHMgdG8gZG8gZWl0aGVy
IHdheS4NCg0KVGhpcyBpcyB0aG91Z2ggYSB2ZXJ5IGdvb2QgcG9pbnQuIFRoaXMgaXMgd2h5IHdl
IHVwc3RyZWFtZWQgcGFzc3RocnUgYXQgdGhlIA0KdGltZTsgc28gcGVvcGxlIGNhbiBleHBlcmlt
ZW50LCB2YWxpZGF0ZSwgYW5kIHVwc3RyZWFtIG9ubHkgd2hlbiB0aGVyZSBpcyBhIA0KY2xlYXIg
cGF0aC4NCg0KPiANCj4gRXZlbiBmb3IgdXNlciBzcGFjZSBjb25zdW1lcnMgb2YgcmF3IGJsb2Nr
IGRldmljZXMsIGlzIHRoZSBsYXN0IHZlcnNpb24NCj4gb2YgdGhlIHBhdGNoIHNldCBnb29kIGVu
b3VnaD8NCj4gDQo+ICogSXQgc2V2ZXJlbHkgY3JpcHBsZXMgdGhlIGRhdGEgc2VwYXJhdGlvbiBj
YXBhYmlsaXRpZXMgYXMgb25seSBhIGhhbmRmdWwgb2YNCj4gICBkYXRhIHBsYWNlbWVudCBidWNr
ZXRzIGFyZSBzdXBwb3J0ZWQNCg0KSSBjb3VsZCB1bmRlcnN0YW5kIGZyb20geW91ciBwcmVzZW50
YXRpb24gYXQgTFBDLCBhbmQgbGF0ZSBsb29raW5nIGF0IHRoZSBjb2RlIHRoYXQgDQppcyBhdmFp
bGFibGUgdGhhdCB5b3UgaGF2ZSBiZWVuIHN1Y2Nlc3NmdWwgYXQgZ2V0dGluZyBnb29kIHJlc3Vs
dHMgd2l0aCB0aGUgZXhpc3RpbmcgDQppbnRlcmZhY2UgaW4gWEZTLiBUaGUgbWFwcGluZyBmb3Jt
IHRoZSB0ZW1wZXJhdHVyZSBzZW1hbnRpY3MgdG8gem9uZXMgKG5vIHNlbWFudGljcykNCmlzIHRo
ZSBleGFjdCBzYW1lIGFzIHdlIGFyZSBkb2luZyB3aXRoIEZEUC4gTm90IGhhdmluZyB0byBjaGFu
Z2UgbmVpdGhlciBpbi1rZXJuZWwgIG5vciB1c2VyLXNwYWNlIA0Kc3RydWN0dXJlcyBpcyBncmVh
dC4NCg0KPiANCj4gKiBJdCBqdXN0IHdvbid0IHdvcmsgaWYgdGhlcmUgaXMgbW9yZSB0aGFuIG9u
ZSB1c2VyIGFwcGxpY2F0aW9uIHBlciBzdG9yYWdlDQo+ICAgZGV2aWNlIGFzIGRpZmZlcmVudCBh
cHBsaWNhdGlvbnMgZGF0YSBzdHJlYW1zIHdpbGwgYmUgbWl4ZWQgYXQgdGhlIG52bWUNCj4gICBk
cml2ZXIgbGV2ZWwuLg0KDQpGb3Igbm93IHRoaXMgdXNlLWNhc2UgaXMgbm90IGNsZWFyLiBGb2xr
cyB3b3JraW5nIG9uIGl0IGFyZSB1c2luZyBwYXNzdGhydS4gV2hlbiB3ZQ0KaGF2ZSBhIG1vcmUg
Y2xlYXIgdW5kZXJzdGFuZGluZyBvZiB3aGF0IGlzIG5lZWRlZCwgd2UgbWlnaHQgbmVlZCBjaGFu
Z2VzIGluIHRoZSBrZXJuZWwuDQoNCklmIHlvdSBzZWUgYSBuZWVkIGZvciB0aGlzIG9uIHRoZSB3
b3JrIHRoYXQgeW91IGFyZSBkb2luZywgYnkgYWxsIG1lYW5zLCBwbGVhc2Ugc2VuZCBwYXRjaGVz
Lg0KQXMgSSBzYWlkIGF0IExQQywgd2UgY2FuIHdvcmsgdG9nZXRoZXIgb24gdGhpcy4NCg0KPiAN
Cj4gV2hpbGUgQ2hyaXN0b3BoIGhhcyBhbHJlYWR5IG91dGxpbmVkIHdoYXQgd291bGQgYmUgZGVz
aXJhYmxlIGZyb20gYQ0KPiBmaWxlIHN5c3RlbSBwb2ludCBvZiB2aWV3LCBJIGRvbid0IGhhdmUg
dGhlIGFuc3dlciB0byB3aGF0IHdvdWxkIGJlIHRoZSBvdmVyYWxsDQo+IGJlc3QgZGVzaWduIGZv
ciBGRFAuIEkgd291bGQgbGlrZSB0byBzYXkgdGhhdCBpdCBsb29rcyB0byBtZSBsaWtlIHdlIG5l
ZWQgdG8NCj4gY29uc2lkZXIgbW9yZSB0aGFuIG1vcmUgdGhhbiB0aGUgZWFybHkgYWRvcHRpb24g
dXNlIGNhc2VzIGFuZCBtYWtlIHN1cmUgd2UNCj4gbWFrZSB0aGUgbW9zdCBvZiB0aGUgaGFyZHdh
cmUgY2FwYWJpbGl0aWVzIHZpYSBsb2dpY2FsIGFic3RyYWN0aW9ucyB0aGF0DQo+IHdvdWxkIGJl
IGNvbXBhdGlibGUgd2l0aCBhIHdpZGVyIHJhbmdlIG9mIHN0b3JhZ2UgZGV2aWNlcy4NCj4gDQo+
IEZpZ3VyaW5nIHRoZSByaWdodCB3YXkgZm9yd2FyZCBpcyB0cmlja3ksIGJ1dCB3aHkgbm90IGp1
c3QgbGV0IGl0IHRha2UgdGhlIHRpbWUNCj4gdGhhdCBpcyBuZWVkZWQgdG8gc29ydCB0aGlzIG91
dCB3aGlsZSBlYXJseSB1c2VycyBleHBsb3JlIGhvdyB0byB1c2UgRkRQDQo+IGRyaXZlcyBhbmQg
c2hhcmUgdGhlIHJlc3VsdHM/DQoNCkkgYWdyZWUgdGhhdCB3ZSBtaWdodCBuZWVkIGEgbmV3IGlu
dGVyZmFjZSB0byBzdXBwb3J0IG1vcmUgaGludHMsIGJleW9uZCB0aGUgdGVtcGVyYXR1cmVzLiAN
Ck9yIG1heWJlIG5vdC4gV2Ugd291bGQgbm90IGtub3cgdW50aWwgc29tZW9uZSBjb21lcyB3aXRo
IGEgdXNlIGNhc2UuIFdlIGhhdmUgbWFkZSB0aGUgDQptaXN0YWtlIGluIHRoZSBwYXN0IG9mIHRy
ZWF0aW5nIGludGVybmFsIHJlc2VhcmNoIGFzIHVwc3RyZWFtYWJsZSB3b3JrLiBJIGtub3cgY2Fu
IHNlZSB0aGF0IA0KdGhpcyBzaW1wbHkgY29tcGxpY2F0ZXMgdGhlIGluLWtlcm5lbCBhbmQgdXNl
ci1zcGFjZSBBUElzLg0KDQpUaGUgZXhpc3RpbmcgQVBJIGlzIHVzYWJsZSBhbmQgcmVxdWlyZXMg
bm8gY2hhbmdlcy4gVGhlcmUgaXMgaGFyZHdhcmUuIFRoZXJlIGFyZSBjdXN0b21lcnMuIA0KVGhl
cmUgYXJlIGFwcGxpY2F0aW9ucyB3aXRoIHVwc3RyZWFtIHN1cHBvcnQgd2hpY2ggaGF2ZSBiZWVu
IHRlc3RlZCB3aXRoIHBhc3N0aHJ1ICh0aGUgDQplYXJseSByZXN1bHRzIHlvdSBtZW50aW9uKS4g
QW5kIHRoZSB3aXJpbmcgdG8gTlZNZSBpcyBfdmVyeV8gc2ltcGxlLiBUaGVyZSBpcyBubyByZWFz
b24gDQpub3QgdG8gdGFrZSB0aGlzIGluLCBhbmQgdGhlbiB3ZSB3aWxsIHNlZSB3aGF0IG5ldyBp
bnRlcmZhY2VzIHdlIG1pZ2h0IG5lZWQgaW4gdGhlIGZ1dHVyZS4NCg0KSSB3b3VsZCBtdWNoIHJh
dGhlciBzcGVuZCB0aW1lIGluIGRpc2N1c3NpbmcgaWRlYXMgd2l0aCB5b3UgYW5kIG90aGVycyBv
biBhIHBvdGVudGlhbA0KZnV0dXJlIEFQSSB0aGFuIGFyZ3VpbmcgYWJvdXQgdGhlIHZhbGlkaXR5
IG9mIGFuIF9leGlzdGluZ18gb25lLiANCg0KDQo=

