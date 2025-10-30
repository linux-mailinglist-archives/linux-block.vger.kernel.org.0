Return-Path: <linux-block+bounces-29202-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A87C1EECD
	for <lists+linux-block@lfdr.de>; Thu, 30 Oct 2025 09:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C475E4079AE
	for <lists+linux-block@lfdr.de>; Thu, 30 Oct 2025 08:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BBE2F549D;
	Thu, 30 Oct 2025 08:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RR4tyvZ4"
X-Original-To: linux-block@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3E285CB6
	for <linux-block@vger.kernel.org>; Thu, 30 Oct 2025 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761811980; cv=fail; b=ld19mwaAR2kSNwO0yuF4hn2RHU9Dy0fomg+k1583Ozae2FYjaUL/Pb6YREF1Nyis1xqBNbJGHkYkpn4QRV9dt57IAbqC3sMYWlSPyugqZd5l6xUqkIZLauTF+0Iio/zTwfVG3t27YVTUBiuIKVSUhT+QRb47+yY9OPUSDzg5gM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761811980; c=relaxed/simple;
	bh=6c2fTA9WYz1uCdvebbJmF33jqiRu3c+3XCydPcVxL4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfeljHKM1JSomsO34Srdg/SSDDfv5XYFPs5U0WGj0wk5OEdIDchXwQk6b7sY0Qp4MLqjnlGIMifymtMk4JeF5TTqdXHQ9BmRumTHpSEm9LVG3M2f6M0Feem0lD+RMqapsQsqRJcWLS427yETs9JCwxPoEuHhe2msvVWqFW5VBC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RR4tyvZ4; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2sc3266koCdoe3MM1VrPx3BurCEj10DoCgfKwnYRdZhCVSaDaLy1mZ5fHzROQZlXDtQ5BQIJWKpcUsJ1R5KWeMHwthaTmwgNt4wZueE5fNrBCHL0/zJ1pcOjP8pB50J2cnNO7gg8VG1J+Mco/2EFezafXr200Y8SaCkxltLqRXM9WW4sPHM88gjF8PHOi8ONjcL+4Q8r0y/KBxRZl+2CoBEdtWg30NLBCl2v0RCg1H5HgxT9M6uof+DOTVRMyfiIscCjfwkfEw/HOPMCAeV/lNkBsTC9ryRgiaIgJST6Bf+0B5La3hWcrb90NxJE2Zn3lloiSf4m9UzLpJjXCENuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6c2fTA9WYz1uCdvebbJmF33jqiRu3c+3XCydPcVxL4Q=;
 b=x8B+nrtBRmKzUvHsZx89YfPeyETO8JTMfK8BuKNls8syJijj4HijbWI/f0O/DQPou06Gtwzz2d82DoYRL1fvvXPFv3sA5Jzf9lL+yaCLpSQDzzSiF0OC4vZtrPESk3vBvka7O8KNhOQLPROJdBCMkoCUWzwwUVdT1XzK0JzJPR4easesxX/9nAGW+/IiS0DsnxTqfo3M6T+sBFlVDiuZgcDgCe32dNhUvSarVzAzkmYOpR+uIcIiqXYrjeTdbcQZxMZSAe3CRSGLjxOm9OVWnAFkBasAEiNla13z+l/0/AMFyndzdYywlNZrSgU5SUur2eQfs3f+MnxPk7NMjBM5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6c2fTA9WYz1uCdvebbJmF33jqiRu3c+3XCydPcVxL4Q=;
 b=RR4tyvZ41ThLiwFrepwBKq+a5++g4vf/ERJQ6i0O164G/EpJnxYpEpJFPPMl3r+9yC7o5RZJKVlmeH/wD570Ncp6B93fUK7rRyUQjf0J2+TrdUYF3E2vOrB30W1lzKAd7Wu9NNNV8kTr+Ph3F/+9dO7lRAcLsGwsyBg1sGqK55/TgK9QuOelA7u9AJsn3BfCwMSf8EZPSX7mNLBBAfZYV4WT6TATuGrfonXY6pQ7Vg8ck1HkaIE3N1Xh3zCwbpMa8HkX5QHKsTq++7U0KV3cIOlrgoHR72Pe2h6FBRO+LKsFt9gDUd8ieoqeC/PgdMutCw2xSjlPLDWNxf0G1L73rw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 08:12:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 08:12:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Casey Chen <cachen@purestorage.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>, "sconnor@purestorage.com"
	<sconnor@purestorage.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>, Ming Lei
	<ming.lei@redhat.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Topic: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Thread-Index: AQHcSRhauqXv7enrvU2FX6HoDAYwUrTZ2SIAgAB+qIA=
