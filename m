Return-Path: <linux-block+bounces-9616-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36989237B4
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2024 10:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFC6B22FC8
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2024 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB4714D6FE;
	Tue,  2 Jul 2024 08:42:20 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F28814E2D8
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 08:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909740; cv=none; b=WAskMvgOG3Uwu5oYs/xB8RdwoRiJjPXcEsBsKN+Xe5ssBTB4neC3WyESquSA0B89zcZER8446QckvHFqTobNnpUpWaFjeHcOU1pSJLfVe8gQ42GG1w/JgMh2KycPc/u7wU8Mveu+WcpvSxBfHRwokFPo61nBfSYLQkHg8iGT+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909740; c=relaxed/simple;
	bh=Puj+jNmI26rldIqIgNvv4QkEN36nq3C66P0GQHXmSM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RXGYp246lsW+uj57/9sEi/GlAYZwsaF2BrCN2j1GNMdlIqnk8HU97gyewojPpOwjQRhUdiGXnzfbjUW2y0j6qdkTm3dN5C/gg/kOx6BO2pQd2ywlYvTTt1hh+QVQprw0MG6RCWQfpIRuiowU6w+M4tnkiLauR3va03zKWhaxQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4628fkba023870;
	Tue, 2 Jul 2024 16:41:46 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4WCx8z6xTXz2K4lJ1;
	Tue,  2 Jul 2024 16:36:51 +0800 (CST)
Received: from BJMBX02.spreadtrum.com (10.0.64.8) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 2 Jul 2024
 16:41:44 +0800
Received: from BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb]) by
 BJMBX02.spreadtrum.com ([fe80::c8c3:f3a0:9c9f:b0fb%19]) with mapi id
 15.00.1497.023; Tue, 2 Jul 2024 16:41:44 +0800
From: =?utf-8?B?54mb5b+X5Zu9IChaaGlndW8gTml1KQ==?= <Zhiguo.Niu@unisoc.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph
 Hellwig" <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
        =?utf-8?B?546L55qTIChIYW9faGFvIFdhbmcp?= <Hao_hao.Wang@unisoc.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjIgMi8yXSBibG9jay9tcS1kZWFkbGluZTogRml4?=
 =?utf-8?Q?_the_tag_reservation_code?=
Thread-Topic: [PATCH v2 2/2] block/mq-deadline: Fix the tag reservation code
Thread-Index: AQHazCQFSt1vw8hL60CP452z2NHXcbHjHolw
Date: Tue, 2 Jul 2024 08:41:44 +0000
Message-ID: <91752dcd09fb427bb48dbec05d151c37@BJMBX02.spreadtrum.com>
References: <20240509170149.7639-1-bvanassche@acm.org>
 <202407020202.46222wCt089266@SHSPAM01.spreadtrum.com>
