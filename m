Return-Path: <linux-block+bounces-2068-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2B8359F6
	for <lists+linux-block@lfdr.de>; Mon, 22 Jan 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5AF1C212AC
	for <lists+linux-block@lfdr.de>; Mon, 22 Jan 2024 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB30F1FA1;
	Mon, 22 Jan 2024 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YDSWCcAK"
X-Original-To: linux-block@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE61C2E
	for <linux-block@vger.kernel.org>; Mon, 22 Jan 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705896378; cv=fail; b=peUBtJfJl483jENa/drb3TvTFJCfvSqzk0mgQkJXtcc8cQNkH4B7XRRfx8CSubND6JRLVoxp6jojgDuOg7bY2SzrXv4vdFiQ4irRQaRisk0iEXw6IKP9Wljl73IRUTb864byhPJPo31ADucPAcd6Eryjx9jyG+YgR6yBLhCw+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705896378; c=relaxed/simple;
	bh=FYmY44/1xEbMgPc2ytpNtORAnp6vJ4j+hxGkRJfA7ys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KoeEvwCe+tPWFh97fi6ehTKH0a2iTbbKOv8rXSMw2VjEwQy7N/sagQTp85PqepMxIgB+bqeSvKV4ALuXzEKG1hG699j3RIBs3bpMn1npXBKjd0C2RNi+WGAhnit4A0zRfJT6MbGPLjHkkYfaMZ+zOXvJ6VKe5wN2oGDo0YPE91U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YDSWCcAK; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXXGIfC+OV46K4RBzpNA2DwX5FsEg+sYfmboXnPNJ35zeNVrOYeNkVqFAm03RttCXxZD5/fapbybFpvzNCMNoRD6wr83FE44q1faOygKcSqu6+F1mPYVsEBSV3r7CjHU+jEqzInz/gVznOuDGCfc/lN1gx+Ea0N8legses3OVlE1GiJUUtf2KCxoodDnatTpzfNkNXkpJ+Hh6tzFK5I4YSln1bfrqU+3DqFTI6UnBan8L9cdX81shueu53v7nkE8ea9/SAOThrlVLCiTv7Vyer7MAO9Ecfzgl8m7rPu2x8Fbg1LfxUGNumyTY9U67ww8D53xpqivZYNsP4r1KUcdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYmY44/1xEbMgPc2ytpNtORAnp6vJ4j+hxGkRJfA7ys=;
 b=iNE7I7avrYjJIdi+sVk87hxKzZszRL5ZvZ2qkyV0fcgy6VfbROYZMJGJ1z3VTf61ElfliNnfi1boq9bSiBAi1FEvmFydj/emCj+FwU7P1WGdkXXBzoYEnSxcEcqf3HnetpFkBqumChZ1cu7mZe5Z3wH8rrAotdE+2/LSwfT1MElJ7a3sZm4ZSYGN6zaTKUpqql0QyD5EA635wVd22kWUauM3XIViDOj++PLxX7nfpfMIhSSATGdHRdNtVZdolPMX9SSDEAPx9rNyhH6k4IhyU7aSH5onT0Qy26/OENI1QFzlQbvXFkTtkJpFp6HdUzVp5p6X6ctybPLuvTWXa+jkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYmY44/1xEbMgPc2ytpNtORAnp6vJ4j+hxGkRJfA7ys=;
 b=YDSWCcAK1OE8lAxyJ2OnKNtMSuO+NW3C3QN4XjoDpNyHrfw1OFRQTN9ztpIx5vNd4wg0QDSOOMR8SRmr9T04tuLgComM+CW8Zm0k79bWGpFsh+37mCKhZ6Pirp6QuHsJdyM//NzrViNRqaOHwEO2CPE24XzYV8soEW7V9Dy5R+dF5mk8fEdKGPei/Hb730DtTPPa3GZfqySRyz4AX5yJgv5wVwWCdBOmU3+xliT03fjoz8FZ+GtKlbzDX6aMa+eJiCYZTNIk2Nt32Smk3+EzDAYrHaCjUFbVOCO1QHzbCvVHiDks7fCkU5mtndgdBhYODu8Ki3oGfglhyW3Z08dVwQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.28; Mon, 22 Jan
 2024 04:06:13 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 04:06:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests V2 1/1] nvme: add nvme pci timeout testcase
