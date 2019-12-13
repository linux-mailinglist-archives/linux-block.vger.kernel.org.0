Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA72511E018
	for <lists+linux-block@lfdr.de>; Fri, 13 Dec 2019 10:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfLMJCq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Dec 2019 04:02:46 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:25978 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMJCq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Dec 2019 04:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576227766; x=1607763766;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nZPMt1r2rquLNIIerC8fN6kOd0FjwhJ4qQN2mC6HbNs=;
  b=gU1BDRlsl9mzIsM/uem7DVXNEWcT7htnCh64xm6oEfTuIGmBn8du6u7k
   CROMAmQOO4M5vwnYd2oBmhaQBy+a1syLTLRd/n3utsSLSqztWshh3BApQ
   l5YOMMnaCFeijIitUaxIbYpJpLD6EZPUjB6wCeuOAwxtQHQH45siQwQ/R
   U=;
IronPort-SDR: ELN6J2Y41O7+pP0YfYvJxoMSSDX9C/rjjIh3ouZjpmY0NjOiPHKWq2S6BJn+HsDpKbJdia8iWJ
 YoA4h0djaNiw==
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="8397097"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 13 Dec 2019 09:02:45 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 85C61A18B9;
        Fri, 13 Dec 2019 09:02:43 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 09:02:42 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Dec 2019 09:02:42 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Fri, 13 Dec 2019 09:02:41 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: RE: [PATCH v3 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
Thread-Topic: [PATCH v3 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
Thread-Index: AQHVsDffBxYqNCmzjU+fCrGls961Bae2A5WAgAHDUYCAAABxAA==
Date:   Fri, 13 Dec 2019 09:02:41 +0000
Message-ID: <32fa4b86ac9d407a94d10a3b638a4ba3@EX13D32EUC003.ant.amazon.com>
References: <20191211152956.5168-1-pdurrant@amazon.com>
 <20191211152956.5168-4-pdurrant@amazon.com>
 <cfd8f169-e925-dbff-64b2-d471300a6694@suse.com>
 <1c12f2d7-ce67-41fc-f022-e39ea0c4e1df@suse.com>
In-Reply-To: <1c12f2d7-ce67-41fc-f022-e39ea0c4e1df@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.122]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKw7xyZ2VuIEdyb8OfIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFNlbnQ6IDEzIERlY2VtYmVyIDIwMTkgMDk6MDANCj4gVG86IER1cnJh
bnQsIFBhdWwgPHBkdXJyYW50QGFtYXpvbi5jb20+OyB4ZW4tZGV2ZWxAbGlzdHMueGVucHJvamVj
dC5vcmc7DQo+IGxpbnV4LWJsb2NrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xl
LmNvbT47IFN0ZWZhbm8gU3RhYmVsbGluaQ0KPiA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzRdIHhlbi9pbnRlcmZhY2U6IHJlLWRlZmluZQ0KPiBG
Uk9OVC9CQUNLX1JJTkdfQVRUQUNIKCkNCj4gDQo+IE9uIDEyLjEyLjE5IDA3OjA0LCBKw7xyZ2Vu
IEdyb8OfIHdyb3RlOg0KPiA+IE9uIDExLjEyLjE5IDE2OjI5LCBQYXVsIER1cnJhbnQgd3JvdGU6
DQo+ID4+IEN1cnJlbnRseSB0aGVzZSBtYWNyb3MgYXJlIGRlZmluZWQgdG8gcmUtaW5pdGlhbGl6
ZSBhIGZyb250L2JhY2sgcmluZw0KPiA+PiAocmVzcGVjdGl2ZWx5KSB0byB2YWx1ZXMgcmVhZCBm
cm9tIHRoZSBzaGFyZWQgcmluZyBpbiBzdWNoIGEgd2F5IHRoYXQNCj4gYW55DQo+ID4+IHJlcXVl
c3RzL3Jlc3BvbnNlcyB0aGF0IGFyZSBhZGRlZCB0byB0aGUgc2hhcmVkIHJpbmcgd2hpbHN0IHRo
ZQ0KPiA+PiBmcm9udC9iYWNrDQo+ID4+IGlzIGRldGFjaGVkIHdpbGwgYmUgc2tpcHBlZCBvdmVy
LiBUaGlzLCBpbiBnZW5lcmFsLCBpcyBub3QgYSBkZXNpcmFibGUNCj4gPj4gc2VtYW50aWMgc2lu
Y2UgbW9zdCBmcm9udGVuZCBpbXBsZW1lbnRhdGlvbnMgd2lsbCBldmVudHVhbGx5IGJsb2NrDQo+
ID4+IHdhaXRpbmcNCj4gPj4gZm9yIGEgcmVzcG9uc2Ugd2hpY2ggd291bGQgZWl0aGVyIG5ldmVy
IGFwcGVhciBvciBuZXZlciBiZSBwcm9jZXNzZWQuDQo+ID4+DQo+ID4+IFNpbmNlIHRoZSBtYWNy
b3MgYXJlIGN1cnJlbnRseSB1bnVzZWQsIHRha2UgdGhpcyBvcHBvcnR1bml0eSB0byByZS0NCj4g
ZGVmaW5lDQo+ID4+IHRoZW0gdG8gcmUtaW5pdGlhbGl6ZSBhIGZyb250L2JhY2sgcmluZyB1c2lu
ZyBzcGVjaWZpZWQgdmFsdWVzLiBUaGlzDQo+IGFsc28NCj4gPj4gYWxsb3dzIEZST05UL0JBQ0tf
UklOR19JTklUKCkgdG8gYmUgcmUtZGVmaW5lZCBpbiB0ZXJtcyBvZg0KPiA+PiBGUk9OVC9CQUNL
X1JJTkdfQVRUQUNIKCkgdXNpbmcgYSBzcGVjaWZpZWQgdmFsdWUgb2YgMC4NCj4gPj4NCj4gPj4g
Tk9URTogQkFDS19SSU5HX0FUVEFDSCgpIHdpbGwgYmUgdXNlZCBkaXJlY3RseSBpbiBhIHN1YnNl
cXVlbnQgcGF0Y2guDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFBhdWwgRHVycmFudCA8cGR1
cnJhbnRAYW1hem9uLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxq
Z3Jvc3NAc3VzZS5jb20+DQo+IA0KPiBQYXVsLCBJIHRoaW5rIHlvdSBzaG91bGQgc2VuZCBhIHBh
dGNoIGNoYW5naW5nIHJpbmcuaCBpbiB0aGUgWGVuIHRyZWUuDQo+IA0KPiBBcyBzb29uIGFzIGl0
IGhhcyBiZWVuIGFjY2VwdGVkIEknbGwgdGFrZSB5b3VyIHNlcmllcyBmb3IgdGhlIGtlcm5lbC4N
Cj4gDQoNCk9rLiBJIHdhcyB3YWl0aW5nIGZvciBhIHB1c2ggc28gdGhhdCBJIGNvdWxkIGNpdGUg
dGhlIGNvbW1pdCBoYXNoIGJ1dCBJJ2xsIHByZXAgc29tZXRoaW5nIG5vdyBpbnN0ZWFkLg0KDQog
IFBhdWwNCg==
