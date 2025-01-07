Return-Path: <linux-block+bounces-16059-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE1A04097
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00823A1EAC
	for <lists+linux-block@lfdr.de>; Tue,  7 Jan 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D781EE7B7;
	Tue,  7 Jan 2025 13:14:54 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17A18CC15;
	Tue,  7 Jan 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255694; cv=none; b=LgcFXKP2H7JmqLyExhNtJ+H03io9ZhQOTM7UP+0D8j9rsfzZLVev2HwoDC0WEhmwi9PBIeHSaZ6GjiBQmkH7ojsTv14xHJ2+wCnbpReZPKMOmzZI6zUdVAJpEXP7h9LH72NBMeSzbtDt5rlykZI/lWdhXs0OCFVP6o13D2XsSKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255694; c=relaxed/simple;
	bh=uGvtVmh1VBQMZDbhKtaXTTM8an8VdHRzDmLgsyfenps=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgNfKLcp8ZeRgu6SWaXZ0rcKa/BNcvKM53mel5jXzmCyrLM3CJgbSSjAEjOi6+skI1qcViwureJ+VGdKNAyqSB7bzv3np1JeDpMEopAmFlxRbvq8yAV7tEhd0snyo8EH830J5iGP3WA3+5wcSaigR6x9QFGBe0OZ4lnzUo1nl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YSBLS0PWnzpZJM;
	Tue,  7 Jan 2025 21:13:04 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id BDE54180087;
	Tue,  7 Jan 2025 21:14:45 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (7.221.188.25) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 7 Jan 2025 21:14:45 +0800
Received: from kwepemd500012.china.huawei.com ([7.221.188.25]) by
 kwepemd500012.china.huawei.com ([7.221.188.25]) with mapi id 15.02.1258.034;
 Tue, 7 Jan 2025 21:14:45 +0800
From: lizetao <lizetao1@huawei.com>
To: Ferry Meng <mengferry@linux.alibaba.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, Stefan Hajnoczi
	<stefanha@redhat.com>, Christoph Hellwig <hch@infradead.org>, Joseph Qi
	<joseph.qi@linux.alibaba.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: RE: [PATCH v1 2/3] virtio-blk: add uring_cmd support for I/O passthru
 on chardev.
Thread-Topic: [PATCH v1 2/3] virtio-blk: add uring_cmd support for I/O
 passthru on chardev.
Thread-Index: AQHbUS+9ylKmIhB65Ui5jP/WaqakW7MLaSyw
Date: Tue, 7 Jan 2025 13:14:45 +0000
Message-ID: <e7e8751a45334b9c8ac75ac8ed325d7c@huawei.com>
References: <20241218092435.21671-1-mengferry@linux.alibaba.com>
 <20241218092435.21671-3-mengferry@linux.alibaba.com>