Date: Thu, 30 Oct 2025 08:12:53 +0000
Message-ID: <9669f8a9-11ad-4911-9e03-00758e1d9957@nvidia.com>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com> <aQKzxpJp98Po_pch@kbusch-mbp>
In-Reply-To: <aQKzxpJp98Po_pch@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW3PR12MB4490:EE_
x-ms-office365-filtering-correlation-id: 719513f8-1556-46a5-cc98-08de178c203e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VXZsS1lkSEtQMDJ3dmxiOGhkRUt2RlFjajROWlJqMFUxMnlJdm1tMzRWeXVV?=
 =?utf-8?B?c1RDb2N0ckZzT0QrNkgrOVRFRUtoazlnOUt3dXdQVXplSE1mWk9IWGZsNnNO?=
 =?utf-8?B?VnVBeFc5SnpxRHhGZmZnWUlsemNwM1VIMDRzZTI2Q2tOMWt0ZzM1TFRobUhQ?=
 =?utf-8?B?M2FwVmQvZUl1bUtlM2NWSUFib1hHVXdVQnIyKzExWlFtOG9RUTMyVjFabGNP?=
 =?utf-8?B?VWdqekhYeThhZW9CSnV6c3FYNEFXNG1GWkZsZDB1UFFWL25COVl5WE5qNlZ2?=
 =?utf-8?B?OHd4SWt0Z0t3eG5WSVRMamhZazdxVjhrSDc1R1lKUWZTc25NcS9HWXhlMmVY?=
 =?utf-8?B?VFI1TVdHOVdWVDBmWDZWNDIySDhCYlNWZUxqNnpSNE83LzhLcnppQ0llVklt?=
 =?utf-8?B?dVJBVXdzd2N1NG9zSUl2MHpUZ0R3eEhZV1RjNnk2YW5UNHBLZEVzQ3pCUUxZ?=
 =?utf-8?B?VWIwSHBqWkpaYzhFVzh3aU84NzAxYlhWVFZjcFhMaVYrWS90Und2WFpnNEN4?=
 =?utf-8?B?c3B5U3A2SjNaZ29lcTViUmRlSWZQNU9uTGJINDVEL1V6bml5U0JmSTgyanZv?=
 =?utf-8?B?MlEvKzNHWmJ6N25SVlRiVUxZUSt5VXZCZzZCWmI4TnZMOHQxS2tBWjFoZXJt?=
 =?utf-8?B?dlBMVFVydDFNR0kwNXNSVjk0R1krbG5tcTFqNE9FMFNTT0Y2Y01SM2tyRWxm?=
 =?utf-8?B?RHhoWlNqMHBHRFlnZjJhSTVTYllQUWI1K0o4VlRlc2o0WVIxKzRhZ0FiR2Rq?=
 =?utf-8?B?MGE3L1hwQmU2WjVFZ2lUV3NWQ2I5OWVyZUt3SXFDeHIrMXhUU1ZtWkJLQ0NJ?=
 =?utf-8?B?QklpcmFhajNKY3NCQ3N5TGFVQ2twb0ZySnVkZmIvaDc2dlovQ0NQTzVONXYx?=
 =?utf-8?B?VEluWUF6c3RuRkVFeU5IbCtWN25DQkZMK1QwNTVjbStHNDBoN2tlRVhsMnNh?=
 =?utf-8?B?TVhyQitmdkVpak9tQ0JrTlRacm11R1lGVE1DQTF6U3NBSllJWitLWXN4VmV0?=
 =?utf-8?B?MTdBUDltVkVxNkdQK1dQZlhLUU81SGRkeXFOb3BTNHZjdFhaTEVHY09Dd3p6?=
 =?utf-8?B?Y3FvVVl1V21kYSs5WithZ3JuT3JnS25maTQva0hpYzl0Z1FuUTlIa2FoUTFq?=
 =?utf-8?B?RUxLcDhJdUoxK1ltdXB0VW1oZnNtZXRCT1hWU2RpTHZ4ZHRONzhBT29tNUZv?=
 =?utf-8?B?LzQ5QUhiMWNvTExNMnh3OG9xMEsrbkgrQzJHaVNHbEhvcG1FSCtCaFRvdDUy?=
 =?utf-8?B?NWVMenY0TXZ4K0lCZ1ArT0RVUHE0ZU4wR2xXaEpEcWZub013TUo3bldYMFlZ?=
 =?utf-8?B?aTVnNVVpSFkzK3d1S0YrOXRFekU4S1JUSWpoMWFtUEhMVDFoYkJIRitmeTNY?=
 =?utf-8?B?Qm9qRjcxMWNWOVgvcXNkTm9TMU9uVlNsUjhMSlNNSXEreDZ0dCtPNVJWd0sy?=
 =?utf-8?B?a1daTm41V29sQXBuMTVUZE5tZnp4WFhFZm5iV3QwTlRsN1NIN1Y0eVAvVDFt?=
 =?utf-8?B?VzczU1djRE9MOS84anFCMUF5T1ZQVkpKR0IwaHVLd1luZU5jUmR6TzR0MzJx?=
 =?utf-8?B?QVlEamR3ZDZwUWhmOTFGMjdqdWtHMVF2TlZYcFhPMStLYnpwY1RycHNtNnBr?=
 =?utf-8?B?VkVGc1gxRjRlTjYrSEIySEh1SGVJUUJ6NG1adkNxRGdvR1I4Wm03dFN0SFN3?=
 =?utf-8?B?eHZrb0VhUWhiUE5QbmkvYlMwU1BMYjNSd2VjWGIzYVg3czRacngyL0xsZXEz?=
 =?utf-8?B?ZFV3R0tQVkxscm5ENU5oZDQ3d1dUWVVFbDFPNnorbEJucmFPZnk5amYydHZD?=
 =?utf-8?B?Z0MyaGVLbEx4V3c0clRMWFo1WWhxWUlXa05BdTgvUXBRc0Q1ZXh1R0I4bnlE?=
 =?utf-8?B?OGsvRnl5RjlpMzNTdEN6QnBOR2FSZ2RvdzQ4d0VuamtuYXNTcmMwODBmWTdQ?=
 =?utf-8?B?M0tuc0FIS2p1UnNZbVY3VEZKMXVUaC9TUVRsdHI1c3NMa2ZaMUdSUEZlcEpK?=
 =?utf-8?B?YlJWRFUyL2M2UVFuRzlwOEkyaGNJdHdwa1FsckQ4SS9VeVUrUlg1NG1Yem16?=
 =?utf-8?Q?+lY2UX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1o3OUpGNWZKQ0lXcEkxNW5pZlhrVlZnek54T0NQNTlyWUxDSGlXalpFTGdq?=
 =?utf-8?B?Y3ViYXF6SnFzajFsNFVzZDBEQ2tTNktmVGZyanNqODJlUHBkUEppdjhnc0g5?=
 =?utf-8?B?SERDK05qN0t3bW5XQ1pkbWkwODNlRXEwajh3NlRDajB6aEh3M01UU3NVNHBk?=
 =?utf-8?B?TFBMcThBQzlMT25RTzFjWEtmOFNEKzVsR2FGSk5Jd1FiS2Y1OTZaTVBjQWta?=
 =?utf-8?B?cTVEM1pqSXZSdkpjTVBvUkNhMlByblpld2lZZFRrMHZiNUtGcFViK20yV1Zt?=
 =?utf-8?B?SmlhZDdlTTRkYnhGbDZQWHRyLytrUnJFYWFDSC9vWWRqMHJrY0Z5RG1PR01U?=
 =?utf-8?B?R1NYc0pKcmxkTlJjVTU3RmNLOWNXUFBRYmY2ak9MWEdrb3ZxNFYzSXpja3BP?=
 =?utf-8?B?QzJhckNnd2dQS2RpK2dMSHhUSG1BbHNJa0taUzJURE0zZTZmUjRLaHkzRi9L?=
 =?utf-8?B?djczZ1BEVjVteVJWenNrRGlBQVBwcG5TWUIvc3RKMTRRN2hJNUJqbmlxT3FS?=
 =?utf-8?B?QkhzVklpcUQ1QkN1ejk2dVJFa2pHNFhMa2k0UTA0MnhqaTJtMlN1SzA3TURC?=
 =?utf-8?B?SW5WY0RkaWdPaUhlOC8rL3FEK3ZIN1R1aUZLR3JVeEMwdkE5NCtxYzRyajBK?=
 =?utf-8?B?eTZLWWNVdk45Q1VON2hzMm54WW9wcWpFMDBIOVduQVhGbFU1ZjhaSDdLeU80?=
 =?utf-8?B?dkpraFRwdEpkUzRTVHl2elYrOGVYWnhkVzRhaXlkRktFamM4eGRhWFRVTk1E?=
 =?utf-8?B?WHc3SkEzQlp2UXFvaHNyOVhjVUtGdWxmT3JuRUhBUlREeHFGa2wrOUxacGVw?=
 =?utf-8?B?M1ZWbjZKS0FUQ1AvMEp5cHh6YmNNRC9jQ2lhcWVPSG1XbGJqSGU3czlCTk9m?=
 =?utf-8?B?RlNxVFNET2g3VW5zZ2ppMDdCMHR6dG51TThoY0JqM01qNGZucEpQcWNpdTR5?=
 =?utf-8?B?ZUR0dXZKOVBKdWc2WkRld1g2MXVNMnVGM2psTHo5V04xSzNaK3VXL21UY3Ar?=
 =?utf-8?B?VExRN2xJT2hFZTJxNDN3anJtOFZpdXZ3YUpKOVU3Wm8wQlR2ZDdZbXY3L3cz?=
 =?utf-8?B?ejY0Ujlldkd5VTVTNkpkaVYxRVMwbXpnSDlJTHBsYUoyaUNPTzcwWWVsYzAy?=
 =?utf-8?B?RkZ3STU0SWgrc1U4T3FpeWVkeFdQTHhhOEhRVi9JcDgzNm03N2p2U1phVlJx?=
 =?utf-8?B?YzZSWGFzZkJKWVhiVVBJdFdzTStaQmtGZHl5ZTMrdEQycmZBUHJXVXF0VEcz?=
 =?utf-8?B?dW1QYkJrNXNRbU5tYmdBYWdWd3d4Y3ZpdnZTVjArMHRFYmpoN3IrT3kxNTJx?=
 =?utf-8?B?eXBFK0F6cVFxdmVuR1pZMXZJM0ZEamd5dUpzWTlIMy9Gekcvb1BCS3ZIYUIr?=
 =?utf-8?B?YXlqMERMK0NMeHoyTzU0UUtMY0gybjBUTDY4T0t0SDVyakpXYTkrT09hK3o0?=
 =?utf-8?B?YkpCSmd6SFU4KzByVDhRMDdWeXlaVDJnR2tQcFh5Si94ZzBnMFF4ZjVGRFJt?=
 =?utf-8?B?SDV0UWM3ckIrTWpoUnIwSnpSWW1tZ2pEZTh1UFZpekZKNVBUcFBDNG53Q09I?=
 =?utf-8?B?ZnR4TjhKeTNWb1dxN3VRRnJFRXcwVEprZHJtbkwzUHJRNFF2WHB5K1RORnJH?=
 =?utf-8?B?UWlFdlZKWnVoUCtJK01VaUU4NkJmK2Q1bFVKdm5kclJCdnhKVWE1eEdlcEg2?=
 =?utf-8?B?ZUtIUWVjYzNac09iUnBYOXdpeE4xQXVkcXI5RFpqd0MvMEdmdTRtZFhuTUNJ?=
 =?utf-8?B?V1c0SE1lcWFzOW9CRmE2R0pqTXFBT1RFUUQwQnArUGhaaUZ1M1RSYThCZ1V2?=
 =?utf-8?B?QVdnWnpOSHZGVGVHeG9WQTFzc3NHM1hPS2NjbC9LYStlK3dTZ0NsN2ZmSmZv?=
 =?utf-8?B?ZXA5TjFXQ2Y0Q2JDWjFDUGdYZnBLd21oUUVQZHpvSlpCLzF2bUtWKy9HZ3c3?=
 =?utf-8?B?Rit1Y1hyVi94N0ZiNzhkcVF5TzMyOHZSRE5jT0Y0SlE0MlQ4ODZMUHMwcnhS?=
 =?utf-8?B?R0tGOTF3Yzd4UnZOc3VVNlhwUEZWQzlKQUZKaXphOUoyVnV5YVRiSmpwNDRx?=
 =?utf-8?B?K1JJUURlcDh6NEt1UlVnUmZsd01vb0t3OW92N1hGbmdBaFoxa0dZMytOSnVJ?=
 =?utf-8?B?aHpDeFJzQ005VXpjdnpYekJBOW9EcG9adVI0dXAvSnZPOWJDOXphcFI1RC83?=
 =?utf-8?Q?Aks6jhAa9uSdR7lcLbcsPTeU1B6aJOnfv0T/RsPQO0dE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45509307FF11E147A875963D68581908@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 719513f8-1556-46a5-cc98-08de178c203e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 08:12:53.6414
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2IU2w+r1yC6jDwtnZ2zL9Ib2t2vxTe4o+4Tbip1qjR72C+a7cfTKzgjKayjKbcwhO3ZKe2Shpl4nOZEPY8M7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