Thread-Topic: [PATCH blktests V2 1/1] nvme: add nvme pci timeout testcase
Thread-Index: AQHaSPzT8ihXU818jkGsOp0AVDo2QbDg/mMAgARAVAA=
Date: Mon, 22 Jan 2024 04:06:13 +0000
Message-ID: <0597b185-4d67-45cf-a8b6-371fbcdbf2af@nvidia.com>
References: <20240117042206.11031-1-kch@nvidia.com>
 <20240117042206.11031-2-kch@nvidia.com>
 <r6txdry3nph5s33z2wrgilq4hle5fvg65y6nhf7tfpwkdwqtmx@ju32opkuqqv3>
In-Reply-To: <r6txdry3nph5s33z2wrgilq4hle5fvg65y6nhf7tfpwkdwqtmx@ju32opkuqqv3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB6898:EE_
x-ms-office365-filtering-correlation-id: 6e549048-6dfb-46c5-5263-08dc1aff7949
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ek783YQdDa99KSxS4K+Fd8YiaYyJgnnmT+A4+S6FxK2QHGyug5ec+szxKNm30rOA+EAFZYpjMkhRZQfafz+KQ27GU/qswfCsSxNBLmdoSq/wRAibYNR+0zPRLc6l9v0mnKFUAwqYgMt9zdyFw8C4n6exJzvM79cJ/Dn/xw21mHa5YkzpCQ22z/AWDr5QcmKGDpGrJ5haP3gEfFLu3vPRr767yfToMCjK0+NHkmm8sE5zSmeEyzKhLuWBYCuPakhjhMd+daWPblK6Si+z1ah2DfhHuq+uI/Vey/Plj9TFCptvNsPEvrNV07IQBdVE32xSBDmBkSeEZ6iPCxAM19LhwCJdQd/eulKYeOQRaXikwrDLe8sP/doFDlNntv0cQuC1NJ8qeLkwotjzBdhQBQm/YXhsigOpzUhBgsoE2RZeHCoC+Lj/92+7cp/z24lhf897hb6RvPbbzkTI6YrDEEXwHs82/4l1p9n2K8ady1EA/bF+P75wNiea5GWG/Zl9miui/JvyD/rcakDQc6DfiJhXgNN/rG/8tiKNy00or/ScAUylOhXj+XUqB9Sow2BIeTsAcM8AhfCvWTutLeCNLUx39h1fzVPwNcSuH5I6w5eIrSG4vnn4GTaq3jm3Ov6BzcyeQYLH348v+po3oINm87LAQPZ2Loh2iG/xkaMZhLFlGr0eZXxF3dKFgMDSXB6Z7X5dKnTJ0fslZvEhR3DkNsdUGsKhiJyeq6WXtoWSPSXL6ns=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(38070700009)(36756003)(31686004)(31696002)(86362001)(83380400001)(2616005)(71200400001)(76116006)(316002)(66946007)(66476007)(8676002)(66556008)(8936002)(64756008)(6486002)(54906003)(966005)(6512007)(478600001)(6916009)(6506007)(91956017)(66446008)(53546011)(2906002)(4326008)(5660300002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a3orTkdQUTJ3ZHVnalRIWEVIZzdKbXZqZ05YRXpmNjdvd2E0blRhTlhTL1J6?=
 =?utf-8?B?ejBWaHpDZTlYOHloUHZOTHRHa0xwYU1QeDlDT2wyUnRXR0VReDhSRFc0Nkh6?=
 =?utf-8?B?UDVDcWJtRFJUNUVQTWEzZUJxY05VaEF1NXZkWWRJaUUvbU5td25FOFUxNTFl?=
 =?utf-8?B?dlphalNvT2ZKMDk2OFhBd01lYnFoR1NiRmJGMkhkcE9xZ253K0lGT2dqK2tk?=
 =?utf-8?B?Q2Nkd0lQQlUxQUVCZHExQzJTOVhxMHNqT2JsSHE4Ry9XMFRYTmtkWnhlSlU5?=
 =?utf-8?B?a205MTVvYjB2ZExFMHppUWhKT3B1RlNVMFc2TmNTTDk1VkE3NXY1NE13M1pH?=
 =?utf-8?B?VWlaanRoUmtxeHU1UzBZVUIrb1ovRGtmWXFTS2VZR0xtK3VwQ01zNnZKSlVj?=
 =?utf-8?B?am9MekNvRjVRNnowenNxMTFGSDhFRmxCblZQb1BSc3czeXFpZ2YyVnFsenRr?=
 =?utf-8?B?VUd6eHRTYVZlQmdqL1hmYUU0eG1jMElyNlYweVlBM1V0dkdmMWROb210OU40?=
 =?utf-8?B?NkUxMXhrZVJUR0c1bzNHODBpMVQvN1pZbEhHMWZOWlVYV3dEVDcwM3ZaWkQ2?=
 =?utf-8?B?eGJSNnNPNnlTQm5HOTBGd0MvV3FJUFg0d01RVHFYVkovT01tVFZhL1R1RHZD?=
 =?utf-8?B?bWNLNno5bkVWbFJSaU5HM081WFFqOUpSeUJtSyt4MW13T3hQK1ZSNmFDUEFJ?=
 =?utf-8?B?akVRbzNEOGNtWjBtZEJkOWpTVnRqYnJMYTg5RzMrdUxHTmFnNzNlcTFTdVEx?=
 =?utf-8?B?d3hNMlFTdlp3KzNZaU5SWkt4SDZKZzRCeFFLVm9BRkxWYTZhbFdOVDk0NU9a?=
 =?utf-8?B?L3NZK3orSm9ZU1FOWHVRYjdVMTFmVVlhai9odW5scng1RjQzRWNMS0xQSEZv?=
 =?utf-8?B?M0xZaXJiYUh5Zndnc0xjZnBBVGt0NU1Mdnc2dmc3Si93WGFHUzU4Y0VBYXlN?=
 =?utf-8?B?MkVTSVVpYWJpZ1lwcEZPSk5DdnhUamkxbE5icmdPYjA3RGJ0L2wwR3lxYThP?=
 =?utf-8?B?T2JtTkRSeG1pODd5UldmWC91eUlaamRoTzAvMng4dXBvelBzQkU0UzRRZWpm?=
 =?utf-8?B?S05rQXdPaE9BS3JDUk43Tkl0UnJqR0NGaVoyVlNQVVFPOG13Q3pzcDRMTDRF?=
 =?utf-8?B?bElqU0RlSTRDK1psVUFpeFJLb21ucis2Y2Fnb2ZMc2dNU1VDWVUyb3k2Vk1J?=
 =?utf-8?B?V0VRMFVwVm1pdGV3TTJUbldORWdYNGRWSG1SN1pWdHBZT2JSNk1GR3FzNmtu?=
 =?utf-8?B?cmtoMldlSUJaKzgvTmc5MmxZNkxmdkN4L1BTeE9ZaU5BZTVweXdDclNsc0J1?=
 =?utf-8?B?dVNQbGVibFIvNVpHOGJTKy9IcmZJZlFjVTZ1bzlLVGQxUjJZSjl2SmRsWklD?=
 =?utf-8?B?SGlNOWZuNTllMWpGSHVUK3lJR2t0ajBQdkNtTEtOcytvSDdSc1o3WGo4Snhu?=
 =?utf-8?B?cDhnNkdMUFRrRGh3YW0za2ZkbDB5dmtRWkU0NHBnYVgyTy9RRzhONkV0SE1J?=
 =?utf-8?B?U3BFM3hOYk5OWHZtaFd4UjRIeWJkQ3RqdGtZcjErWGV1em52OForbUpEVE1G?=
 =?utf-8?B?bXREU0JqNndsVjZZenlXZmtxSlk2ajJsWHpsaG1sbFhYRXhJVFhHVWNkWHls?=
 =?utf-8?B?YjNtWDFzSG9lS1JuMzF4VkhYMUpjRWVDaVpVUUI5WndwZjcxUjdiTFRPeFpz?=
 =?utf-8?B?dzJJd0JXd25iVkRHbnFPcFNpYkVERU1yZzAxcUN0K3ZPZDRZM2lnbFR0TUJQ?=
 =?utf-8?B?Rmg1NGlJUkx3bkV1NmRyWk5QS3FjR3g4UVdGcE1kOHRSZldaUE14QlhlVm1p?=
 =?utf-8?B?ZXFlcmJhODUxbTB0OFZSSUxBUHhLbWRXTWpnanMzVzM3eUpyckViem8yRk5B?=
 =?utf-8?B?ZHQ2QkxXUGE1SytZaGQ3elhiRjhFalMxNXJNSjZ2czdHbFZmUi94cWJKRlRo?=
 =?utf-8?B?NUFWUStZK3VSZG92V1FEYU4wQThZbzI0K3d3V2MwNlA3cVlNeGhRamF2eDgz?=
 =?utf-8?B?T2hHM0tsdnFyaVZsc3NxSXUvcHFiSXZJOEViOTlPNGZoaG5DZmhkQmFTNkIv?=
 =?utf-8?B?NnUzdWUvdzhBNG5MQitXbm5JdVF1Z3BXQyswbXZJS0dnSmM1anpJVG1jME4r?=
 =?utf-8?B?SWFTWjlHQUg2UitCM29lbWtZZHZ4WlorNmxURDJVMkFSNjhXTnJnNFM2b2ND?=
 =?utf-8?Q?CdEi8FvaOIgu+gA6Gy7bHvPnIlv+msJbJT01V8KqigVY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3E16879FB01B244A888918C3213B9B7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e549048-6dfb-46c5-5263-08dc1aff7949
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2024 04:06:13.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C/6XRDoTG/gbVNuo0ep2RKdvMwGAKUgNNyoOL/IDVwBKzc2uLKwoUxVCOKvAq5KAQd8IiJ7AsD/ECZYRYN54IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898

T24gMS8xOS8yMDI0IDM6MTEgQU0sIFNoaW5pY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEhpIENo
YWl0YW55YSwgdGhhbmtzIGZvciB0aGlzIHYyIHBhdGNoLg0KPiANCj4gSSByYW4gdGhpcyBuZXcg
dGVzdCBjYXNlIHdpdGggc2V2ZXJhbCBkZXZpY2VzIGFuZCBvYnNlcnZlZCB0aGVzZSB0d286DQo+
IA0KPiAxKSBUaGUgdGVzdCBjYXNlIGZhaWxzIHdpdGggbXkgUUVNVSBOTVZFIGRldmljZXMuIEl0
IGxvb2tzIGFsbCBvZiB0aGUgaW5qZWN0DQo+ICAgICBmYWlsdXJlcyBnZXQgcmVjb3ZlcmVkIGJ5
IGVycm9yIGhhbmRsZXIsIHRoZW4gbm8gSS9PIGVycm9yIGlzIHJlcG9ydGVkIHRvIHRoZQ0KPiAg
ICAgZmlvIHByb2Nlc3MuIEkgbW9kaWZpZWQgdHdvIGZhaWxfaW9fdGltZW91dCBwYXJhbWV0ZXJz
IGFzIGZvbGxvd3MgdG8gaW5qZWN0DQo+ICAgICBtb3JlIGZhaWx1cmVzLCBhbmQgc2F3IHRoZSB0
ZXN0IGNhc2UgZmFpbHMgd2l0aCB0aGUgZGV2aWNlLiBJIHN1Z2dlc3QgdGhlc2UNCj4gICAgIHBh
cmFtZXRlcnMuDQo+IA0KPiBAQCAtNDksOCArNTAsOCBAQCB0ZXN0X2RldmljZSgpIHsNCj4gICAg
ICAgICAgc2F2ZV9maV9zZXR0aW5ncw0KPiAgICAgICAgICBlY2hvIDEgPiAvc3lzL2Jsb2NrLyIk
e252bWVfbnN9Ii9pby10aW1lb3V0LWZhaWwNCj4gDQo+IC0gICAgICAgZWNobyA5OSA+IC9zeXMv
a2VybmVsL2RlYnVnL2ZhaWxfaW9fdGltZW91dC9wcm9iYWJpbGl0eQ0KPiAtICAgICAgIGVjaG8g
MTAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3RpbWVvdXQvaW50ZXJ2YWwNCj4gKyAgICAg
ICBlY2hvIDEwMCA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxfaW9fdGltZW91dC9wcm9iYWJpbGl0
eQ0KPiArICAgICAgIGVjaG8gMSA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxfaW9fdGltZW91dC9p
bnRlcnZhbA0KPiAgICAgICAgICBlY2hvIC0xID4gL3N5cy9rZXJuZWwvZGVidWcvZmFpbF9pb190
aW1lb3V0L3RpbWVzDQo+ICAgICAgICAgIGVjaG8gIDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWls
X2lvX3RpbWVvdXQvc3BhY2UNCj4gICAgICAgICAgZWNobyAgMSA+IC9zeXMva2VybmVsL2RlYnVn
L2ZhaWxfaW9fdGltZW91dC92ZXJib3NlDQo+IA0KDQpMZXQgbWUgdGVzdCB0aGVzZSBhbmQgYWRk
IHRvIHRoZSBWMy4gQnV0IGl0IGlzIHJlYWxseSBzdHJhbmdlLCBjdXJyZW50DQpjb2RlIHBhc3Mg
dGVzdGNhc2UgMTAwJSBvZiB0aGUgdGltZSB3aXRob3V0IGFib3ZlIGNoYW5nZXMgLi4uDQoNCj4g
MikgQWZ0ZXIgSSByYW4gdGhlIHRlc3QgY2FzZSwgSSBzZWUgdGhlIHRlc3QgdGFyZ2V0IGRldmlj
ZSBsZWZ0IHdpdGggemVybw0KPiAgICAgc2l6ZS4gSSB0aGluayB0aGlzIGlzIGNvbnNpc3RlbnQg
YXMgeW91ciByZXBvcnQgWypdLiBJIHN0aWxsIHRoaW5rIGRldmljZQ0KPiAgICAgcmVtb3ZlIGFu
ZCByZXNjYW4gYXQgdGhlIHRlc3QgY2FzZSBlbmQgaXMgcmVxdWlyZWQgdG8gYXZvaWQgaW1wYWN0
cyBvbg0KPiAgICAgZm9sbG93aW5nIHRlc3QgY2FzZXMuIEl0IHdpbGwgZGVwZW5kIG9uIHRoZSBk
aXNjdXNzaW9uIGZvciB5b3VyIHJlcG9ydCwNCj4gICAgIHRob3VnaC4NCj4gDQoNClllcywgc3Rp
bGwgd2FpdGluZyBvbiB0aGF0LCBob3BlZnVsbHkgd2Ugd2lsbCBnZXQgc29tZSBpbmZvcm1hdGlv
biB0bw0KbW92ZSB0aGlzIGZvcndhcmQuIFRoZSByZWFzb24gSSBkaWRuJ3QgYWRkIHJlbW92ZS9y
ZXNjYW4gZGV2aWVjIGNveiBpdA0KaGVscGVkIG1lIGRlYnVnIHRoZSBzdGF0ZSBvZiB0aGUgZGV2
aWNlIHBvc3QgdGltZW91dCBoYW5kbGVyIHdoaWNoIGlzDQp0dXJuZWQgb3V0IHRvIGJlIG5vdCBj
b25zaXN0ZW50IGZvciBzdXJlIC4uDQoNCj4gWypdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW52bWUvMjg3YjllZDktNmViMy00NmQwLWE2ZjAtYTlkMjgzMjQ1YjkwQG52aWRpYS5jb20v
DQo+IA0KPiBQbGVhc2UgZmluZCBteSBzb21lIG1vcmUgY29tbWVudHMgaW4gbGluZToNCj4gDQo+
IE9uIEphbiAxNiwgMjAyNCAvIDIwOjIyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBU
cmlnZ2VyIGFuZCB0ZXN0IG52bWUtcGNpIHRpbWVvdXQgd2l0aCBjb25jdXJyZW50IGZpbyBqb2Jz
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQo+PiAtLS0NCj4+ICAgdGVzdHMvbnZtZS8wNTAgICAgIHwgNzQgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICB0ZXN0cy9udm1lLzA1MC5vdXQg
fCAgMiArKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKykNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNzU1IHRlc3RzL252bWUvMDUwDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0
ZXN0cy9udm1lLzA1MC5vdXQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZS8wNTAgYi90
ZXN0cy9udm1lLzA1MA0KPj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4+IGluZGV4IDAwMDAwMDAu
LjZjNDRiNDMNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL3Rlc3RzL252bWUvMDUwDQo+PiBA
QCAtMCwwICsxLDc0IEBADQo+PiArIyEvYmluL2Jhc2gNCj4+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMy4wKw0KPj4gKyMgQ29weXJpZ2h0IChDKSAyMDI0IENoYWl0YW55YSBLdWxr
YXJuaQ0KPj4gKyMNCj4+ICsjIFRlc3QgTlZNZS1QQ0kgdGltZW91dCB3aXRoIEZJTyBqb2JzIGJ5
IHRyaWdnZXJpbmcgdGhlIG52bWVfdGltZW91dCBmdW5jdGlvbi4NCj4+ICsjDQo+PiArDQo+PiAr
LiB0ZXN0cy9udm1lL3JjDQo+PiArDQo+PiArREVTQ1JJUFRJT049InRlc3QgbnZtZS1wY2kgdGlt
ZW91dCB3aXRoIGZpbyBqb2JzIg0KPiANCj4gSSByYW4gdGhpcyB0ZXN0IGNhc2UgYSBaTlMgZHJp
dmUgdG9kYXksIGFuZCBpdCBsb29rcyB3b3JraW5nLiBJIHN1Z2dlc3QgdG8gYWRkOg0KPiANCj4g
Q0FOX0JFX1pPTkVEPTENCj4gDQoNCm9rYXkgLi4NCg0KPj4gKw0KPj4gK3N5c2ZzX3BhdGg9Ii9z
eXMva2VybmVsL2RlYnVnL2ZhaWxfaW9fdGltZW91dC8iDQo+PiArI3Jlc3RyaWN0IHRlc3QgdG8g
bnZtZS1wY2kgb25seQ0KPj4gK252bWVfdHJ0eXBlPXBjaQ0KPj4gKw0KPj4gKyMgZmF1bHQgaW5q
ZWN0aW9uIGNvbmZpZyBhcnJheQ0KPj4gK2RlY2xhcmUgLUEgZmlfYXJyYXkNCj4+ICsNCj4+ICty
ZXF1aXJlcygpIHsNCj4+ICsgICAgICAgIF9yZXF1aXJlX252bWVfdHJ0eXBlIHBjaQ0KPiANCj4g
V2UgY2FuIHJlbW92ZSB0aGlzIGxpbmUsIHNpbmNlIHdlIGFkZGVkICJudm1lX3RydHlwZT1wY2ki
IGFib3ZlLg0KDQp5ZWFoIC4uDQoNCj4gDQo+PiArICAgICAgICBfaGF2ZV9maW8NCj4+ICsgICAg
ICAgIF9udm1lX3JlcXVpcmVzDQo+PiArICAgICAgICBfaGF2ZV9rZXJuZWxfb3B0aW9uIEZBSUxf
SU9fVElNRU9VVA0KPiANCj4gVG9kYXksIEkgZm91bmQgdGhhdCB0aGlzIHRlc3QgY2FzZSBkZXBl
bmRzIG9uIGFub3RoZXIga2VybmVsIG9wdGlvbi4gTGV0J3MgYWRkLA0KPiANCj4gICAgICAgICAg
X2hhdmVfa2VybmVsX29wdGlvbiBGQVVMVF9JTkpFQ1RJT05fREVCVUdfRlMNCg0KaW5kZWVkIGdv
b2QgY2F0Y2ggSSdsbCBhZGQgdGhpcyAuLg0KDQo+IA0KPj4gK30NCj4+ICsNCj4+ICtkZXZpY2Vf
cmVxdWlyZXMoKSB7DQo+PiArCV9yZXF1aXJlX3Rlc3RfZGV2X2lzX252bWUNCj4+ICt9DQo+IA0K
PiBBY3R1YWxseSwgdGhpcyBjaGVjayBpcyBub3QgcmVxdWlyZWQgaGVyZSwgc2luY2UgaXQgaXMg
YWxyZWFkeSBkb25lIGluDQo+IGdyb3VwX2RldmljZV9yZXF1aXJlcygpIGluIHRlc3RzL252bWUv
cmMuIEl0IGlzIGEgc21hbGwgbGVmdCB3b3JrIHRvIHJlbW92ZQ0KPiB0aGUgc2FtZSBkZXZpY2Vf
cmVxdWlyZXMoKSBpbiBudm1lLzAzMi4NCj4gDQoNCm9rYXkgd2lsbCByZW1vdmUgdGhhdCAuLg0K
DQo+PiArDQo+PiArc2F2ZV9maV9zZXR0aW5ncygpIHsNCj4+ICsJZm9yIGZpX2F0dHIgaW4gcHJv
YmFiaWxpdHkgaW50ZXJ2YWwgdGltZXMgc3BhY2UgdmVyYm9zZQ0KPj4gKwlkbw0KPj4gKwkJZmlf
YXJyYXlbIiR7ZmlfYXR0cn0iXT0kKGNhdCAiJHtzeXNmc19wYXRofS8ke2ZpX2F0dHJ9IikNCj4+
ICsJZG9uZQ0KPj4gK30NCj4+ICsNCj4+ICtyZXN0b3JlX2ZpX3NldHRpbmdzKCkgew0KPj4gKwlm
b3IgZmlfYXR0ciBpbiBwcm9iYWJpbGl0eSBpbnRlcnZhbCB0aW1lcyBzcGFjZSB2ZXJib3NlDQo+
PiArCWRvDQo+PiArCQllY2hvICIke2ZpX2FycmF5WyIke2ZpX2F0dHJ9Il19IiA+ICIke3N5c2Zz
X3BhdGh9LyR7ZmlfYXR0cn0iDQo+PiArCWRvbmUNCj4+ICt9DQo+PiArDQo+PiArdGVzdF9kZXZp
Y2UoKSB7DQo+PiArCWxvY2FsIG52bWVfbnMNCj4+ICsJbG9jYWwgaW9fZmltZW91dF9mYWlsDQo+
PiArDQo+PiArCWVjaG8gIlJ1bm5pbmcgJHtURVNUX05BTUV9Ig0KPj4gKw0KPj4gKwludm1lX25z
PSIkKGJhc2VuYW1lICIke1RFU1RfREVWfSIpIg0KPj4gKwlpb19maW1lb3V0X2ZhaWw9IiQoY2F0
IC9zeXMvYmxvY2svIiR7bnZtZV9uc30iL2lvLXRpbWVvdXQtZmFpbCkiDQo+PiArCXNhdmVfZmlf
c2V0dGluZ3MNCj4+ICsJZWNobyAxID4gL3N5cy9ibG9jay8iJHtudm1lX25zfSIvaW8tdGltZW91
dC1mYWlsDQo+PiArDQo+PiArCWVjaG8gOTkgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWlsX2lvX3Rp
bWVvdXQvcHJvYmFiaWxpdHkNCj4+ICsJZWNobyAxMCA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxf
aW9fdGltZW91dC9pbnRlcnZhbA0KPj4gKwllY2hvIC0xID4gL3N5cy9rZXJuZWwvZGVidWcvZmFp
bF9pb190aW1lb3V0L3RpbWVzDQo+PiArCWVjaG8gIDAgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9mYWls
X2lvX3RpbWVvdXQvc3BhY2UNCj4+ICsJZWNobyAgMSA+IC9zeXMva2VybmVsL2RlYnVnL2ZhaWxf
aW9fdGltZW91dC92ZXJib3NlDQo+PiArDQo+PiArCWZpbyAtLWJzPTRrIC0tcnc9cmFuZHJlYWQg
LS1ub3JhbmRvbW1hcCAtLW51bWpvYnM9IiQobnByb2MpIiBcDQo+PiArCSAgICAtLW5hbWU9cmVh
ZHMgLS1kaXJlY3Q9MSAtLWZpbGVuYW1lPSIke1RFU1RfREVWfSIgLS1ncm91cF9yZXBvcnRpbmcg
XA0KPj4gKwkgICAgLS10aW1lX2Jhc2VkIC0tcnVudGltZT0xbSAyPiYxIHwgZ3JlcCAtcSAiSW5w
dXQvb3V0cHV0IGVycm9yIg0KPiANCj4gV2hlbiBJIGludmVzdGlnYXRlZCB0aGUgZmFpbHVyZSBj
YXVzZSBvZiB0aGlzIHRlc3QgY2FzZSwgSSBmb3VuZCBmaW8gb3V0cHV0DQo+IGlzIHVzZWZ1bC4g
U28sIEkgc3VnZ2VzdCB0byBrZWVwIHRoZSBvdXRwdXQgaW4gJEZVTEwuDQo+IA0KPiAgICAgICAg
ICAgICAgLS10aW1lX2Jhc2VkIC0tcnVudGltZT0xbSA+JiIkRlVMTCINCj4gDQoNCm9rYXkgYW5k
IHdpbGwgbW9kaWZ5IHRoZSB0ZXN0Y2FzZSBmb3IgdGhhdCAuLg0KDQo+PiArDQo+PiArCSMgc2hl
bGxjaGVjayBkaXNhYmxlPVNDMjE4MQ0KPj4gKwlpZiBbICQ/IC1lcSAwIF07IHRoZW4NCj4gDQo+
IFdpdGggdGhhdCAkRlVMTCBmaWxlLCB0aGUgaWYgc3RhdGVtZW50IGNhbiBiZSBhcyBmb2xsb3dz
LiBBbmQgd2UgZG9uJ3QgbmVlZCB0bw0KPiBkaXNhYmxlIFNDMjE4MSBlaXRoZXIuDQo+IA0KPiAg
ICAgICAgIGlmIGdyZXAgLXEgIklucHV0L291dHB1dCBlcnJvciIgIiRGVUxMIjsgdGhlbg0KDQph
Z3JlZSAuLg0KDQo+IA0KPj4gKwkJZWNobyAiVGVzdCBjb21wbGV0ZSINCj4+ICsJZWxzZQ0KPj4g
KwkJZWNobyAiVGVzdCBmYWlsZWQiDQo+PiArCWZpDQo+PiArDQo+PiArCXJlc3RvcmVfZmlfc2V0
dGluZ3MNCj4+ICsJZWNobyAiJHtpb19maW1lb3V0X2ZhaWx9IiA+IC9zeXMvYmxvY2svIiR7bnZt
ZV9uc30iL2lvLXRpbWVvdXQtZmFpbA0KPj4gK30NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9udm1l
LzA1MC5vdXQgYi90ZXN0cy9udm1lLzA1MC5vdXQNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
PiBpbmRleCAwMDAwMDAwLi5iNzhiMDVmDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi90ZXN0
cy9udm1lLzA1MC5vdXQNCj4+IEBAIC0wLDAgKzEsMiBAQA0KPj4gK1J1bm5pbmcgbnZtZS8wNTAN
Cj4+ICtUZXN0IGNvbXBsZXRlDQo+PiAtLSANCj4+IDIuNDAuMA0KDQpUaGFua3MgZm9yIHRoZSBy
ZXZpZXcgY29tbWVudHMsIEknbGwgc2VuZCBvdXQgVjMgd2l0aCB5b3VyDQpzdWdnZXN0aW9ucyAu
Lg0KDQotY2sNCg0KDQo=