In-Reply-To: <20241218092435.21671-3-mengferry@linux.alibaba.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmVycnkgTWVuZyA8
bWVuZ2ZlcnJ5QGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIERlY2VtYmVy
IDE4LCAyMDI0IDU6MjUgUE0NCj4gVG86IE1pY2hhZWwgUyAuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPjsgSmFzb24gV2FuZw0KPiA8amFzb3dhbmdAcmVkaGF0LmNvbT47IGxpbnV4LWJsb2NrQHZn
ZXIua2VybmVsLm9yZzsgSmVucyBBeGJvZQ0KPiA8YXhib2VAa2VybmVsLmRrPjsgdmlydHVhbGl6
YXRpb25AbGlzdHMubGludXguZGV2DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBpby11cmluZ0B2Z2VyLmtlcm5lbC5vcmc7IFN0ZWZhbiBIYWpub2N6aQ0KPiA8c3RlZmFuaGFA
cmVkaGF0LmNvbT47IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IEpvc2Vw
aCBRaQ0KPiA8am9zZXBoLnFpQGxpbnV4LmFsaWJhYmEuY29tPjsgSmVmZmxlIFh1IDxqZWZmbGV4
dUBsaW51eC5hbGliYWJhLmNvbT47IEZlcnJ5DQo+IE1lbmcgPG1lbmdmZXJyeUBsaW51eC5hbGli
YWJhLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYxIDIvM10gdmlydGlvLWJsazogYWRkIHVyaW5n
X2NtZCBzdXBwb3J0IGZvciBJL08gcGFzc3RocnUgb24NCj4gY2hhcmRldi4NCj4gDQo+IEFkZCAt
PnVyaW5nX2NtZCgpIHN1cHBvcnQgZm9yIHZpcnRpby1ibGsgY2hhcmRldiAoL2Rldi92ZFhjMCku
DQo+IEFjY29yZGluZyB0byB2aXJ0aW8gc3BlYywgaW4gYWRkaXRpb24gdG8gcGFzc2luZyAnaGRy
JyBpbmZvIGludG8ga2VybmVsLCB3ZSBhbHNvDQo+IG5lZWQgdG8gcGFzcyB2YWRkciAmIGRhdGEg
bGVuZ3RoIG9mIHRoZSAnaW92JyByZXF1ZWlyZWQgZm9yIHRoZSB3cml0ZXYvcmVhZHYgb3AuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBGZXJyeSBNZW5nIDxtZW5nZmVycnlAbGludXguYWxpYmFiYS5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgICAgICB8IDIyMyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19ibGsuaCB8ICAxNiArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjM1IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9f
YmxrLmMgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyBpbmRleA0KPiAzNDg3YWFhNjc1MTQu
LmNkODhjZjkzOTE0NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMN
Cj4gKysrIGIvZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMNCj4gQEAgLTE4LDYgKzE4LDkgQEAN
Cj4gICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+DQo+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92
aXJ0aW9fcmluZy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2NkZXYuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9pb191cmluZy9jbWQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiArI2lu
Y2x1ZGUgPGxpbnV4L3Vpby5oPg0KPiANCj4gICNkZWZpbmUgUEFSVF9CSVRTIDQNCj4gICNkZWZp
bmUgVlFfTkFNRV9MRU4gMTYNCj4gQEAgLTU0LDYgKzU3LDIwIEBAIHN0YXRpYyBzdHJ1Y3QgY2xh
c3MgKnZkX2Nocl9jbGFzczsNCj4gDQo+ICBzdGF0aWMgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1Y3Qg
KnZpcnRibGtfd3E7DQo+IA0KPiArc3RydWN0IHZpcnRibGtfdXJpbmdfY21kX3BkdSB7DQo+ICsJ
c3RydWN0IHJlcXVlc3QgKnJlcTsNCj4gKwlzdHJ1Y3QgYmlvICpiaW87DQo+ICsJaW50IHN0YXR1
czsNCj4gK307DQo+ICsNCj4gK3N0cnVjdCB2aXJ0YmxrX2NvbW1hbmQgew0KPiArCXN0cnVjdCB2
aXJ0aW9fYmxrX291dGhkciBvdXRfaGRyOw0KPiArDQo+ICsJX191NjQJZGF0YTsNCj4gKwlfX3Uz
MglkYXRhX2xlbjsNCj4gKwlfX3UzMglmbGFnOw0KPiArfTsNCj4gKw0KPiAgc3RydWN0IHZpcnRp
b19ibGtfdnEgew0KPiAgCXN0cnVjdCB2aXJ0cXVldWUgKnZxOw0KPiAgCXNwaW5sb2NrX3QgbG9j
azsNCj4gQEAgLTEyMiw2ICsxMzksMTEgQEAgc3RydWN0IHZpcnRibGtfcmVxIHsNCj4gIAlzdHJ1
Y3Qgc2NhdHRlcmxpc3Qgc2dbXTsNCj4gIH07DQo+IA0KPiArc3RhdGljIHZvaWQgX191c2VyICp2
aXJ0YmxrX3RvX3VzZXJfcHRyKHVpbnRwdHJfdCBwdHJ2YWwpIHsNCj4gKwlyZXR1cm4gKHZvaWQg
X191c2VyICopcHRydmFsOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW5saW5lIGJsa19zdGF0dXNf
dCB2aXJ0YmxrX3Jlc3VsdCh1OCBzdGF0dXMpICB7DQo+ICAJc3dpdGNoIChzdGF0dXMpIHsNCj4g
QEAgLTI1OSw5ICsyODEsNiBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHZpcnRibGtfc2V0dXBfY21k
KHN0cnVjdA0KPiB2aXJ0aW9fZGV2aWNlICp2ZGV2LA0KPiAgCWlmICghSVNfRU5BQkxFRChDT05G
SUdfQkxLX0RFVl9aT05FRCkgJiYNCj4gb3BfaXNfem9uZV9tZ210KHJlcV9vcChyZXEpKSkNCj4g
IAkJcmV0dXJuIEJMS19TVFNfTk9UU1VQUDsNCj4gDQo+IC0JLyogU2V0IGZpZWxkcyBmb3IgYWxs
IHJlcXVlc3QgdHlwZXMgKi8NCj4gLQl2YnItPm91dF9oZHIuaW9wcmlvID0gY3B1X3RvX3ZpcnRp
bzMyKHZkZXYsIHJlcV9nZXRfaW9wcmlvKHJlcSkpOw0KPiAtDQo+ICAJc3dpdGNoIChyZXFfb3Ao
cmVxKSkgew0KPiAgCWNhc2UgUkVRX09QX1JFQUQ6DQo+ICAJCXR5cGUgPSBWSVJUSU9fQkxLX1Rf
SU47DQo+IEBAIC0zMDksOSArMzI4LDExIEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgdmlydGJsa19z
ZXR1cF9jbWQoc3RydWN0DQo+IHZpcnRpb19kZXZpY2UgKnZkZXYsDQo+ICAJCXR5cGUgPSBWSVJU
SU9fQkxLX1RfWk9ORV9SRVNFVF9BTEw7DQo+ICAJCWJyZWFrOw0KPiAgCWNhc2UgUkVRX09QX0RS
Vl9JTjoNCj4gKwljYXNlIFJFUV9PUF9EUlZfT1VUOg0KPiAgCQkvKg0KPiAgCQkgKiBPdXQgaGVh
ZGVyIGhhcyBhbHJlYWR5IGJlZW4gcHJlcGFyZWQgYnkgdGhlIGNhbGxlcg0KPiAodmlydGJsa19n
ZXRfaWQoKQ0KPiAtCQkgKiBvciB2aXJ0YmxrX3N1Ym1pdF96b25lX3JlcG9ydCgpKSwgbm90aGlu
ZyB0byBkbyBoZXJlLg0KPiArCQkgKiB2aXJ0YmxrX3N1Ym1pdF96b25lX3JlcG9ydCgpIG9yIGlv
X3VyaW5nIHBhc3N0aHJvdWdoIGNtZCksDQo+IG5vdGhpbmcNCj4gKwkJICogdG8gZG8gaGVyZS4N
Cj4gIAkJICovDQo+ICAJCXJldHVybiAwOw0KPiAgCWRlZmF1bHQ6DQo+IEBAIC0zMjMsNiArMzQ0
LDcgQEAgc3RhdGljIGJsa19zdGF0dXNfdCB2aXJ0YmxrX3NldHVwX2NtZChzdHJ1Y3QNCj4gdmly
dGlvX2RldmljZSAqdmRldiwNCj4gIAl2YnItPmluX2hkcl9sZW4gPSBpbl9oZHJfbGVuOw0KPiAg
CXZici0+b3V0X2hkci50eXBlID0gY3B1X3RvX3ZpcnRpbzMyKHZkZXYsIHR5cGUpOw0KPiAgCXZi
ci0+b3V0X2hkci5zZWN0b3IgPSBjcHVfdG9fdmlydGlvNjQodmRldiwgc2VjdG9yKTsNCj4gKwl2
YnItPm91dF9oZHIuaW9wcmlvID0gY3B1X3RvX3ZpcnRpbzMyKHZkZXYsIHJlcV9nZXRfaW9wcmlv
KHJlcSkpOw0KPiANCj4gIAlpZiAodHlwZSA9PSBWSVJUSU9fQkxLX1RfRElTQ0FSRCB8fCB0eXBl
ID09DQo+IFZJUlRJT19CTEtfVF9XUklURV9aRVJPRVMgfHwNCj4gIAkgICAgdHlwZSA9PSBWSVJU
SU9fQkxLX1RfU0VDVVJFX0VSQVNFKSB7IEBAIC04MzIsNiArODU0LDcgQEANCj4gc3RhdGljIGlu
dCB2aXJ0YmxrX2dldF9pZChzdHJ1Y3QgZ2VuZGlzayAqZGlzaywgY2hhciAqaWRfc3RyKQ0KPiAg
CXZiciA9IGJsa19tcV9ycV90b19wZHUocmVxKTsNCj4gIAl2YnItPmluX2hkcl9sZW4gPSBzaXpl
b2YodmJyLT5pbl9oZHIuc3RhdHVzKTsNCj4gIAl2YnItPm91dF9oZHIudHlwZSA9IGNwdV90b192
aXJ0aW8zMih2YmxrLT52ZGV2LA0KPiBWSVJUSU9fQkxLX1RfR0VUX0lEKTsNCj4gKwl2YnItPm91
dF9oZHIuaW9wcmlvID0gY3B1X3RvX3ZpcnRpbzMyKHZibGstPnZkZXYsDQo+ICtyZXFfZ2V0X2lv
cHJpbyhyZXEpKTsNCj4gIAl2YnItPm91dF9oZHIuc2VjdG9yID0gMDsNCj4gDQo+ICAJZXJyID0g
YmxrX3JxX21hcF9rZXJuKHEsIHJlcSwgaWRfc3RyLCBWSVJUSU9fQkxLX0lEX0JZVEVTLA0KPiBH
RlBfS0VSTkVMKTsgQEAgLTEyNTAsNiArMTI3MywxOTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBi
bGtfbXFfb3BzDQo+IHZpcnRpb19tcV9vcHMgPSB7DQo+ICAJLnBvbGwJCT0gdmlydGJsa19wb2xs
LA0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCB2aXJ0YmxrX3VyaW5nX2NtZF9w
ZHUgKnZpcnRibGtfZ2V0X3VyaW5nX2NtZF9wZHUoDQo+ICsJCXN0cnVjdCBpb191cmluZ19jbWQg
KmlvdWNtZCkNCj4gK3sNCj4gKwlyZXR1cm4gKHN0cnVjdCB2aXJ0YmxrX3VyaW5nX2NtZF9wZHUg
KikmaW91Y21kLT5wZHU7IH0NCj4gKw0KPiArc3RhdGljIHZvaWQgdmlydGJsa191cmluZ190YXNr
X2NiKHN0cnVjdCBpb191cmluZ19jbWQgKmlvdWNtZCwNCj4gKwkJdW5zaWduZWQgaW50IGlzc3Vl
X2ZsYWdzKQ0KPiArew0KPiArCXN0cnVjdCB2aXJ0YmxrX3VyaW5nX2NtZF9wZHUgKnBkdSA9DQo+
IHZpcnRibGtfZ2V0X3VyaW5nX2NtZF9wZHUoaW91Y21kKTsNCj4gKwlzdHJ1Y3QgdmlydGJsa19y
ZXEgKnZiciA9IGJsa19tcV9ycV90b19wZHUocGR1LT5yZXEpOw0KPiArCXU2NCByZXN1bHQgPSAw
Ow0KPiArDQo+ICsJaWYgKHBkdS0+YmlvKQ0KPiArCQlibGtfcnFfdW5tYXBfdXNlcihwZHUtPmJp
byk7DQo+ICsNCj4gKwkvKiBjdXJyZW50bHkgcmVzdWx0IGhhcyBubyB1c2UsIGl0IHNob3VsZCBi
ZSB6ZXJvIGFzIGNxZS0+cmVzICovDQo+ICsJaW9fdXJpbmdfY21kX2RvbmUoaW91Y21kLCB2YnIt
PmluX2hkci5zdGF0dXMsIHJlc3VsdCwgaXNzdWVfZmxhZ3MpOyB9DQo+ICsNCj4gK3N0YXRpYyBl
bnVtIHJxX2VuZF9pb19yZXQgdmlydGJsa191cmluZ19jbWRfZW5kX2lvKHN0cnVjdCByZXF1ZXN0
ICpyZXEsDQo+ICsJCQkJCQkgICBibGtfc3RhdHVzX3QgZXJyKQ0KPiArew0KPiArCXN0cnVjdCBp
b191cmluZ19jbWQgKmlvdWNtZCA9IHJlcS0+ZW5kX2lvX2RhdGE7DQo+ICsJc3RydWN0IHZpcnRi
bGtfdXJpbmdfY21kX3BkdSAqcGR1ID0NCj4gdmlydGJsa19nZXRfdXJpbmdfY21kX3BkdShpb3Vj
bWQpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBGb3IgaW9wb2xsLCBjb21wbGV0ZSBpdCBkaXJlY3Rs
eS4gTm90ZSB0aGF0IHVzaW5nIHRoZSB1cmluZ19jbWQNCj4gKwkgKiBoZWxwZXIgZm9yIHRoaXMg
aXMgc2FmZSBvbmx5IGJlY2F1c2Ugd2UgY2hlY2sgYmxrX3JxX2lzX3BvbGwoKS4NCj4gKwkgKiBB
cyB0aGF0IHJldHVybnMgZmFsc2UgaWYgd2UncmUgTk9UIG9uIGEgcG9sbGVkIHF1ZXVlLCB0aGVu
IGl0J3MNCj4gKwkgKiBzYWZlIHRvIHVzZSB0aGUgcG9sbGVkIGNvbXBsZXRpb24gaGVscGVyLg0K
PiArCSAqDQo+ICsJICogT3RoZXJ3aXNlLCBtb3ZlIHRoZSBjb21wbGV0aW9uIHRvIHRhc2sgd29y
ay4NCj4gKwkgKi8NCj4gKwlpZiAoYmxrX3JxX2lzX3BvbGwocmVxKSkgew0KPiArCQlpZiAocGR1
LT5iaW8pDQo+ICsJCQlibGtfcnFfdW5tYXBfdXNlcihwZHUtPmJpbyk7DQo+ICsJCWlvX3VyaW5n
X2NtZF9pb3BvbGxfZG9uZShpb3VjbWQsIDAsIHBkdS0+c3RhdHVzKTsNCj4gKwl9IGVsc2Ugew0K
PiArCQlpb191cmluZ19jbWRfZG9faW5fdGFza19sYXp5KGlvdWNtZCwgdmlydGJsa191cmluZ190
YXNrX2NiKTsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gUlFfRU5EX0lPX0ZSRUU7DQo+ICt9DQo+
ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgdmlydGJsa19yZXEgKnZpcnRibGtfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEpIHsNCj4gKwlyZXR1cm4gYmxrX21xX3JxX3RvX3BkdShyZXEpOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgaW5saW5lIGVudW0gcmVxX29wIHZpcnRibGtfcmVxX29wKGNvbnN0IHN0cnVj
dCB2aXJ0YmxrX3VyaW5nX2NtZA0KPiArKmNtZCkgew0KPiArCXJldHVybiAoY21kLT50eXBlICYg
VklSVElPX0JMS19UX09VVCkgPyBSRVFfT1BfRFJWX09VVCA6DQo+ICtSRVFfT1BfRFJWX0lOOyB9
DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqdmlydGJsa19hbGxvY191c2VyX3JlcXVl
c3QoDQo+ICsJCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxLCBzdHJ1Y3QgdmlydGJsa19jb21tYW5k
ICpjbWQsDQo+ICsJCWJsa19vcGZfdCBycV9mbGFncywgYmxrX21xX3JlcV9mbGFnc190IGJsa19m
bGFncykgew0KPiArCXN0cnVjdCByZXF1ZXN0ICpyZXE7DQo+ICsNCj4gKwlyZXEgPSBibGtfbXFf
YWxsb2NfcmVxdWVzdChxLCBycV9mbGFncywgYmxrX2ZsYWdzKTsNCj4gKwlpZiAoSVNfRVJSKHJl
cSkpDQo+ICsJCXJldHVybiByZXE7DQo+ICsNCj4gKwlyZXEtPnJxX2ZsYWdzIHw9IFJRRl9ET05U
UFJFUDsNCj4gKwltZW1jcHkoJnZpcnRibGtfcmVxKHJlcSktPm91dF9oZHIsICZjbWQtPm91dF9o
ZHIsIHNpemVvZihzdHJ1Y3QNCj4gdmlydGlvX2Jsa19vdXRoZHIpKTsNCj4gKwlyZXR1cm4gcmVx
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IHZpcnRibGtfbWFwX3VzZXJfcmVxdWVzdChzdHJ1
Y3QgcmVxdWVzdCAqcmVxLCB1NjQgdWJ1ZmZlciwNCj4gKwkJdW5zaWduZWQgaW50IGJ1ZmZsZW4s
IHN0cnVjdCBpb191cmluZ19jbWQgKmlvdWNtZCwNCj4gKwkJYm9vbCB2ZWMpDQo+ICt7DQo+ICsJ
c3RydWN0IHJlcXVlc3RfcXVldWUgKnEgPSByZXEtPnE7DQo+ICsJc3RydWN0IHZpcnRpb19ibGsg
KnZibGsgPSBxLT5xdWV1ZWRhdGE7DQo+ICsJc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiA9IHZi
bGsgPyB2YmxrLT5kaXNrLT5wYXJ0MCA6IE5VTEw7DQo+ICsJc3RydWN0IGJpbyAqYmlvID0gTlVM
TDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaWYgKGlvdWNtZCAmJiAoaW91Y21kLT5mbGFncyAm
IElPUklOR19VUklOR19DTURfRklYRUQpKSB7DQo+ICsJCXN0cnVjdCBpb3ZfaXRlciBpdGVyOw0K
PiArDQo+ICsJCS8qIGZpeGVkYnVmcyBpcyBvbmx5IGZvciBub24tdmVjdG9yZWQgaW8gKi8NCj4g
KwkJaWYgKFdBUk5fT05fT05DRSh2ZWMpKQ0KPiArCQkJcmV0dXJuIC1FSU5WQUw7DQpTaG91bGUg
YmUgZ290byBvdXQgaGVyZT8gT3IgcmVxIHdpbGwgbm90IGJlIGZyZWUuIEFuZCBJIHN1Z2dlc3Qg
dG8NCmZyZWUgcmVxdWVzdCBpbiB2aXJ0YmxrX3VyaW5nX2NtZF9pbygpLg0KPiArCQlyZXQgPSBp
b191cmluZ19jbWRfaW1wb3J0X2ZpeGVkKHVidWZmZXIsIGJ1ZmZsZW4sDQo+ICsJCQkJcnFfZGF0
YV9kaXIocmVxKSwgJml0ZXIsIGlvdWNtZCk7DQo+ICsJCWlmIChyZXQgPCAwKQ0KPiArCQkJZ290
byBvdXQ7DQo+ICsJCXJldCA9IGJsa19ycV9tYXBfdXNlcl9pb3YocSwgcmVxLCBOVUxMLA0KPiAr
CQkJJml0ZXIsIEdGUF9LRVJORUwpOw0KPiArCX0gZWxzZSB7DQo+ICsJCXJldCA9IGJsa19ycV9t
YXBfdXNlcl9pbyhyZXEsIE5VTEwsDQo+ICsJCQkJdmlydGJsa190b191c2VyX3B0cih1YnVmZmVy
KSwNCj4gKwkJCQlidWZmbGVuLCBHRlBfS0VSTkVMLCB2ZWMsIDAsDQo+ICsJCQkJMCwgcnFfZGF0
YV9kaXIocmVxKSk7DQo+ICsJfQ0KPiArCWlmIChyZXQpDQo+ICsJCWdvdG8gb3V0Ow0KPiArDQo+
ICsJYmlvID0gcmVxLT5iaW87DQo+ICsJaWYgKGJkZXYpDQo+ICsJCWJpb19zZXRfZGV2KGJpbywg
YmRldik7DQo+ICsJcmV0dXJuIDA7DQo+ICsNCj4gK291dDoNCj4gKwlibGtfbXFfZnJlZV9yZXF1
ZXN0KHJlcSk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCB2aXJ0
YmxrX3VyaW5nX2NtZF9pbyhzdHJ1Y3QgdmlydGlvX2JsayAqdmJsaywNCj4gKwkJc3RydWN0IGlv
X3VyaW5nX2NtZCAqaW91Y21kLCB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3MsIGJvb2wNCj4gdmVj
KSB7DQo+ICsJc3RydWN0IHZpcnRibGtfdXJpbmdfY21kX3BkdSAqcGR1ID0NCj4gdmlydGJsa19n
ZXRfdXJpbmdfY21kX3BkdShpb3VjbWQpOw0KPiArCWNvbnN0IHN0cnVjdCB2aXJ0YmxrX3VyaW5n
X2NtZCAqY21kID0gaW9fdXJpbmdfc3FlX2NtZChpb3VjbWQtDQo+ID5zcWUpOw0KPiArCXN0cnVj
dCByZXF1ZXN0X3F1ZXVlICpxID0gdmJsay0+ZGlzay0+cXVldWU7DQo+ICsJc3RydWN0IHZpcnRi
bGtfcmVxICp2YnI7DQo+ICsJc3RydWN0IHZpcnRibGtfY29tbWFuZCBkOw0KPiArCXN0cnVjdCBy
ZXF1ZXN0ICpyZXE7DQo+ICsJYmxrX29wZl90IHJxX2ZsYWdzID0gUkVRX0FMTE9DX0NBQ0hFIHwg
dmlydGJsa19yZXFfb3AoY21kKTsNCj4gKwlibGtfbXFfcmVxX2ZsYWdzX3QgYmxrX2ZsYWdzID0g
MDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJaWYgKCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0K
PiArCQlyZXR1cm4gLUVBQ0NFUzsNCj4gKw0KPiArCWQub3V0X2hkci5pb3ByaW8gPSBjcHVfdG9f
dmlydGlvMzIodmJsay0+dmRldiwgUkVBRF9PTkNFKGNtZC0NCj4gPmlvcHJpbykpOw0KPiArCWQu
b3V0X2hkci50eXBlID0gY3B1X3RvX3ZpcnRpbzMyKHZibGstPnZkZXYsIFJFQURfT05DRShjbWQt
PnR5cGUpKTsNCj4gKwlkLm91dF9oZHIuc2VjdG9yID0gY3B1X3RvX3ZpcnRpbzY0KHZibGstPnZk
ZXYsIFJFQURfT05DRShjbWQtDQo+ID5zZWN0b3IpKTsNCj4gKwlkLmRhdGEgPSBSRUFEX09OQ0Uo
Y21kLT5kYXRhKTsNCj4gKwlkLmRhdGFfbGVuID0gUkVBRF9PTkNFKGNtZC0+ZGF0YV9sZW4pOw0K
PiArDQo+ICsJaWYgKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9OT05CTE9DSykgew0KPiArCQly
cV9mbGFncyB8PSBSRVFfTk9XQUlUOw0KPiArCQlibGtfZmxhZ3MgPSBCTEtfTVFfUkVRX05PV0FJ
VDsNCj4gKwl9DQo+ICsJaWYgKGlzc3VlX2ZsYWdzICYgSU9fVVJJTkdfRl9JT1BPTEwpDQo+ICsJ
CXJxX2ZsYWdzIHw9IFJFUV9QT0xMRUQ7DQo+ICsNCj4gKwlyZXEgPSB2aXJ0YmxrX2FsbG9jX3Vz
ZXJfcmVxdWVzdChxLCAmZCwgcnFfZmxhZ3MsIGJsa19mbGFncyk7DQo+ICsJaWYgKElTX0VSUihy
ZXEpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihyZXEpOw0KPiArDQo+ICsJdmJyID0gdmlydGJsa19y
ZXEocmVxKTsNCj4gKwl2YnItPmluX2hkcl9sZW4gPSBzaXplb2YodmJyLT5pbl9oZHIuc3RhdHVz
KTsNCj4gKwlpZiAoZC5kYXRhICYmIGQuZGF0YV9sZW4pIHsNCj4gKwkJcmV0ID0gdmlydGJsa19t
YXBfdXNlcl9yZXF1ZXN0KHJlcSwgZC5kYXRhLCBkLmRhdGFfbGVuLA0KPiBpb3VjbWQsIHZlYyk7
DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gKw0KPiArCS8qIHRv
IGZyZWUgYmlvIG9uIGNvbXBsZXRpb24sIGFzIHJlcS0+YmlvIHdpbGwgYmUgbnVsbCBhdCB0aGF0
IHRpbWUgKi8NCj4gKwlwZHUtPmJpbyA9IHJlcS0+YmlvOw0KPiArCXBkdS0+cmVxID0gcmVxOw0K
PiArCXJlcS0+ZW5kX2lvX2RhdGEgPSBpb3VjbWQ7DQo+ICsJcmVxLT5lbmRfaW8gPSB2aXJ0Ymxr
X3VyaW5nX2NtZF9lbmRfaW87DQo+ICsJYmxrX2V4ZWN1dGVfcnFfbm93YWl0KHJlcSwgZmFsc2Up
Ow0KPiArCXJldHVybiAtRUlPQ0JRVUVVRUQ7DQo+ICt9DQo+ICsNCj4gKw0KPiArc3RhdGljIGlu
dCB2aXJ0YmxrX3VyaW5nX2NtZChzdHJ1Y3QgdmlydGlvX2JsayAqdmJsaywgc3RydWN0IGlvX3Vy
aW5nX2NtZA0KPiAqaW91Y21kLA0KPiArCQkJICAgICB1bnNpZ25lZCBpbnQgaXNzdWVfZmxhZ3Mp
DQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCUJVSUxEX0JVR19PTihzaXplb2Yoc3RydWN0
IHZpcnRibGtfdXJpbmdfY21kX3BkdSkgPg0KPiArc2l6ZW9mKGlvdWNtZC0+cGR1KSk7DQo+ICsN
Cj4gKwlzd2l0Y2ggKGlvdWNtZC0+Y21kX29wKSB7DQo+ICsJY2FzZSBWSVJUQkxLX1VSSU5HX0NN
RF9JTzoNCj4gKwkJcmV0ID0gdmlydGJsa191cmluZ19jbWRfaW8odmJsaywgaW91Y21kLCBpc3N1
ZV9mbGFncywgZmFsc2UpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIFZJUlRCTEtfVVJJTkdfQ01E
X0lPX1ZFQzoNCj4gKwkJcmV0ID0gdmlydGJsa191cmluZ19jbWRfaW8odmJsaywgaW91Y21kLCBp
c3N1ZV9mbGFncywgdHJ1ZSk7DQo+ICsJCWJyZWFrOw0KPiArCWRlZmF1bHQ6DQo+ICsJCXJldCA9
IC1FTk9UVFk7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIGludCB2aXJ0YmxrX2Nocl91cmluZ19jbWQoc3RydWN0IGlvX3VyaW5nX2NtZCAqaW91Y21k
LCB1bnNpZ25lZA0KPiAraW50IGlzc3VlX2ZsYWdzKSB7DQo+ICsJc3RydWN0IHZpcnRpb19ibGsg
KnZibGsgPSBjb250YWluZXJfb2YoZmlsZV9pbm9kZShpb3VjbWQtPmZpbGUpLT5pX2NkZXYsDQo+
ICsJCQlzdHJ1Y3QgdmlydGlvX2JsaywgY2Rldik7DQo+ICsNCj4gKwlyZXR1cm4gdmlydGJsa191
cmluZ19jbWQodmJsaywgaW91Y21kLCBpc3N1ZV9mbGFncyk7IH0NCj4gKw0KPiAgc3RhdGljIHZv
aWQgdmlydGJsa19jZGV2X3JlbChzdHJ1Y3QgZGV2aWNlICpkZXYpICB7DQo+ICAJaWRhX2ZyZWUo
JnZkX2Nocl9taW5vcl9pZGEsIE1JTk9SKGRldi0+ZGV2dCkpOyBAQCAtMTI5Nyw2DQo+ICsxNTEx
LDcgQEAgc3RhdGljIGludCB2aXJ0YmxrX2NkZXZfYWRkKHN0cnVjdCB2aXJ0aW9fYmxrICp2Ymxr
LA0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHZpcnRibGtfY2hy
X2ZvcHMgPSB7DQo+ICAJLm93bmVyCQk9IFRISVNfTU9EVUxFLA0KPiArCS51cmluZ19jbWQJPSB2
aXJ0YmxrX2Nocl91cmluZ19jbWQsDQo+ICB9Ow0KPiANCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQg
dmlydGJsa19xdWV1ZV9kZXB0aDsgZGlmZiAtLWdpdA0KPiBhL2luY2x1ZGUvdWFwaS9saW51eC92
aXJ0aW9fYmxrLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2Jsay5oIGluZGV4DQo+IDM3
NDRlNGRhMWIyYS4uOTNiNmUxYjViOWE0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX2Jsay5oDQo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgN
Cj4gQEAgLTMxMyw2ICszMTMsMjIgQEAgc3RydWN0IHZpcnRpb19zY3NpX2luaGRyIHsgIH07ICAj
ZW5kaWYNCj4gLyogIVZJUlRJT19CTEtfTk9fTEVHQUNZICovDQo+IA0KPiArc3RydWN0IHZpcnRi
bGtfdXJpbmdfY21kIHsNCj4gKwkvKiBWSVJUSU9fQkxLX1QqICovDQo+ICsJX191MzIgdHlwZTsN
Cj4gKwkvKiBpbyBwcmlvcml0eS4gKi8NCj4gKwlfX3UzMiBpb3ByaW87DQo+ICsJLyogU2VjdG9y
IChpZS4gNTEyIGJ5dGUgb2Zmc2V0KSAqLw0KPiArCV9fdTY0IHNlY3RvcjsNCj4gKw0KPiArCV9f
dTY0IGRhdGE7DQo+ICsJX191MzIgZGF0YV9sZW47DQo+ICsJX191MzIgZmxhZzsNCj4gK307DQo+
ICsNCj4gKyNkZWZpbmUgVklSVEJMS19VUklOR19DTURfSU8JCTENCj4gKyNkZWZpbmUgVklSVEJM
S19VUklOR19DTURfSU9fVkVDCTINCj4gKw0KPiAgLyogQW5kIHRoaXMgaXMgdGhlIGZpbmFsIGJ5
dGUgb2YgdGhlIHdyaXRlIHNjYXR0ZXItZ2F0aGVyIGxpc3QuICovDQo+ICAjZGVmaW5lIFZJUlRJ
T19CTEtfU19PSwkJMA0KPiAgI2RlZmluZSBWSVJUSU9fQkxLX1NfSU9FUlIJMQ0KPiAtLQ0KPiAy
LjQzLjUNCj4gDQo+IA0KDQo=

