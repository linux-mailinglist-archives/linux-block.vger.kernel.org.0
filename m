Return-Path: <linux-block+bounces-18068-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F6A564E7
	for <lists+linux-block@lfdr.de>; Fri,  7 Mar 2025 11:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F228B3A99FB
	for <lists+linux-block@lfdr.de>; Fri,  7 Mar 2025 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A101E1DFB;
	Fri,  7 Mar 2025 10:16:39 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.cecloud.com (unknown [1.203.97.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A7120CCF5;
	Fri,  7 Mar 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.203.97.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342599; cv=none; b=t06Lw97w0GIkzwhfmvp3WtJd+Pag0tGH6Rle05EXWA6npGjpSgL6M/Wy/p699vYcyPqsV0sGxUlv90dXr0AkVDZls81x3whorUm9/bhP92EloBVXKJ0fNxZ3yx6G/DGxXJU14V1giSGK99IT5b4wsrPEwoZe5GXd+XttWuQYwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342599; c=relaxed/simple;
	bh=0C8ZfqMqZuoovYFbMVUqy5GecvU3AoQHWZmmwzHJY7o=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=HBVXBzWLLHNbqLdqhuOC68v0poQqlzl8TRy3nhqezG+mzdOnhK/uTQ7uTAd8ffKTRY9DtuhbmvteN/5KaEy34lVIkafvBWKvoj5WcWBKib/p57C5rZxjNmVmoX0C+l9jPlUelzqE2O3mCxdSTTojD9SFdSJ6cq7iLom+aJ7en2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn; spf=pass smtp.mailfrom=cestc.cn; arc=none smtp.client-ip=1.203.97.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cestc.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cestc.cn
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id 859D5900113;
	Fri,  7 Mar 2025 18:10:48 +0800 (CST)
X-MAIL-GRAY:0
X-MAIL-DELIVERY:1
X-SKE-CHECKED:1
X-ABS-CHECKED:1
X-ANTISPAM-LEVEL:2
Received: from desktop-n31qu50 (unknown [39.156.73.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907749T281458224329072S1741342247056699_;
	Fri, 07 Mar 2025 18:10:47 +0800 (CST)
X-IP-DOMAINF:1
X-RL-SENDER:zhang.guanghui@cestc.cn
X-SENDER:zhang.guanghui@cestc.cn
X-LOGIN-NAME:zhang.guanghui@cestc.cn
X-FST-TO:sagi@grimberg.me
X-RCPT-COUNT:8
X-LOCAL-RCPT-COUNT:0
X-MUTI-DOMAIN-COUNT:0
X-SENDER-IP:39.156.73.12
X-ATTACHMENT-NUM:0
X-UNIQUE-TAG:<1be85d387a87dfb187ff48dbfef631eb>
X-System-Flag:0
Date: Fri, 7 Mar 2025 18:10:46 +0800
From: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>
To: sagi <sagi@grimberg.me>, 
	mgurtovoy <mgurtovoy@nvidia.com>, 
	kbusch <kbusch@kernel.org>, 
	sashal <sashal@kernel.org>, 
	chunguang.xu <chunguang.xu@shopee.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-nvme <linux-nvme@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFJlOiBudm1lLXRjcDogZml4IGEgcG9zc2libGUgVUFGIHdoZW4gZmFpbGluZyB0byBzZW5kIHJlcXVlc3TjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFzYWdpZ3JpbUBnbWFpbC5jb23ku6Plj5HjgJE=?=
References: <2025021015413817916143@cestc.cn>, 
	<aed9dde7-3271-4b97-9632-8380d37505d9@grimberg.me>
X-Priority: 3
X-GUID: 975E8B81-9D52-4F73-B182-02888A113620
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.331[cn]
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202503071810452687957@cestc.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

CkhpIAoKICAgICAgICBBZnRlciB0ZXN0aW5nIHRoaXMgcGF0Y2gsICAgc2VuZGluZyByZXF1ZXN0
IGZhaWx1cmUgb2NjdXJyZWQsICAgdW5mb3J0dW5hdGVseSwgdGhlIGlzc3VlIHN0aWxsIHBlcnNp
c3RzLiAgCgoKYmVzdCB3aXNoZXMKCgoKCnpoYW5nLmd1YW5naHVpQGNlc3RjLmNuCgoKCsKgCgoK
CuWPkeS7tuS6uu+8msKgU2FnaSBHcmltYmVyZwoKCgrlj5HpgIHml7bpl7TvvJrCoDIwMjUtMDIt
MTfCoDE1OjQ2CgoKCuaUtuS7tuS6uu+8msKgemhhbmcuZ3VhbmdodWlAY2VzdGMuY247IG1ndXJ0
b3ZveTsga2J1c2NoOyBzYXNoYWw7IGNodW5ndWFuZy54dQoKCgrmioTpgIHvvJrCoGxpbnV4LWtl
cm5lbDsgbGludXgtbnZtZTsgbGludXgtYmxvY2sKCgoK5Li76aKY77yawqBSZTogbnZtZS10Y3A6
IGZpeCBhIHBvc3NpYmxlIFVBRiB3aGVuIGZhaWxpbmcgdG8gc2VuZCByZXF1ZXN044CQ6K+35rOo
5oSP77yM6YKu5Lu255Sxc2FnaWdyaW1AZ21haWwuY29t5Luj5Y+R44CRCgoKCsKgCgoKCsKgCgoK
CsKgCgoKCk9uIDEwLzAyLzIwMjUgOTo0MSwgemhhbmcuZ3VhbmdodWlAY2VzdGMuY24gd3JvdGU6
CgoKCj4gSGVsbG8KCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKgIMKgwqBXaGVuIHVzaW5nIHRoZSBu
dm1lLXRjcCBkcml2ZXIgaW4gYSBzdG9yYWdlIGNsdXN0ZXIsIHRoZSBkcml2ZXIgbWF5IHRyaWdn
ZXIgYSBudWxsIHBvaW50ZXIgY2F1c2luZyB0aGUgaG9zdCB0byBjcmFzaCBzZXZlcmFsIHRpbWVz
LgoKCgo+CgoKCj4KCgoKPgoKCgo+IEJ5IGFuYWx5emluZyB0aGUgdm1jb3JlLCB3ZSBrbm93IHRo
ZSBkaXJlY3QgY2F1c2UgaXMgdGhhdMKgIHRoZSByZXF1ZXN0LT5tcV9oY3R4IHdhcyB1c2VkIGFm
dGVyIGZyZWUuCgoKCj4KCgoKPgoKCgo+CgoKCj4KCgoKPgoKCgo+IENQVTHCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENQVTIKCgoKPgoKCgo+CgoKCj4KCgoKPiBu
dm1lX3RjcF9wb2xswqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbnZtZV90Y3BfdHJ5X3Nl
bmTCoCAtLWZhaWxlZCB0byBzZW5kIHJlcXJlc3QgMTMKCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKg
IMKgwqBudm1lX3RjcF90cnlfcmVjdsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG52bWVfdGNwX2Zh
aWxfcmVxdWVzdAoKCgo+CgoKCj4KCgoKPgoKCgo+wqAgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9y
ZWN2X3NrYsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG52bWVfdGNwX2VuZF9yZXF1ZXN0CgoKCj4K
CgoKPgoKCgo+CgoKCj7CoCDCoCDCoMKgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9yZWN2X3BkdcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIG52bWVfY29tcGxldGVfcnEKCgoKPgoKCgo+CgoKCj4KCgoK
PsKgIMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9oYW5kbGVfY29tcMKgIMKg
wqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgbnZtZV9yZXRyeV9yZXEgLS3CoHJlcXVlc3QtPm1x
X2hjdHggaGF2ZSBiZWVuIGZyZWVkLCBpcyBOVUxMLgoKCgo+CgoKCj4KCgoKPgoKCgo+wqAgwqAg
wqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqBudm1lX3RjcF9wcm9jZXNzX252bWVfY3Fl
CgoKCj4KCgoKPgoKCgo+CgoKCj7CoCDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDC
oMKgIMKgIG52bWVfY29tcGxldGVfcnEKCgoKPgoKCgo+CgoKCj4KCgoKPsKgIMKgIMKgwqDCoCDC
oMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgIG52bWVfZW5kX3JlcQoKCgo+CgoK
Cj4KCgoKPgoKCgo+wqAgwqAgwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBibGtfbXFfZW5kX3JlcXVlc3QKCgoKPgoKCgo+CgoKCj4KCgoKPgoK
Cgo+CgoKCj4KCgoKPgoKCgo+IHdoZW4gbnZtZV90Y3BfdHJ5X3NlbmQgZmFpbGVkIHRvIHNlbmQg
cmVxcmVzdCAxMywgaXQgbWF5YmUgYmUgcmVzdWx0ZWQgYnkgc2VsaW51eCBvciBvdGhlciByZWFz
b25zLCB0aGlzIGlzIGEgcHJvYmxlbS4gdGhlbsKgIHRoZSBudm1lX3RjcF9mYWlsX3JlcXVlc3Qg
d291bGQgZXhlY3V0ZeOAggoKCgo+CgoKCj4KCgoKPgoKCgo+IGJ1dCB0aGUgbnZtZV90Y3BfcmVj
dl9wZHUgbWF5IGhhdmUgcmVjZWl2ZWQgdGhlIHJlc3BvbmRpbmcgcGR1IGFuZCB0aGUgbnZtZV90
Y3BfcHJvY2Vzc19udm1lX2NxZSB3b3VsZCBoYXZlIGNvbXBsZXRlZCB0aGUgcmVxdWVzdC7CoCBy
ZXF1ZXN0LT5tcV9oY3R4IHdhcyB1c2VkIGFmdGVyIGZyZWUuCgoKCj4KCgoKPgoKCgo+CgoKCj4g
dGhlIGZvbGxvdyBwYXRjaCBpcyB0byBzb2x2ZSBpdC4KCgoKwqAKCgoKWmhhbmcsIHlvdXIgZW1h
aWwgY2xpZW50IG5lZWRzIGZpeGluZyAtIGl0IGlzIGltcG9zc2libGUgdG8gZm9sbG93IHlvdXIK
CgoKZW1haWxzLgoKCgrCoAoKCgo+CgoKCj4KCgoKPgoKCgo+IGNhbiB5b3UgZ2l2ZcKgIHNvbWUg
c3VnZ2VzdGlvbnM/wqAgdGhhbmtzIQoKCgrCoAoKCgpUaGUgcHJvYmxlbSBpcyB0aGUgQzJIVGVy
bSB0aGF0IHRoZSBob3N0IGlzIHVuYWJsZSB0byBoYW5kbGUgY29ycmVjdGx5LgoKCgpBbmQgaXQg
YWxzbyBhcHBlYXJzIHRoYXQgbnZtZV90Y3BfcG9sbCgpIGRvZXMgbm90IHNpZ25hbCBjb3JyZWN0
bHkgdG8KCgoKYmxrLW1xIHRvIHN0b3AKCgoKY2FsbGluZyBwb2xsLgoKCgrCoAoKCgpPbmUgdGhp
bmcgdG8gZG8gaXMgdG8gaGFuZGxlIEMySFRlcm0gUERVIGNvcnJlY3RseSwgYW5kLCBoZXJlIGlz
IGEKCgoKcG9zc2libGUgZml4IHRvIHRyeSBmb3IgdGhlIFVBRiBpc3N1ZToKCgoKLS0KCgoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNw
LmMKCgoKaW5kZXggYzYzN2ZmMDRhMDUyLi4wZTM5MGU5OGFhZjkgMTAwNjQ0CgoKCi0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L3RjcC5jCgoKCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCgoK
CkBAIC0yNjczLDYgKzI2NzMsNyBAQCBzdGF0aWMgaW50IG52bWVfdGNwX3BvbGwoc3RydWN0IGJs
a19tcV9od19jdHgKCgoKKmhjdHgsIHN0cnVjdCBpb19jb21wX2JhdGNoICppb2IpCgoKCsKgewoK
CgrCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV90Y3BfcXVldWUgKnF1ZXVlID0gaGN0eC0+ZHJp
dmVyX2RhdGE7CgoKCsKgwqDCoMKgwqDCoMKgIHN0cnVjdCBzb2NrICpzayA9IHF1ZXVlLT5zb2Nr
LT5zazsKCgoKK8KgwqDCoMKgwqDCoCBpbnQgcmV0OwoKCgrCoAoKCgrCoMKgwqDCoMKgwqDCoCBp
ZiAoIXRlc3RfYml0KE5WTUVfVENQX1FfTElWRSwgJnF1ZXVlLT5mbGFncykpCgoKCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKCgoKQEAgLTI2ODAsOSArMjY4MSw5IEBA
IHN0YXRpYyBpbnQgbnZtZV90Y3BfcG9sbChzdHJ1Y3QgYmxrX21xX2h3X2N0eAoKCgoqaGN0eCwg
c3RydWN0IGlvX2NvbXBfYmF0Y2ggKmlvYikKCgoKwqDCoMKgwqDCoMKgwqAgc2V0X2JpdChOVk1F
X1RDUF9RX1BPTExJTkcsICZxdWV1ZS0+ZmxhZ3MpOwoKCgrCoMKgwqDCoMKgwqDCoCBpZiAoc2tf
Y2FuX2J1c3lfbG9vcChzaykgJiYKCgoKc2tiX3F1ZXVlX2VtcHR5X2xvY2tsZXNzKCZzay0+c2tf
cmVjZWl2ZV9xdWV1ZSkpCgoKCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBza19idXN5
X2xvb3Aoc2ssIHRydWUpOwoKCgotwqDCoMKgwqDCoMKgIG52bWVfdGNwX3RyeV9yZWN2KHF1ZXVl
KTsKCgoKK8KgwqDCoMKgwqDCoCByZXQgPSBudm1lX3RjcF90cnlfcmVjdihxdWV1ZSk7CgoKCsKg
wqDCoMKgwqDCoMKgIGNsZWFyX2JpdChOVk1FX1RDUF9RX1BPTExJTkcsICZxdWV1ZS0+ZmxhZ3Mp
OwoKCgotwqDCoMKgwqDCoMKgIHJldHVybiBxdWV1ZS0+bnJfY3FlOwoKCgorwqDCoMKgwqDCoMKg
IHJldHVybiByZXQgPCAwID8gcmV0IDogcXVldWUtPm5yX2NxZTsKCgoKwqB9CgoKCsKgCgoKCsKg
c3RhdGljIGludCBudm1lX3RjcF9nZXRfYWRkcmVzcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBj
aGFyICpidWYsIGludAoKCgpzaXplKQoKCgotLQoKCgrCoAoKCgpEb2VzIHRoaXMgaGVscD8KCgoK
wqAKCgoKwqAKCgo=




