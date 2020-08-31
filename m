Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75802573AE
	for <lists+linux-block@lfdr.de>; Mon, 31 Aug 2020 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHaG0x (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Aug 2020 02:26:53 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3494 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgHaG0x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 02:26:53 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 48F92F51C9D0E10F398D;
        Mon, 31 Aug 2020 14:26:51 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 31 Aug 2020 14:26:51 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 31 Aug 2020 14:26:50 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: bio: Trim bio to sensible size in bio_trim()
Thread-Topic: [PATCH] block: bio: Trim bio to sensible size in bio_trim()
Thread-Index: AdZ/REBJJJyCMvddRKS1UF17cHdE3g==
Date:   Mon, 31 Aug 2020 06:26:50 +0000
Message-ID: <4772af7044754f96a7e0be4ef93fa2bf@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPiB3cm90ZToNCj5PbiA4LzI5LzIwIDM6MzcgQU0s
IE1pYW9oZSBMaW4gd3JvdGU6DQo+PiBUcmltIGJpbyB0byBzZW5zaWJsZSBzaXplIGluIGJpb190
cmltKCkgb3Igc29tZXRoaW5nIGJhZCBtYXkgaGFwcGVuLg0KPg0KPlRoaXMgcmVhbGx5IG5lZWRz
IGEgTE9UIG1vcmUgZGV0YWlsLiBXaGF0IGlzICJzb21ldGhpbmcgYmFkIj8gSG93IGRvZXMgdGhp
cyBjb25kaXRpb24gdHJpZ2dlciB0byBiZWdpbiB3aXRoPw0KPg0KDQpNYW55IHRoYW5rcyBmb3Ig
eW91ciByZXBseS4NCg0KSSBkbyB0aGlzIG1haW5seSBieSBjb2RlIHJldmlldywgc28gSSBkaWRu
J3QgZmluZCB0aGUgY29uZGl0aW9uIHRyaWdnZXIgdG8gYmVnaW4gd2l0aC4gQnV0IEkgdGhpbmsg
aXQncyBiZXR0ZXINCnRvIGRvIHN1Y2ggYSBjaGVjayBhcyB0aGlzIGlzIGEgZXh0ZXJuYWwgSW50
ZXJmYWNlLiBBbHNvIElmIGJpb190cmltKCkgc2V0IGJpby0+YmlfaXRlci5iaV9zaXplIHRvIGEg
dmFsdWUgbGFyZ2VyIHRoYW4gdGhlIG9yaWdpbiBvbmUsDQp3ZSBtYXkgYWNjZXNzIHRoZSBiaW9f
dmVjIHBhc3QgdGhlIGxhc3Qgb25lIG9mIGJpby0+YmlfaW9fdmVjIGluIGZvcl9lYWNoX2J2ZWMg
bWFjcm8uDQoNCj4tLQ0KPkplbnMgQXhib2UNCj4NCg==
