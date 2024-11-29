Return-Path: <linux-block+bounces-14709-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EB9DC1E1
	for <lists+linux-block@lfdr.de>; Fri, 29 Nov 2024 11:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BD0B20F3B
	for <lists+linux-block@lfdr.de>; Fri, 29 Nov 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81CD153814;
	Fri, 29 Nov 2024 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l6kR5UMQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KLEiWzYq"
X-Original-To: linux-block@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9E14C5B0
	for <linux-block@vger.kernel.org>; Fri, 29 Nov 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732874507; cv=fail; b=Dq+2vfE1Co4kNjxXpgyzJ4Y1JAgumLr8qN5cCNlgGU4U/tm5w3Ci9LSetwOJu5IEVae/lL8q0c37p4vJHljOZzxAA4HDet+dnjn+HrMPHYSIkht6/eSPKiA2XeDUhOHd7PGxa4UYOPVUYGSV2U7C0M7522ZTjNZcWWLbxRPTrRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732874507; c=relaxed/simple;
	bh=u36FuDrD3afn8odQBL04iiqt93/13X8F9BWbGv+XPH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoP5AWPmkoUW6VJLV2nycfZnIx9WnHNWHVylwX2zING0jSWS3J5XZO6IGR+6jtG5WpP7kQas9uZflgrBSSCmAu1ELki1OKA5IDDuMjUKzOoItbxIYPxy2U/JWb3afJ+UEFzHwfqkkCPqAjz7I4Avc/GVZpYtp0T9CnHJpvL/Uik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=l6kR5UMQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KLEiWzYq; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732874505; x=1764410505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=u36FuDrD3afn8odQBL04iiqt93/13X8F9BWbGv+XPH4=;
  b=l6kR5UMQdUOjCDAHg7XSX3OF+arTK9Hq65W0PGukQLfbAiCcUy87mr51
   uUJos/Yx2nUE6jFYcXGvSvdVKGyD7KVpbGTXZ3NiOi53CYFUM57iB7MHe
   YeAy8s1tUvoJhjB6am76tC2/xylYCrCBQ+wDFktO9wprBkjSt/htTtWXS
   2VN0pW3RDiTY7yTw+DfDLIPh3yo3i3QQQHrcLVsL6VWxAPhHBgmCMR4Ja
   FrcMba/E0nXhzhthOHwv4vPyS3jdgAlaAGjFjO+eGGJ6Et9M/Tiv3Y9lp
   gpSudpK4i2TppIFJGl7RWbZjJzAbiRIJl5WfJL+Gr/XtUYYY5vb3lysQM
   A==;
