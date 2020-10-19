Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19429313D
	for <lists+linux-block@lfdr.de>; Tue, 20 Oct 2020 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbgJSWaH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Oct 2020 18:30:07 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:55692
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729803AbgJSWaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 18:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl85hLCzxrMgH7jwyOhj5YrijD1ZkzOPIuyX11vOjHFfpi/gfjaJb2QNAIoO/p5/ex4QHy+RozMHlyt803YijyzE8vVac5POalnE0hdwMPI5GDWHs9wWU0YYxRXh1r2TgLcioVGPQb305Q/2Rb8zKNJ2WRVIVKONFjj8uF8gbEDKOeY7i4+YQ8fzpqPXd3qrPdgB8dXZarFwnviuQZY5ps47ZUSBRY9M2fQWq6rj989+udNMnVHn4hGTTlw0Ou5q7L/xyW+27ErkNCiAhhfUYthJ0AX1rpPuokRPi0zlEYgQHlOLy1u7C4r9Zdwx6f3tFLXLS2FMYzE7qfNkhXZ8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HWgTrNYXPQRtw4B66EpbAct0hF2RCV1TbL24DDcolU=;
 b=fCOORAiRqCzmIOE2maHsJwnAXVvreuGqrOqqFeBLC1BTkQYSvfaC15Zq1TADi2ticqBS0X9JsaWf1M+xQkXcFy75enIPMyPWN8wX7RABufRUpom2xOKwEZGnnxLiYjGjP3grdWy2wqLvlJcqYqeLahdXi5XjGJiRdd/jd47+HcbBCiBiTCHTR4k83r9tgENJWvZTNPzubgpcWLHmvhW0BxVei6Vcq61NzPnX66Fq4NcEMfhXeCp8+ZJelGF5QbBVKRBpP0hOwOqMoNwDtiRSfdz6Zzf78Vk10gIO7PHpwv6ShvNg0kIuQ3PKnZyLcD0jsAjy6rLzS8/LqblpdcYPSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HWgTrNYXPQRtw4B66EpbAct0hF2RCV1TbL24DDcolU=;
 b=un8tFK77hOaI5XfNoK8cqgzwzvv+wCR6So1DJ20x3tZNyCLp2fktIIBqIOfggmWQOKoZ4Xom/T6VLRmL35QPTfpwf/RhQG3TsHw2uGOui1yiyyCe1EUtHpXGfnVNzqYrB5v29AQ9kWD9jLi5e38AQ8C1dGxPrPbr0IUMMGhaQnI=
