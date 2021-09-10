Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5BF406DC4
	for <lists+linux-block@lfdr.de>; Fri, 10 Sep 2021 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhIJOwL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Sep 2021 10:52:11 -0400
Received: from UCOL19PA36.eemsg.mail.mil ([214.24.24.196]:26383 "EHLO
        UCOL19PA36.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhIJOwK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 10:52:10 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Sep 2021 10:52:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=mail.mil; i=@mail.mil; q=dns/txt; s=EEMSG2021v1a;
  t=1631285459; x=1662821459;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r75cw+HwjAUqTwWDhRinmzHGQwH1pcDNpN1OOTO44h8=;
  b=Ve6zVmRDD9sRxsk2XfecJM9riBdEGIGK8JBYYYnX1O1Z/RTmYr1Tsmwt
   OYFzI9aPhTqJLhS3A8azn6IwD6t58eu4Bn5L+KkJWa4djz1If26GvChIy
   KRRhKOuvFPDQKQu1fywY06RVeKWtLfQwkNKwk1HsD73XgWdW7tKeyruAu
   P+677r27/03YT674Eb8OYV8sfBMHVmaU9ZYHByoxb11h9+nVUafuyMqD6
   07DqjV2vgfL63kRxqRyPIpqoDi2pcM1ny/7wgndu5x1o6AfmAUGSERxTc
   a8QDm2vMvVawlGThjpL+Ht2VdszkhsiMw0xlljbOmR3ELjVSAV1aNibXB
   Q==;
X-EEMSG-check-017: 277924411|UCOL19PA36_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.85,283,1624320000"; 
   d="scan'208";a="277924411"
IronPort-HdrOrdr: A9a23:Ljymy63u6fNxai0mHj3l9gqjBNskLtp133Aq2lEZdPUzSKKlfq
 GV88jzuSWetN95YhhJpTnqAsS9qB3nn6KdmrN8AYuf
Received: from edge-mech02.mail.mil ([214.21.130.228])
  by UCOL19PA36.eemsg.mail.mil with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 10 Sep 2021 14:43:48 +0000
Received: from UMECHPAOS.easf.csd.disa.mil (214.21.130.162) by
 edge-mech02.mail.mil (214.21.130.228) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Fri, 10 Sep 2021 14:43:24 +0000
Received: from UMECHPA7B.easf.csd.disa.mil ([169.254.8.49]) by
 umechpaos.easf.csd.disa.mil ([1.213.132.164]) with mapi id 14.03.0513.000;
 Fri, 10 Sep 2021 14:43:24 +0000
From:   "Finlayson, James M CIV (USA)" <james.m.finlayson4.civ@mail.mil>
To:     'Jens Axboe' <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
CC:     "Finlayson, James M CIV (USA)" <james.m.finlayson4.civ@mail.mil>
Subject: RE: [Non-DoD Source] Re: [PATCH] blk-mq: allow 4x
 BLK_MAX_REQUEST_COUNT at blk_plug for multiple_queues
Thread-Topic: [Non-DoD Source] Re: [PATCH] blk-mq: allow 4x
 BLK_MAX_REQUEST_COUNT at blk_plug for multiple_queues
Thread-Index: AQHXpDznG+xCL1cjjEKFiPArWUUJe6udWmpQ
Date:   Fri, 10 Sep 2021 14:43:24 +0000
Message-ID: <5EAED86C53DED2479E3E145969315A2385876DB8@UMECHPA7B.easf.csd.disa.mil>
References: <20210907230338.227903-1-songliubraving@fb.com>
 <f64a938a-372c-aac1-4c5c-4b9456af5a69@kernel.dk>
In-Reply-To: <f64a938a-372c-aac1-4c5c-4b9456af5a69@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [214.21.44.12]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QWxsLA0KSSBoYXZlIGEgc3VzcGljaW9uIHRoaXMgd2lsbCBoZWxwIG15IGVmZm9ydHMgaW5jcmVh
c2luZyB0aGUgSU9QUyBhYmlsaXR5IG9mIG1kcmFpZCAgaW4gMTAtMTIgTlZNZSBkcml2ZSAgcGVy
IHJhaWQgZ3JvdXAgc2l0dWF0aW9ucy4NCg0KUHVyZSBuZW9waHl0ZSBxdWVzdGlvbiwgd2hpY2gg
SSBhcG9sb2dpemUgZm9yIGluIGFkdmFuY2UsIGhvdyBjYW4gSSB0ZXN0IHRoaXM/ICAgRG9lcyB0
aGlzIGVuZCB1cCBpbiAgYSA1LjE1IHJlbGVhc2UgY2FuZGlkYXRlIGtlcm5lbD8NCg0KSSB3YW50
IHRvIG1ha2UgY29udHJpYnV0aW9ucyB3aGVyZXZlciBJIGNhbiwgYXMgSSBoYXZlIGhhcmR3YXJl
IGFuZCBuZWVkcywgc28gSSBjYW4gYWN0IGFzIGEgcGVyZm9ybWFuY2UgdmFsaWRhdG9yIHdpdGhp
biByZWFzb24uICAgSSBrbm93IEkgY2FuJ3QgbWFrZSBjb250cmlidXRpb25zIGFzIGEgZGV2ZWxv
cGVyLCBidXQgSSdtIHdpbGxpbmcgdG8gY29udHJpYnV0ZSBpbiBhcmVhcyB3aGVyZSBvdXIgZ29h
bHMgYXJlIGluIGFsaWdubWVudCBhbmQgdGhpcyBhcHBlYXJzIHRvIGJlIG9uZS4NCg0KUmVnYXJk
cywNCkppbQ0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKZW5zIEF4Ym9l
IDxheGJvZUBrZXJuZWwuZGs+IA0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDcsIDIwMjEgNzow
NiBQTQ0KVG86IFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BmYi5jb20+OyBsaW51eC1ibG9ja0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJhaWRAdmdlci5rZXJuZWwub3JnDQpDYzogbWFyY2luLndh
bmF0QGdtYWlsLmNvbQ0KU3ViamVjdDogW05vbi1Eb0QgU291cmNlXSBSZTogW1BBVENIXSBibGst
bXE6IGFsbG93IDR4IEJMS19NQVhfUkVRVUVTVF9DT1VOVCBhdCBibGtfcGx1ZyBmb3IgbXVsdGlw
bGVfcXVldWVzDQoNCk9uIDkvNy8yMSA1OjAzIFBNLCBTb25nIExpdSB3cm90ZToNCj4gTGltaXRp
bmcgbnVtYmVyIG9mIHJlcXVlc3QgdG8gQkxLX01BWF9SRVFVRVNUX0NPVU5UIGF0IGJsa19wbHVn
IGh1cnRzIA0KPiBwZXJmb3JtYW5jZSBmb3IgbGFyZ2UgbWQgYXJyYXlzLiBbMV0gc2hvd3MgcmVz
eW5jIHNwZWVkIG9mIG1kIGFycmF5IA0KPiBkcm9wcyBmb3IgbWQgYXJyYXkgd2l0aCBtb3JlIHRo
YW4gMTYgSEREcy4NCj4gDQo+IEZpeCB0aGlzIGJ5IGFsbG93aW5nIG1vcmUgcmVxdWVzdCBhdCBw
bHVnIHF1ZXVlLiBUaGUgbXVsdGlwbGVfcXVldWUgDQo+IGZsYWcgaXMgdXNlZCB0byBvbmx5IGFw
cGx5IGhpZ2hlciBsaW1pdCB0byBtdWx0aXBsZSBxdWV1ZSBjYXNlcy4NCg0KQXBwbGllZCwgdGhh
bmtzLg0KDQotLQ0KSmVucyBBeGJvZQ0KDQo=