X-CSE-ConnectionGUID: nk8mTfD6RvWBaQ4R9oQcYw==
X-CSE-MsgGUID: pqUrurfSQWCsYcJT3EHwEg==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208,223";a="33711652"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 18:01:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUsGCibmczcmdHS12njkeub94RQ1Madwo0Ym/5DapiOC9kEF7apUznP2NSu0AWv4WbtVyYRKhLOdIA6p9Fvah9AyvSu8yHTYzW5HxYj9JFcrXR54snoy0OT8gm20t1LKvLdlpJHbuepy1yyvSfi5dJ0p5Jo2m5a3jKp5/CT2XY6px3qcvupAqOiYBwWtL12ENyBtLHRooo7O8JV9ROvUkONlsn909g6XVgu1npmvqjk1l/Fp2DEMAM2xkEz9MlJV5OI6CZcK13x6eU+C9hZ4kivQCQe1udz1Lf+YD0Zh6gievWIXkSwbOhmrRiXAZtrOeMRh8SHmKr7tLexHm6drAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmgBdb762q9YROHQ/oKWPXLCwjMCik7A/jEOFS4EPZY=;
 b=AcyZY9ajLTsNJbW7qdPWJWynuldcnr/oclTu8zhgReupjVoZQzGAEStZZg6zWN+8DYtLczjByVxgYVoYyZkqHyUAa8H+J+2ODsQdYu8HATuGG2UXuLhsppWX8o5CAKx7MffFPdpBVPtFs9F+3NIUMA1PrZXQX1k6dYX7wMJNTxBSePBNACJaa1ZKmSO+0MGzl2eDQ+S7Uz0MM9DB6kLy50NFLa42jhNK5F7QXaV2+DjIDRwmdTvVSLGXoIXJzq+0t6xhIJ+HoVs6ZRVZqHEDbg9Ba4x9jLek/loHXzSc5+JeWpCovc2UOfRXZorLReYBmyu/wmci+QDQXq1EjQ6QiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmgBdb762q9YROHQ/oKWPXLCwjMCik7A/jEOFS4EPZY=;
 b=KLEiWzYqkzJHPDkD4LMf3yIelDEYHNG8IQlUoPrQ4aT5GlB+5l8T8ZKT8JfdrN6UVAU4UWl5NHXQqPdphwQ1ot2aoc23psjxo6qavdnZKdLg8Mzj2gqIfLXSvCdUqZDf2pZlBALXd57JFoiRKriVLqd4lJDQSE0FLS3C6aIqr+k=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6969.namprd04.prod.outlook.com (2603:10b6:5:240::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.15; Fri, 29 Nov 2024 10:01:36 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 10:01:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Aurelien Aptel <aaptel@nvidia.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Shai
 Malin <smalin@nvidia.com>
Subject: Re: [PATCH blktests v4 1/5] nvme/rc: introduce remote target support
Thread-Topic: [PATCH blktests v4 1/5] nvme/rc: introduce remote target support
Thread-Index: AQHbQENPQdcUDXMh9U2n5ldD0qdq1rLOCtAA
Date: Fri, 29 Nov 2024 10:01:35 +0000
Message-ID: <ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2@kncqoxdc77zi>
References: <20241126203857.27210-1-aaptel@nvidia.com>
 <20241126203857.27210-2-aaptel@nvidia.com>
In-Reply-To: <20241126203857.27210-2-aaptel@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB6969:EE_
x-ms-office365-filtering-correlation-id: 990b169a-eea2-4696-43e0-08dd105ccf15
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MG1KazYxeGs5S0luL0d0eG9pak82U0M1bjh4cWQ3ZnFiMzRneFJ0Sm9xKy9Y?=
 =?utf-8?B?RVBvNWhXaEh5N0RWZmhXbFdkbFRjYmZlbk5IU2lmbktSNklzSUFLOFdpMzFG?=
 =?utf-8?B?WHFLR1hoSmt5K3VERTBUWVgvZlNXWGRHRlRvTUQ4TE5lRHJtbmJRelF2S3ht?=
 =?utf-8?B?cFVIYVMveDVoTitMRTA4M0xGZGhhWkxSTnQrREFJeHZqM1ZXNzlHVm40eVJr?=
 =?utf-8?B?TnZqbDVDampjMGZwc3M4Nlo1eEptdnE4U0FjSUdwZDB5TjFFQXlyN2lwcFpt?=
 =?utf-8?B?WlM1M0hqKzNjOFJXKzI4d2RhVVdCSG8xbXRTbmhBdy92eXZrYk5zL2txNUdV?=
 =?utf-8?B?ZS94cXRaY2dpZm91anNaM3JDMlZDSW9SckVsK0swNlZQYkdVeUs0RVdqRzlj?=
 =?utf-8?B?ZmhsZk84ZUJTb1JwWldTeWdoaklCT0pOVTVDekY2cUM4bGJxSmFVV0VKeFFU?=
 =?utf-8?B?cWc5UHphWmQzdnl3bHl0WTgrTDY0ZTQ1NGJFUmtkak1IYzBQcHJSNmlkamE2?=
 =?utf-8?B?OXpzUll2bXFjZ3lZWHpkcHZyL2F5bmRSVkNPV0xmeWdicHFDVTJFazc4dWpx?=
 =?utf-8?B?bjZwMWtZWlNMamsrOE5uTkhHSURhc1h0OVdvUXhGTEpEZkVOdjVId2Q5YXVa?=
 =?utf-8?B?bG5QSngrV24yMWZIUWQydEZ3Vm50K0JKOG1BNDQxRm54ejJmU0NRSWhpdEFn?=
 =?utf-8?B?eVJFK0tMSG5TQW5GRTVNV3QvM2NhVVVTNkk2YmFmSTRoRmMxUWxaNm9sMks5?=
 =?utf-8?B?MURyaE4zUkdkM1pzU1hQL2F3QWlLNjlIZFJMNEViVm44MXpvdnlUREFtTW1j?=
 =?utf-8?B?U1dNM2NvTGNvRGo2SFUyLzM2WVVVQUJ6djZIQi9tTlhTWExFRlNTZy9IZ1g0?=
 =?utf-8?B?ODVrSXFPdEkzNXZmQXBwaWZPSzNPMWdyYmUyOHl4cWorZ2NnWTlPZkc2Tk5u?=
 =?utf-8?B?QUJ2RWxsQjJMOXIyMnMvSFlCWUhaWHd4Q0FWK2syZHlIZk4wWmFtOE8rVUlM?=
 =?utf-8?B?QUpYWGFFN25YU1RtVk1uQ09KeGNXaWJnekhqTklvd3puak1YWThJMlNEVU9F?=
 =?utf-8?B?STlYcm10Q3ZtWkZmUG5JQkpNcHVndTA5bXZrck90dlJvWXBqa0pJbTBzUm1Z?=
 =?utf-8?B?OUh6MzRQM0R3QjhCUm9vRElnRUluZndTR0R3dG9YR0dFa21jWDdpSjI1VVYw?=
 =?utf-8?B?Z2lVelVvcUhLTVdzMXEwVElaZ0RySmpDRlNkeEVOcjJPYnlObmVQZzU4Uysy?=
 =?utf-8?B?VnFockJFblUzQ0x3TXh1TFVvU1Q2a3Y0TWs0NXA4YWpxdkJkeHk3aUd6Rk5o?=
 =?utf-8?B?N3RIYThvQnFmR01ZaThtY2xQQXBQbjRRRUEzdnZIZitTTXJJaDE2dmVyYmpy?=
 =?utf-8?B?SHFWb0Q5L3hDMWxnUTIzN0hQRDBZN00rN2ZGRm9UV1pYbzhTdFF6WEtPTFNG?=
 =?utf-8?B?Qjk0a1NSeXBOZE9QK01MTzVSNk9GUDJVVEdqaWNRNDN5Y0NEcGthQzFLNUh2?=
 =?utf-8?B?bTBpTGlwamord0pJSXUxaEhMTndxZStlcVFKcEtXNUs5Qk5vWDA2WWNIcGJX?=
 =?utf-8?B?enpyY0YwbU5la0RYRWQxMnk1SEpLWE9oQkpKMGhhdks2S3F3eDhWN2VsaXpQ?=
 =?utf-8?B?M1JrQ3p0SEZ4Q2dqNVh0eTZZYTRqVmJ5TXhHbnRIQVIySjhsTHhPUE1CbTBj?=
 =?utf-8?B?Lyt1dDBzeVdPV2JSNFljdkUxNys3ZUhOUllVcVRnVFRNOXVHYVBlN2xkSFdo?=
 =?utf-8?B?KzhDS3Y0NG0zamRjcWpOVTE5YlBXYUNyQnVNeUFCNlNQaDBoOWlwVmtRRGpJ?=
 =?utf-8?B?aktGZ1dWMUdCbzhTa2lvdHF4eERjNG9kQmxvRkRsMUJMa0hGWUtkNlJOUWMy?=
 =?utf-8?B?bjg0TTV3aVhKQ3JzbG5SYUp0dndWd0crV0dERlZzUklSR1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEZ5VTJndUplZUhHa3JTVHZJOUhCS2Y1Sll4aGFYUk1vanpQRG5CUmE3OGJD?=
 =?utf-8?B?NFVNLzFCdWpIOURKc2NlMFZvUFNBWTREYmpXT0F6dC9PVnUzWFE4bGkydVA4?=
 =?utf-8?B?dFZseWxUSTBCamc5OUN3d1NLbndzdDdBRFJXVG5KaHBldGpyalBkT1RrQ2FS?=
 =?utf-8?B?RUYwdnFTQTZpTnR2VXNqekF2WUpmTVlGRGd1OHdBb0RtTEQ4ZVlnUStyNnlO?=
 =?utf-8?B?b2lvN0YvZk9iZXZzc043TjFrK1A1UXQzTld3cHFkalFNTEhJS2V3Y2tyNlVz?=
 =?utf-8?B?dHk0L1hyVUZtWnprV1BRYyt0bjkvSTF2ZDMwV1BoRWxTTzdYTVhDWU5YU0JR?=
 =?utf-8?B?dHRVdmlyc243dk9TV2o0SDdBOC9TY0ZWWmtuYU9Jb0IyTFliUXNhUUJQK3dN?=
 =?utf-8?B?L1NtbDUwOFRqeHdLK3lkWVI2VGJSSEZPOXdZek9XaFRXRVNscjJaTzl6YzZr?=
 =?utf-8?B?eXkxanJPeHp5Z1ArRVE4Mmp4a1hHbzYwUFN3cC9nRDZCczUyT25yQThpSnNY?=
 =?utf-8?B?clE0aGdGZDNrZDFSd1k1eCtrbUV5TkFwZTg4QWV2YUt1ZXBKRUNOV3ZuaU5R?=
 =?utf-8?B?RmNYVGFvTlpyVFV2eFVaeWc4UmNQNkEzdk9RS3lzUTVlOHlMMDkvQ2huQlls?=
 =?utf-8?B?NUNuVTk0RU14RURDZStBL3VrTEdQR1ExK3R5MWlBd2FiYjVZT0xEc2NYSXFR?=
 =?utf-8?B?d3RLa244eHhzeW5sSE03QmNKZExZWTNaenh2U2FEZ0lhNlVvbGZFVFhYWjU0?=
 =?utf-8?B?eTRZcWVUb0VhOUk0SlMrNDltVk9tMGVkcWtOZXRyc0VIVTNTbkd1SU9zN0VP?=
 =?utf-8?B?dHdLZ0gyaDFIbjdrQithUDFjNHFFSkdKUWZkWWNvTnRjbU5ObWN5WTVIQlda?=
 =?utf-8?B?emFtbUh1YnpNclJaa2UwaTQzaVI5bFZRR3REbXd1amFNRWYxQll6SDBDYVlv?=
 =?utf-8?B?ZlBWTC9xeEVUekhZdktUK1FRRGZOSlRpUEl3ZGFYWjVSQmdub1NGRHNrUjRV?=
 =?utf-8?B?SGNONnViNnM3cHpPVzRTZEsxdFpuVEpXU3pvNXl2WmJkSHVMbGF2MVBpNFZh?=
 =?utf-8?B?U3dzZW5EdVoxZUN3RU9YZENSNDZrajJRTVhvMnNjdFFGU0RlQkVzYy9hOGxr?=
 =?utf-8?B?WDBMblJxbHEvc2RvdThTejR4QXZkWWhjOHc2YUNFUXZJdWVuSWxkZ0FiaVJm?=
 =?utf-8?B?d1hteTFIcVBadDZPNEdwNHZzUE9tdm9NOXdXRVpYZkJjNlVQdmVFak55MjJk?=
 =?utf-8?B?TVBYVmdaUVdEZWdyeWpZUXI3UW4zb0Q1SCtYYnZJWXJxMURTNWl2Q21DTXFk?=
 =?utf-8?B?WlRhOHZSME8zVGNSZlhEV1dISUF6RkhyNlZLUGRyZjVwRXp0QWxOUloyazVM?=
 =?utf-8?B?YmxwWFd4TUl5b0NyL0dlZ01xb2pJcnY1Q0dwR0xzRTcycTJ5TnFZZjIxekJJ?=
 =?utf-8?B?eXJrVHhnNUh2YkZlK2R2cGR3eGZJYmNYT1hEUGJxMlZwWjRVa1d6cm5rY1VY?=
 =?utf-8?B?YTNSbFhiNzdLTC92MHcxUlppNjFCdjBIM3Z6d1ZEOVpmU2ZEQ2NsY1QzQWI0?=
 =?utf-8?B?bWtwck5NSnlXOFJDbGNiT0NoM0o5N01sSHhSVWJtRTJaN29vRHNGeXB6bDJV?=
 =?utf-8?B?OUY1V1Rxc3lhRVViUUllZFNaUnB2bDJtNjhXaUhNcWpWRXRZT1dsVDhQR2FJ?=
 =?utf-8?B?djQ0a0hKVVp2Y1puUW4rc0wzcHJGMmh3N1lYcmI0MnU2c011bXF3N1NIMG5M?=
 =?utf-8?B?UUZMaThtck5UdENRdFdBVThkVUZPQzJmZGJaclhDK3JsVHRYVEFFcXRrVGZ5?=
 =?utf-8?B?dVFpVDlBMWhOOERTVlMvRlBiN3MwYXhDREJ1c2p4MHljNi9pQnJQUGtOU2xa?=
 =?utf-8?B?dlZGN1N0eGJ4YVdQWVdQeHorUDEzMGtDKzRLUHpXdFN0WGxTdXEraGhYajJq?=
 =?utf-8?B?ZWFyYnlXV2ZKSVZzKzUyU2hIdWxhSVMzaGpqV2RMT21lVDBuNGhvMnYyMGhZ?=
 =?utf-8?B?bm43eDFqUHJzcmJsbFFQbTFjS3RVQ0xXYUhoYVE2TkxFajVvNWIvQTdsaWtB?=
 =?utf-8?B?MVZxRWhzbXl4ZDdHUzQ3MGF5SjE0YzhiOVordzRFS0hiaVVMbCswa1hMS0ky?=
 =?utf-8?B?OWJHWmhMOGF3ZVFGdlZWT3lvV2V5emN3YXB5dUJic2pNL25sNDRGZ0xqS0Zu?=
 =?utf-8?Q?XQxWJduZ6JMKiJO4pKEI3oQ=3D?=
Content-Type: multipart/mixed;
	boundary="_002_ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2kncqo_"
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B2ysd96Dkuu+yefWnY8spazc73zWifDRfu6F6LJ3vkk9R9wPkfjecz9UBSnK4vvRqjWbHjhsO4ZUOpsENpi1QoBuSRByxwYSlpF42IHNITzBPpB0Yk7zDhBOctoa/ma6oVvjSJFLn4gAI0YjgM879z6UxYoTaOA+e43F/zBLrZJHM9XsvBoWtDSus4H1gok3lUmJYdH3A9RrMQKioIrdnbBElL7iqhNzsMOUOm4RNjFuMgSgDT1IjBteYgx1jx9xiQI1zP1s3FH7FfKr1baRpUtIUDJ4TMrax/dcbk34V6KAnNw9yj/KheInhGoZ7Gy2OijNSwlaO5J8cLzY02h4URoTtaXUJ1LAGOLxmxpPPS2Ewiq/i+zDKH/GvjpgZ1X48pwWP4/LK9Q5KQsV5N6UuvPRWNLQtDLMQ50rqwOI2zTzpJSQ524lCTJXFBI1ddv4BpMzA742HPQZVRNCeQ4AidXSgTrVOadq4d2FLbLB8oXesHy9fLyqTmmwihYhuNyayHEkmvC/48q6r11nNEFXZV440jNfkvSxDkawHo2OKGkGJWBhgjssmaL4KQuPsM/XRMwKGUhevyQhM4VcbAgOXkVCQhDUtzMNRmvTCjfRjA7YXspKKyX8Hsqjwqa+gd5m
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990b169a-eea2-4696-43e0-08dd105ccf15
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 10:01:35.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5SfIslRM6OtlBKS1Xp9QbPsqrPSnR9OtAQoxGps17o5q3lFGLJmNxpRoU0ox5JLVh+59vQk1OyzOlOpH7BtQR9TiGxzGD9WFaJLCr4s+Qg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6969

--_002_ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2kncqo_
Content-Type: text/plain; charset="utf-8"
Content-ID: <06668AC3A8BCAA449A25845AFFB612CB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

SGVsbG8gQXVyZWxpZW4sDQoNClRoYW5rIHlvdSBmb3IgcmViYXNpbmcgdGhlIHNlcmllcy4gUGxl
YXNlIGZpbmQgbXkgY29tbWVudHMgaW4gbGluZS4NCg0KV2hlbiBJIHJhbiAibWFrZSBjaGVjayIs
IEkgb2JzZXJ2ZWQgc29tZSBTaGVsbENoZWNrIHdhcm5pbmdzLiBUaGlzIGNoZWNrIGJlZm9yZQ0K
cG9zdHMgd2lsbCBiZSBhcHByZWNpYXRlZC4gQXMgZm9yIHRoZSB0d28gU2hlbGxDaGVjayB3YXJu
aW5ncywgcGxlYXNlIGZpbmQgbXkNCmNvbW1lbnRzIGJlbG93LiBUaGlzIHBhdGNoIGFsc28gdHJp
Z2dlcmVkIFNoZWxsQ2hlY2sgd2FybmluZ3MgaW4gb3RoZXIgZmlsZXMuDQpGb3IgdGhvc2Ugd2Fy
bmluZ3MsIEkgY3JlYXRlZCBhIGZpeCBwYXRjaCBhbmQgYXR0YWNoZWQgZm9yIHlvdXIgcmVmZXJl
bmNlLg0KDQpPbiBOb3YgMjYsIDIwMjQgLyAyMjozOCwgQXVyZWxpZW4gQXB0ZWwgd3JvdGU6DQpb
Li4uXQ0KPiBkaWZmIC0tZ2l0IGEvY29tbW9uL252bWUgYi9jb21tb24vbnZtZQ0KPiBpbmRleCBm
ZDQ3MmZlLi5mOTlhZjVhIDEwMDY0NA0KPiAtLS0gYS9jb21tb24vbnZtZQ0KPiArKysgYi9jb21t
b24vbnZtZQ0KWy4uLl0NCj4gQEAgLTIwOCw2ICsyMTMsMTggQEAgX2NsZWFudXBfbnZtZXQoKSB7
DQo+ICANCj4gIF9zZXR1cF9udm1ldCgpIHsNCj4gIAlfcmVnaXN0ZXJfdGVzdF9jbGVhbnVwIF9j
bGVhbnVwX252bWV0DQo+ICsNCj4gKwlpZiBbWyAtbiAiJHtudm1lX3RhcmdldF9jb250cm9sfSIg
XV07IHRoZW4NCj4gKwkJZGVmX2hvc3RucW49IiQoJHtudm1lX3RhcmdldF9jb250cm9sfSBjb25m
aWcgLS1zaG93LWhvc3RucW4pIg0KPiArCQlkZWZfaG9zdGlkPSIkKCR7bnZtZV90YXJnZXRfY29u
dHJvbH0gY29uZmlnIC0tc2hvdy1ob3N0aWQpIg0KPiArCQlkZWZfaG9zdF90cmFkZHI9IiQoJHtu
dm1lX3RhcmdldF9jb250cm9sfSBjb25maWcgLS1zaG93LWhvc3QtdHJhZGRyKSINCg0KSSBzdWdn
ZXN0IHRvIHJlbW92ZSB0aGUgbGluZSBhYm92ZS4gSXQgY2F1c2VkIFNoZWxsQ2hlY2sgd2Fybmlu
ZyBTQzIwMzQuIEkgdGhpbmsNCmRlZl9ob3N0X3RyYWRkciBpcyBub3QgdXNlZCBhbnl3aGVyZS4N
Cg0KPiArCQlkZWZfdHJhZGRyPSIkKCR7bnZtZV90YXJnZXRfY29udHJvbH0gY29uZmlnIC0tc2hv
dy10cmFkZHIpIg0KPiArCQlkZWZfdHJzdmNpZD0iJCgke252bWVfdGFyZ2V0X2NvbnRyb2x9IGNv
bmZpZyAtLXNob3ctdHJzdmlkKSINCj4gKwkJZGVmX3N1YnN5c191dWlkPSIkKCR7bnZtZV90YXJn
ZXRfY29udHJvbH0gY29uZmlnIC0tc2hvdy1zdWJzeXMtdXVpZCkiDQo+ICsJCWRlZl9zdWJzeXNu
cW49IiQoJHtudm1lX3RhcmdldF9jb250cm9sfSBjb25maWcgLS1zaG93LXN1YnN5c25xbikiDQo+
ICsJCXJldHVybg0KPiArCWZpDQo+ICsNCj4gIAltb2Rwcm9iZSAtcSBudm1ldA0KPiAgCWlmIFtb
ICIke252bWVfdHJ0eXBlfSIgIT0gImxvb3AiIF1dOyB0aGVuDQo+ICAJCW1vZHByb2JlIC1xIG52
bWV0LSIke252bWVfdHJ0eXBlfSINClsuLi5dDQo+IEBAIC04MTEsNiArODM2LDI5IEBAIF9udm1l
dF90YXJnZXRfc2V0dXAoKSB7DQo+ICAJCWZpDQo+ICAJZmkNCj4gIA0KPiArCWlmIFtbIC1uICIk
e2hvc3RrZXl9IiBdXTsgdGhlbg0KPiArCQlBUkdTKz0oLS1ob3N0a2V5ICIke2hvc3RrZXl9IikN
Cj4gKwlmaQ0KPiArCWlmIFtbIC1uICIke2N0cmxrZXl9IiBdXTsgdGhlbg0KPiArCQlBUkdTKz0o
LS1jdHJrZXkgIiR7Y3RybGtleX0iKQ0KPiArCWZpDQoNClRoaXMgcGFydCBhYm92ZSBzZXRzIGFy
Z3VtZW50cyAtLWhvc3RrZXkgYW5kIC0tY3Rya2V5IGluIEFSR1MgdG8gcGFzcyB0bw0KX2NyZWF0
ZV9udm1ldF9zdWJzeXN0ZW0oKSwgYnV0IEkgZmluZCB0aGF0IF9jcmVhdGVfbnZtZXRfc3Vic3lz
dGVtKCkgZG9lcyBub3QNCnJlZmVyIHRvIHRoZSBhcmd1bWVudHMuIFRob3VnaCBJIGtub3cgdGhp
cyBwYXJ0IHdhcyBpbiB2MyBhbHNvLCBJIHN1Z2dlc3QgZHJvcA0KdGhpcyBwYXJ0Lg0KDQo+ICsN
Cj4gKwlpZiBbWyAtbiAiJHtudm1lX3RhcmdldF9jb250cm9sfSIgXV07IHRoZW4NCj4gKwkJZXZh
bCAiJHtudm1lX3RhcmdldF9jb250cm9sfSIgc2V0dXAgXA0KPiArCQkJLS1zdWJzeXNucW4gIiR7
c3Vic3lzbnFufSIgXA0KPiArCQkJLS1zdWJzeXMtdXVpZCAiJHtzdWJzeXNfdXVpZDotJGRlZl9z
dWJzeXNfdXVpZH0iIFwNCj4gKwkJCS0taG9zdG5xbiAiJHtkZWZfaG9zdG5xbn0iIFwNCj4gKwkJ
CSIke0FSR1NbQF19IiAmPiAvZGV2L251bGwNCg0KVGhlIGxpbmUgYWJvdmUgY2F1c2VzIHRoZSBT
aGVsbENoZWNrIHdhcm5pbmcgU0MgMjI5NC4gTGV0J3MgcmVwbGFjZSAke0FSR1NbQF19DQp3aXRo
ICR7QVJHU1sqXX0uDQoNCj4gKwkJcmV0dXJuDQo+ICsJZmkNCj4gKw0KPiArCXRydW5jYXRlIC1z
ICIke05WTUVfSU1HX1NJWkV9IiAiJChfbnZtZV9kZWZfZmlsZV9wYXRoKSINCj4gKwlpZiBbWyAi
JHtibGtkZXZfdHlwZX0iID09ICJkZXZpY2UiIF1dOyB0aGVuDQo+ICsJCWJsa2Rldj0iJChsb3Nl
dHVwIC1mIC0tc2hvdyAiJChfbnZtZV9kZWZfZmlsZV9wYXRoKSIpIg0KPiArCWVsc2UNCj4gKwkJ
YmxrZGV2PSIkKF9udm1lX2RlZl9maWxlX3BhdGgpIg0KPiArCWZpDQoNClRoaXMgdHJ1bmNhdGUg
YW5kIGJsa2RldiBzZXR1cCBwYXJ0IGNhdXNlcyBmYWlsdXJlIG9mIG52bWUvMDUyOg0KDQpudm1l
LzA1MiAodHI9bG9vcCkgKFRlc3QgZmlsZS1ucyBjcmVhdGlvbi9kZWxldGlvbiB1bmRlciBvbmUg
c3Vic3lzdGVtKSBbZmFpbGVkXQ0KICAgIHJ1bnRpbWUgIDUuNzI4cyAgLi4uICA1LjI2N3MNCiAg
ICAtLS0gdGVzdHMvbnZtZS8wNTIub3V0ICAgICAgMjAyNC0xMS0wNSAxNzowNDo0MC41OTY5MDM2
MDMgKzA5MDANCiAgICArKysgL2hvbWUvc2hpbi9CbGt0ZXN0cy9ibGt0ZXN0cy9yZXN1bHRzL25v
ZGV2X3RyX2xvb3AvbnZtZS8wNTIub3V0LmJhZCAgICAgMjAyNC0xMS0yOSAxNDo0NToyMy4wNjU4
NjEzMTYgKzA5MDANCiAgICBAQCAtMSwyICsxLDQgQEANCiAgICAgUnVubmluZyBudm1lLzA1Mg0K
ICAgICtta2RpcjogY2Fubm90IGNyZWF0ZSBkaXJlY3Rvcnkg4oCYL3N5cy9rZXJuZWwvY29uZmln
L252bWV0Ly9zdWJzeXN0ZW1zL2Jsa3Rlc3RzLXN1YnN5c3RlbS0xL25hbWVzcGFjZXMvMeKAmTog
RmlsZSBleGlzdHMNCiAgICArY29tbW9uL252bWU6IGxpbmUgNTU0OiBwcmludGY6IHdyaXRlIGVy
cm9yOiBEZXZpY2Ugb3IgcmVzb3VyY2UgYnVzeQ0KICAgICBUZXN0IGNvbXBsZXRlDQoNCkFsc28s
IHRoaXMgcGFydCBsb29rcyBkdXBsaWNhdGVkIHdpdGggdGhlIG90aGVyIHBhcnQgaW4gX252bWV0
X3RhcmdldF9zZXR1cCgpLg0KUGxlYXNlIHNlZSB0aGUgJ2lmIFtbICIke2Jsa2Rldl90eXBlfSIg
IT0gIm5vbmUiIF1dJyBibG9jay4NCg0KSSBndWVzcyB0aGlzIGlzIHRoZSBwYXJ0IHlvdSBhZGRl
ZCAidG8gc3BlY2lmeSB0aGUgYmFja2luZyBibG9jayBkZXZpY2Ugb24gdGhlDQp0YXJnZXQsIGlu
c3RlYWQgb2YgaGFyZGNvZGluZyAnL2Rldi92ZGMnIi4gSWYgc28sIEkgdGhpbmsgc3VjaCBjaGFu
Z2VzIHNob3VsZA0KYmUgZG9uZSB1bmRlciAnaWYgW1sgLW4gIiR7bnZtZV90YXJnZXRfY29udHJv
bH0iIF1dJyBjb25kaXRpb24uDQoNCg==

--_002_ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2kncqo_
Content-Type: text/plain;
	name="0001-nvme-041-045-051-double-quote-def_-variable-referenc.patch"
Content-Description:
 0001-nvme-041-045-051-double-quote-def_-variable-referenc.patch
Content-Disposition: attachment;
	filename="0001-nvme-041-045-051-double-quote-def_-variable-referenc.patch";
	size=4856; creation-date="Fri, 29 Nov 2024 10:01:35 GMT";
	modification-date="Fri, 29 Nov 2024 10:01:35 GMT"
Content-ID: <8F2785239C9C464FB9C8CC394B02B7C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBiODZmMjZiNDc3MmVmNWE0NTg2ODVmYmY3ZGNhMTRhNTA1NTFhODE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8ua2F3
YXNha2lAd2RjLmNvbT4NCkRhdGU6IEZyaSwgMjkgTm92IDIwMjQgMTA6NDg6MzEgKzA5MDANClN1
YmplY3Q6IFtQQVRDSF0gbnZtZS97MDQxLTA0NSwwNTF9OiBkb3VibGUgcXVvdGUgZGVmXyogdmFy
aWFibGUgcmVmZXJlbmNlcw0KDQpUaGUgZm9sbG93aW5nIGNvbW1pdCB3aWxsIGFkZCB0aGUgY29k
ZSB0byBzZXQgbnZtZSBjb21tYW5kIG91dHB1dCB0bw0KZGVmXyogdmFyaWFibGVzLiBUaGlzIHdp
bGwgdHJpZ2dlciB0aGUgU2hlbGxDaGVjayB3YXJuaW5nIFNDMjA4Ni4gVG8NCnByZXBhcmUgZm9y
IHRoZSBjaGFuZ2UsIGRvdWJsZSBxdW90ZSB0aGUgcmVmZXJlbmNlcyB0byB0aGUgZGVmXyoNCnZh
cmlhYmxlcy4gQXMgZm9yIG52bWUvMDUxLCB0aGUgbG9jYWwgdmFyaWFibGUgbnMgaXMgaW5pdGlh
bGl6ZWQgd2l0aA0KZGVmX3N1YnN5c25xbiwgdGhlbiBpdCByZXF1aXJlcyBkb3VibGUgcXVvdGUg
YWxzby4NCg0KU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4NCi0tLQ0KIHRlc3RzL252bWUvMDQxIHwgMiArLQ0KIHRlc3RzL252
bWUvMDQyIHwgNCArKy0tDQogdGVzdHMvbnZtZS8wNDMgfCAyICstDQogdGVzdHMvbnZtZS8wNDQg
fCA0ICsrLS0NCiB0ZXN0cy9udm1lLzA0NSB8IDggKysrKy0tLS0NCiB0ZXN0cy9udm1lLzA1MSB8
IDQgKystLQ0KIDYgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0cy9udm1lLzA0MSBiL3Rlc3RzL252bWUvMDQxDQppbmRl
eCBhYTQ0ZjA0Li45NGY4NGYxIDEwMDc1NQ0KLS0tIGEvdGVzdHMvbnZtZS8wNDENCisrKyBiL3Rl
c3RzL252bWUvMDQxDQpAQCAtMzEsNyArMzEsNyBAQCB0ZXN0KCkgew0KIAlsb2NhbCBob3N0a2V5
DQogCWxvY2FsIGN0cmxkZXYNCiANCi0JaG9zdGtleT0iJChudm1lIGdlbi1kaGNoYXAta2V5IC1u
ICR7ZGVmX3N1YnN5c25xbn0gMj4gL2Rldi9udWxsKSINCisJaG9zdGtleT0iJChudm1lIGdlbi1k
aGNoYXAta2V5IC1uICIke2RlZl9zdWJzeXNucW59IiAyPiAvZGV2L251bGwpIg0KIAlpZiBbIC16
ICIkaG9zdGtleSIgXSA7IHRoZW4NCiAJCWVjaG8gIm52bWUgZ2VuLWRoY2hhcC1rZXkgZmFpbGVk
Ig0KIAkJcmV0dXJuIDENCmRpZmYgLS1naXQgYS90ZXN0cy9udm1lLzA0MiBiL3Rlc3RzL252bWUv
MDQyDQppbmRleCA3MGM5MDU2Li4xN2Q4YTczIDEwMDc1NQ0KLS0tIGEvdGVzdHMvbnZtZS8wNDIN
CisrKyBiL3Rlc3RzL252bWUvMDQyDQpAQCAtMzcsNyArMzcsNyBAQCB0ZXN0KCkgew0KIA0KIAlm
b3IgaG1hYyBpbiAwIDEgMiAzOyBkbw0KIAkJZWNobyAiVGVzdGluZyBobWFjICR7aG1hY30iDQot
CQlob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLS1obWFjPSR7aG1hY30gLW4gJHtkZWZf
c3Vic3lzbnFufSAyPiAvZGV2L251bGwpIg0KKwkJaG9zdGtleT0iJChudm1lIGdlbi1kaGNoYXAt
a2V5IC0taG1hYz0ke2htYWN9IC1uICIke2RlZl9zdWJzeXNucW59IiAyPiAvZGV2L251bGwpIg0K
IAkJaWYgWyAteiAiJGhvc3RrZXkiIF0gOyB0aGVuDQogCQkJZWNobyAiY291bGRuJ3QgZ2VuZXJh
dGUgaG9zdCBrZXkgZm9yIGhtYWMgJHtobWFjfSINCiAJCQlyZXR1cm4gMQ0KQEAgLTUxLDcgKzUx
LDcgQEAgdGVzdCgpIHsNCiANCiAJZm9yIGtleV9sZW4gaW4gMzIgNDggNjQ7IGRvDQogCQllY2hv
ICJUZXN0aW5nIGtleSBsZW5ndGggJHtrZXlfbGVufSINCi0JCWhvc3RrZXk9IiQobnZtZSBnZW4t
ZGhjaGFwLWtleSAtLWtleS1sZW5ndGg9JHtrZXlfbGVufSAtbiAke2RlZl9zdWJzeXNucW59IDI+
IC9kZXYvbnVsbCkiDQorCQlob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLS1rZXktbGVu
Z3RoPSR7a2V5X2xlbn0gLW4gIiR7ZGVmX3N1YnN5c25xbn0iIDI+IC9kZXYvbnVsbCkiDQogCQlp
ZiBbIC16ICIkaG9zdGtleSIgXSA7IHRoZW4NCiAJCQllY2hvICJjb3VsZG4ndCBnZW5lcmF0ZSBo
b3N0IGtleSBmb3IgbGVuZ3RoICR7a2V5X2xlbn0iDQogCQkJcmV0dXJuIDENCmRpZmYgLS1naXQg
YS90ZXN0cy9udm1lLzA0MyBiL3Rlc3RzL252bWUvMDQzDQppbmRleCBjZjk5ODY1Li43ZjllNjdl
IDEwMDc1NQ0KLS0tIGEvdGVzdHMvbnZtZS8wNDMNCisrKyBiL3Rlc3RzL252bWUvMDQzDQpAQCAt
MzQsNyArMzQsNyBAQCB0ZXN0KCkgew0KIAlsb2NhbCBob3N0a2V5DQogCWxvY2FsIGN0cmxkZXYN
CiANCi0JaG9zdGtleT0iJChudm1lIGdlbi1kaGNoYXAta2V5IC1uICR7ZGVmX2hvc3RucW59IDI+
IC9kZXYvbnVsbCkiDQorCWhvc3RrZXk9IiQobnZtZSBnZW4tZGhjaGFwLWtleSAtbiAiJHtkZWZf
aG9zdG5xbn0iIDI+IC9kZXYvbnVsbCkiDQogCWlmIFsgLXogIiRob3N0a2V5IiBdIDsgdGhlbg0K
IAkJZWNobyAibnZtZSBnZW4tZGhjaGFwLWtleSBmYWlsZWQiDQogCQlyZXR1cm4gMQ0KZGlmZiAt
LWdpdCBhL3Rlc3RzL252bWUvMDQ0IGIvdGVzdHMvbnZtZS8wNDQNCmluZGV4IDllZDQ2YzkuLjdj
MDgzMjggMTAwNzU1DQotLS0gYS90ZXN0cy9udm1lLzA0NA0KKysrIGIvdGVzdHMvbnZtZS8wNDQN
CkBAIC0zMywxMyArMzMsMTMgQEAgdGVzdCgpIHsNCiAJbG9jYWwgY3RybGtleQ0KIAlsb2NhbCBj
dHJsZGV2DQogDQotCWhvc3RrZXk9IiQobnZtZSBnZW4tZGhjaGFwLWtleSAtbiAke2RlZl9zdWJz
eXNucW59IDI+IC9kZXYvbnVsbCkiDQorCWhvc3RrZXk9IiQobnZtZSBnZW4tZGhjaGFwLWtleSAt
biAiJHtkZWZfc3Vic3lzbnFufSIgMj4gL2Rldi9udWxsKSINCiAJaWYgWyAteiAiJGhvc3RrZXki
IF0gOyB0aGVuDQogCQllY2hvICJmYWlsZWQgdG8gZ2VuZXJhdGUgaG9zdCBrZXkiDQogCQlyZXR1
cm4gMQ0KIAlmaQ0KIA0KLQljdHJsa2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLW4gJHtkZWZf
c3Vic3lzbnFufSAyPiAvZGV2L251bGwpIg0KKwljdHJsa2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1r
ZXkgLW4gIiR7ZGVmX3N1YnN5c25xbn0iIDI+IC9kZXYvbnVsbCkiDQogCWlmIFsgLXogIiRjdHJs
a2V5IiBdIDsgdGhlbg0KIAkJZWNobyAiZmFpbGVkIHRvIGdlbmVyYXRlIGN0cmwga2V5Ig0KIAkJ
cmV0dXJuIDENCmRpZmYgLS1naXQgYS90ZXN0cy9udm1lLzA0NSBiL3Rlc3RzL252bWUvMDQ1DQpp
bmRleCBiZTgxMzE2Li40ZGQwZjk0IDEwMDc1NQ0KLS0tIGEvdGVzdHMvbnZtZS8wNDUNCisrKyBi
L3Rlc3RzL252bWUvMDQ1DQpAQCAtMzgsMTMgKzM4LDEzIEBAIHRlc3QoKSB7DQogCWxvY2FsIHJh
bmRfaW9fc2l6ZQ0KIAlsb2NhbCBucw0KIA0KLQlob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1r
ZXkgLW4gJHtkZWZfc3Vic3lzbnFufSAyPiAvZGV2L251bGwpIg0KKwlob3N0a2V5PSIkKG52bWUg
Z2VuLWRoY2hhcC1rZXkgLW4gIiR7ZGVmX3N1YnN5c25xbn0iIDI+IC9kZXYvbnVsbCkiDQogCWlm
IFsgLXogIiRob3N0a2V5IiBdIDsgdGhlbg0KIAkJZWNobyAiZmFpbGVkIHRvIGdlbmVyYXRlIGhv
c3Qga2V5Ig0KIAkJcmV0dXJuIDENCiAJZmkNCiANCi0JY3RybGtleT0iJChudm1lIGdlbi1kaGNo
YXAta2V5IC1uICR7ZGVmX3N1YnN5c25xbn0gMj4gL2Rldi9udWxsKSINCisJY3RybGtleT0iJChu
dm1lIGdlbi1kaGNoYXAta2V5IC1uICIke2RlZl9zdWJzeXNucW59IiAyPiAvZGV2L251bGwpIg0K
IAlpZiBbIC16ICIkY3RybGtleSIgXSA7IHRoZW4NCiAJCWVjaG8gImZhaWxlZCB0byBnZW5lcmF0
ZSBjdHJsIGtleSINCiAJCXJldHVybiAxDQpAQCAtNjksNyArNjksNyBAQCB0ZXN0KCkgew0KIA0K
IAllY2hvICJSZW5ldyBob3N0IGtleSBvbiB0aGUgY29udHJvbGxlciINCiANCi0JbmV3X2hvc3Rr
ZXk9IiQobnZtZSBnZW4tZGhjaGFwLWtleSAtLW5xbiAke2RlZl9zdWJzeXNucW59IDI+IC9kZXYv
bnVsbCkiDQorCW5ld19ob3N0a2V5PSIkKG52bWUgZ2VuLWRoY2hhcC1rZXkgLS1ucW4gIiR7ZGVm
X3N1YnN5c25xbn0iIDI+IC9kZXYvbnVsbCkiDQogDQogCV9zZXRfbnZtZXRfaG9zdGtleSAiJHtk
ZWZfaG9zdG5xbn0iICIke25ld19ob3N0a2V5fSINCiANCkBAIC03OSw3ICs3OSw3IEBAIHRlc3Qo
KSB7DQogDQogCWVjaG8gIlJlbmV3IGN0cmwga2V5IG9uIHRoZSBjb250cm9sbGVyIg0KIA0KLQlu
ZXdfY3RybGtleT0iJChudm1lIGdlbi1kaGNoYXAta2V5IC0tbnFuICR7ZGVmX3N1YnN5c25xbn0g
Mj4gL2Rldi9udWxsKSINCisJbmV3X2N0cmxrZXk9IiQobnZtZSBnZW4tZGhjaGFwLWtleSAtLW5x
biAiJHtkZWZfc3Vic3lzbnFufSIgMj4gL2Rldi9udWxsKSINCiANCiAJX3NldF9udm1ldF9jdHJs
a2V5ICIke2RlZl9ob3N0bnFufSIgIiR7bmV3X2N0cmxrZXl9Ig0KIA0KZGlmZiAtLWdpdCBhL3Rl
c3RzL252bWUvMDUxIGIvdGVzdHMvbnZtZS8wNTENCmluZGV4IDQ3NTdiODAuLjMyM2ZhYzcgMTAw
NzU1DQotLS0gYS90ZXN0cy9udm1lLzA1MQ0KKysrIGIvdGVzdHMvbnZtZS8wNTENCkBAIC0zNyw4
ICszNyw4IEBAIHRlc3QoKSB7DQogDQogCSMgZmlyZSBvZmYgdHdvIGVuYWJsZS9kaXNhYmxlIGxv
b3BzIGNvbmN1cnJlbnRseSBhbmQgd2FpdA0KIAkjIGZvciB0aGVtIHRvIGNvbXBsZXRlLi4uDQot
CW5zX2VuYWJsZV9kaXNhYmxlX2xvb3AgJG5zICYNCi0JbnNfZW5hYmxlX2Rpc2FibGVfbG9vcCAk
bnMgJg0KKwluc19lbmFibGVfZGlzYWJsZV9sb29wICIkbnMiICYNCisJbnNfZW5hYmxlX2Rpc2Fi
bGVfbG9vcCAiJG5zIiAmDQogCXdhaXQNCiANCiAJX252bWV0X3RhcmdldF9jbGVhbnVwDQotLSAN
CjIuNDYuMg0KDQo=

--_002_ghcsy46j652pvawoikkpym4buqo2hmimrvxrfnetlmqjnkvxr2kncqo_--

