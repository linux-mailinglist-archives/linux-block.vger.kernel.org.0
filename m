Return-Path: <linux-block+bounces-5815-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4116D899706
	for <lists+linux-block@lfdr.de>; Fri,  5 Apr 2024 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653481C22BD6
	for <lists+linux-block@lfdr.de>; Fri,  5 Apr 2024 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA76142636;
	Fri,  5 Apr 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R3UgTOM+"
X-Original-To: linux-block@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2119.outbound.protection.outlook.com [40.107.237.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110031422B6
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303562; cv=fail; b=HstHLGCuYqPRQaqyIOwptqlqOVJLW2/O+eBIjddZP8FN/kaQO4ZsRxewjiCtlVSAuDlziK0hN4CwK7EFkU+tOh3lMTyKsMSiE6UZtBvfVruj5QpPhPg9wriiGbNMGxt1fzPTMZpTmzSQe7fnxF9etPQ4NCPtyyk/y3oskUqkkwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303562; c=relaxed/simple;
	bh=8eT0eYgm8xHF4opTUkvFBEw1OARyU3Zz1sg4epvc/V4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WfPPTRNx1Hkgnd/51lfqm7gNVSAFXZg14oQcPdn7COitCEoGkZOehTcNwe9s8YfhefX3VBlQb6ST0hJLYZV8UjitKWymy2vibjYKoVFRsC6wMy36B//9c34P9H7JAZ2jR5CwKZyDH7O6JHc7f3Mnuxi0ge1c3dIBnoYPHfh7h+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R3UgTOM+; arc=fail smtp.client-ip=40.107.237.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4wiouMtoDM9rfMgMiRV8mFyUls/1tCs9nJObMLk/7KZZTwHjGqsekF8N7VNSNjo3pb4k97QiFVLiEVOHSFKWicJqh0suOM0h8NE/Cp+AN6kTre/ExkQUkzIL9cF5hW49CDIvMFu1Ia5BNOqvbEUdijNVP9dAB0a6ZoeM8A9tDtlSlZXVtjYcDWvQK/cJQ+JGKdKFmb/ByAJ7Uy5kfgeBoRNBTUZ9f6Ew9WefemqBK+YHIBUTJO+R5bBxdaUa9tvgIKXFNkRFY/kcJwOz2zJGNhwsTwEycGloynBlyor5o3l8uKlmvFYWywuPEA7tds9XTZVmIHh3pIduGif3po/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eT0eYgm8xHF4opTUkvFBEw1OARyU3Zz1sg4epvc/V4=;
 b=Bc09E9rIc6JIpVvJ/yH3AizdX1cMcuFtdVIKB/E+M56qGlmwXjcPbjJnEUAAE8Olh+G4BhuhI1V1AlxYB3YEyph4x6cM4bKje6Cx72alyG9ys+dTGitY5hTKR2QYoim2rh4+QcZ93x4iANPKWMrrgMXa44/n3HD/08LzSunYL8tghvc3asLNdapvQkTuaAXVatd8g9XsYRXk9I7aFHSDlZv+eQ92+R/FWtGLZfwGajkoVoCeCm3vQdcK2GiEQpOJvD5j8YAQYrT72y1sMz9qYiM+0CmZnJWMzy/gIo0OotpBn7aqlhu1IsOvE8gowkfH5EvGBmFbUz1/YdZJ/04+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eT0eYgm8xHF4opTUkvFBEw1OARyU3Zz1sg4epvc/V4=;
 b=R3UgTOM+fr9syh5KLlE1/3YmCysRi1FyGBMbv0q8VuGybmePKFOv+6gV4aGtCx0IiU7zhzQlDHEVdRzP0DtnSNIERUZM8Can+fGZZecPNMAATRANMNb5VbDViFjn9jD31Ht5UbMXXK1PG+2FVfAwk9HKz/iNMMpRKz/3O3/BOnnM7py9+c2lOiKvKLqcMhNboeU0462WO2VAG59gL8gjh2uzosHRioC/UpUCzNKpPbbQC4ayz8Gcdaz5SzCzmBDh2W7BEajIB4lEWd/O2WeXE0FZWhDp9ebCGrOSORAFFwhj7zebExvdCTjghNsjk9gd+AI7iUto664RtQdfV9nIGQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Fri, 5 Apr
 2024 07:52:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 07:52:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Index: AQHahvyWiheVndYbAU2CjNmML0/vjLFZTnqA
Date: Fri, 5 Apr 2024 07:52:36 +0000
Message-ID: <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
References: <20240405015657.751659-1-saranyamohan@google.com>
In-Reply-To: <20240405015657.751659-1-saranyamohan@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7137:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ngQQGPb24uOSDiK+pdCo7RVIm8ONQXTdJg5SwjP1bVeqw1jNLbjWEl2FZHBijbHUX9ggXG0TkJHEm54psXEL8ytcMqvI1dyukAe5XsJOV8KtappE9PIUl7phfiZWw840N7CpjaxE5q8GXGQlPpw6yaY/jjlBqQrGBtZefCCkUjkVK9K951MijBKAEjv32FADjw/n0HWe5f1QiqeDbP0BW/obAs/2Raz0Zi1yJm8pyKDzyvBeP6Jiae8oSt4tvn35vxcdOocKtBcYyFXRUtOAqQV3+7Mg0dTy5pNT7C8pZcw7mTPd7JgS5b/SWYrqFnE54h7T9WWIUY+l/bPUIy1f9fge6ZrCtFWikKgeF/28xE8rAqLjhAF0fjfNd/9ZQOQplfzoLl8Cb7a55+/XXz9KNpt5TrNq4KApD8MFhVUNNXVybYjq3z7Jh9dc+Vj1WlhXVgha9obF/KZ0yg/0guJz9sXd8dhBlXCVw5AtjCxXMvqd+hLrH8Y8SBNLTCa9BZ7mSfpO7iGDndv7TQlHAjjQbsAY7DyWunZeW72k1b1rr5dcrHsiUyvxXGWG/25NqwmNY2tcTCEWNm2S4v8lI1mDF0RkzGoWifkf8aPxiSL4CoFz/ssX8TqmwBYdsVU4fnCQdIx8ZwsrBXf63Ym4VTK/t258bvWPw1oQM7Z42JPLSXU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkNWVDZyaUdYdEE3UzZQK0pHalk4dXh1R3BFOXhEdXJOL0JQeFkyc3RnMzR3?=
 =?utf-8?B?Q3hwSnZMVE51UStQTTMyUzk0MURzdVVLSXFEdUkzMkJWRzhJenZrQ0ZJc0ZG?=
 =?utf-8?B?K0dtdXl0NU5Qc3c0d09kdGdoR0F5SzVQTlllMDVYMzBubGFQMzJTUXZuRkVs?=
 =?utf-8?B?Z05QUkNLajBkaXdGWkhlelhtb0RwN0ZqOGg0WVk2RFJvRVd0WjFpeThMZmFT?=
 =?utf-8?B?cUpXZTJIRTQ1SklMVWsxNFZnV29OazFld2xZYVlFY2g4WjJLTDhsQUpRNEVp?=
 =?utf-8?B?Mkh5bzJIVUk4eU1jZ2tYcE1LaHMrN2VkakFlODZnQWtHdTNSbFFXWFZtOXFF?=
 =?utf-8?B?dEtVam9CU2tlNTAxQmtzWDMxRzRncWsrdXdRczJDM2ZHb29UVko3MGladjgy?=
 =?utf-8?B?K3N6MExXWm9XMnVHdGZwcHdpelQzVXpJSWpBWDdzS05zczdZRE9CeSt3UzU4?=
 =?utf-8?B?SUt4dWxLVk5xQUVsU1VndE5QcUZ6WGpwSWdUSjZ1Y2w5bERwOXV4YUc5RDF0?=
 =?utf-8?B?M2gxUUQ0cDRpZ29PVTVQOWdWeEhnTmw4NGt2YjNnYWYxOHhGSVIra0lrUm84?=
 =?utf-8?B?OHNaVVQ1S3JSSklhdzhGS0lJeEZQVWRkaTMxYjJSV3kvZC9NSlB6TlFWYkxV?=
 =?utf-8?B?Snk0cUppNUVrVlVHZFE5ZkV0UkxVaVB4WjkwNWFpcGc5aDVNSndJN1o4dEw1?=
 =?utf-8?B?QjltRUR5eVRIWnJHK2NmRVRCSXRsQ0EyLzlJVEdXZ0pDWEtpYmVNSXIwWjJ1?=
 =?utf-8?B?OEwyWEVMWll3WkVMVitrR1NxQVZLOGNwN2JwSzhiUHBFSURwelBUZjd0NlI5?=
 =?utf-8?B?TTMzSzFDTlB6SU50TVhJUktINDlic05BYU8rNVVsQnZhQzJCV0NZbU8vdml1?=
 =?utf-8?B?WGgwQnVzLzJnWDBxM3laRFErODBoQ3dCSkFXZUFvc3Rhdlk2Qi96eGhYdDN6?=
 =?utf-8?B?ZEUyLzQ4Sy9leGhSd1lKTDZCRHRXVUVRL0dIN0l1YWRFNDVwOWlCc2tocGFv?=
 =?utf-8?B?Wmd6S3o3UU83WjBoM3NVb1VwT3VyTFRZVnBZU2hGNXJ4ZEdLU3F2dzVOWUt3?=
 =?utf-8?B?OVRXdk56dlFTVFlRdUYvN250WUxnTTBDcXUxa2lOVlFuVUlWRmtJUTQ3Rmwx?=
 =?utf-8?B?TXdvbU4wV3QwSUh2YlBPWk5vY1FPdUhCME1oemVGQmgwQVVOUDl5TUNXU2lJ?=
 =?utf-8?B?SnpySTQ2b0dpNGxsemJDdlp3Sm42dGorUXhZTW5GKzFLbS9Jcm5aTXZRNVBD?=
 =?utf-8?B?SWQvRWdrWEcxRklFc1V0TmtuTmlnSTFSZ2FYUEt3TWdUZWpIWmQ1RzBHQ29i?=
 =?utf-8?B?dzdSUG4wMy9BWitVT2xHT2dLWVpGS2EyanFYT2Q4aGVxY2ZzV1ZWYy8zUU9h?=
 =?utf-8?B?b2RvQjR6RzVTdDB4ZUJ1R0FZSVRBRDBWUUhPS3c5WElJd3BMNDlNWGRmY3Rj?=
 =?utf-8?B?cTRRNTR6Vnl4SUdNZkppQ2w0RzI5UHc0NHpIS1JPL0xWbFhzbHI1dS8xNWZ4?=
 =?utf-8?B?YSsxWEljNjF1WUdIR2NIbStpejQwUEV2K0lEVE1qRTFIVHlFNFFkcWgxam5v?=
 =?utf-8?B?eDl0aEJ4YW1BV0dGS080UUdQeHVKZThzVlExZ1ZNRVVWZzd4NnkrcHBhRjlj?=
 =?utf-8?B?VG8vOEt0STJSbjU1SC9CeFlTaWt2VGc4QVF4WEduWTdqMVJ0WHFnRy9VdkY2?=
 =?utf-8?B?MjNoNzJ1bktvZnAyZkhaTGI2cFpWSERpM05EUkc0WGJsdnF0Y2xpOVA0TW9i?=
 =?utf-8?B?M1ZuMEM0V3VrT1VZcSs2ajJQN0pXdTIrOTBjbUJyN1FUd3RzZHhxMUhKSG9o?=
 =?utf-8?B?YU9rK0dLdUtzRUJoa0Vnb0VIMjBhZGJ0MENxcExpc1pxdEJ4TEY5RGxGOEhY?=
 =?utf-8?B?bTlSamRjQXd0UkJWY0Jackh1b0tUOS9sYllETmVnR040Y1BKYXRabjhHZXdu?=
 =?utf-8?B?SGNGVzc1YmdUWW85dTlpWFQ3MUFtbElERzViQm1lcWsvampKYnFaSVF6UVJa?=
 =?utf-8?B?eE42dURIclJNeU55OStkV05zckJQbVhhVzYyZjBKNlNSQnpXUWpjRGdHZVlk?=
 =?utf-8?B?c09Ma3ZoNVdLbjkvaG8rUXJTWjAraDZwZ0NVVlRwZEFaRXRaRE1GMTVkZGNE?=
 =?utf-8?B?RjhNNFNUeVFBbVFRZ3lBaFB3N1EzQzNZV28xSEh2MzZ2Y2ZTZlFNaG1aNk9l?=
 =?utf-8?Q?LoMyjHlYjHhKS/NtUrTgNo9scXd/vo8l9BH73p7W1t/z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E01B33BCC69C747AA0567157C93F2CF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab98568-5b19-450e-e0fb-08dc55455bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 07:52:36.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +xnCT1QDcjMGBno2chBWxM6T0XfQ8KqTBICqNM/jfaH8u1r6Lob1ds2aAXVnWFgYPrb+8vjdN1SKDKKRcOIzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

KyBDQyBTaGluaWNoaXJvDQoNCk9uIDQvNC8yMDI0IDY6NTYgUE0sIFNhcmFueWEgTXVydWdhbmFu
ZGFtIHdyb3RlOg0KPiBXaGVuIHdlIGZhaWwgdG8gcmVyZWFkIHRoZSBwYXJ0aXRpb24gc3VwZXJi
bG9jayBmcm9tIHRoZSBkaXNrLCBkdWUgdG8NCj4gYmFkIHNlY3RvciBvciBiYWQgZGlzayBldGMs
IEJMS1JSUEFSVCBzaG91bGQgZmFpbCB3aXRoIEVJTy4NCj4gU2ltdWxhdGUgZmFpbHVyZSBmb3Ig
dGhlIGVudGlyZSBibG9jayBkZXZpY2UgYW5kIHJ1bg0KPiAiYmxvY2tkZXYgLS1yZXJlYWRwdCIg
YW5kIGV4cGVjdCBpdCB0byBmYWlsIGFuZCByZXR1cm4gRUlPIGluc3RlYWQgb2YNCj4gcGFzcy4N
Cj4gDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDQwNTAxNDI1My43
NDg2MjctMS1zYXJhbnlhbW9oYW5AZ29vZ2xlLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogU2FyYW55
YSBNdXJ1Z2FuYW5kYW0gPHNhcmFueWFtb2hhbkBnb29nbGUuY29tPg0KPiAtLS0NCj4gICB0ZXN0
cy9ibG9jay8wMzUgICAgIHwgODAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAgdGVzdHMvYmxvY2svMDM1Lm91dCB8ICA3ICsrKysNCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMv
YmxvY2svMDM1DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL2Jsb2NrLzAzNS5vdXQNCj4g
DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9ibG9jay8wMzUgYi90ZXN0cy9ibG9jay8wMzUNCj4gbmV3
IGZpbGUgbW9kZSAxMDA3NTUNCj4gaW5kZXggMDAwMDAwMC4uM2IzMDdmMQ0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL3Rlc3RzL2Jsb2NrLzAzNQ0KPiBAQCAtMCwwICsxLDgwIEBADQo+ICsjIS9i
aW4vYmFzaA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTMuMCsNCj4gKyMgQ29w
eXJpZ2h0IChDKSAyMDI0IFNhcmFueWEgTXVydWdhbmFuZGFtDQo+ICsjDQo+ICsjIFJlZ3Jlc3Np
b24gdGVzdCBmb3IgQkxLUlJQQVJULg0KPiArIw0KPiArIyBJZiB3ZSBmYWlsIHRvIHJlYWQgdGhl
IHBhcnRpdGlvbiB0YWJsZSBkdWUgdG8gYmFkIHNlY3RvciBvciBvdGhlciBJTw0KPiArIyBmYWls
dXJlcywgcnVubmluZyAiYmxvY2tkZXYgLS1yZXJlYWRwdCIgc2hvdWxkIGZhaWwgYW5kIHJldHVy
bg0KPiArIyAtRUlPLiAgT24gYSBidWdneSBrZXJuZWwsIGl0IHBhc3NlcyB1bmV4cGVjdGVkbHku
DQo+ICsNCj4gKy4gdGVzdHMvYmxvY2svcmMNCj4gKw0KPiArREVTQ1JJUFRJT049InRlc3QgcmV0
dXJuIEVJTyBmcm9tIEJMS1JSUEFSVCBmb3Igd2hvbGUtZGV2Ig0KPiArUVVJQ0s9MQ0KPiArREVC
VUdGU19NTlQ9Ii9zeXMva2VybmVsL2RlYnVnIg0KPiArDQo+ICsNCj4gK19oYXZlX2RlYnVnZnMo
KSB7DQo+ICsNCj4gKwlpZiBbWyAhIC1kIC9zeXMva2VybmVsL2RlYnVnIF1dOyB0aGVuDQo+ICsJ
CVNLSVBfUkVBU09OUys9KCJkZWJ1Z2ZzIGRvZXMgbm90IGV4aXN0IikNCj4gKwkJcmV0dXJuIDEN
Cj4gKwlmaQ0KPiArCXJldHVybiAwDQo+ICt9DQo+ICsNCj4gK3JlcXVpcmVzKCkgew0KPiArCV9o
YXZlX2RlYnVnZnMNCj4gK30NCj4gKw0KPiArDQo+ICthbGxvd19mYWlsX21ha2VfcmVxdWVzdCgp
DQo+ICt7DQo+ICsgICAgWyAtZiAiJERFQlVHRlNfTU5UL2ZhaWxfbWFrZV9yZXF1ZXN0L3Byb2Jh
YmlsaXR5IiBdIFwNCj4gKwl8fCBfbm90cnVuICIkREVCVUdGU19NTlQvZmFpbF9tYWtlX3JlcXVl
c3QgXA0KPiArIG5vdCBmb3VuZC4gU2VlbXMgdGhhdCBDT05GSUdfRkFJTF9NQUtFX1JFUVVFU1Qg
a2VybmVsIGNvbmZpZyBvcHRpb24gbm90IGVuYWJsZWQiDQo+ICsNCj4gKyAgICBlY2hvICJBbGxv
dyBnbG9iYWwgZmFpbF9tYWtlX3JlcXVlc3QgZmVhdHVyZSINCg0KSSBkb24ndCB0aGluayB3ZSBu
ZWVkIGFib3ZlIHByaW50DQoNCj4gKyAgICBlY2hvIDEwMCA+ICRERUJVR0ZTX01OVC9mYWlsX21h
a2VfcmVxdWVzdC9wcm9iYWJpbGl0eQ0KPiArICAgIGVjaG8gOTk5OTk5OSA+ICRERUJVR0ZTX01O
VC9mYWlsX21ha2VfcmVxdWVzdC90aW1lcw0KPiArICAgIGVjaG8gMCA+ICAvc3lzL2tlcm5lbC9k
ZWJ1Zy9mYWlsX21ha2VfcmVxdWVzdC92ZXJib3NlDQo+ICsNCj4gKyAgICBlY2hvICJGb3JjZSBU
RVNUX0RFViBkZXZpY2UgZmFpbHVyZSINCg0Kc2FtZSBoZXJlDQoNCj4gKyAgICBlY2hvIDEgPiAv
c3lzL2Jsb2NrLyQoYmFzZW5hbWUgJHtURVNUX0RFVn0pL21ha2UtaXQtZmFpbA0KPiArDQo+ICt9
DQo+ICsNCj4gK2Rpc2FsbG93X2ZhaWxfbWFrZV9yZXF1ZXN0KCkNCj4gK3sNCj4gKyAgICBlY2hv
ICJNYWtlIFRFU1RfREVWIGRldmljZSBvcGVyYXRhYmxlIGFnYWluIg0KDQpzYW1lIGhlcmUNCg0K
PiArICAgIGVjaG8gMCA+IC9zeXMvYmxvY2svJChiYXNlbmFtZSAke1RFU1RfREVWfSkvbWFrZS1p
dC1mYWlsDQo+ICsNCj4gKyAgICBlY2hvICJEaXNhbGxvdyBnbG9iYWwgZmFpbF9tYWtlX3JlcXVl
c3QgZmVhdHVyZSINCg0Kc2FtZSBoZXJlDQoNCj4gKyAgICBlY2hvIDAgPiAkREVCVUdGU19NTlQv
ZmFpbF9tYWtlX3JlcXVlc3QvcHJvYmFiaWxpdHkNCj4gKyAgICBlY2hvIDAgPiAkREVCVUdGU19N
TlQvZmFpbF9tYWtlX3JlcXVlc3QvdGltZXMNCj4gK30NCj4gKw0KPiArDQo+ICt0ZXN0X2Rldmlj
ZSgpIHsNCj4gKwllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCj4gKw0KPiArCWFsbG93X2Zh
aWxfbWFrZV9yZXF1ZXN0DQo+ICsNCj4gKwkjIENoZWNrIHJlcmVhZGluZyBwYXJ0aXRpb25zIG9u
IGJhZCBkaXNrIGNhbm5vdCBvcGVuIC9kZXYvc2RjOiBJbnB1dC9vdXRwdXQgZXJyb3INCj4gKwls
b2NhbCBvdXQ9JChibG9ja2RldiAtLXJlcmVhZHB0ICR7VEVTVF9ERVZ9IDI+JjEpDQo+ICsJZWNo
byAkb3V0IHwgZ3JlcCAtcSAiSW5wdXQvb3V0cHV0IGVycm9yIg0KPiArCWlmIFsgJD8gLWVxIDAg
XTsgdGhlbg0KPiArCQllY2hvICJSZXR1cm4gRUlPIGZvciBCTEtSUlBBUlQgb24gYmFkIGRpc2si
DQo+ICsJZWxzZQ0KPiArCQllY2hvICJEaWQgbm90IHJldHVybiBFSU8gZm9yIEJMS1JSUEFSVCBv
biBiYWQgZGlzayINCj4gKwlmaQ0KPiArDQo+ICsJZWNobyAkb3V0ID4+ICIkRlVMTCINCj4gKwlz
dGF0dXM9JD8NCj4gKwkNCj4gKwlkaXNhbGxvd19mYWlsX21ha2VfcmVxdWVzdA0KPiArDQoNCmlu
c3RlYWQgb2YgZGlzYWxsb3cgZmFpbCBtYWtlIHJlcXVlc3QgY29tcGxldGVseSwgd2UgbmVlZCB0
byBzYXZlIHRoZQ0KZXhpc3RpbmcgY29uZmlndXJhdGlvbiBiZWZvcmUgY2FsbGluZyBhbGxvd19m
YWlsX21ha2VfcmVxdWVzdCBhbmQgDQpyZXN0b3JlIHRoYXQgc2F2ZWQgY29uZmlndXJhdGlvbiBo
ZXJlLCB1bmxlc3MgdGhlcmUgaXMgYSBzcGVjaWZpYyByZWFzb24NCmZvciBub3QgZG9pbmcgdGhh
dCB3aGljaCBJIGRpZG4ndCB1bmRlcnN0YW5kIC4uDQoNCj4gKwllY2hvICJUZXN0IGNvbXBsZXRl
Ig0KPiArfQ0KPiArDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9ibG9jay8wMzUub3V0IGIvdGVzdHMv
YmxvY2svMDM1Lm91dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwLi4z
ZmJmZDc3DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvYmxvY2svMDM1Lm91dA0KPiBA
QCAtMCwwICsxLDcgQEANCj4gK1J1bm5pbmcgYmxvY2svMDM1DQo+ICtBbGxvdyBnbG9iYWwgZmFp
bF9tYWtlX3JlcXVlc3QgZmVhdHVyZQ0KPiArRm9yY2UgVEVTVF9ERVYgZGV2aWNlIGZhaWx1cmUN
Cj4gK1JldHVybiBFSU8gZm9yIEJMS1JSUEFSVCBvbiBiYWQgZGlzaw0KPiArTWFrZSBURVNUX0RF
ViBkZXZpY2Ugb3BlcmF0YWJsZSBhZ2Fpbg0KPiArRGlzYWxsb3cgZ2xvYmFsIGZhaWxfbWFrZV9y
ZXF1ZXN0IGZlYXR1cmUNCj4gK1Rlc3QgY29tcGxldGUNCg0KDQpJIGZvdW5kIHNldmVyYWwgc2hl
bGxjaGVjayB3YXJuaW5ncywgcGxlYXNlIGNvbnNpZGVyIGZpeGluZyB0aG9zZSB1bmxlc3MNCnRo
ZXkgYXJlIGtlcHQgZm9yIGEgcmVhc29uICh3aGljaCBJIGRpZG4ndCB1bmRlcnN0YW5kIHdoeSks
IHRoZW4NCmNvbnNpZGVyIGRpc2FibGluZyBpdCB3aXRoIHJpZ2h0IHNoZWxsY2hlY2sgZGlyZWN0
aXZlIHdpdGggYXBwcm9wcmlhdGUNCmNvbW1lbnQgc3VwcG9ydGluZyByZWFzb246LQ0KDQp0ZXN0
cy9ibG9jay8wMzU6NDQ6MjU6IHdhcm5pbmc6IFF1b3RlIHRoaXMgdG8gcHJldmVudCB3b3JkIHNw
bGl0dGluZy4gDQpbU0MyMDQ2XSANCnRlc3RzL2Jsb2NrLzAzNTo0NDozNjogbm90ZTogRG91Ymxl
IHF1b3RlIHRvIHByZXZlbnQgZ2xvYmJpbmcgYW5kIHdvcmQgDQpzcGxpdHRpbmcuIFtTQzIwODZd
IA0KdGVzdHMvYmxvY2svMDM1OjUxOjI1OiB3YXJuaW5nOiBRdW90ZSB0aGlzIHRvIHByZXZlbnQg
d29yZCBzcGxpdHRpbmcuIA0KW1NDMjA0Nl0gDQp0ZXN0cy9ibG9jay8wMzU6NTE6MzY6IG5vdGU6
IERvdWJsZSBxdW90ZSB0byBwcmV2ZW50IGdsb2JiaW5nIGFuZCB3b3JkIA0Kc3BsaXR0aW5nLiBb
U0MyMDg2XSANCnRlc3RzL2Jsb2NrLzAzNTo2NTo4OiB3YXJuaW5nOiBEZWNsYXJlIGFuZCBhc3Np
Z24gc2VwYXJhdGVseSB0byBhdm9pZCANCm1hc2tpbmcgcmV0dXJuIHZhbHVlcy4gW1NDMjE1NV0g
DQp0ZXN0cy9ibG9jay8wMzU6NjU6MzQ6IG5vdGU6IERvdWJsZSBxdW90ZSB0byBwcmV2ZW50IGds
b2JiaW5nIGFuZCB3b3JkIA0Kc3BsaXR0aW5nLiBbU0MyMDg2XSANCnRlc3RzL2Jsb2NrLzAzNTo2
Njo3OiBub3RlOiBEb3VibGUgcXVvdGUgdG8gcHJldmVudCBnbG9iYmluZyBhbmQgd29yZCANCnNw
bGl0dGluZy4gW1NDMjA4Nl0gDQp0ZXN0cy9ibG9jay8wMzU6Njc6Nzogbm90ZTogQ2hlY2sgZXhp
dCBjb2RlIGRpcmVjdGx5IHdpdGggZS5nLiAnaWYgDQpteWNtZDsnLCBub3QgaW5kaXJlY3RseSB3
aXRoICQ/LiBbU0MyMTgxXSANCnRlc3RzL2Jsb2NrLzAzNTo3Mzo3OiBub3RlOiBEb3VibGUgcXVv
dGUgdG8gcHJldmVudCBnbG9iYmluZyBhbmQgd29yZCANCnNwbGl0dGluZy4gW1NDMjA4Nl0gDQp0
ZXN0cy9ibG9jay8wMzU6NzQ6Mjogd2FybmluZzogc3RhdHVzIGFwcGVhcnMgdW51c2VkLiBWZXJp
ZnkgdXNlIChvciANCmV4cG9ydCBpZiB1c2VkIGV4dGVybmFsbHkpLiBbU0MyMDM0XQ0KDQotY2sN
Cg0KDQo=

