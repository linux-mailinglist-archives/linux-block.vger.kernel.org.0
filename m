Return-Path: <linux-block+bounces-14797-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF8F9E10D8
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 02:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3886F163852
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 01:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C414084D;
	Tue,  3 Dec 2024 01:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="rihLDOaP"
X-Original-To: linux-block@vger.kernel.org
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A9A4C60B
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733189903; cv=fail; b=qPK6u1l2oZSb3J1nIzCNK2wptU/L+5MiYSFKPIBJhq9ajo9QXqIiLmSRmpqafiPXhTGE0rT3YmuC72kQQxLU+JyotzVXXLfGAwAxjeUsAsAfc2uQJT6XnojjXIS9GPEwukOvkJC4cH1tc570lw3ZPvOBkEP1Faj+TQVuguiJTsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733189903; c=relaxed/simple;
	bh=jG2BIW0y+qx5v+h8UuXcBfUhhS4G/99APzzeAXk4V1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GozHq7eVNgtzw9xb2g9kiNlL2KmtHP9phjCzqzTA6RA5+Dsjf86CdvlIuU6RE4iPQfoRfjWq6Gw/VTCRg97wUuQDAIMauFF+I3DDkAputIXSd3ItWTjN9f5yPiBEW6mKzkTO4TrHQ4M8VzEcAsaXk4RDE1S2NkgaZgUDxvDvKIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=rihLDOaP; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733189900; x=1764725900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jG2BIW0y+qx5v+h8UuXcBfUhhS4G/99APzzeAXk4V1k=;
  b=rihLDOaPp3CzsQNmnlnzJUHps3RD8lDBj/5zNCwDQSY7TRnR/IHOwqNm
   N+1vATznNYjbbLvxYTJSkDVOCr1Qr9JOVzmatNSzE0e2IGacC3HalS5bw
   7re/SxMka7v++3K8Ay0ReO5P2hmZmgkSjSZCbt0oWFEQZ8FcCxm52mUcl
   VYNy41+PVqNp5PU+juPkoNX11Pd7mI9BzxQcr6DjuQWJJ/eNpiMvlSudI
   iXuRv23r5bx5CaaZlWVc6DM6A/vANOpAFUEW66jhNYBLOgDnEb1/CaRZO
   VVsaBkhwlHIHjMSeU4bFiALXDmGJDQepZrfSV8s+alQytp1sLknJq9Ej2
   g==;
X-CSE-ConnectionGUID: ThkOAE6sRQelHLZ4iWEDTA==
X-CSE-MsgGUID: FSewrenRTiCQYbPw6vlLtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="138810337"
X-IronPort-AV: E=Sophos;i="6.12,204,1728918000"; 
   d="scan'208";a="138810337"