Received: from SN6PR08MB4208.namprd08.prod.outlook.com (2603:10b6:805:3b::21)
 by SN6PR08MB5488.namprd08.prod.outlook.com (2603:10b6:805:fb::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 19 Oct
 2020 22:30:02 +0000
Received: from SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa]) by SN6PR08MB4208.namprd08.prod.outlook.com
 ([fe80::f459:dd7f:5b2:effa%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 22:30:02 +0000
From:   "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>
Subject: RE: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Topic: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Thread-Index: AQHWoLSk7QDKlgB4AkWtKLxj5k5RI6mYUcIAgAJzT5CAAAw0AIAEt6vw
Date:   Mon, 19 Oct 2020 22:30:02 +0000
Message-ID: <SN6PR08MB420843C280D54D7B5B76EB78B31E0@SN6PR08MB4208.namprd08.prod.outlook.com>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
In-Reply-To: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=micron.com;
x-originating-ip: [104.129.198.248]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2bb28cf-76ec-4743-3eab-08d8747e8575
x-ms-traffictypediagnostic: SN6PR08MB5488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR08MB54884D0BCD5CCA0B18AE8706B31E0@SN6PR08MB5488.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QpSNR3sEqj6ae32hYm6GBPc1hF7NoPe7XfsSfJBB7SWZ4lCg2KWO7mzq5KIWHhNYzuvXAHkHHD3VNoX7d27A5bBWMihyOUNtP8o4JRu0gJxgHXjOtK/Mt44hMWRdLY9+Y+9Asl0cX40XT0jKcSJWHmSm8Gqa7FhrzB0g6Q+85J7yTY7ZPV9h9WNWcIvPwACtxEZj/Fv3ISco4y2izAAotB5W5UvMTkZKKDgoA0QPcnQvDeTUmo75AXyma4PdVml49Oo6ek9QPtRCxveoiRF5Yz+G+lxtZRjw6JOh9oOlNZbUZ9Qa3oOadkjxGnKxdL7JOlndyrYAISg0CcUAC1KHeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR08MB4208.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(83380400001)(33656002)(6506007)(6916009)(107886003)(4326008)(53546011)(7696005)(26005)(2906002)(55236004)(186003)(55016002)(5660300002)(478600001)(54906003)(52536014)(86362001)(316002)(9686003)(71200400001)(8936002)(76116006)(66556008)(66476007)(64756008)(66446008)(66946007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lJJ11coeEvTNAL8ZrEASiVZbjgzr9RGVHiaqzr76Jx/uXF5ohD2fNGs1z7AeVimJjSPIRk6rxdFu6Q0ojCS0PJkp4s7NNgMAwBxByuzx9IA71NNT8uyErjPXRtDBMkd6nKbdPEDAfCRsoVDBb0MPrCOc2PLo1NDWWFntFqQIBBVmwLUzg3Dwhrpy2SUpoEjnsXHG/ywKaZICVS4ARGgOUylblVBr10tPiK32COrsZHuAE3drm3UlOeukjC2AfELpNROIVNjGI3R3ixmv9rmZYSBjDRKYYblrFNKGN07BcjcOr6Y/bHS08Bpor1UC/41FUR0pY9pNtoiEmkIucQreyOkx55S3DzXl1k++C/VPwe/G61YLAFNfdyTZ/IsXDvgB5kIo1rUfTJZpYEJ94hKBnk6VnRHMR7io2/obkjXzXJcqtFqxB2KQexx1plME3WB0EHJUGV9fmXZa3mK8JebD5smUTk4NMH+nbryRA20wKIyjHhgJjkabMlMN+nPJiZkE8+g8JxWdKhEJHdD0SXBe4UVz5ybbNQvjqZ9F73IQZIbTfnzWT+KioF35IWaTpA1to4qcXAkH7jmXgjW1xp+MhmyQ/ttDi9wmPmKtGy0aYWcgGMQ1uYDvBCA4PPyA55HDbM8KVhjLlpaQMYcdjo9GYg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR08MB4208.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bb28cf-76ec-4743-3eab-08d8747e8575
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 22:30:02.4903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIk03yXBMkynDcLNMlSUHyB0qwXaBgXIoc2MlhU/ShePMdhvBW1dslq0QG90EbmrvXk11TjGFg0hbWcEGB8AQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR08MB5488
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGkgRGFuLA0KDQpPbiBGcmlkYXksIE9jdG9iZXIgMTYsIDIwMjAgNDoxMiBQTSwgRGFuIFdpbGxp
YW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBPY3Qg
MTYsIDIwMjAgYXQgMjo1OSBQTSBOYWJlZWwgTWVlcmFtb2hpZGVlbiBNb2hhbWVkDQo+IChubWVl
cmFtb2hpZGUpIDxubWVlcmFtb2hpZGVAbWljcm9uLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBU
aHVyc2RheSwgT2N0b2JlciAxNSwgMjAyMCAyOjAzIEFNLCBDaHJpc3RvcGggSGVsbHdpZw0KPiA8
aGNoQGluZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+ID4gSSBkb24ndCB0aGluayB0aGlzIGJlbG9u
Z3MgaW50byB0aGUga2VybmVsLiAgSXQgaXMgYSBjbGFzc2ljIGNhc2UgZm9yDQo+ID4gPiBpbmZy
YXN0cnVjdHVyZSB0aGF0IHNob3VsZCBiZSBidWlsdCBpbiB1c2Vyc3BhY2UuICBJZiBhbnl0aGlu
ZyBpcw0KPiA+ID4gbWlzc2luZyB0byBpbXBsZW1lbnQgaXQgaW4gdXNlcnNwYWNlIHdpdGggZXF1
aXZhbGVudCBwZXJmb3JtYW5jZSB3ZQ0KPiA+ID4gbmVlZCB0byBpbXByb3ZlIG91dCBpbnRlcmZh
Y2VzLCBhbHRob3VnaCBpb191cmluZyBzaG91bGQgY292ZXIgcHJldHR5DQo+ID4gPiBtdWNoIGV2
ZXJ5dGhpbmcgeW91IG5lZWQuDQo+ID4NCj4gPiBIaSBDaHJpc3RvcGgsDQo+ID4NCj4gPiBXZSBw
cmV2aW91c2x5IGNvbnNpZGVyZWQgbW92aW5nIHRoZSBtcG9vbCBvYmplY3Qgc3RvcmUgY29kZSB0
byB1c2VyLXNwYWNlLg0KPiA+IEhvd2V2ZXIsIGJ5IGltcGxlbWVudGluZyBtcG9vbCBhcyBhIGRl
dmljZSBkcml2ZXIsIHdlIGdldCBzZXZlcmFsIGJlbmVmaXRzDQo+ID4gaW4gdGVybXMgb2Ygc2Nh
bGFiaWxpdHksIHBlcmZvcm1hbmNlLCBhbmQgZnVuY3Rpb25hbGl0eS4gSW4gZG9pbmcgc28sIHdl
IHJlbGllZA0KPiA+IG9ubHkgb24gc3RhbmRhcmQgaW50ZXJmYWNlcyBhbmQgZGlkIG5vdCBtYWtl
IGFueSBjaGFuZ2VzIHRvIHRoZSBrZXJuZWwuDQo+ID4NCj4gPiAoMSkgIG1wb29sJ3MgIm1jYWNo
ZSBtYXAiIGZhY2lsaXR5IGFsbG93cyB1cyB0byBtZW1vcnktbWFwIChhbmQgbGF0ZXIgdW5tYXAp
DQo+ID4gYSBjb2xsZWN0aW9uIG9mIGxvZ2ljYWxseSByZWxhdGVkIG9iamVjdHMgd2l0aCBhIHNp
bmdsZSBzeXN0ZW0gY2FsbC4gVGhlIG9iamVjdHMgaW4NCj4gPiBzdWNoIGEgY29sbGVjdGlvbiBh
cmUgY3JlYXRlZCBhdCBkaWZmZXJlbnQgdGltZXMsIHBoeXNpY2FsbHkgZGlzcGFyYXRlLCBhbmQg
bWF5DQo+ID4gZXZlbiByZXNpZGUgb24gZGlmZmVyZW50IG1lZGlhIGNsYXNzIHZvbHVtZXMuDQo+
ID4NCj4gPiBGb3Igb3VyIEhTRSBzdG9yYWdlIGVuZ2luZSBhcHBsaWNhdGlvbiwgdGhlcmUgYXJl
IGNvbW1vbmx5IDEwJ3MgdG8gMTAwJ3Mgb2YNCj4gPiBvYmplY3RzIGluIGEgZ2l2ZW4gbWNhY2hl
IG1hcCwgYW5kIDc1LDAwMCB0b3RhbCBvYmplY3RzIG1hcHBlZCBhdCBhIGdpdmVuDQo+IHRpbWUu
DQo+ID4NCj4gPiBDb21wYXJlZCB0byBtZW1vcnktbWFwcGluZyBvYmplY3RzIGluZGl2aWR1YWxs
eSwgdGhlIG1jYWNoZSBtYXAgZmFjaWxpdHkNCj4gPiBzY2FsZXMgd2VsbCBiZWNhdXNlIGl0IHJl
cXVpcmVzIG9ubHkgYSBzaW5nbGUgc3lzdGVtIGNhbGwgYW5kIHNpbmdsZQ0KPiB2bV9hcmVhX3N0
cnVjdA0KPiA+IHRvIG1lbW9yeS1tYXAgYSBjb21wbGV0ZSBjb2xsZWN0aW9uIG9mIG9iamVjdHMu
DQoNCj4gV2h5IGNhbid0IHRoYXQgYmUgYSBiYXRjaCBvZiBtbWFwIGNhbGxzIG9uIGlvX3VyaW5n
Pw0KDQpBZ3JlZWQsIHdlIGNvdWxkIGFkZCB0aGUgY2FwYWJpbGl0eSB0byBpbnZva2UgbW1hcCB2
aWEgaW9fdXJpbmcgdG8gaGVscCBtaXRpZ2F0ZSB0aGUNCnN5c3RlbSBjYWxsIG92ZXJoZWFkIG9m
IG1lbW9yeS1tYXBwaW5nIGluZGl2aWR1YWwgb2JqZWN0cywgdmVyc3VzIG91ciBtYWNoZSBtYXAN
Cm1lY2hhbmlzbS4gSG93ZXZlciwgdGhlcmUgaXMgc3RpbGwgdGhlIHNjYWxhYmlsaXR5IGlzc3Vl
IG9mIGhhdmluZyBhIHZtX2FyZWFfc3RydWN0DQpmb3IgZWFjaCBvYmplY3QgKHZlcnN1cyBvbmUg
Zm9yIGVhY2ggbWFjaGUgbWFwKS4NCg0KV2UgcmFuIFlDU0Igd29ya2xvYWQgQyBpbiB0d28gZGlm
ZmVyZW50IGNvbmZpZ3VyYXRpb25zIC0NCkNvbmZpZyAxOiBtZW1vcnktbWFwcGluZyBlYWNoIGlu
ZGl2aWR1YWwgb2JqZWN0DQpDb25maWcgMjogbWVtb3J5LW1hcHBpbmcgYSBjb2xsZWN0aW9uIG9m
IHJlbGF0ZWQgb2JqZWN0cyB1c2luZyBtY2FjaGUgbWFwDQoNCi0gQ29uZmlnIDEgaW5jdXJyZWQg
fjMuM3ggYWRkaXRpb25hbCBrZXJuZWwgbWVtb3J5IGZvciB0aGUgdm1fYXJlYV9zdHJ1Y3Qgc2xh
YiAtDQoyNC44IE1CICgxMjcxODggb2JqZWN0cykgZm9yIGNvbmZpZyAxLCB2ZXJzdXMgNy4zIE1C
ICgzNzQ4MiBvYmplY3RzKSBmb3IgY29uZmlnIDIuDQoNCi0gV29ya2xvYWQgQyBleGhpYml0ZWQg
YXJvdW5kIDEwLTI1JSBiZXR0ZXIgdGFpbCBsYXRlbmNpZXMgKDQtbmluZXMpIGZvciBjb25maWcg
MiwNCm5vdCBzdXJlIGlmIGl0J3MgZHVlIHRoZSByZWR1Y2VkIGNvbXBsZXhpdHkgb2Ygc2VhcmNo
aW5nIFZNQXMgZHVyaW5nIHBhZ2UgZmF1bHRzLg0KDQo+ID4gKDIpIFRoZSBtY2FjaGUgbWFwIHJl
YXBlciBtZWNoYW5pc20gcHJvYWN0aXZlbHkgZXZpY3RzIG9iamVjdCBkYXRhIGZyb20gdGhlDQo+
IHBhZ2UNCj4gPiBjYWNoZSBiYXNlZCBvbiBvYmplY3QtbGV2ZWwgbWV0cmljcy4gVGhpcyBwcm92
aWRlcyBzaWduaWZpY2FudCBwZXJmb3JtYW5jZQ0KPiBiZW5lZml0DQo+ID4gZm9yIG1hbnkgd29y
a2xvYWRzLg0KPiA+DQo+ID4gRm9yIGV4YW1wbGUsIHdlIHJhbiBZQ1NCIHdvcmtsb2FkcyBCICg5
NS81IHJlYWQvd3JpdGUgbWl4KSAgYW5kIEMgKDEwMCUgcmVhZCkNCj4gPiBhZ2FpbnN0IG91ciBI
U0Ugc3RvcmFnZSBlbmdpbmUgdXNpbmcgdGhlIG1wb29sIGRyaXZlciBpbiBhIDUuOSBrZXJuZWwu
DQo+ID4gRm9yIGVhY2ggd29ya2xvYWQsIHdlIHJhbiB3aXRoIHRoZSByZWFwZXIgdHVybmVkLW9u
IGFuZCB0dXJuZWQtb2ZmLg0KPiA+DQo+ID4gRm9yIHdvcmtsb2FkIEIsIHRoZSByZWFwZXIgaW5j
cmVhc2VkIHRocm91Z2hwdXQgMS43N3gsIHdoaWxlIHJlZHVjaW5nIDk5Ljk5JQ0KPiB0YWlsDQo+
ID4gbGF0ZW5jeSBmb3IgcmVhZHMgYnkgMzklIGFuZCB1cGRhdGVzIGJ5IDk5JS4gRm9yIHdvcmts
b2FkIEMsIHRoZSByZWFwZXINCj4gaW5jcmVhc2VkDQo+ID4gdGhyb3VnaHB1dCBieSAxLjg0eCwg
d2hpbGUgcmVkdWNpbmcgdGhlIDk5Ljk5JSByZWFkIHRhaWwgbGF0ZW5jeSBieSA2MyUuIFRoZXNl
DQo+ID4gaW1wcm92ZW1lbnRzIGFyZSBldmVuIG1vcmUgZHJhbWF0aWMgd2l0aCBlYXJsaWVyIGtl
cm5lbHMuDQoNCj4gV2hhdCBtZXRyaWNzIHByb3ZlZCB1c2VmdWwgYW5kIGNhbiB0aGUgdmFuaWxs
YSBwYWdlIGNhY2hlIC8gcGFnZQ0KPiByZWNsYWltIG1lY2hhbmlzbSBiZSBhdWdtZW50ZWQgd2l0
aCB0aG9zZSBtZXRyaWNzPw0KDQpUaGUgbWNhY2hlIG1hcCBmYWNpbGl0eSBpcyBkZXNpZ25lZCB0
byBjYWNoZSBhIGNvbGxlY3Rpb24gb2YgcmVsYXRlZCBpbW11dGFibGUgb2JqZWN0cw0Kd2l0aCBz
aW1pbGFyIGxpZmV0aW1lcy4gSXQgaXMgYmVzdCBzdWl0ZWQgZm9yIHN0b3JhZ2UgYXBwbGljYXRp
b25zIHRoYXQgcnVuIHF1ZXJpZXMgYWdhaW5zdA0Kb3JnYW5pemVkIGNvbGxlY3Rpb25zIG9mIGlt
bXV0YWJsZSBvYmplY3RzLCBzdWNoIGFzIHN0b3JhZ2UgZW5naW5lcyBhbmQgREJzIGJhc2VkIG9u
DQpTU1RhYmxlcy4NCg0KRWFjaCBtY2FjaGUgbWFwIGlzIGFzc29jaWF0ZWQgd2l0aCBhIHRlbXBl
cmF0dXJlIChwaW5uZWQsIGhvdCwgd2FybSwgY29sZCkgYW5kIGlzIGxlZnQNCnRvIHRoZSBhcHBs
aWNhdGlvbiB0byB0YWcgaXQgYXBwcm9wcmlhdGVseS4gRm9yIG91ciBIU0Ugc3RvcmFnZSBlbmdp
bmUgYXBwbGljYXRpb24sDQp0aGUgU1NUYWJsZXMgaW4gdGhlIHJvb3QvaW50ZXJtZWRpYXRlIGxl
dmVscyBhY3RzIGFzIGEgcm91dGluZyB0YWJsZSB0byByZWRpcmVjdCBxdWVyaWVzIHRvDQphbiBh
cHByb3ByaWF0ZSBsZWFmIGxldmVsIFNTVGFibGUsIGluIHdoaWNoIGNhc2UsIHRoZSBtY2FjaGUg
bWFwIGNvcnJlc3BvbmRpbmcgdG8gdGhlDQpyb290L2ludGVybWVkaWF0ZSBsZXZlbCBTU1RhYmxl
cyBjYW4gYmUgdGFnZ2VkIGFzIHBpbm5lZC9ob3QuDQoNClRoZSBtY2FjaGUgcmVhcGVyIHRyYWNr
cyB0aGUgYWNjZXNzIHRpbWUgb2YgZWFjaCBvYmplY3QgaW4gYW4gbWNhY2hlIG1hcC4gT24gbWVt
b3J5DQpwcmVzc3VyZSwgdGhlIGFjY2VzcyB0aW1lIGlzIGNvbXBhcmVkIHRvIGEgdGltZS10by1s
aXZlIG1ldHJpYyB0aGF04oCZcyBzZXQgYmFzZWQgb24gdGhlDQptYXDigJlzIHRlbXBlcmF0dXJl
LCBob3cgY2xvc2UgaXMgdGhlIGZyZWUgbWVtb3J5IHRvIHRoZSBsb3cgYW5kIGhpZ2ggd2F0ZXJt
YXJrcyBldGMuDQpJZiB0aGUgb2JqZWN0IHdhcyBsYXN0IGFjY2Vzc2VkIG91dHNpZGUgdGhlIHR0
bCB3aW5kb3csIGl0cyBwYWdlcyBhcmUgZXZpY3RlZCBmcm9tIHRoZQ0KcGFnZSBjYWNoZS4NCg0K
V2UgYWxzbyBhcHBseSBhIGZldyBvdGhlciB0ZWNobmlxdWVzIGxpa2UgdGhyb3R0bGluZyB0aGUg
cmVhZGFoZWFkcyBhbmQgYWRkaW5nIGEgZGVsYXkNCmluIHRoZSBwYWdlIGZhdWx0IGhhbmRsZXIg
dG8gbm90IG92ZXJ3aGVsbSB0aGUgcGFnZSBjYWNoZSBkdXJpbmcgbWVtb3J5IHByZXNzdXJlLg0K
DQpJbiB0aGUgd29ya2xvYWRzIHRoYXQgd2UgcnVuLCB3ZSBoYXZlIG5vdGljZWQgc3RhbGxzIHdo
ZW4ga3N3YXBkIGRvZXMgdGhlIHJlY2xhaW0gYW5kDQp0aGF0IGltcGFjdHMgdGhyb3VnaHB1dCBh
bmQgdGFpbCBsYXRlbmNpZXMgYXMgZGVzY3JpYmVkIGluIG91ciBsYXN0IGVtYWlsLiBUaGUgbWNh
Y2hlDQpyZWFwZXIgcnVucyBwcm9hY3RpdmVseSBhbmQgY2FuIG1ha2UgYmV0dGVyIHJlY2xhaW0g
ZGVjaXNpb25zIGFzIGl0IGlzIGRlc2lnbmVkIHRvDQphZGRyZXNzIGEgc3BlY2lmaWMgY2xhc3Mg
b2Ygd29ya2xvYWRzLg0KDQpXZSBkb3VidCB3aGV0aGVyIHRoZSBzYW1lIG1lY2hhbmlzbXMgY2Fu
IGJlIGVtcGxveWVkIGluIHRoZSB2YW5pbGxhIHBhZ2UgY2FjaGUgYXMNCml0IGlzIGRlc2lnbmVk
IHRvIHdvcmsgZm9yIGEgd2lkZSB2YXJpZXR5IG9mIHdvcmtsb2Fkcy4NCg0KPiA+ICg0KSBtcG9v
bCdzIGltbXV0YWJsZSBvYmplY3QgbW9kZWwgYWxsb3dzIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBj
b25jdXJyZW50DQo+IHJlYWRpbmcNCj4gPiBvZiBvYmplY3QgZGF0YSBkaXJlY3RseSBhbmQgbWVt
b3J5LW1hcHBlZCB3aXRob3V0IGEgcGVyZm9ybWFuY2UgcGVuYWx0eSB0bw0KPiB2ZXJpZnkNCj4g
PiBjb2hlcmVuY2UuIFRoaXMgYWxsb3dzIGJhY2tncm91bmQgb3BlcmF0aW9ucywgc3VjaCBhcyBM
U00tdHJlZSBjb21wYWN0aW9uLA0KPiB0bw0KPiA+IG9wZXJhdGUgZWZmaWNpZW50bHkgYW5kIHdp
dGhvdXQgcG9sbHV0aW5nIHRoZSBwYWdlIGNhY2hlLg0KDQo+IEhvdyBpcyB0aGlzIGRpZmZlcmVu
dCB0aGFuIGV4aXN0aW5nIGJhY2tncm91bmQgb3BlcmF0aW9ucyAvIGRlZnJhZw0KPiB0aGF0IGZp
bGVzeXN0ZW1zIHBlcmZvcm0gdG9kYXk/IFdoZXJlIGFyZSB0aGUgb3Bwb3J0dW5pdGllcyB0byBp
bXByb3ZlDQo+IHRob3NlIG9wZXJhdGlvbnM/DQoNCldlIGhhdmVu4oCZdCBtZWFzdXJlZCB0aGUg
YmVuZWZpdCBvZiBlbGltaW5hdGluZyB0aGUgY29oZXJlbmNlIGNoZWNrLCB3aGljaCBpc27igJl0
IG5lZWRlZA0KaW4gb3VyIGNhc2UgYmVjYXVzZSBvYmplY3RzIGFyZSBpbW11dGFibGUuIEhvd2V2
ZXIgdGhlIG9wZW4oMikgZG9jdW1lbnRhdGlvbiBtYWtlcw0KdGhlIHN0YXRlbWVudCB0aGF0IOKA
nGFwcGxpY2F0aW9ucyBzaG91bGQgYXZvaWQgbWl4aW5nIG1tYXAoMikgb2YgZmlsZXMgd2l0aCBk
aXJlY3QgSS9PIHRvDQp0aGUgc2FtZSBmaWxlc+KAnSwgd2hpY2ggaXMgd2hhdCB3ZSBhcmUgZWZm
ZWN0aXZlbHkgZG9pbmcgd2hlbiB3ZSBkaXJlY3RseSByZWFkIGZyb20gYW4NCm9iamVjdCB0aGF0
IGlzIGFsc28gaW4gYW4gbWNhY2hlIG1hcC4NCg0KPiA+ICg1KSBSZXByZXNlbnRpbmcgYW4gbXBv
b2wgYXMgYSAvZGV2L21wb29sLzxtcG9vbC1uYW1lPiBkZXZpY2UgZmlsZQ0KPiBwcm92aWRlcyBh
DQo+ID4gY29udmVuaWVudCBtZWNoYW5pc20gZm9yIGNvbnRyb2xsaW5nIGFjY2VzcyB0byBhbmQg
bWFuYWdpbmcgdGhlIG11bHRpcGxlDQo+IHN0b3JhZ2UNCj4gPiB2b2x1bWVzLCBhbmQgaW4gdGhl
IGZ1dHVyZSBwbWVtIGRldmljZXMsIHRoYXQgbWF5IGNvbXByaXNlIGFuIGxvZ2ljYWwgbXBvb2wu
DQoNCj4gQ2hyaXN0b3BoIGFuZCBJIGhhdmUgdGFsa2VkIGFib3V0IHJlcGxhY2luZyB0aGUgcG1l
bSBkcml2ZXIncw0KPiBkZXBlbmRlbmNlIG9uIGRldmljZS1tYXBwZXIgZm9yIHBvb2xpbmcuIFdo
YXQgZXh0ZW5zaW9ucyB3b3VsZCBiZQ0KPiBuZWVkZWQgZm9yIHRoZSBleGlzdGluZyBkcml2ZXIg
YXJjaD8NCg0KbXBvb2wgZG9lc27igJl0IGV4dGVuZCBhbnkgb2YgdGhlIGV4aXN0aW5nIGRyaXZl
ciBhcmNoIHRvIG1hbmFnZSBtdWx0aXBsZSBzdG9yYWdlIHZvbHVtZXMuDQoNCk1wb29sIGltcGxl
bWVudHMgdGhlIGNvbmNlcHQgb2YgbWVkaWEgY2xhc3Nlcywgd2hlcmUgZWFjaCBtZWRpYSBjbGFz
cyBjb3JyZXNwb25kcw0KdG8gYSBkaWZmZXJlbnQgc3RvcmFnZSB2b2x1bWUuIENsaWVudHMgc3Bl
Y2lmeSBhIG1lZGlhIGNsYXNzIHdoZW4gY3JlYXRpbmcgYW4gb2JqZWN0IGluDQphbiBtcG9vbC4g
bXBvb2wgY3VycmVudGx5IHN1cHBvcnRzIG9ubHkgdHdvIG1lZGlhIGNsYXNzZXMsIOKAnGNhcGFj
aXR54oCdIGZvciBzdG9yaW5nIGJ1bGsNCm9mIHRoZSBvYmplY3RzIGJhY2tlZCBieSwgZm9yIGlu
c3RhbmNlLCBRTEMgU1NEcyBhbmQg4oCcc3RhZ2luZ+KAnSBmb3Igc3RvcmluZyBvYmplY3RzDQpy
ZXF1aXJpbmcgbG93ZXIgbGF0ZW5jeS9oaWdoZXIgdGhyb3VnaHB1dCBiYWNrZWQgYnksIGZvciBp
bnN0YW5jZSwgM0RYUCBTU0RzLiANCg0KQW4gbXBvb2wgaXMgYWNjZXNzZWQgdmlhIHRoZSAvZGV2
L21wb29sLzxtcG9vbC1uYW1lPiBkZXZpY2UgZmlsZSBhbmQgdGhlDQptcG9vbCBkZXNjcmlwdG9y
IGF0dGFjaGVkIHRvIHRoaXMgZGV2aWNlIGZpbGUgaW5zdGFuY2UgdHJhY2tzIGFsbCBpdHMgYXNz
b2NpYXRlZCBtZWRpYQ0KY2xhc3Mgdm9sdW1lcy4gbXBvb2wgcmVsaWVzIG9uIGRldmljZSBtYXBw
ZXIgdG8gcHJvdmlkZSBwaHlzaWNhbCBkZXZpY2UgYWdncmVnYXRpb24NCndpdGhpbiBhIG1lZGlh
IGNsYXNzIHZvbHVtZS4NCg==