In-Reply-To: <202407020202.46222wCt089266@SHSPAM01.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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
X-MAIL:SHSQR01.spreadtrum.com 4628fkba023870

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogQmFydCBWYW4gQXNzY2hlIDxi
dmFuYXNzY2hlQGFjbS5vcmc+IA0K5Y+R6YCB5pe26Ze0OiAyMDI05bm0NeaciDEw5pelIDE6MDIN
CuaUtuS7tuS6ujogSmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0K5oqE6YCBOiBsaW51eC1i
bG9ja0B2Z2VyLmtlcm5lbC5vcmc7IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgQmFy
dCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+OyBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9h
bEBrZXJuZWwub3JnPjsg54mb5b+X5Zu9IChaaGlndW8gTml1KSA8WmhpZ3VvLk5pdUB1bmlzb2Mu
Y29tPg0K5Li76aKYOiBbUEFUQ0ggdjIgMi8yXSBibG9jay9tcS1kZWFkbGluZTogRml4IHRoZSB0
YWcgcmVzZXJ2YXRpb24gY29kZQ0KDQoNCuazqOaEjzog6L+Z5bCB6YKu5Lu25p2l6Ieq5LqO5aSW
6YOo44CC6Zmk6Z2e5L2g56Gu5a6a6YKu5Lu25YaF5a655a6J5YWo77yM5ZCm5YiZ5LiN6KaB54K5
5Ye75Lu75L2V6ZO+5o6l5ZKM6ZmE5Lu244CCDQpDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KDQoNClRoZSBjdXJyZW50IHRhZyByZXNlcnZhdGlv
biBjb2RlIGlzIGJhc2VkIG9uIGEgbWlzdW5kZXJzdGFuZGluZyBvZiB0aGUgbWVhbmluZyBvZiBk
YXRhLT5zaGFsbG93X2RlcHRoLiBGaXggdGhlIHRhZyByZXNlcnZhdGlvbiBjb2RlIGFzIGZvbGxv
d3M6DQoqIEJ5IGRlZmF1bHQsIGRvIG5vdCByZXNlcnZlIGFueSB0YWdzIGZvciBzeW5jaHJvbm91
cyByZXF1ZXN0cyBiZWNhdXNlDQogIGZvciBjZXJ0YWluIHVzZSBjYXNlcyByZXNlcnZpbmcgdGFn
cyByZWR1Y2VzIHBlcmZvcm1hbmNlLiBTZWUgYWxzbw0KICBIYXJzaGl0IE1vZ2FsYXBhbGxpLCBb
YnVnLXJlcG9ydF0gUGVyZm9ybWFuY2UgcmVncmVzc2lvbiB3aXRoIGZpbw0KICBzZXF1ZW50aWFs
LXdyaXRlIG9uIGEgbXVsdGlwYXRoIHNldHVwLCAyMDI0LTAzLTA3DQogIChodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1ibG9jay81Y2UyYWU1ZC02MWUyLTRlZGUtYWQ1NS01NTExMTI2MDI0
MDFAb3JhY2xlLmNvbS8pDQoqIFJlZHVjZSBtaW5fc2hhbGxvd19kZXB0aCB0byBvbmUgYmVjYXVz
ZSBtaW5fc2hhbGxvd19kZXB0aCBtdXN0IGJlIGxlc3MNCiAgdGhhbiBvciBlcXVhbCBhbnkgc2hh
bGxvd19kZXB0aCB2YWx1ZS4NCiogU2NhbGUgZGQtPmFzeW5jX2RlcHRoIGZyb20gdGhlIHJhbmdl
IFsxLCBucl9yZXF1ZXN0c10gdG8gWzEsDQogIGJpdHNfcGVyX3NiaXRtYXBfd29yZF0uDQoNCkNj
OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCkNjOiBEYW1pZW4gTGUgTW9hbCA8ZGxl
bW9hbEBrZXJuZWwub3JnPg0KQ2M6IFpoaWd1byBOaXUgPHpoaWd1by5uaXVAdW5pc29jLmNvbT4N
CkZpeGVzOiAwNzc1NzU4OGU1MDcgKCJibG9jay9tcS1kZWFkbGluZTogUmVzZXJ2ZSAyNSUgb2Yg
c2NoZWR1bGVyIHRhZ3MgZm9yIHN5bmNocm9ub3VzIHJlcXVlc3RzIikNClNpZ25lZC1vZmYtYnk6
IEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPg0KLS0tDQogYmxvY2svbXEtZGVh
ZGxpbmUuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ibG9jay9tcS1kZWFk
bGluZS5jIGIvYmxvY2svbXEtZGVhZGxpbmUuYyBpbmRleCA5NGVlZGU0ZmI5ZWIuLmFjZGMyODc1
NmQ5ZCAxMDA2NDQNCi0tLSBhL2Jsb2NrL21xLWRlYWRsaW5lLmMNCisrKyBiL2Jsb2NrL21xLWRl
YWRsaW5lLmMNCkBAIC00ODcsNiArNDg3LDIwIEBAIHN0YXRpYyBzdHJ1Y3QgcmVxdWVzdCAqZGRf
ZGlzcGF0Y2hfcmVxdWVzdChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCkNCiAgICAgICAgcmV0
dXJuIHJxOw0KIH0NCg0KKy8qDQorICogJ2RlcHRoJyBpcyBhIG51bWJlciBpbiB0aGUgcmFuZ2Ug
MS4uSU5UX01BWCByZXByZXNlbnRpbmcgYSBudW1iZXIgb2YNCisgKiByZXF1ZXN0cy4gU2NhbGUg
aXQgd2l0aCBhIGZhY3RvciAoMSA8PCBidC0+c2Iuc2hpZnQpIC8gDQorcS0+bnJfcmVxdWVzdHMg
c2luY2UNCisgKiAxLi4oMSA8PCBidC0+c2Iuc2hpZnQpIGlzIHRoZSByYW5nZSBleHBlY3RlZCBi
eSBzYml0bWFwX2dldF9zaGFsbG93KCkuDQorICogVmFsdWVzIGxhcmdlciB0aGFuIHEtPm5yX3Jl
cXVlc3RzIGhhdmUgdGhlIHNhbWUgZWZmZWN0IGFzIHEtPm5yX3JlcXVlc3RzLg0KKyAqLw0KK3N0
YXRpYyBpbnQgZGRfdG9fd29yZF9kZXB0aChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCwgdW5z
aWduZWQgaW50IA0KK3FkZXB0aCkgew0KKyAgICAgICBzdHJ1Y3Qgc2JpdG1hcF9xdWV1ZSAqYnQg
PSAmaGN0eC0+c2NoZWRfdGFncy0+Yml0bWFwX3RhZ3M7DQorICAgICAgIGNvbnN0IHVuc2lnbmVk
IGludCBucnIgPSBoY3R4LT5xdWV1ZS0+bnJfcmVxdWVzdHM7DQorDQorICAgICAgIHJldHVybiAo
KHFkZXB0aCA8PCBidC0+c2Iuc2hpZnQpICsgbnJyIC0gMSkgLyBucnI7IH0NCisNCiAvKg0KICAq
IENhbGxlZCBieSBfX2Jsa19tcV9hbGxvY19yZXF1ZXN0KCkuIFRoZSBzaGFsbG93X2RlcHRoIHZh
bHVlIHNldCBieSB0aGlzDQogICogZnVuY3Rpb24gaXMgdXNlZCBieSBfX2Jsa19tcV9nZXRfdGFn
KCkuDQpAQCAtNTAzLDcgKzUxNyw3IEBAIHN0YXRpYyB2b2lkIGRkX2xpbWl0X2RlcHRoKGJsa19v
cGZfdCBvcGYsIHN0cnVjdCBibGtfbXFfYWxsb2NfZGF0YSAqZGF0YSkNCiAgICAgICAgICogVGhy
b3R0bGUgYXN5bmNocm9ub3VzIHJlcXVlc3RzIGFuZCB3cml0ZXMgc3VjaCB0aGF0IHRoZXNlIHJl
cXVlc3RzDQogICAgICAgICAqIGRvIG5vdCBibG9jayB0aGUgYWxsb2NhdGlvbiBvZiBzeW5jaHJv
bm91cyByZXF1ZXN0cy4NCiAgICAgICAgICovDQotICAgICAgIGRhdGEtPnNoYWxsb3dfZGVwdGgg
PSBkZC0+YXN5bmNfZGVwdGg7DQorICAgICAgIGRhdGEtPnNoYWxsb3dfZGVwdGggPSBkZF90b193
b3JkX2RlcHRoKGRhdGEtPmhjdHgsIA0KKyBkZC0+YXN5bmNfZGVwdGgpOw0KIH0NCg0KIC8qIENh
bGxlZCBieSBibGtfbXFfdXBkYXRlX25yX3JlcXVlc3RzKCkuICovIEBAIC01MTMsOSArNTI3LDkg
QEAgc3RhdGljIHZvaWQgZGRfZGVwdGhfdXBkYXRlZChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0
eCkNCiAgICAgICAgc3RydWN0IGRlYWRsaW5lX2RhdGEgKmRkID0gcS0+ZWxldmF0b3ItPmVsZXZh
dG9yX2RhdGE7DQogICAgICAgIHN0cnVjdCBibGtfbXFfdGFncyAqdGFncyA9IGhjdHgtPnNjaGVk
X3RhZ3M7DQoNCi0gICAgICAgZGQtPmFzeW5jX2RlcHRoID0gbWF4KDFVTCwgMyAqIHEtPm5yX3Jl
cXVlc3RzIC8gNCk7DQorICAgICAgIGRkLT5hc3luY19kZXB0aCA9IHEtPm5yX3JlcXVlc3RzOw0K
DQotICAgICAgIHNiaXRtYXBfcXVldWVfbWluX3NoYWxsb3dfZGVwdGgoJnRhZ3MtPmJpdG1hcF90
YWdzLCBkZC0+YXN5bmNfZGVwdGgpOw0KKyAgICAgICBzYml0bWFwX3F1ZXVlX21pbl9zaGFsbG93
X2RlcHRoKCZ0YWdzLT5iaXRtYXBfdGFncywgMSk7DQogfQ0KSGkgQmFydCwNCkkgdGVzdGVkIGJh
c2ljIGZ1bmN0aW9uIGFib3V0IHRoZXNlIHNlcmlhbCBwYXRjaGVzIGFuZCByZXN1bHRzIGlzIHBh
c3MsIGFuZCBubyB3YXJuaW5nIHJlcG9ydCBhZnRlciBzZXR0aW5nIGFzeW5jX2RlcHRoIHZhbHVl
IGJ5IHN5c2ZzLCBzbw0KVGVzdGVkLWJ5OiBaaGlndW8gTml1IDx6aGlndW8ubml1QHVuaXNvYy5j
b20+DQpUaGFua3MhDQoNCiAvKiBDYWxsZWQgYnkgYmxrX21xX2luaXRfaGN0eCgpIGFuZCBibGtf
bXFfaW5pdF9zY2hlZCgpLiAqLw0K