T24gMTAvMjkvMjUgMTc6MzksIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBXZWQsIE9jdCAyOSwg
MjAyNSBhdCAwMzowODo1M1BNIC0wNjAwLCBDYXNleSBDaGVuIHdyb3RlOg0KPj4gRml4IHRoaXMg
YnkgdGFraW5nIGFuIGFkZGl0aW9uYWwgcmVmZXJlbmNlIG9uIHRoZSBhZG1pbiBxdWV1ZSBkdXJp
bmcNCj4+IG5hbWVzcGFjZSBhbGxvY2F0aW9uIGFuZCByZWxlYXNpbmcgaXQgZHVyaW5nIG5hbWVz
cGFjZSBjbGVhbnVwLg0KPiBTaW5jZSB0aGUgbmFtZXNwYWNlcyBhbHJlYWR5IGhvbGQgcmVmZXJl
bmNlcyBvbiB0aGUgY29udHJvbGxlciwgd291bGQgaXQNCj4gYmUgc2ltcGxlciB0byBtb3ZlIHRo
ZSBjb250cm9sbGVyJ3MgZmluYWwgYmxrX3B1dF9xdWV1ZSB0byB0aGUgZmluYWwNCj4gY3RybCBm
cmVlPyBUaGlzIHNob3VsZCBoYXZlIHRoZSBzYW1lIGxpZmV0aW1lIGFzIHlvdXIgcGF0Y2gsIGJ1
dCB3aXRoDQo+IHNpbXBsZXIgcmVmIGNvdW50aW5nOg0KPg0KPiAtLS0NCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBp
bmRleCBmYTQxODFkN2RlNzM2Li4wYjgzZDgyZjY3ZTc1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+IEBA
IC00OTAxLDcgKzQ5MDEsNiBAQCB2b2lkIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoc3RydWN0
IG52bWVfY3RybCAqY3RybCkNCj4gICAgICAgICAgICovDQo+ICAgICAgICAgIG52bWVfc3RvcF9r
ZWVwX2FsaXZlKGN0cmwpOw0KPiAgICAgICAgICBibGtfbXFfZGVzdHJveV9xdWV1ZShjdHJsLT5h
ZG1pbl9xKTsNCj4gLSAgICAgICBibGtfcHV0X3F1ZXVlKGN0cmwtPmFkbWluX3EpOw0KPiAgICAg
ICAgICBpZiAoY3RybC0+b3BzLT5mbGFncyAmIE5WTUVfRl9GQUJSSUNTKSB7DQo+ICAgICAgICAg
ICAgICAgICAgYmxrX21xX2Rlc3Ryb3lfcXVldWUoY3RybC0+ZmFicmljc19xKTsNCj4gICAgICAg
ICAgICAgICAgICBibGtfcHV0X3F1ZXVlKGN0cmwtPmZhYnJpY3NfcSk7DQo+IEBAIC01MDQ1LDYg
KzUwNDQsNyBAQCBzdGF0aWMgdm9pZCBudm1lX2ZyZWVfY3RybChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICAgICAgICAgICAgICAgICAgY29udGFpbmVyX29mKGRldiwgc3RydWN0IG52bWVfY3RybCwg
Y3RybF9kZXZpY2UpOw0KPiAgICAgICAgICBzdHJ1Y3QgbnZtZV9zdWJzeXN0ZW0gKnN1YnN5cyA9
IGN0cmwtPnN1YnN5czsNCj4NCj4gKyAgICAgICBibGtfcHV0X3F1ZXVlKGN0cmwtPmFkbWluX3Ep
Ow0KPiAgICAgICAgICBpZiAoIXN1YnN5cyB8fCBjdHJsLT5pbnN0YW5jZSAhPSBzdWJzeXMtPmlu
c3RhbmNlKQ0KPiAgICAgICAgICAgICAgICAgIGlkYV9mcmVlKCZudm1lX2luc3RhbmNlX2lkYSwg
Y3RybC0+aW5zdGFuY2UpOw0KPiAgICAgICAgICBudm1lX2ZyZWVfY2VscyhjdHJsKTsNCj4gLS0N
Cj4NCg0KYWJvdmUgaXMgbXVjaCBiZXR0ZXIgYXBwcm9hY2ggdGhhdCBkb2Vzbid0IHJlbHkgb24g
dGFraW5nIGV4dHJhDQpyZWYgY291bnQgYnV0IHVzaW5nIGV4aXN0aW5nIGNvdW50IHRvIHByb3Rl
Y3QgdGhlIFVBRi4NCkkndmUgYWRkZWQgcmVxdWlyZWQgY29tbWVudHMgdGhhdCBhcmUgdmVyeSBt
dWNoIG5lZWRlZCBoZXJlLA0KdG90YWxseSB1bnRlc3RlZCA6LQ0KDQpudm1lOiBmaXggVUFGIHdo
ZW4gYWNjZXNzaW5nIGFkbWluIHF1ZXVlIGFmdGVyIHJlbW92YWwNCg0KRml4IGEgdXNlLWFmdGVy
LWZyZWUgd2hlcmUgdXNlcnNwYWNlIElPQ1RMcyBjYW4gYWNjZXNzIGN0cmwtPmFkbWluX3ENCmFm
dGVyIGl0IGhhcyBiZWVuIGZyZWVkIGR1cmluZyBjb250cm9sbGVyIHJlbW92YWwuDQoNClRoZSBS
YWNlIENvbmRpdGlvbjoNCg0KIMKgIFRocmVhZCAxICh1c2Vyc3BhY2UgSU9DVEwpwqAgwqAgwqAg
wqAgwqAgVGhyZWFkIDIgKHN5c2ZzIHJlbW92ZSkNCiDCoCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLcKgIMKgIMKgIMKgIMKgIC0tLS0tLS0tLS0tLS0tLS0tLS0NCiDCoCBvcGVuKC9kZXYvbnZt
ZTBuMSkgLT4gZmQ9Mw0KIMKgIGlvY3RsKDMsIE5WTUVfSU9DVExfQURNSU5fQ01EKQ0KIMKgIMKg
IG52bWVfaW9jdGwoKQ0KIMKgIMKgIG52bWVfdXNlcl9jbWQoKQ0KIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWNobyAxID4gLi4uL3Jl
bW92ZQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgcGNpX2RldmljZV9yZW1vdmUoKQ0KIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgbnZtZV9yZW1vdmUoKQ0KIMKgbnZtZV9y
ZW1vdmVfYWRtaW5fdGFnX3NldCgpDQogwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBibGtfcHV0X3F1ZXVlKGFkbWluX3EpDQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBbUkNVIGdyYWNlIHBlcmlvZF0NCiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJsa19mcmVlX3F1ZXVlKGFkbWluX3EpDQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBrbWVtX2NhY2hlX2ZyZWUoKSA8LSBGUkVFRA0KIMKgIMKgIG52bWVfc3VibWl0X3VzZXJf
Y21kKG5zLT5jdHJsLT5hZG1pbl9xKSA8LSBTVEFMRSBQT0lOVEVSDQogwqAgwqAgwqAgYmxrX21x
X2FsbG9jX3JlcXVlc3QoYWRtaW5fcSkNCiDCoCDCoCDCoCDCoCBibGtfcXVldWVfZW50ZXIoYWRt
aW5fcSkNCiDCoCDCoCDCoCDCoCDCoCAqKiogVVNFLUFGVEVSLUZSRUUgKioqDQoNCg0KVGhlIGFk
bWluIHF1ZXVlIGlzIGZyZWVkIGluIG52bWVfcmVtb3ZlX2FkbWluX3RhZ19zZXQoKSB3aGlsZSB1
c2Vyc3BhY2UNCm1heSBzdGlsbCBob2xkIG9wZW4gZmlsZSBkZXNjcmlwdG9ycyB0byBuYW1lc3Bh
Y2UgZGV2aWNlcy4gVGhlc2Ugb3Blbg0KZmlsZSBkZXNjcmlwdG9ycyBjYW4gaXNzdWUgSU9DVExz
IHRoYXQgZGVyZWZlcmVuY2UgY3RybC0+YWRtaW5fcSBhZnRlcg0KaXQgaGFzIGJlZW4gZnJlZWQu
DQoNCkRlZmVyIGJsa19wdXRfcXVldWUoY3RybC0+YWRtaW5fcSkgZnJvbSBudm1lX3JlbW92ZV9h
ZG1pbl90YWdfc2V0KCkgdG8NCm52bWVfZnJlZV9jdHJsKCkuIFNpbmNlIGVhY2ggbmFtZXNwYWNl
IGhvbGRzIGEgY29udHJvbGxlciByZWZlcmVuY2UgdmlhDQpudm1lX2dldF9jdHJsKCkvbnZtZV9w
dXRfY3RybCgpLCB0aGUgY29udHJvbGxlciB3aWxsIG9ubHkgYmUgZnJlZWQgYWZ0ZXINCmFsbCBu
YW1lc3BhY2VzIChhbmQgdGhlaXIgb3BlbiBmaWxlIGRlc2NyaXB0b3JzKSBhcmUgcmVsZWFzZWQu
IFRoaXMNCmd1YXJhbnRlZXMgYWRtaW5fcSByZW1haW5zIGFsbG9jYXRlZCB3aGlsZSBpdCBtYXkg
c3RpbGwgYmUgYWNjZXNzZWQuDQoNCkFmdGVyIGJsa19tcV9kZXN0cm95X3F1ZXVlKCkgaW4gbnZt
ZV9yZW1vdmVfYWRtaW5fdGFnX3NldCgpLCB0aGUgcXVldWUNCmlzIG1hcmtlZCBkeWluZyAoUVVF
VUVfRkxBR19EWUlORyksIHNvIG5ldyBJT0NUTCBhdHRlbXB0cyBmYWlsIHNhZmVseQ0KYXQgYmxr
X3F1ZXVlX2VudGVyKCkgd2l0aCAtRU5PREVWLiBUaGUgcXVldWUgc3RydWN0dXJlIHJlbWFpbnMg
dmFsaWQgZm9yDQpwb2ludGVyIGRlcmVmZXJlbmNlIHVudGlsIG52bWVfZnJlZV9jdHJsKCkgaXMg
Y2FsbGVkLg0KDQotLS0NCiDCoGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDIyICsrKysrKysr
KysrKysrKysrKysrKy0NCiDCoDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4IDczNGFkNzI1ZTZmNC4uZGJiY2Y5OWRiZWY4IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQorKysgYi9kcml2ZXJzL252bWUv
aG9zdC9jb3JlLmMNCkBAIC00ODk3LDcgKzQ4OTcsMTkgQEAgdm9pZCBudm1lX3JlbW92ZV9hZG1p
bl90YWdfc2V0KHN0cnVjdCBudm1lX2N0cmwgDQoqY3RybCkNCiDCoCDCoCDCoCAqLw0KIMKgIMKg
IMKgbnZtZV9zdG9wX2tlZXBfYWxpdmUoY3RybCk7DQogwqAgwqAgwqBibGtfbXFfZGVzdHJveV9x
dWV1ZShjdHJsLT5hZG1pbl9xKTsNCi3CoCDCoCBibGtfcHV0X3F1ZXVlKGN0cmwtPmFkbWluX3Ep
Ow0KK8KgIMKgIC8qKg0KK8KgIMKgIMKgKiBEZWZlciBibGtfcHV0X3F1ZXVlKCkgdG8gbnZtZV9m
cmVlX2N0cmwoKSB0byBwcmV2ZW50IHVzZS1hZnRlci1mcmVlLg0KK8KgIMKgIMKgKg0KK8KgIMKg
IMKgKiBVc2Vyc3BhY2UgbWF5IGhvbGQgb3BlbiBmaWxlIGRlc2NyaXB0b3JzIHRvIG5hbWVzcGFj
ZSBkZXZpY2VzIGFuZA0KK8KgIMKgIMKgKiBpc3N1ZSBJT0NUTHMgdGhhdCBkZXJlZmVyZW5jZSBj
dHJsLT5hZG1pbl9xIGFmdGVyIGNvbnRyb2xsZXIgcmVtb3ZhbA0KK8KgIMKgIMKgKiBzdGFydHMu
IFNpbmNlIGVhY2ggbmFtZXNwYWNlIGhvbGRzIGEgY29udHJvbGxlciByZWZlcmVuY2UsIGRlZmVy
cmluZw0KK8KgIMKgIMKgKiB0aGUgZmluYWwgcXVldWUgcmVsZWFzZSBlbnN1cmVzIGFkbWluX3Eg
cmVtYWlucyBhbGxvY2F0ZWQgdW50aWwgYWxsDQorwqAgwqAgwqAqIG5hbWVzcGFjZSByZWZlcmVu
Y2VzIGFyZSByZWxlYXNlZC4NCivCoCDCoCDCoCoNCivCoCDCoCDCoCogYmxrX21xX2Rlc3Ryb3lf
cXVldWUoKSBhYm92ZSBtYXJrcyB0aGUgcXVldWUgZHlpbmcgDQooUVVFVUVfRkxBR19EWUlORyks
DQorwqAgwqAgwqAqIGNhdXNpbmcgbmV3IHJlcXVlc3RzIHRvIGZhaWwgYXQgYmxrX3F1ZXVlX2Vu
dGVyKCkgd2l0aCAtRU5PREVWIHdoaWxlDQorwqAgwqAgwqAqIGtlZXBpbmcgdGhlIHN0cnVjdHVy
ZSB2YWxpZCBmb3IgcG9pbnRlciBhY2Nlc3MuDQorwqAgwqAgwqAqLw0KIMKgIMKgIMKgaWYgKGN0
cmwtPm9wcy0+ZmxhZ3MgJiBOVk1FX0ZfRkFCUklDUykgew0KIMKgIMKgIMKgIMKgIMKgYmxrX21x
X2Rlc3Ryb3lfcXVldWUoY3RybC0+ZmFicmljc19xKTsNCiDCoCDCoCDCoCDCoCDCoGJsa19wdXRf
cXVldWUoY3RybC0+ZmFicmljc19xKTsNCkBAIC01MDQxLDYgKzUwNTMsMTQgQEAgc3RhdGljIHZv
aWQgbnZtZV9mcmVlX2N0cmwoc3RydWN0IGRldmljZSAqZGV2KQ0KIMKgIMKgIMKgIMKgIMKgY29u
dGFpbmVyX29mKGRldiwgc3RydWN0IG52bWVfY3RybCwgY3RybF9kZXZpY2UpOw0KIMKgIMKgIMKg
c3RydWN0IG52bWVfc3Vic3lzdGVtICpzdWJzeXMgPSBjdHJsLT5zdWJzeXM7DQoNCivCoCDCoCAv
KioNCivCoCDCoCDCoCogUmVsZWFzZSBhZG1pbl9xJ3MgZmluYWwgcmVmZXJlbmNlLiBBbGwgbmFt
ZXNwYWNlIHJlZmVyZW5jZXMgaGF2ZQ0KK8KgIMKgIMKgKiBiZWVuIHJlbGVhc2VkIGF0IHRoaXMg
cG9pbnQuIE5VTEwgY2hlY2sgaXMgbmVlZGVkIGZvciB0byBoYW5kbGUNCivCoCDCoCDCoCogYWxs
b2NhdGlvbiBmYWlsdXJlIGluIG52bWVfYWxsb2NfYWRtaW5fdGFnX3NldCgpLg0KK8KgIMKgIMKg
Ki8NCivCoCDCoCBpZiAoY3RybC0+YWRtaW5fcSkNCivCoCDCoCDCoCDCoCBibGtfcHV0X3F1ZXVl
KGN0cmwtPmFkbWluX3EpOw0KKw0KIMKgIMKgIMKgaWYgKCFzdWJzeXMgfHwgY3RybC0+aW5zdGFu
Y2UgIT0gc3Vic3lzLT5pbnN0YW5jZSkNCiDCoCDCoCDCoCDCoCDCoGlkYV9mcmVlKCZudm1lX2lu
c3RhbmNlX2lkYSwgY3RybC0+aW5zdGFuY2UpOw0KIMKgIMKgIMKgbnZtZV9mcmVlX2NlbHMoY3Ry
bCk7DQoNCi1jaw0KDQoNCg0K

