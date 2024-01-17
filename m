Return-Path: <linux-block+bounces-1908-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E682FF79
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 05:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419CC1F2520A
	for <lists+linux-block@lfdr.de>; Wed, 17 Jan 2024 04:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1335546BB;
	Wed, 17 Jan 2024 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WN9gW0nT"
X-Original-To: linux-block@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2546B5
	for <linux-block@vger.kernel.org>; Wed, 17 Jan 2024 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705464799; cv=fail; b=MeDoDkQtQgYvdtpLq5eGYVbY4mwYl7f93mO1auZVuX1omF9+O7NWbxQsw13d6sgk363GzdrLiXHq73EKYESd3KnYS3xIMFs3Iq+htnHonC5phSMtWKQvJ9rPTA4IVUNbeQHukXfWERn38zOfwRXd7lXHJqLOPEB2KuZ5ohRKeQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705464799; c=relaxed/simple;
	bh=IRRYi+xTZd2h0gtm3ExJrfxHpEKGpnzkeyLV0vegUAE=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=EVr/zIrJJTv6CsusUeG65vp+RBDxLDpFDXucbJmNxorxh6j/CxquLrfy577SwcPEL6ruex/Q5iZV3HSRDTA5cJbu3DlbiYiaTcXn31rRSQ1yFhwsf49P2DLyjGxoncI9huOhOxZ7VX3DouKXNraxqJjZhtM74ln2cVX67CIDN7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WN9gW0nT; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4AtDEcFsLVc46ZQzv84oT2TciMYaD+sWx5ZgTn7oodQdng2BxD1oS6QFxYiuhDvGxV+Hd+s9GF+XVcC6wi4ocFuh2T2XMOXBWszMPg480hp8ZbfRr6yPoAyG0uCh+ZmGur9H5vPIucPIjiAIkqyAfm/SFxDk3A2agrNHM9+7Gk5uefxVEgKgi0u+mdZlNU6t2FO7JJtW52sv1sCZvTyFcX53xFsybDBndJYN2IR13wcK+bejNMKVdpVLUdLpqgBS+VDRG0efNWjUM5A5LyNhle+EGdWCvg2/8oCYN9DHcs4n9if0fT0jByW4hGz5AkhV21vL1ifz4wU605X/cibSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRRYi+xTZd2h0gtm3ExJrfxHpEKGpnzkeyLV0vegUAE=;
 b=Fq0kuNJIkeKzc4IEz20dTrmNhDq5Rp5kRFw7h5Pay2PCb8zI7fYM7ZOSYKzmH9n9BRJJA9zeMSpTtlInps5NeEdyu2O8YIVGaNsvamgdxnISH0GWNBKxDZW5hA7OWzK1UxHVneFThs4+B5uoo3s4dudy6986OZ2d0NQShZLMLEfX7xlqC7TNNlyF0xOZv4nbqtYqzq9+174cgtAJduBCBlTlUz/JAKqRfTRw/2DbXUQ0DyPiBl5Ew/0LS+fm3pCU6QMFnOXuhWz68DzrDvOGL31uM3ih6kJ7f7Tf29hnjGQWiwaCknZr1lk1lPKwXouYd9Jbv4oagPkLcisM1q12KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRRYi+xTZd2h0gtm3ExJrfxHpEKGpnzkeyLV0vegUAE=;
 b=WN9gW0nTyMXVIa7gGNAgZVr6dus8W91b7D1KDf0QLd2BwHtuh8P+KgXHyKJqmbxXq6coLtdd+Lf49UUm97oBUV837H7N1cc75EzmZYX2kb7G+kcudfZjuNme7gFant9I+NT/dQPf9IIQzoUXrO7nht3wXw7YpU/cnu6F5C1yNjqKcuiNpqE67pjhDRooE19upVDJBUk+0TmP/V+3Rd/CozuzMfKQxZ2qBor+7jd+ufmyN516RciqsSD1CgIW4g1Qj+2PSdmP66BLdHN8QeDXP8STnU4xcOlghNzMns9deEnxy93xYBHb17eypZk1Y8xyyi0wGP4APvOA7m9goMNX/w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6177.namprd12.prod.outlook.com (2603:10b6:930:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 04:13:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 04:13:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Index: AQHaSC2lrv/Oq5AGDkmm0PEnfzxHI7DdZp6A
Date: Wed, 17 Jan 2024 04:13:14 +0000
Message-ID: <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
References: <20240116033927.628524-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240116033927.628524-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6177:EE_
x-ms-office365-filtering-correlation-id: 9bdbbe2f-2e4a-42f9-95b3-08dc1712a013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cfH4/7+WRql4gDjpB0+xAIxrx2SwBcPgsExG68LBPttODqxIJ8aLXw6NPmZJ4oZtZz7aeu/ZV5/L8p8zH3hhi1nL0JeFaIVp53eEOFbaiA1ZpYhhwoK3y3U1ljg+hmNXD3t59igu7w9N+1YAGaZ2DZS3Sz6NfoLLyN4LhXMJwBbTFMXoEE5Ih/qdDR0TFdn8VdPjFOAz6VdrLoOhcHkc/hV1OOvc5NFtHPTHD8BPmf9gJjtT4leaAIwPHbRPW9N7URxrk7dNM5VhaQO84QhvJS6lF9lc2++g/WLKq/NpcqLyHuYwmSEhk9Wiuy2XJYsojP3H3RbkR9vWMKqiitKKo7CiEj5CXpsk9btLVJqIZQdYKhxPAMGJQXMg5/wj/WPCLNLKTiVSd7WBZpoOWaiJ69eFPX/7gwbgj0GouiznTudJOXDfBUMD2UT5YF240PHr6X1pXr0H34OjEH45YvoVYgnm+atHKWgR/lTH+8L3z/9MrdcfjqbFyFyZMcENmkTeOVZVB78PX0D0knpI2ZJMcqHVGYD8XyvQ0dDQBFGte1SHN5lxOBa/q17RgXr5NwTD79hyI337iInop7BPkBMyld60zdDdYvVONpSv7b1RmwmkYNygr5qz75GagDspBocAlfHyQ+xUkGV1U9IqGmlfSzUvnTksBB3Ou2fWc4LNiJrZC3SvsklvQjhzJDGpV2/OsfxSBV6BU39kNv9vmySlb7LbOufLA+iR1KeAI6EUpbs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(38100700002)(54906003)(4326008)(8676002)(91956017)(86362001)(64756008)(5660300002)(966005)(66946007)(6486002)(66556008)(8936002)(31696002)(6916009)(66446008)(76116006)(66476007)(316002)(2906002)(6506007)(38070700009)(71200400001)(36756003)(53546011)(6512007)(83380400001)(26005)(478600001)(122000001)(2616005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjdQcVZVK0F3RW9hbWF5WFVJV0xYamJtVVdyV1N4Wi95WUtXTm0xR25ZbWZ3?=
 =?utf-8?B?SGNLaFBUUlNBRnVJMW9TWFNPZ003V0FZTUpNSStnRURrVGhvSHBSbDlSL1JL?=
 =?utf-8?B?ZVdaU2MyeVcvL2k0dXJmRHp5dlAycWZiWHNZZ1ZlZjhKaXpTNkFRaDlHNGZB?=
 =?utf-8?B?Wkk3NDgzd05nKzZnTGR2SEcvcHBsd1JmTGduQytMZGpKbVk4RWtzQkFuZk5E?=
 =?utf-8?B?RStaclpDSXFZeU1GRjJwQTRRR3IzZ0lNSE9OWVRaTmtPUzQ2dUt3ZHRPTmxx?=
 =?utf-8?B?eGJCN0JhTjlGWkpsNmZGVWRpMVlmYnB3K3J5YkN5V0tFZnJEUDBodXUwT3Fk?=
 =?utf-8?B?OU4rM2JNZDFDQXdiQ0VRK1NNVVdSL2pOclFNUGpMZHFRTDJBcnVZaHN0Q3F1?=
 =?utf-8?B?NDFjNjJndE5LZ3pvM0xXeklWeERxMkF6cTVXUHhMZGwzaHRRTkZjNTZDVHFh?=
 =?utf-8?B?aDBxWlczRGdKdGV4MlRIVnRVK0pFY1hFVStIWE9FeEZZZmFXZnB4Z3NiMGlF?=
 =?utf-8?B?anRnMi8xU2IyQ3BTdE1pOTVqZ3lqaVhPakl1czhrUEJ4czhYNng1Umd2bzRo?=
 =?utf-8?B?cEVBbnBmYTVhb2NFSG5zcjdyMzM2MGNyOGtaYStmMXZKTEd1Vi9IVldkQlRD?=
 =?utf-8?B?UkYzMXRYeEF1ZmVZNUxCVUJLTEJ1WGIxVG1ZT2U0bVNwK3ZqTkhrNStNWnB4?=
 =?utf-8?B?b3NBcHRaU3graGRnc0xKeXZLbWN4YjJydHprVm0zT0xwM2N0L0FUSVA3ZHM3?=
 =?utf-8?B?OVd6L2srTEp0SGtPUWs1RFJXWE81RWV4eXd2dFF4WEVNdWh2NE1JN2VBQnor?=
 =?utf-8?B?eG9kYmN3MzF1T2Zyb0NnWTlRdkg3OVUvaGtnemdlYzhuaHNoN2JmZlVBOXVu?=
 =?utf-8?B?OFpsVXBZNW1wRmhzRjMxR09YNDkzWWRhd2N5alBjQURnbTF6Y0tiU0Q4cUdo?=
 =?utf-8?B?ZWwyaE5aYVJoSWN1cDBxUDc4Ti9zL1grd3NrOFdoWUVqeWloRml3a2J2bjA3?=
 =?utf-8?B?dmp6WTg3ZTBjcWwyZ2hRQmNWYlB5ZzFLenNRSGJnSWVJdjRvUW9nR1pRcGRD?=
 =?utf-8?B?UWVKUEMrVjFnaEFXNC9PaFpBMkJ5d1d0VDBPZUU3U1o2ZzFyVGt1WU4yaS93?=
 =?utf-8?B?SlJyTCtOLzdkL3JmVlMxbFNWNVhBeURETWVubElBa3pRRXVKazdGY2E5ZVFW?=
 =?utf-8?B?di9TcUZxdXMyMmY0SzZWdTBqNUhHSjVkNTlxdHQ0RzdRbWJYT3JIbEJld2I1?=
 =?utf-8?B?U2puSVlLTVl0bFNsQVBBUzRheGxEcm9zU3A4ZEY3NDlEQ3JBTllETmdkUkJr?=
 =?utf-8?B?UUF6UFZCTE1Ld1FOaGR3U2FQemplaUdIMThwRTNnUU0xd2lBWFE1cHlSL0lw?=
 =?utf-8?B?L2Q0Ym03VFZSLytnckpnZXdkREd4R0RSMnJBUGF3dCtnN0J1QjVRR1ZXdDlK?=
 =?utf-8?B?UThSWFB1c3RnZklvUXh6NmROV3dKaE1qRmV6eEhlVDkxajdRL0twV214MUF1?=
 =?utf-8?B?aWRnb09OU3VtcGVaa3h3SlpNTHRkNUVjZW56bGM2RjNOQ2xjbjR5SEg4d1R6?=
 =?utf-8?B?T0RuN0NGUnpwbno2WEp5SHNYUE1PSjJ5cHM3aUI3dGc1YlY5UnZvVE5VUlFr?=
 =?utf-8?B?NUYxSllHVTJTSjk3dHBzWVdLdXNkZnFrVURsR0JVcC9ESndiMm9PZkNDNTI3?=
 =?utf-8?B?a3EyNzF6eXlidEpWemJNRmZjWWJaVWNJbklNMk14VnpyOXFGRjZBZ05BSmxa?=
 =?utf-8?B?TVpEczdKazhTYmtzUFF6SXh3QTdCUVJYUnd4VXRZU0hqcTNFSWJQM3o2dm5l?=
 =?utf-8?B?RFdPY2o0MEVuQTB2RnBKQ3hOTk1Ldm5wdkR0RWd5a3pZaDZ0aWtYVlJrSm5V?=
 =?utf-8?B?ME1MNDhFeEV5enRRYmJYQ1JoVmt3cUsrYXRvZ0VSaUtNSzk3T2tOK2VLTFIr?=
 =?utf-8?B?dnRQQS81QXZNZjVTb2xYRG1JQ2YvdUdWa0sraVpQMDZBRGtSaWx2akhpK0w4?=
 =?utf-8?B?dlVQSHdWMkpFU3IwWVRZMFlEQldHOElzQnV6Z2pLVDNxL0hhRlgwb0hjWHAw?=
 =?utf-8?B?cTF1TzdnYzVMWjkwNEVMQ2l2YUs0aFMzckZiU3NiR1VBNk9ZVXVUUmc2WXFN?=
 =?utf-8?Q?B/3TqtQeHzMOcaTL2K1WMm41I?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E9720B723919C418537AF91C2FEA4A3@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdbbe2f-2e4a-42f9-95b3-08dc1712a013
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 04:13:14.1633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTRjJiZR4puayOLqsxJIlkXP0+XNoPomWsyEKVCCrKHzUrLKW6593sbflkFFoR0RjohAQvCvUL+SqXT6SYfHAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6177

T24gMS8xNS8yNCAxOTozOSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEFsbG93IHNl
dHRpbmcgc2hhcmVkX3RhZ3MgdGhyb3VnaCBjb25maWdmcywgd2hpY2ggY291bGQgb25seSBiZSBz
ZXQgYXMgYQ0KPiBtb2R1bGUgcGFyYW1ldGVyLiBGb3IgdGhhdCBwdXJwb3NlLCBkZWxheSB0YWdf
c2V0IGluaXRpYWxpemF0aW9uIGZyb20NCj4gbnVsbF9pbml0KCkgdG8gbnVsbF9hZGRfZGV2KCku
IEludHJvZHVjZSB0aGUgZmxhZyB0YWdfc2V0X2luaXRpYWxpemVkIHRvDQo+IG1hbmFnZSB0aGUg
aW5pdGlhbGl6YXRpb24gc3RhdHVzIG9mIHRhZ19zZXQuDQo+DQo+IFRoZSBmb2xsb3dpbmcgcGFy
YW1ldGVycyBjYW4gbm90IGJlIHNldCB0aHJvdWdoIGNvbmZpZ2ZzIHlldDoNCj4NCj4gICAgICB0
aW1lb3V0DQo+ICAgICAgcmVxdWV1ZQ0KPiAgICAgIGluaXRfaGN0eA0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0K
PiAtLS0NCj4gVGhpcyBwYXRjaCB3aWxsIGFsbG93IHJ1bm5pbmcgdGhlIGJsa3Rlc3RzIHRlc3Qg
Y2FzZXMgYmxvY2svMDEwIGFuZCBibG9jay8wMjINCj4gdXNpbmcgdGhlIGJ1aWx0LWluIG51bGxf
YmxrIGRyaXZlci4gQ29ycmVzcG9uZGluZyBibGt0ZXN0cyBzaWRlIGNoYW5nZXMgYXJlDQo+IGRy
YWZ0ZWQgaGVyZSBbMV0uDQo+DQo+IFsxXSBodHRwczovL2dpdGh1Yi5jb20va2F3YXNha2kvYmxr
dGVzdHMvdHJlZS9zaGFyZWRfdGFncw0KPg0KPiAgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFp
bi5jICAgICB8IDM4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICBkcml2ZXJz
L2Jsb2NrL251bGxfYmxrL251bGxfYmxrLmggfCAgMSArDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAy
MSBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMN
Cj4gaW5kZXggMzY3NTVmMjYzZThlLi5jMzM2MWU1MjE1NjQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsv
bWFpbi5jDQo+IEBAIC02OSw2ICs2OSw3IEBAIHN0YXRpYyBMSVNUX0hFQUQobnVsbGJfbGlzdCk7
DQo+ICAgc3RhdGljIHN0cnVjdCBtdXRleCBsb2NrOw0KPiAgIHN0YXRpYyBpbnQgbnVsbF9tYWpv
cjsNCj4gICBzdGF0aWMgREVGSU5FX0lEQShudWxsYl9pbmRleGVzKTsNCj4gK3N0YXRpYyBib29s
IHRhZ19zZXRfaW5pdGlhbGl6ZWQgPSBmYWxzZTsNCg0KZXhwbGljaXQgaW5pdGlhbGl6aW5nIGds
b2JhbCBib29sIHRvIGZhbHNlIHJlYWxseSBuZWVkZWQgPw0KdW5sZXNzIEkgZGlkIHNvbWV0aGlu
ZyBzZWUgWzFdLg0KDQotY2sNCg0KWzFdDQpudm1lIChudm1lLTYuOCkgIyBnaXQgZGlmZiBkcml2
ZXJzL2Jsb2NrL251bGxfYmxrLw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsv
bWFpbi5jIGIvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWluLmMNCmluZGV4IDlmNzY5NWYwMGMy
ZC4uMTI2ODZhZWFhZTM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ibG9jay9udWxsX2Jsay9tYWlu
LmMNCisrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5jDQpAQCAtNjgsNiArNjgsOCBA
QCBzdHJ1Y3QgbnVsbGJfcGFnZSB7DQogwqBzdGF0aWMgTElTVF9IRUFEKG51bGxiX2xpc3QpOw0K
IMKgc3RhdGljIHN0cnVjdCBtdXRleCBsb2NrOw0KIMKgc3RhdGljIGludCBudWxsX21ham9yOw0K
K3N0YXRpYyBib29sIGFiY2Q7DQorc3RhdGljIGJvb2wgYWJjZF9pbml0ID0gZmFsc2U7DQogwqBz
dGF0aWMgREVGSU5FX0lEQShudWxsYl9pbmRleGVzKTsNCiDCoHN0YXRpYyBzdHJ1Y3QgYmxrX21x
X3RhZ19zZXQgdGFnX3NldDsNCg0KQEAgLTIyODAsNiArMjI4Miw3IEBAIHN0YXRpYyBpbnQgX19p
bml0IG51bGxfaW5pdCh2b2lkKQ0KIMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBpOw0KIMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCBudWxsYiAqbnVsbGI7DQoNCivCoMKgwqDCoMKgwqAgcHJfaW5m
bygiJXMgJWQgYWJjZCAlZCBhYmNkX2luaXQgJWRcbiIsIF9fZnVuY19fLCBfX0xJTkVfXywgDQph
YmNkLCBhYmNkX2luaXQpOw0KIMKgwqDCoMKgwqDCoMKgIGlmIChnX2JzID4gUEFHRV9TSVpFKSB7
DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImludmFsaWQgYmxvY2sg
c2l6ZVxuIik7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dhcm4oImRlZmF1
bHRzIGJsb2NrIHNpemUgdG8gJWx1XG4iLCBQQUdFX1NJWkUpOw0KbnZtZSAobnZtZS02LjgpICMg
bWFrZWogTT1kcml2ZXJzL2Jsb2NrLyBjbGVhbg0KIMKgIENMRUFOwqDCoCBkcml2ZXJzL2Jsb2Nr
L01vZHVsZS5zeW12ZXJzDQpudm1lIChudm1lLTYuOCkgIyBtYWtlaiBNPWRyaXZlcnMvYmxvY2sv
DQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay9mbG9wcHkubw0KIMKgIENDIFtNXcKgIGRyaXZl
cnMvYmxvY2svYnJkLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL2xvb3Aubw0KIMKgIEND
IFtNXcKgIGRyaXZlcnMvYmxvY2svbmJkLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL3Zp
cnRpb19ibGsubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2svYmxrYmFj
ay5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay94ZW4tYmxrZnJvbnQubw0KIMKgIENDIFtN
XcKgIGRyaXZlcnMvYmxvY2svcmJkLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL3hlbi1i
bGtiYWNrL3hlbmJ1cy5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay96cmFtL3pjb21wLm8N
CiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL210aXAzMnh4L210aXAzMnh4Lm8NCiDCoCBDQyBb
TV3CoCBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9iaXRtYXAubw0KIMKgIENDIFtNXcKgIGRyaXZl
cnMvYmxvY2svZHJiZC9kcmJkX2J1aWxkdGFnLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2Nr
L3pyYW0venJhbV9kcnYubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX3By
b2Mubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX3dvcmtlci5vDQogwqAg
Q0MgW01dwqAgZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfcmVjZWl2ZXIubw0KIMKgIENDIFtNXcKg
IGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbWFpbi5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9j
ay9kcmJkL2RyYmRfcmVxLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL3Ry
YWNlLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9hY3Rsb2cubw0KIMKg
IENDIFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX21haW4ubw0KIMKgIENDIFtNXcKgIGRy
aXZlcnMvYmxvY2svbnVsbF9ibGsvem9uZWQubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2sv
ZHJiZC9kcmJkX3N0cmluZ3Mubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJk
X25sLm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL2RyYmQvZHJiZF9pbnRlcnZhbC5vDQog
wqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay9kcmJkL2RyYmRfc3RhdGUubw0KIMKgIENDIFtNXcKg
IGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX25sYS5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9j
ay9kcmJkL2RyYmRfZGVidWdmcy5vDQogwqAgTEQgW01dwqAgZHJpdmVycy9ibG9jay96cmFtL3py
YW0ubw0KIMKgIExEIFtNXcKgIGRyaXZlcnMvYmxvY2sveGVuLWJsa2JhY2sveGVuLWJsa2JhY2su
bw0KIMKgIExEIFtNXcKgIGRyaXZlcnMvYmxvY2svbnVsbF9ibGsvbnVsbF9ibGsubw0KIMKgIExE
IFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkLm8NCiDCoCBNT0RQT1NUIGRyaXZlcnMvYmxv
Y2svTW9kdWxlLnN5bXZlcnMNCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL2Zsb3BweS5tb2Qu
bw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svYnJkLm1vZC5vDQogwqAgQ0MgW01dwqAgZHJp
dmVycy9ibG9jay9sb29wLm1vZC5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay9uYmQubW9k
Lm8NCiDCoCBDQyBbTV3CoCBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsubW9kLm8NCiDCoCBDQyBb
TV3CoCBkcml2ZXJzL2Jsb2NrL3hlbi1ibGtmcm9udC5tb2Qubw0KIMKgIENDIFtNXcKgIGRyaXZl
cnMvYmxvY2sveGVuLWJsa2JhY2sveGVuLWJsa2JhY2subW9kLm8NCiDCoCBDQyBbTV3CoCBkcml2
ZXJzL2Jsb2NrL2RyYmQvZHJiZC5tb2Qubw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svcmJk
Lm1vZC5vDQogwqAgQ0MgW01dwqAgZHJpdmVycy9ibG9jay9tdGlwMzJ4eC9tdGlwMzJ4eC5tb2Qu
bw0KIMKgIENDIFtNXcKgIGRyaXZlcnMvYmxvY2svenJhbS96cmFtLm1vZC5vDQogwqAgQ0MgW01d
wqAgZHJpdmVycy9ibG9jay9udWxsX2Jsay9udWxsX2Jsay5tb2Qubw0KIMKgIExEIFtNXcKgIGRy
aXZlcnMvYmxvY2svYnJkLmtvDQogwqAgTEQgW01dwqAgZHJpdmVycy9ibG9jay94ZW4tYmxrYmFj
ay94ZW4tYmxrYmFjay5rbw0KIMKgIExEIFtNXcKgIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkLmtv
DQogwqAgTEQgW01dwqAgZHJpdmVycy9ibG9jay9sb29wLmtvDQogwqAgTEQgW01dwqAgZHJpdmVy
cy9ibG9jay9mbG9wcHkua28NCiDCoCBMRCBbTV3CoCBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsu
a28NCiDCoCBMRCBbTV3CoCBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL251bGxfYmxrLmtvDQogwqAg
TEQgW01dwqAgZHJpdmVycy9ibG9jay9yYmQua28NCiDCoCBMRCBbTV3CoCBkcml2ZXJzL2Jsb2Nr
L210aXAzMnh4L210aXAzMnh4LmtvDQogwqAgTEQgW01dwqAgZHJpdmVycy9ibG9jay96cmFtL3py
YW0ua28NCiDCoCBMRCBbTV3CoCBkcml2ZXJzL2Jsb2NrL25iZC5rbw0KIMKgIExEIFtNXcKgIGRy
aXZlcnMvYmxvY2sveGVuLWJsa2Zyb250LmtvDQpudm1lIChudm1lLTYuOCkgIyBpbnNtb2QgZHJp
dmVycy9ibG9jay9udWxsX2Jsay9udWxsX2Jsay5rbw0KbnZtZSAobnZtZS02LjgpICMgZG1lc2fC
oCAtYw0KWzIzMjI4LjM1NTQyM10gbnVsbF9ibGs6IG51bGxfaW5pdCAyMjg1IGFiY2QgMCBhYmNk
X2luaXQgMA0KWzIzMjI4LjM1NzU3MV0gbnVsbF9ibGs6IGRpc2sgbnVsbGIwIGNyZWF0ZWQNClsy
MzIyOC4zNTc1NzRdIG51bGxfYmxrOiBtb2R1bGUgbG9hZGVkDQpudm1lIChudm1lLTYuOCkgIw0K
DQo=