Received: from mail-japaneastazlp17011024.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.24])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 10:37:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbYereRaKVRzyjyv+a16IZzaPk5EoyZqfAeNI/b5X2iytQqAJOdod0Q7QBUC/s1IxXWLPrib2hx9hHlKAzW6RTomgpNlU2qZ9x9pNWQV4xi0Soo1RGBRQF0+A+VCxuZ0R1fuXfYpbSHE5sa5hcFolO1wpciAE0Nd2UaKbpnB/30dmeHQINzFMkWU36aqd1kuUxKWUtPXzV0sYlPs0+1KkXj1z38iAHDCTalw8bqOlgFBfmo08YwR0aN5C5GlZ9daN9q9OvLjrdAhIJ1D2MGUFpzqi5VLqc8cV7Qk69ISW5BBE2hDujwQ3gai7Zl+UfnHqKa6bWdbv5ZieHsuqnK39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jG2BIW0y+qx5v+h8UuXcBfUhhS4G/99APzzeAXk4V1k=;
 b=UzKQT+PYDlZj+RKgAOlWTz1wod0pDDyh6vvNTDaocMedCrh1x7YNUsY65Dd15909NPtH/ooa/ReqEJ1AT1lo5v64mrzBbwN1vJVdW05CRMo/GpbvRdMvIP6cgYii6jHqRI79zz2ULSj18Idv/q5ZWbm9jM4v+iXv5h1KDKj3TW++N0g2VysAXq2eybb4nAcNS2aFKlFTniz0t7o513TgJfebbUwzC9d7RCT0tbRvjZqLjBLTAkcpKq2uEmwBX+QRezR9IX2sm/Avw7jvu7H5/B207o9kYHXT6FO5wKvRhcO7gIBqB2ZjXYdKYrUUStiMzZt/ETQJfPPgwz+7LOnFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSCPR01MB12482.jpnprd01.prod.outlook.com (2603:1096:604:32b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 01:37:04 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 01:37:04 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [blktests] zbd/009 fails due to "No space left on device"
Thread-Topic: [blktests] zbd/009 fails due to "No space left on device"
Thread-Index: AQHbRR5IFWhFAyix6ES9S5kU/Jzbu7LTuqkAgAACz4A=
Date: Tue, 3 Dec 2024 01:37:04 +0000
Message-ID: <98177d3e-87a8-4993-a256-3b0c80bb1522@fujitsu.com>
References: <fecc3814-cc34-4349-8a51-98670d0d868d@fujitsu.com>
 <CAHj4cs_eaa5mGH=6JbZLC+f2wUZrKkWqCD37gtVW0_L+L3Pe-w@mail.gmail.com>
In-Reply-To:
 <CAHj4cs_eaa5mGH=6JbZLC+f2wUZrKkWqCD37gtVW0_L+L3Pe-w@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSCPR01MB12482:EE_
x-ms-office365-filtering-correlation-id: 3731f81b-7b37-4039-85a0-08dd133afdfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cUNEYS91eVRBZTgxM3lIWkc0Z3pRQWtOc3h0clora2s5SzFPSFVJeUhrNUR6?=
 =?utf-8?B?Y01PQWJEVUU5dHg1bXRNRHFFby9ST3JlbmZ5RlcrRVJNdDVSdTcvd3hKRjcx?=
 =?utf-8?B?TlV6Z1laVDVlMVZ5SG9xdkJ0WnJQR1gyc1BHazN0czduV3F1dEtDQlB5Mk1S?=
 =?utf-8?B?d1lMUnZGelA2NTM4NVFzYmQ5dFoyc0l3LytCMHpHT01CWVJPUjB5dEZkK0c0?=
 =?utf-8?B?WW96QVhtbEVKejU5Q2FFNnZnQm5QeHZ1eVJuYktMb0xZZUdyUGdpZW9NMU9E?=
 =?utf-8?B?UW1MbDRoSy90bm5UVGZoRWliLzJSRE5kOEY0clZpSjF6eTUwdVNEUU4yUHgz?=
 =?utf-8?B?dlpGTEZ3MXlCQkNQeWYveGZpNzN4a1RyK1dBd0R1MHowbnU4WWpremRtSkdS?=
 =?utf-8?B?YWxyTE1sUEM4a0dHckRqWTBBWHJDSGZpRGFzMXVMVStWUHNkNHFJcmFNNXBK?=
 =?utf-8?B?b1RGQ29qQktWRGV0em0xb3RMVGhYbXRjdm53MGtoN1RSREV3Tkl5Qko2VFJj?=
 =?utf-8?B?Szk2TjFJMWxaTkE4TU1UZFczeCt0d3RHeFFZUHFQQnNxZytsL1loNGF4NVBr?=
 =?utf-8?B?cTlYNlg5UHJNaG9wdW9OZ201S1MvSS93T2NKMUhscm1POExHYnBOSkNJNTZx?=
 =?utf-8?B?emVBWjRTczRKQkVzdzRmZ2ZhbWErbUg5MGMzYUZEYm1SZnVnZThIVUlqbnZT?=
 =?utf-8?B?bXdGWk1HV043aHZmYWw5ZTRkY0tHS0J1SmdlNnJ6YmZOQkM1T2x6SjFCb2U1?=
 =?utf-8?B?WTlDQjdDUDBpdCtJcFF6R1g5a3ZqKzk0STUrUXIvYlM4OWVSU0J4Yy9YeWYx?=
 =?utf-8?B?cUIwWEVyMFVzSUFlWXhoTWxzSXc4Ylp4L0xxK2hFRkpvdlZwZkxZZnVnWE1n?=
 =?utf-8?B?bUFscWdCV2ZLQzgySXNSUEE2UXJRYjgyWDFNWUZGN2tVdGV5VFBMdE9tWTd1?=
 =?utf-8?B?QXIxSFpWM0xvdFEvVENObmJvSkpRcmZvZ1ZVaTZxTEhlRmFwaUJSZFNzZmh1?=
 =?utf-8?B?U21qTXVKQVJ3Nlk0cG1SU1Nudkh3RzhSUXQ3WDI2eUQrL1dUVFBHZWFDdWJt?=
 =?utf-8?B?Q1RyNEw2azc5dkdMWWpyS0JhWHI2S0dhMWtWSEdXQzh4S0tWbFhaYThkczN3?=
 =?utf-8?B?ckp3aktlQjVhaEIyc2MyT0Z2YWtmbFBSWGlleDlzcXg1RERxbG5OWFV3QjFH?=
 =?utf-8?B?UkZWcFJoVkFvMldpSkZsYUJEUmhXWkRqMks1VXZYRitqUjZxSEJpZE5MYU5C?=
 =?utf-8?B?MmFxMDBxNmZlaFV4K1Fad2xTR0ZHOFRQY28xTVozWnd1dWxOZ091UnhETlhi?=
 =?utf-8?B?cFNTQWhTcklDUmJxVnJKbk8xdFpDRjlQS0txR1ZHQ3VkTXovOE9hd2UyVkFr?=
 =?utf-8?B?eGxNOTFUVnFwQTRxSXJiSnVwdFZldUtnQnRrNWxaeUZMd2tBOE5WeXlXT2lj?=
 =?utf-8?B?MHlWSGR0anFHdDJNdGNwS3NTeGxaY0Y1TEJ2ejFhYTFYOGVLL0REbVJpdDZR?=
 =?utf-8?B?TjFrcXZ1cTFISGdZWC93U3k0T1VQdHVyZHRJUElObUU3NDN0K3RCek5NV2xk?=
 =?utf-8?B?b1JKMzc0T2Rhckp0Lytod1llNFg1a1g5MEQ3YTY0VCsyZGZUc2ttNE9sbDUy?=
 =?utf-8?B?VGRPRE1lb0x4TXdhNDRKM0MwYWoveDJlTTVwZ3pPRHZ3UjR4NmRuMDd2dUVS?=
 =?utf-8?B?bXBsSnpjY3F1WnJQeGJRY0hDNmJZUkMwcTJyMXZ2ZWdudHBIMHFEZTlTWFdS?=
 =?utf-8?B?Sm5KcUVvNkRyRGoyeml4eno5TnBKOU1wOUNUb01HL2Nodms0Nk1kQ3RqUVdQ?=
 =?utf-8?B?ZGhJQk9MKzNVbVNXMDFvL1VYQ2E0WEt5eFZtY0Z1Vm9jTm5KRWZBcm0yeTcx?=
 =?utf-8?Q?QJrMaKEBplOLi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEdnbzJoRGE4UFZhcThtK1ZPNGZEL2ExcVEyaEJpd2VUK3FYWEpwWUJjYzVz?=
 =?utf-8?B?ZE95OU93bXpQNXRjcmt1eHdkdUlmZHFFMnRTTU85TXNYZFB5RTQ2anlVdWF0?=
 =?utf-8?B?K21jSE0wODBBbHFNQ1c5bW4rRVpNcHpWdmxqY1hWN3VtSlRjb1VCT2szdUFQ?=
 =?utf-8?B?ZTFtS2tSdUhuRTlHbVVOeDBPa2ZkSGF4N3dIZnRVZ2dWcG5GelVTTkpheWY1?=
 =?utf-8?B?a3JZaW5tWC8wRDhGak51NHJUQTF5WkdzZXNyaHR5YXZKWGlkMVUvT0ZENWto?=
 =?utf-8?B?TVpzVE9MWWI4UmM2ek1ud3RpbVprSEp4aFN2dENDaUk5Mk1kS1NxMHJmYU45?=
 =?utf-8?B?UzZ2RU5vMlJTSkRUQkJYVTBkaHhxM3pQQ2s2Q2ZaZ2E3SXZHQTdQUGVsK0d1?=
 =?utf-8?B?eVFlRjQ5WGVPZ2pkd1JlTm9KRnNSVXhBT21ia2xPZmd2SjFnN0pjMXJrcXl1?=
 =?utf-8?B?bWp3TlNWZlNRWDRDYVoxOHA3d2hpTnA3NHZ1b2xNZlNCcE1vV1JJbTJCemRr?=
 =?utf-8?B?VDd3WUV3bk9xNGFTMjYzcGg1UVNxUWIrcGlFM0NFNExBdUxtc1cvOUJSTGZI?=
 =?utf-8?B?b0FRVk5BMXNvVFhPRjNjckFrZVBZMU1aOTd5eFpmeVhQZzk0b0tDRW1KT1Er?=
 =?utf-8?B?RjJYckF6NE9SRDMrMXJTTUgzQTJDdFdTTW9FVTB6OFBxVlkyaGU4MzZrdVRu?=
 =?utf-8?B?bW8zY0FzVUFReCtBcUNsSFljSlo3cTBNUWVYVmVrQklKZ0tjYm8waVJCTXhq?=
 =?utf-8?B?N2YxSmRYQmk3VUpVc0Y3eDRIbWZ4ZU5NZGhYbnBrbU1aRlJHdVo5Q0RuTUVh?=
 =?utf-8?B?OTBiK0ZEdVhsWVdxNld3U2RTUGN4UEFvOEJVWGh5elZEZnVwNVFtSnlaWEdD?=
 =?utf-8?B?MEUzUnZWOEZVRmEwaU9MSlRrOHpoTWVSMktUajlDWkw2bm51L1lnanVUSjlT?=
 =?utf-8?B?WlllM2tBbDNHQ2dNdHp3ckVhbWR6QldsSTNyNHd0cy81SXdLWXU2STZqRkp4?=
 =?utf-8?B?M2dyMnBzSHU1UFN4a1hKYStSbVFmWngvb0JHRnhhUENuYm1URHhlbU9ibEIv?=
 =?utf-8?B?ZGtzR1VSNU9PNEFTb2RGeTE0TExnYU5qakhhL201bWo2QVBuaDB0VlhXYlBS?=
 =?utf-8?B?VWQrUm1tZ3lXSG5KMUJCVFEyclROcExPbW5MdjBtMVZLbWxwNFpMdnZ6K0RM?=
 =?utf-8?B?SzRjemJnWENsNjg5Tk5WWTNReDZSVTVDMHN4SUN6UnVSWkNVVlp3aUdmeEc1?=
 =?utf-8?B?M0pOK1NRUGFQUlJneng3Mm1KYUYxL0VEUFljTmxBZGJSWDdFYzFQODJkcmZn?=
 =?utf-8?B?RnVDQnFwUzNJZ1FrSzZodTVVVnpZdlFIV21vWjIxaGcxSFFMK0tEMStNTjZK?=
 =?utf-8?B?OHRjNTFKcDVIY01wL2MvK05uMXVhcjQvR1BjOVhiekZiOXVyRTFVcGw3SFhr?=
 =?utf-8?B?amh3OVNyV3B5aEZISkkrTGF4ellvNytSaE44NzhpK3RHV0luNGEvZVZYSDdv?=
 =?utf-8?B?Z0Q3MXFEWHlPQ0ZCbStJQmx5bDFLS2xHaTlpaUpWbzJxQkUyblUwTFZKS001?=
 =?utf-8?B?Yk5tSGsvS2kyQ2NEZVpYR3paN29mRkRzd3dLZzVEY0VlQXlBNXVWUmpQWTdI?=
 =?utf-8?B?ZU5DK2MrZ3lrR3d5RFVuUWQrczlsTW5IYTZoUXNndXp4R2RLQVNxSVJtbjdQ?=
 =?utf-8?B?L091OWtkMzZ6VEt1VkVnNkFFVDhPVjhBRktmNHVWcU1WY2hmS3c0dGxFL2h1?=
 =?utf-8?B?YWJuUG9IcFJQb3pCZnhlaWdrM3VQTVIxNEg5bVN2bWpsMFI3aEZvS1BzTFBk?=
 =?utf-8?B?S3U4aWZrejAvK1p6ZUtVbDlSYTB3LzNRRHo3dHpTdUh4RC80MUlWMTc1dGlY?=
 =?utf-8?B?ZVBpSzlQbGhBSVc0Q1FJbnk1K2tWY2JIUk5JMUpFeUNGZ0N0SnNXV2lvLzZI?=
 =?utf-8?B?ek5CTHlmWFVTVUZvLy91aEVrWnVKd2NRQWFVVGM2TlJFSk1lY0lBU3QvN0pY?=
 =?utf-8?B?ZTg4WGFGNXhUVnNEbGFlWndZUGc0TFBUOGxXbldTVUR0UHIzUTB1UFlFR0xZ?=
 =?utf-8?B?OWNSNEtZcEhCMm1xeHJwTFdHSzlzVjU3Ylg0YmpDRGVPTDdNR2ZwaEUvaGc2?=
 =?utf-8?B?ZWRaR1YvTmdEOE16SVdIclZNWnFXMGJvdTdLeDNKb1BvNzBjM3FEcHdtMzZK?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40D8022D082B3940A298245514673EB4@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fjuf8903zCVEwy6V1pzu3XkTGB9L1o1HuBEsWsrK0uHrr5vrp2QmGzn6Y1echST0fnkmwPRmwFRktUNc3me8z1rPTeUM78rFEgBs0B5lcWHM+er3djuIUvWTpK8hUsAn07rQz4jcsDAxGcC/AWEXS95B+vhe7pBmeVPOvfCd/QPCYcjwMjbLklYQ2EqmqwfKvWmoukIQ+vDjSq3SaDF8nwl4pbuN+M0pSNhkVuIwaf2QD5DhvWlWXH3sBq5eaafGTsi43px8uRCHXX/OL1Vi593lgzrI+I9QNB/4e/VctTvHK4L3m+sa6UBSWUlvtjYL6sEFSlkgJ1Apr44/Jjlj0bUr9/dHLa+bWDL9SOPbWyZ4XrNEBnjPYjEWyhrs64gdWpDRr6JRAXn4hudI87WaVVkLFMsTpJk9IGIAyYP7rS3oB2xcMHDPAKbbjocHRgQT0pcUvF4dEUKDUl483iTFP58QOnwfFQ3fHj33STYB24a1O1Ms9tMMm4NZZytGnEGh2ENsMzKihO5yQBPZlvErReqQSDClx8IOO9cUOCOrwNgjQAKdk9uk+a4Y/G11GNqye6ksAcNEhpb4aZpyMTLTP2qt4OPoOFnDsXnlH3K3F9EdO23v2eNY9Lm7jRUMztGN
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3731f81b-7b37-4039-85a0-08dd133afdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 01:37:04.6694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWc/I15+exDF0IPYVNfsvI1+Ji1iFBACQwhZYBUuc/v9vyTNpf9wQG8sdJKmgGe9CVDBz/hukn1DCouRREBhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12482

DQoNCk9uIDAzLzEyLzIwMjQgMDk6MjcsIFlpIFpoYW5nIHdyb3RlOg0KPiBIaSBaaGlqaWFuDQo+
IFNlZW1zIGl0J3Mgb25lIGJ0ZnMgaXNzdWUsIHlvdSBjYW4gZmluZCBtb3JlIGhlcmU6DQo+IA0K
PiBodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cy9pc3N1ZXMvMTUwDQoNCg0KWWVz
LCB0aGFuayB5b3UgZm9yIHlvdXIgaW5mb3JtYXRpb24uIFRoZXNlIHR3byBhcmUgaW5kZWVkIGR1
cGxpY2F0ZXMuDQoNClRoYW5rcw0KDQoNCg0KPiANCj4gT24gVHVlLCBEZWMgMywgMjAyNCBhdCA4
OjU44oCvQU0gWmhpamlhbiBMaSAoRnVqaXRzdSkNCj4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4g
d3JvdGU6DQo+Pg0KPj4gSGV5IGFsbCwNCj4+DQo+PiBUaGlzIGNhc2UgYWx3YXlzIGZhaWxzIG9u
IG15IGVudmlyb25tZW50IEZlZm9yYTQwICsgdXBzdHJlYW0ga2VybmVsIDYuMTMuMC1yYzErKDYu
MTItcmN4IGFsc28gZmFpbGVkKQ0KPj4NCj4+IEl0IGNhbiBiZSByZXNvbHZlZCBpZiBJIGVubGFy
Z2UgdGhlIGJsb2NrIGRldmljZSBzaXplIHRvIDJHaUIoMS41R2lCIGFsc28gZmFpbGVkKS4NCj4+
ICQgZ2l0IGRpZmYNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy96YmQvMDA5IGIvdGVzdHMvemJkLzAw
OQ0KPj4gaW5kZXggNjIyNmQ4My4uMTFiY2FmYiAxMDA3NTUNCj4+IC0tLSBhL3Rlc3RzL3piZC8w
MDkNCj4+ICsrKyBiL3Rlc3RzL3piZC8wMDkNCj4+IEBAIC00NCw3ICs0NCw3IEBAIHRlc3QoKSB7
DQo+Pg0KPj4gICAgICAgICAgIGxvY2FsIHBhcmFtcz0oDQo+PiAgICAgICAgICAgICAgICAgICBk
ZWxheT0wDQo+PiAtICAgICAgICAgICAgICAgZGV2X3NpemVfbWI9MTAyNA0KPj4gKyAgICAgICAg
ICAgICAgIGRldl9zaXplX21iPTIwNDgNCj4+ICAgICAgICAgICAgICAgICAgIHNlY3Rvcl9zaXpl
PTQwOTYNCj4+ICAgICAgICAgICAgICAgICAgIHpiYz1ob3N0LW1hbmFnZWQNCj4+ICAgICAgICAg
ICAgICAgICAgIHpvbmVfY2FwX21iPTMNCj4+DQo+Pg0KPj4gSSBoYXZlIG5vIGlkZWEgd2h5IHdl
IG5lZWQgdG8gZW5sYXJnZSB0aGUgYmxvY2sgc2l6ZSB3aGlsZSB0aGUgRklPIG9ubHkgcnVuIHdp
dGggc2l6ZSAnMU0nIGluIHRoaXMgY2FzZS4NCj4+IElmIHlvdSB3YW50IG1vcmUgZGV0YWlscywg
ZmVlbCBmcmVlIHRvIGxldCBtZSBrbm93Lg0KPj4NCj4+ID09PT09PT09PT09PT09PT09PQ0KPj4N
Cj4+ICQgLi9jaGVjayB6YmQvMDA5DQo+PiB6YmQvMDA5ICh0ZXN0IGdhcCB6b25lIHN1cHBvcnQg
d2l0aCBCVFJGUykgICAgICAgICAgICAgICAgICAgW2ZhaWxlZF0NCj4+ICAgICAgIHJ1bnRpbWUg
ICAgLi4uICA2LjIzNHMNCj4+ICAgICAgIC0tLSB0ZXN0cy96YmQvMDA5Lm91dCAgICAgIDIwMjIt
MTAtMTEgMTA6NTk6MjkuNzk2OTI4ODY5ICswODAwDQo+PiAgICAgICArKysgL2hvbWUvbGl6aGlq
aWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvemJkLzAwOS5vdXQuYmFkIDIwMjQtMTItMDMgMDg6
NDY6MjkuMTE4OTMyNzg4ICswODAwDQo+PiAgICAgICBAQCAtMSwyICsxLDIgQEANCj4+ICAgICAg
ICBSdW5uaW5nIHpiZC8wMDkNCj4+ICAgICAgIC1UZXN0IGNvbXBsZXRlDQo+PiAgICAgICArVGVz
dCBmYWlsZWQNCj4+DQo+Pg0KPj4gJCBjYXQgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3Vs
dHMvbm9kZXYvemJkLzAwOS5mdWxsDQo+PiBidHJmcy1wcm9ncyB2Ni44DQo+PiBTZWUgaHR0cHM6
Ly9idHJmcy5yZWFkdGhlZG9jcy5pbyBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4+DQo+PiBSZXNl
dHRpbmcgZGV2aWNlIHpvbmVzIC9kZXYvc2RiICgyNTYgem9uZXMpIC4uLg0KPj4gTk9URTogc2V2
ZXJhbCBkZWZhdWx0IHNldHRpbmdzIGhhdmUgY2hhbmdlZCBpbiB2ZXJzaW9uIDUuMTUsIHBsZWFz
ZSBtYWtlIHN1cmUNCj4+ICAgICAgICAgdGhpcyBkb2VzIG5vdCBhZmZlY3QgeW91ciBkZXBsb3lt
ZW50czoNCj4+ICAgICAgICAgLSBEVVAgZm9yIG1ldGFkYXRhICgtbSBkdXApDQo+PiAgICAgICAg
IC0gZW5hYmxlZCBuby1ob2xlcyAoLU8gbm8taG9sZXMpDQo+PiAgICAgICAgIC0gZW5hYmxlZCBm
cmVlLXNwYWNlLXRyZWUgKC1SIGZyZWUtc3BhY2UtdHJlZSkNCj4+DQo+PiBMYWJlbDogICAgICAg
ICAgICAgIChudWxsKQ0KPj4gVVVJRDogICAgICAgICAgICAgICA2M2E5ZjBlZS03Zjg4LTQ2OTYt
YjcwNS0zZWJiMGUyYWM2ZTINCj4+IE5vZGUgc2l6ZTogICAgICAgICAgMTYzODQNCj4+IFNlY3Rv
ciBzaXplOiAgICAgICAgNDA5NiAgICAgICAgKENQVSBwYWdlIHNpemU6IDQwOTYpDQo+PiBGaWxl
c3lzdGVtIHNpemU6ICAgIDEuMDBHaUINCj4+IEJsb2NrIGdyb3VwIHByb2ZpbGVzOg0KPj4gICAg
IERhdGE6ICAgICAgICAgICAgIHNpbmdsZSAgICAgICAgICAgIDQuMDBNaUINCj4+ICAgICBNZXRh
ZGF0YTogICAgICAgICBEVVAgICAgICAgICAgICAgICA0LjAwTWlCDQo+PiAgICAgU3lzdGVtOiAg
ICAgICAgICAgRFVQICAgICAgICAgICAgICAgNC4wME1pQg0KPj4gU1NEIGRldGVjdGVkOiAgICAg
ICB5ZXMNCj4+IFpvbmVkIGRldmljZTogICAgICAgeWVzDQo+PiAgICAgWm9uZSBzaXplOiAgICAg
ICAgNC4wME1pQg0KPj4gRmVhdHVyZXM6ICAgICAgICAgICBleHRyZWYsIHNraW5ueS1tZXRhZGF0
YSwgbm8taG9sZXMsIGZyZWUtc3BhY2UtdHJlZSwgem9uZWQNCj4+IENoZWNrc3VtOiAgICAgICAg
ICAgY3JjMzJjDQo+PiBOdW1iZXIgb2YgZGV2aWNlczogIDENCj4+IERldmljZXM6DQo+PiAgICAg
IElEICAgICAgICBTSVpFICBaT05FUyAgUEFUSA0KPj4gICAgICAgMSAgICAgMS4wMEdpQiAgICAy
NTYgIC9kZXYvc2RiDQo+Pg0KPj4gZmlvOiBpb191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlq
aWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBO
byBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zmc2V0PTEwMjQwMDAsIGJ1Zmxlbj00MDk2
DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4vYmxrdGVzdHMvcmVz
dWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxlZnQgb24g
ZGV2aWNlOiB3cml0ZSBvZmZzZXQ9OTA1MjE2LCBidWZsZW49NDA5Ng0KPj4gZmlvOiBpb191IGVy
cm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4w
MDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zm
c2V0PTY4ODEyOCwgYnVmbGVuPTQwOTYNCj4+IGZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21l
L2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5
LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD01NDA2NzIsIGJ1Zmxl
bj00MDk2DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4vYmxrdGVz
dHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxl
ZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9NjMwNzg0LCBidWZsZW49NDA5Ng0KPj4gZmlvOiBp
b191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGly
LnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3Jp
dGUgb2Zmc2V0PTEwMjgwOTYsIGJ1Zmxlbj00MDk2DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmls
ZSAvaG9tZS9saXpoaWppYW4vYmxrdGVzdHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50
L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9MTIyODgs
IGJ1Zmxlbj00MDk2DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4v
YmxrdGVzdHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNw
YWNlIGxlZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9MjMzNDcyLCBidWZsZW49NDA5Ng0KPj4g
ZmlvOiBpb191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMv
dG1wZGlyLnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmlj
ZTogd3JpdGUgb2Zmc2V0PTMzOTk2OCwgYnVmbGVuPTQwOTYNCj4+IGZpbzogaW9fdSBlcnJvciBv
biBmaWxlIC9ob21lL2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJ
Si9tbnQvdmVyaWZ5LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD04
NzY1NDQsIGJ1Zmxlbj00MDk2DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpo
aWppYW4vYmxrdGVzdHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6
IE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9NzA0NTEyLCBidWZsZW49NDA5
Ng0KPj4gZmlvOiBpb191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jl
c3VsdHMvdG1wZGlyLnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9u
IGRldmljZTogd3JpdGUgb2Zmc2V0PTU4OTgyNCwgYnVmbGVuPTQwOTYNCj4+IGZpbzogaW9fdSBl
cnJvciBvbiBmaWxlIC9ob21lL2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQu
MDA5LjFJSi9tbnQvdmVyaWZ5LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9m
ZnNldD05OTUzMjgsIGJ1Zmxlbj00MDk2DQo+PiBmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9t
ZS9saXpoaWppYW4vYmxrdGVzdHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3Zlcmlm
eS4wLjA6IE5vIHNwYWNlIGxlZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9Mzk3MzEyLCBidWZs
ZW49NDA5Ng0KPj4gZmlvOiBpb191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rl
c3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBs
ZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zmc2V0PTE2Mzg0LCBidWZsZW49NDA5Ng0KPj4gZmlvOiBp
b191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGly
LnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3Jp
dGUgb2Zmc2V0PTc4MjMzNiwgYnVmbGVuPTQwOTYNCj4+IGZpbyBleGl0ZWQgd2l0aCBzdGF0dXMg
MQ0KPj4gZmlvOiB2ZXJpZmljYXRpb24gcmVhZCBwaGFzZSB3aWxsIG5ldmVyIHN0YXJ0IGJlY2F1
c2Ugd3JpdGUgcGhhc2UgdXNlcyBhbGwgb2YgcnVudGltZQ0KPj4gNDtmaW8tMy4zNjt2ZXJpZnk7
MDsyODs3MDA0MTY7MzY0NjEwOzkxMTUyOzE5MjE7MzsxMTA7OS4yODMwMjc7Mi4wNzg2Nzg7Mjsx
MjM0OzE1OS4zMDQzNjA7MjguOTI1MzY3OzEuMDAwMDAwJT0yMzs1LjAwMDAwMCU9MTEyOzEwLjAw
MDAwMCU9MTUwOzIwLjAwMDAwMCU9MTU2OzMwLjAwMDAwMCU9MTU2OzQwLjAwMDAwMCU9MTU4OzUw
LjAwMDAwMCU9MTYwOzYwLjAwMDAwMCU9MTYyOzcwLjAwMDAwMCU9MTY4OzgwLjAwMDAwMCU9MTcz
OzkwLjAwMDAwMCU9MTgxOzk1LjAwMDAwMCU9MTg1Ozk5LjAwMDAwMCU9MjA1Ozk5LjUwMDAwMCU9
MjIwOzk5LjkwMDAwMCU9MjU5Ozk5Ljk1MDAwMCU9Mjc2Ozk5Ljk5MDAwMCU9NDI4OzAlPTA7MCU9
MDswJT0wOzEwOzEyNDM7MTY4LjU4NzM4ODsyOC45OTg4Mzc7MDswOzAuMDAwMDAwJTswLjAwMDAw
MDswLjAwMDAwMDs3MDA0MTY7MTkxNzg5OzQ3OTUxOzM2NTI7NDs1MDIzOzE3LjkyODk3ODsyNy43
OTQxODk7MTs1NDQ2OzMwMy4xNDM5Mjg7MTI0LjA2OTYwMTsxLjAwMDAwMCU9NTk7NS4wMDAwMDAl
PTEyNDsxMC4wMDAwMDAlPTE1MDsyMC4wMDAwMDAlPTE5OTszMC4wMDAwMDAlPTI0Mjs0MC4wMDAw
MDAlPTI4MDs1MC4wMDAwMDAlPTMwMTs2MC4wMDAwMDAlPTMyNTs3MC4wMDAwMDAlPTM1ODs4MC4w
MDAwMDAlPTM5MTs5MC4wMDAwMDAlPTQ0NDs5NS4wMDAwMDAlPTQ4OTs5OS4wMDAwMDAlPTYwMjs5
OS41MDAwMDAlPTY3NTs5OS45MDAwMDAlPTc5ODs5OS45NTAwMDAlPTg3Mjs5OS45OTAwMDAlPTEw
MTE7MCU9MDswJT0wOzAlPTA7MTc7NTQ1MjszMjEuMDU1NTU5OzEyNS43MTc3MjY7MTEwMzc2OzEz
MzEyMDs2NS43MTA0NzElOzEyNjAyNS40NTQ1NDU7NjQ5MS43MTg2MDc7MDswOzA7MDswOzA7MC4w
MDAwMDA7MC4wMDAwMDA7MDswOzAuMDAwMDAwOzAuMDAwMDAwOzEuMDAwMDAwJT0wOzUuMDAwMDAw
JT0wOzEwLjAwMDAwMCU9MDsyMC4wMDAwMDAlPTA7MzAuMDAwMDAwJT0wOzQwLjAwMDAwMCU9MDs1
MC4wMDAwMDAlPTA7NjAuMDAwMDAwJT0wOzcwLjAwMDAwMCU9MDs4MC4wMDAwMDAlPTA7OTAuMDAw
MDAwJT0wOzk1LjAwMDAwMCU9MDs5OS4wMDAwMDAlPTA7OTkuNTAwMDAwJT0wOzk5LjkwMDAwMCU9
MDs5OS45NTAwMDAlPTA7OTkuOTkwMDAwJT0wOzAlPTA7MCU9MDswJT0wOzA7MDswLjAwMDAwMDsw
LjAwMDAwMDswOzA7MC4wMDAwMDAlOzAuMDAwMDAwOzAuMDAwMDAwOzE1LjY3OTk0MyU7NDcuNTYw
MTAwJTsyODIwNTM7MDszMDswLjQlOzAuOCU7MS42JTszLjElOzk0LjElOzAuMCU7MC4wJTswLjA4
JTswLjIxJTswLjAxJTswLjIwJTswLjg3JTsxLjY5JTs2Mi42NSU7MzIuMTclOzIuMDIlOzAuMDkl
OzAuMDElOzAuMDAlOzAuMDElOzAuMDAlOzAuMDAlOzAuMDAlOzAuMDAlOzAuMDAlOzAuMDAlOzAu
MDAlOzAuMDAlOzAuMDAlDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGlqaWFuDQo+IA0KPiANCj4gDQo=

