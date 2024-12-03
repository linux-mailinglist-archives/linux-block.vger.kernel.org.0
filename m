Return-Path: <linux-block+bounces-14795-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E599E108A
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 01:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3B4164D08
	for <lists+linux-block@lfdr.de>; Tue,  3 Dec 2024 00:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542102500A8;
	Tue,  3 Dec 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NmAxdP1c"
X-Original-To: linux-block@vger.kernel.org
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF778F6C
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733187509; cv=fail; b=H+LRwvf11YTGl3kYoZXXQBxou5ueynCensd5wd70CGYXV9VRmCSmNl/QytHo5rEVY+SRxsjZLQxcEQ9uxKYqQ3PwuCR9NR7CsTYeGXM8W88iG2eQ91/b6rboHiZBDfvi7I0gPjHAUtd6qbM73JtPIPadFyHs0OBSKG2T7J1hqfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733187509; c=relaxed/simple;
	bh=WO/Gh3rDVQVoWp6Q1IVFk48ICd4OCbFM0ylJAoQlAzM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Suta4zSg+adRT5LAkDvZKkoncjMzlVpFlvbCrKpDQ/p+g8Ai/4eN5ENCX5MtcX7Y6w1EqZcdQArDLrC7CLFKzcsp7Yn0OvGi6ozWLvf+bUcXAPdKkw9ygmXmxnooh9GnRhu66UntCN3MGxhPhQak5FqdI0frz8CLGCXU6tFBREc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NmAxdP1c; arc=fail smtp.client-ip=216.71.158.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1733187507; x=1764723507;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=WO/Gh3rDVQVoWp6Q1IVFk48ICd4OCbFM0ylJAoQlAzM=;
  b=NmAxdP1cVd4szvMa5ehDsAiUTgjJpfImjDP1qfq59aTQD6W9i7Q3scsr
   rrbrbZx7j0NLBO6kTCufkqkh2+HFY10ZiIy3U7P5Di0TUFtO0kuRR/Cxi
   hiXs8XZRW4F+d5oY8AM/W3DkZ+GnuAupkURj0YdmXTaRyBcgNR4atOEI8
   82uMebe7FevZiOvtNu3+2i2z9xUkuYbwHteksP4GQnlPEJM8ZSlwjwpPs
   tRMZBsTqc6vskIdYcj/HqsksuvYW80PMRlclZkhVoOWJLPb5vBZhP/P9F
   HMvJDUoh2sYPfWyYVxVrYBhM2Rsm6aYu54SC0jbwaqQLrnWxpgOR9zmoF
   Q==;
X-CSE-ConnectionGUID: MCVIAqPWT2asA5mW1NYx6Q==
X-CSE-MsgGUID: BZpHCzEpQvmw5VVEYExDiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="138872319"
X-IronPort-AV: E=Sophos;i="6.12,203,1728918000"; 
   d="scan'208";a="138872319"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 09:57:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFnde5FdAKUczsMaq/nxsdrn0Gf6JTTuSmIFoKxWldJ5gSWC32ODXwFHTA+SECDY0VQ4qXIjizpyjiEsJjKnf05Y5u1sxQKb41IqC+BCXm8IySlkKnnO/wYykPZVUYYzlq9YuEK9elsqOosMW/nrSszDC6nmw/ZXQ9WWgWTnKxn8B0RA1FzS3spPpJc8AHTbOVBDJrsl2YhD/2pkF9YWY+W/mfHTwUpG8cipJZH4CwPSjpc/bWLvOwxYLfeO0gc4TzeWawyB5itmSvL59C523hTJsvUVJVz1LDiVJLm7mZ2+IBuR7Jx1VwARahQKDiZ7iA4zMXWOksEnUtAtGWvU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO/Gh3rDVQVoWp6Q1IVFk48ICd4OCbFM0ylJAoQlAzM=;
 b=YEOYLcaa+8+1sy98xBPn1h5GKARLJMibnH/cFl7+abx88XFLSvbLj1gtdBsjmTlzQK1LDKzUVZyDHbyfestLpJYW+Efw9qez761a/D3999awK01YVC3pAAUODmSNk7v0qIzUHZIsvo+dJGgwvCgL5oD1Q8+JcPGsck+e9GVN1J/FtWfojt3jiPj0SW2iF9eAEFkym3utHlrjtvkBC99JaXQcYhNs7dyCMmNA5onkZylR+C0NybAKARxjkanJzWHX4OUGbE5zXnjJ/dAO/Q+2TA62uf5klk1s2tOu9oVIO2uTf+TLv6rwAByUIE7nRmkwZsVwlwdboZ2+kxXONMS4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYAPR01MB6235.jpnprd01.prod.outlook.com (2603:1096:402:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 00:57:10 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 00:57:10 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [blktests] zbd/009 fails due to "No space left on device"
Thread-Topic: [blktests] zbd/009 fails due to "No space left on device"
Thread-Index: AQHbRR5IFWhFAyix6ES9S5kU/Jzbuw==
Date: Tue, 3 Dec 2024 00:57:10 +0000
Message-ID: <fecc3814-cc34-4349-8a51-98670d0d868d@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYAPR01MB6235:EE_
x-ms-office365-filtering-correlation-id: e59af027-ea1f-49e6-bd51-08dd13356ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?K2VnelF2bldxWHJmK0FuemJMRzBQYUZVRWdQUmU1OWFoY0lPN1dkS3R5SDI3?=
 =?utf-8?B?ZUFwcytPZzlFK1JGbXFwbUdqdit5Zi9Rd0REQzdTZ01hOTV6V2E5aXJERUJL?=
 =?utf-8?B?NitQdld5aWZDbE1mVEVUeVFBZ2loUlp1VlU5ckN6OGFvOEF1NUtoWVlEdG9j?=
 =?utf-8?B?QW5wUHFnWnZEQktlbmpxZVJOL3NWbElaak5OT3J1Z2ROWkc1aHI1VW1jczVZ?=
 =?utf-8?B?OU9mQmRtZXVSNUZLSnltaVJSMVdTN0x1NXlvUlEwWThxd204V2M5bkQySGtX?=
 =?utf-8?B?UmJTNE94K2JUQmNvaXdWZlFWSWJsNGltaHg3anlxT0VZV001NTBDR1Z2WWx4?=
 =?utf-8?B?bndoUWN1M2o3V3hkV3JYbkVaMFFZRzlhdU9KRkpkMlBQUjdReGJHRGZGaXZV?=
 =?utf-8?B?ZVdrT1JTOTU2MUhqVzdLOCt3NUgzRUxUNWw3K3JDOVdlcXBkNG1MWEFvUGZN?=
 =?utf-8?B?c3Y3RmFIZFBHSGNlRkQ2dXZHQ1ZGdHdSaWJiUU9ROWQ5M1hqMFk5clJBNkl0?=
 =?utf-8?B?eGxzQ3RQMkRCZXBCRjhSRFdNdTdydHM0U0FzL2ZpYmhyUEZySUFkSlRlc3ht?=
 =?utf-8?B?cllqY2pya0ZuS01wZDZUZGtzRVVXdkFRcjJuNUNhdlZJV2NJQVZHbGVtdEky?=
 =?utf-8?B?ZUJwcHM1Ty9laEp6WlZuV05EekRORWNSOTZoZHh2emF5ZHlZemZRLys0SHgv?=
 =?utf-8?B?ZTNSbWFUWmF0SlRmQmJ3bGRCdmVtZWxuYnl0cVMzUkxZWnpnUjIxdE1Rakh4?=
 =?utf-8?B?VG04MW0zM0w3K01GY05yQTRRMFFRbCt6VVcvNjJnQmJ1NG84cjg0UmhqcmJL?=
 =?utf-8?B?VURRMDdESHYxYmRlWjlvTXUyTWxKNnVkMXU0Mm1jTURocWdkbzhQS1ZQUWor?=
 =?utf-8?B?amFYTmMvVjRXUDQ3Nkx1dVcyN09mcUVBUGNWbjFrR1oxeHNHR3VrRUVvSjc2?=
 =?utf-8?B?c1JNQ09rd0dUbW9lcTVRbUZkTGVKamZKT1RGWnQ3cE5sKyt0OVFqOU9yRE5F?=
 =?utf-8?B?R3lxZUxrRDY0MFc5NTB0R1I0Q2tYN3NtdWEwODN6Y3U1V25nKzkxajFaZFFW?=
 =?utf-8?B?YzArenhFQS91cTF3T084ZHVtSFRaZGc5V0pZLy9QcDhhUTZHY0NJdmZqUmE0?=
 =?utf-8?B?SyswTFNPZDNwUGNpekQvNTh5Y2kxMUZjQzQxYkpwaUd0bzFpMWFscUQyelZS?=
 =?utf-8?B?NjNacUJrTFFHZnVEQXdLb3NZNGlqU1NPZlcwN1hEWmh0dXFPUVI1YzhuSElE?=
 =?utf-8?B?WUhBaFlkRmNxNHdTVyszTUVCNEJEYnVDaUZOVC9vTHVzR1UwblljbnErS25H?=
 =?utf-8?B?RnpoWlQ2b0NOeGJjVXpCYXJka2t2T0VhNlpvb0JBV1V3d2d0NUVqNXV0ekkr?=
 =?utf-8?B?dkpDMWYyb2xtMm5GOWZ2UFV1Q2xCbVV3bVd4L2ZKaFBneUJjdytxcDZaVzUx?=
 =?utf-8?B?Z004bWZ3L3paVnAxZ3RBUVcvTlY2bWpueWJCTCtXM0FJMnBLTE40MFAxaXRh?=
 =?utf-8?B?NVFzc2Fac3J5UDA3SnNSVHBTc0xRUi9jVjhGdHAyYi8rYTN6bXVjalA1d21X?=
 =?utf-8?B?RFN2cGRMSjVER3h5a2J0YmYvZmhzYnVINldWdUtpaTFiUFczN2hodXQ5NjNt?=
 =?utf-8?B?NUhkUUV5c2tVTEh6V1E0VDdKNzQrT3BJcnhjcUhkK0xuQTBOZzBQWTRJbkg2?=
 =?utf-8?B?KzhBUG91cjA3b2hzeXgrRjNLZ0h3L0k3Snd1SEhiamN6dnJ1NVRrTUxUc2x1?=
 =?utf-8?B?QWQ2T1hOTkdEcit2QS9pcUszczFZbkp0NkZMQjdCcC95V0IvTi8wSGFwSzhL?=
 =?utf-8?B?TUhWQW9YU0tZaEdsQk5oTHVqdE5QWm41WEpTREE3cllyZmlWUmtIQi9HMVV6?=
 =?utf-8?Q?VdPG3xsO1nkZh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFBlQlRLSGdtM0NaUFZ4Wmc1dFNkYlREbmkyaDhtNnBLaGk3ZHpLOC9lVHJQ?=
 =?utf-8?B?cHJ4aGdVYkQ0ODdZWHFEeVZDWEJOZTN2RGpHKzNHN1ErZTFQRWN6L1NuVTRj?=
 =?utf-8?B?b1gxelFOMlNZRTRSM3lKUlp2dUVObXRTUitRaFNmdFZvejdyVDdpaEVKZ1Jv?=
 =?utf-8?B?UGtIVjhwQ25NNXQyZS9udmhtSmlmQ05QK0NIM0d6M2Qzc21tM0ZJOU9PaEJk?=
 =?utf-8?B?NHEyem5RdHIyTFR1VmFFWEZmREJwc1ZoTVAzMXlxN0RLTUx2ZzE4S2ZaUWVF?=
 =?utf-8?B?WGxXRjl0N29nUmR0d1Z6eGpWa1J4eGZocUNidCtuVFRHc2oza2VYZEFpd1o1?=
 =?utf-8?B?eDd4Mmd3emR1RFJnOE45dkdvVmtqaWUvNFRIbzJBdzJRY3VmZU9JOWxwM0xy?=
 =?utf-8?B?aDZaYlp4WTNGNUlCNVZDQ1N3VnhYb25tYU40cWxoS0xnNU5GdGZ3QTlPaHB2?=
 =?utf-8?B?THV4RnZhMmNiK0hoc01hWnZPNGt5WEoydnJ4S0lKM0FyaGJyWFlBSzhYc01S?=
 =?utf-8?B?eHlTbXZxL0w0L2NCMys3THRQM01hcXdYM1FPeHpuRlRqUlIzYy9hd3lPTHFh?=
 =?utf-8?B?MUVRVDgvbkpJWU45RCtLV3pNc3djM2JDam5qNnlVQXQydnQ5NWpvMkgwbGU0?=
 =?utf-8?B?RW5LMFVVenNsaUtYc3g5ZzlBRXBlUHlZcXRjVkR2ek01Qjh1L3pqM0hBQTBK?=
 =?utf-8?B?aER0ekZzNTllTmJDRHVFNkplWHdrcG15MThEcXlkUEVxSkVOR2hjVW5IVUhN?=
 =?utf-8?B?Slh4bWtiTHYzbmZDTnZwZUJ3SHBnaXNxWVpJRWx1MktHc0l6OUkxSjZ1a3FP?=
 =?utf-8?B?Mm5hSUNNalNsbVBsY3FNRHVRdmRucVZPUldPcHdMQk56RG5qcGdac2ZkZlVr?=
 =?utf-8?B?WEVWbHVaTmFCQnZWVGU2QXM1S0dPVXRPWFlUbWFWdFhqb0kreEM4NkY1TmJz?=
 =?utf-8?B?RkxWMC9ORDdwdmlML0tpSFIwVTVwT0ZJYlFNSnVqRjZKS2pLUWx3Mm1pVkRr?=
 =?utf-8?B?SmdHR09LYWZLQWZMQ1RSTnFlYS90dmtON1FBVVliYnpIWmYvWVFLNXk3MVRp?=
 =?utf-8?B?S2lndTZkc2FZQXJKSEgwN2tjaWtJbUZ6RDZhOGMxQ1dIR1RleVBHcVcvUHp6?=
 =?utf-8?B?WEdqdC80NEJUNm4zOFowZzdjdjFnRHh0eHpGSXlseFc3R0RsU25HNTJERk4z?=
 =?utf-8?B?N1hzY09ON1ZlblRGeEloV3d6YVBPT3JtZVRLNWRCejhGbkNKQy80UmxDL0Nq?=
 =?utf-8?B?NHc1QStkeCtQaXdJbVRGL1ZJWmc3VGVoUVRmVFREcldtd2pubGVzOVpUbVNM?=
 =?utf-8?B?NWp0SjlCK3gxZVAwM1FjL2JzYXlOSW54dUwrVHAwNHgyUEdxR29pUFJhWUVy?=
 =?utf-8?B?eWo1NElxSUJkOFRXMTNhNHlBRFNaR0c1bmR3K2g4RTRuZXdNV0Z5VGhlUTNP?=
 =?utf-8?B?L0dQV1dDMTZsbnVxVkRRTVpabllEY2hBNExFMnNybHg1Ly8zNHpGYXUzYU0r?=
 =?utf-8?B?dVh5V091c0owd3FUMVlXL2txWDZQM0F2UXQzQ24xdGo4RXpjdEhzZUdobFpk?=
 =?utf-8?B?M09ja1d6V2U0MlJYeTlnc0wrd3dSNU1xTzBqWURZV2REdjJ1bFBqWFJhVzUr?=
 =?utf-8?B?cnk5bDR4eUlTWWdTZU1uMGVNczdWZEJQRjdIUUNMbkdxanlDaTRuY20rSFFS?=
 =?utf-8?B?b0pqVUF4NjIyYXZsMzZLZlNoTzVBMGFJN2dXZlBvMnlFMnhsQlRnMzdXTVBl?=
 =?utf-8?B?ZkRnTENsVldUV3ppTU44YmRiUEpVUDFhb3dsZzRFNDZodWtkVnJoSDhTUG5I?=
 =?utf-8?B?TFNKeXVPQXRKZWdNMTdLTzRJRzJMOEJ2bnFwbXNHMTFnUGlIRXhDME0zeTJ4?=
 =?utf-8?B?bytwWExydEhCU2huUWRmdmcrV3ZtbFB4Y0JXVldWa1I5TjFadFY0UXV2L1pU?=
 =?utf-8?B?akE4NFpkR1FKUU5OTUlKeTRRK2o0U0dwYkJkMmVxUGlWTlNCckk5OXJPbVlP?=
 =?utf-8?B?OTdtSitjS2JobWxuaVhmUmlxWllpMlJDZklBZ0ZzN1VqajUxU05TdmxIbUt3?=
 =?utf-8?B?ZFJyVG1SaDFXbW85UDc0emg5RS9laU1uRGpacFpHcTRCNEZuc2tlQTZLZEMz?=
 =?utf-8?B?ek5INnVvM1ZsNmMyUjhDMWJJemIvMERBQy93OWdySFE1NXJzd08wS3dSWEVR?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44013CA5F2FE0E4AA1E52D8981F4EAF7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bKih6ourxbt0sCTQM8hJtZChbXXQ7LbKVCm84oHX4o/qBddi9CJDJ4zuWysCJHFnQ5yJnueUu8TW8IpV6FQqrbfV0Nbr02RE1EIK2EbK0iNeQbOD4kgm0BeOdj6S/gLSEwNSX98KkGyjaLKMcR7Ll32lcOSAKyYAHUL0FyLXR3eSoBkgNoEWfe8eeg8E1DpacngQfpy34ncOyFAI0e09bSuc12/Ya+MWrOgGBm5SZq1Vn2/MGFNmzIsiq2JbpyV75GzHwYA8ovFT01XCBgQd5B/G8rg5poUqIXCws5uQfrRX4bVp9nu8PNN2QIsmD2vfIPBfwaLmDvvw3L6GDQEoNRHPQfmBexJLM/wM41lY16J4InuSsWLJJVYUfQdXfs/v/EYB4u0Gnk5Mv9hXm9hcSga6VFy/RjnRKqLJ33WJnAL/9QaMutOu0XTpaqqGs14c8Iiu6vr9OANfxX8dhdlYjibY5+mlcdVQA6+ffZ0IZsSMldcT+Ot6nQKdN8Si2+4/03O30YihJSfXr+YazAv9NEy8GGU5+p2oSlesof/1WvQlkFalPiYpqJorVv5JGi428AmzrbPqcbrDcuESWFLvVl+Bc922JZZwNDcS39VKzXbWY2H3+CXPFCc3L+dTNsGy
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59af027-ea1f-49e6-bd51-08dd13356ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 00:57:10.1665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: To0I8Ju/gZm5soykWgdMpAnE3BAlLt1EiBJF1hUbcfbNSiBYSpgMiy6omUJgmw77LU6a9aMsm+XkD0PXTibt1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6235

SGV5IGFsbCwNCg0KVGhpcyBjYXNlIGFsd2F5cyBmYWlscyBvbiBteSBlbnZpcm9ubWVudCBGZWZv
cmE0MCArIHVwc3RyZWFtIGtlcm5lbCA2LjEzLjAtcmMxKyg2LjEyLXJjeCBhbHNvIGZhaWxlZCkN
Cg0KSXQgY2FuIGJlIHJlc29sdmVkIGlmIEkgZW5sYXJnZSB0aGUgYmxvY2sgZGV2aWNlIHNpemUg
dG8gMkdpQigxLjVHaUIgYWxzbyBmYWlsZWQpLg0KJCBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL3Rl
c3RzL3piZC8wMDkgYi90ZXN0cy96YmQvMDA5DQppbmRleCA2MjI2ZDgzLi4xMWJjYWZiIDEwMDc1
NQ0KLS0tIGEvdGVzdHMvemJkLzAwOQ0KKysrIGIvdGVzdHMvemJkLzAwOQ0KQEAgLTQ0LDcgKzQ0
LDcgQEAgdGVzdCgpIHsNCiAgDQogICAgICAgICBsb2NhbCBwYXJhbXM9KA0KICAgICAgICAgICAg
ICAgICBkZWxheT0wDQotICAgICAgICAgICAgICAgZGV2X3NpemVfbWI9MTAyNA0KKyAgICAgICAg
ICAgICAgIGRldl9zaXplX21iPTIwNDgNCiAgICAgICAgICAgICAgICAgc2VjdG9yX3NpemU9NDA5
Ng0KICAgICAgICAgICAgICAgICB6YmM9aG9zdC1tYW5hZ2VkDQogICAgICAgICAgICAgICAgIHpv
bmVfY2FwX21iPTMNCg0KDQpJIGhhdmUgbm8gaWRlYSB3aHkgd2UgbmVlZCB0byBlbmxhcmdlIHRo
ZSBibG9jayBzaXplIHdoaWxlIHRoZSBGSU8gb25seSBydW4gd2l0aCBzaXplICcxTScgaW4gdGhp
cyBjYXNlLg0KSWYgeW91IHdhbnQgbW9yZSBkZXRhaWxzLCBmZWVsIGZyZWUgdG8gbGV0IG1lIGtu
b3cuDQoNCj09PT09PT09PT09PT09PT09PQ0KDQokIC4vY2hlY2sgemJkLzAwOQ0KemJkLzAwOSAo
dGVzdCBnYXAgem9uZSBzdXBwb3J0IHdpdGggQlRSRlMpICAgICAgICAgICAgICAgICAgIFtmYWls
ZWRdDQogICAgIHJ1bnRpbWUgICAgLi4uICA2LjIzNHMNCiAgICAgLS0tIHRlc3RzL3piZC8wMDku
b3V0CTIwMjItMTAtMTEgMTA6NTk6MjkuNzk2OTI4ODY5ICswODAwDQogICAgICsrKyAvaG9tZS9s
aXpoaWppYW4vYmxrdGVzdHMvcmVzdWx0cy9ub2Rldi96YmQvMDA5Lm91dC5iYWQJMjAyNC0xMi0w
MyAwODo0NjoyOS4xMTg5MzI3ODggKzA4MDANCiAgICAgQEAgLTEsMiArMSwyIEBADQogICAgICBS
dW5uaW5nIHpiZC8wMDkNCiAgICAgLVRlc3QgY29tcGxldGUNCiAgICAgK1Rlc3QgZmFpbGVkDQoN
Cg0KJCBjYXQgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvbm9kZXYvemJkLzAwOS5m
dWxsDQpidHJmcy1wcm9ncyB2Ni44DQpTZWUgaHR0cHM6Ly9idHJmcy5yZWFkdGhlZG9jcy5pbyBm
b3IgbW9yZSBpbmZvcm1hdGlvbi4NCg0KUmVzZXR0aW5nIGRldmljZSB6b25lcyAvZGV2L3NkYiAo
MjU2IHpvbmVzKSAuLi4NCk5PVEU6IHNldmVyYWwgZGVmYXVsdCBzZXR0aW5ncyBoYXZlIGNoYW5n
ZWQgaW4gdmVyc2lvbiA1LjE1LCBwbGVhc2UgbWFrZSBzdXJlDQogICAgICAgdGhpcyBkb2VzIG5v
dCBhZmZlY3QgeW91ciBkZXBsb3ltZW50czoNCiAgICAgICAtIERVUCBmb3IgbWV0YWRhdGEgKC1t
IGR1cCkNCiAgICAgICAtIGVuYWJsZWQgbm8taG9sZXMgKC1PIG5vLWhvbGVzKQ0KICAgICAgIC0g
ZW5hYmxlZCBmcmVlLXNwYWNlLXRyZWUgKC1SIGZyZWUtc3BhY2UtdHJlZSkNCg0KTGFiZWw6ICAg
ICAgICAgICAgICAobnVsbCkNClVVSUQ6ICAgICAgICAgICAgICAgNjNhOWYwZWUtN2Y4OC00Njk2
LWI3MDUtM2ViYjBlMmFjNmUyDQpOb2RlIHNpemU6ICAgICAgICAgIDE2Mzg0DQpTZWN0b3Igc2l6
ZTogICAgICAgIDQwOTYJKENQVSBwYWdlIHNpemU6IDQwOTYpDQpGaWxlc3lzdGVtIHNpemU6ICAg
IDEuMDBHaUINCkJsb2NrIGdyb3VwIHByb2ZpbGVzOg0KICAgRGF0YTogICAgICAgICAgICAgc2lu
Z2xlICAgICAgICAgICAgNC4wME1pQg0KICAgTWV0YWRhdGE6ICAgICAgICAgRFVQICAgICAgICAg
ICAgICAgNC4wME1pQg0KICAgU3lzdGVtOiAgICAgICAgICAgRFVQICAgICAgICAgICAgICAgNC4w
ME1pQg0KU1NEIGRldGVjdGVkOiAgICAgICB5ZXMNClpvbmVkIGRldmljZTogICAgICAgeWVzDQog
ICBab25lIHNpemU6ICAgICAgICA0LjAwTWlCDQpGZWF0dXJlczogICAgICAgICAgIGV4dHJlZiwg
c2tpbm55LW1ldGFkYXRhLCBuby1ob2xlcywgZnJlZS1zcGFjZS10cmVlLCB6b25lZA0KQ2hlY2tz
dW06ICAgICAgICAgICBjcmMzMmMNCk51bWJlciBvZiBkZXZpY2VzOiAgMQ0KRGV2aWNlczoNCiAg
ICBJRCAgICAgICAgU0laRSAgWk9ORVMgIFBBVEgNCiAgICAgMSAgICAgMS4wMEdpQiAgICAyNTYg
IC9kZXYvc2RiDQoNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21lL2xpemhpamlhbi9ibGt0
ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5LjAuMDogTm8gc3BhY2Ug
bGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD0xMDI0MDAwLCBidWZsZW49NDA5Ng0KZmlvOiBp
b191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGly
LnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3Jp
dGUgb2Zmc2V0PTkwNTIxNiwgYnVmbGVuPTQwOTYNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9o
b21lL2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVy
aWZ5LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD02ODgxMjgsIGJ1
Zmxlbj00MDk2DQpmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4vYmxrdGVz
dHMvcmVzdWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxl
ZnQgb24gZGV2aWNlOiB3cml0ZSBvZmZzZXQ9NTQwNjcyLCBidWZsZW49NDA5Ng0KZmlvOiBpb191
IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpi
ZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUg
b2Zmc2V0PTYzMDc4NCwgYnVmbGVuPTQwOTYNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21l
L2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5
LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD0xMDI4MDk2LCBidWZs
ZW49NDA5Ng0KZmlvOiBpb191IGVycm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3Rz
L3Jlc3VsdHMvdG1wZGlyLnpiZC4wMDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0
IG9uIGRldmljZTogd3JpdGUgb2Zmc2V0PTEyMjg4LCBidWZsZW49NDA5Ng0KZmlvOiBpb191IGVy
cm9yIG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4w
MDkuMUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zm
c2V0PTIzMzQ3MiwgYnVmbGVuPTQwOTYNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21lL2xp
emhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5LjAu
MDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD0zMzk5NjgsIGJ1Zmxlbj00
MDk2DQpmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4vYmxrdGVzdHMvcmVz
dWx0cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxlZnQgb24g
ZGV2aWNlOiB3cml0ZSBvZmZzZXQ9ODc2NTQ0LCBidWZsZW49NDA5Ng0KZmlvOiBpb191IGVycm9y
IG9uIGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4wMDku
MUlKL21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zmc2V0
PTcwNDUxMiwgYnVmbGVuPTQwOTYNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21lL2xpemhp
amlhbi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5LjAuMDog
Tm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD01ODk4MjQsIGJ1Zmxlbj00MDk2
DQpmaW86IGlvX3UgZXJyb3Igb24gZmlsZSAvaG9tZS9saXpoaWppYW4vYmxrdGVzdHMvcmVzdWx0
cy90bXBkaXIuemJkLjAwOS4xSUovbW50L3ZlcmlmeS4wLjA6IE5vIHNwYWNlIGxlZnQgb24gZGV2
aWNlOiB3cml0ZSBvZmZzZXQ9OTk1MzI4LCBidWZsZW49NDA5Ng0KZmlvOiBpb191IGVycm9yIG9u
IGZpbGUgL2hvbWUvbGl6aGlqaWFuL2Jsa3Rlc3RzL3Jlc3VsdHMvdG1wZGlyLnpiZC4wMDkuMUlK
L21udC92ZXJpZnkuMC4wOiBObyBzcGFjZSBsZWZ0IG9uIGRldmljZTogd3JpdGUgb2Zmc2V0PTM5
NzMxMiwgYnVmbGVuPTQwOTYNCmZpbzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21lL2xpemhpamlh
bi9ibGt0ZXN0cy9yZXN1bHRzL3RtcGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5LjAuMDogTm8g
c3BhY2UgbGVmdCBvbiBkZXZpY2U6IHdyaXRlIG9mZnNldD0xNjM4NCwgYnVmbGVuPTQwOTYNCmZp
bzogaW9fdSBlcnJvciBvbiBmaWxlIC9ob21lL2xpemhpamlhbi9ibGt0ZXN0cy9yZXN1bHRzL3Rt
cGRpci56YmQuMDA5LjFJSi9tbnQvdmVyaWZ5LjAuMDogTm8gc3BhY2UgbGVmdCBvbiBkZXZpY2U6
IHdyaXRlIG9mZnNldD03ODIzMzYsIGJ1Zmxlbj00MDk2DQpmaW8gZXhpdGVkIHdpdGggc3RhdHVz
IDENCmZpbzogdmVyaWZpY2F0aW9uIHJlYWQgcGhhc2Ugd2lsbCBuZXZlciBzdGFydCBiZWNhdXNl
IHdyaXRlIHBoYXNlIHVzZXMgYWxsIG9mIHJ1bnRpbWUNCjQ7ZmlvLTMuMzY7dmVyaWZ5OzA7Mjg7
NzAwNDE2OzM2NDYxMDs5MTE1MjsxOTIxOzM7MTEwOzkuMjgzMDI3OzIuMDc4Njc4OzI7MTIzNDsx
NTkuMzA0MzYwOzI4LjkyNTM2NzsxLjAwMDAwMCU9MjM7NS4wMDAwMDAlPTExMjsxMC4wMDAwMDAl
PTE1MDsyMC4wMDAwMDAlPTE1NjszMC4wMDAwMDAlPTE1Njs0MC4wMDAwMDAlPTE1ODs1MC4wMDAw
MDAlPTE2MDs2MC4wMDAwMDAlPTE2Mjs3MC4wMDAwMDAlPTE2ODs4MC4wMDAwMDAlPTE3Mzs5MC4w
MDAwMDAlPTE4MTs5NS4wMDAwMDAlPTE4NTs5OS4wMDAwMDAlPTIwNTs5OS41MDAwMDAlPTIyMDs5
OS45MDAwMDAlPTI1OTs5OS45NTAwMDAlPTI3Njs5OS45OTAwMDAlPTQyODswJT0wOzAlPTA7MCU9
MDsxMDsxMjQzOzE2OC41ODczODg7MjguOTk4ODM3OzA7MDswLjAwMDAwMCU7MC4wMDAwMDA7MC4w
MDAwMDA7NzAwNDE2OzE5MTc4OTs0Nzk1MTszNjUyOzQ7NTAyMzsxNy45Mjg5Nzg7MjcuNzk0MTg5
OzE7NTQ0NjszMDMuMTQzOTI4OzEyNC4wNjk2MDE7MS4wMDAwMDAlPTU5OzUuMDAwMDAwJT0xMjQ7
MTAuMDAwMDAwJT0xNTA7MjAuMDAwMDAwJT0xOTk7MzAuMDAwMDAwJT0yNDI7NDAuMDAwMDAwJT0y
ODA7NTAuMDAwMDAwJT0zMDE7NjAuMDAwMDAwJT0zMjU7NzAuMDAwMDAwJT0zNTg7ODAuMDAwMDAw
JT0zOTE7OTAuMDAwMDAwJT00NDQ7OTUuMDAwMDAwJT00ODk7OTkuMDAwMDAwJT02MDI7OTkuNTAw
MDAwJT02NzU7OTkuOTAwMDAwJT03OTg7OTkuOTUwMDAwJT04NzI7OTkuOTkwMDAwJT0xMDExOzAl
PTA7MCU9MDswJT0wOzE3OzU0NTI7MzIxLjA1NTU1OTsxMjUuNzE3NzI2OzExMDM3NjsxMzMxMjA7
NjUuNzEwNDcxJTsxMjYwMjUuNDU0NTQ1OzY0OTEuNzE4NjA3OzA7MDswOzA7MDswOzAuMDAwMDAw
OzAuMDAwMDAwOzA7MDswLjAwMDAwMDswLjAwMDAwMDsxLjAwMDAwMCU9MDs1LjAwMDAwMCU9MDsx
MC4wMDAwMDAlPTA7MjAuMDAwMDAwJT0wOzMwLjAwMDAwMCU9MDs0MC4wMDAwMDAlPTA7NTAuMDAw
MDAwJT0wOzYwLjAwMDAwMCU9MDs3MC4wMDAwMDAlPTA7ODAuMDAwMDAwJT0wOzkwLjAwMDAwMCU9
MDs5NS4wMDAwMDAlPTA7OTkuMDAwMDAwJT0wOzk5LjUwMDAwMCU9MDs5OS45MDAwMDAlPTA7OTku
OTUwMDAwJT0wOzk5Ljk5MDAwMCU9MDswJT0wOzAlPTA7MCU9MDswOzA7MC4wMDAwMDA7MC4wMDAw
MDA7MDswOzAuMDAwMDAwJTswLjAwMDAwMDswLjAwMDAwMDsxNS42Nzk5NDMlOzQ3LjU2MDEwMCU7
MjgyMDUzOzA7MzA7MC40JTswLjglOzEuNiU7My4xJTs5NC4xJTswLjAlOzAuMCU7MC4wOCU7MC4y
MSU7MC4wMSU7MC4yMCU7MC44NyU7MS42OSU7NjIuNjUlOzMyLjE3JTsyLjAyJTswLjA5JTswLjAx
JTswLjAwJTswLjAxJTswLjAwJTswLjAwJTswLjAwJTswLjAwJTswLjAwJTswLjAwJTswLjAwJTsw
LjAwJTswLjAwJQ0KDQpUaGFua3MNClpoaWppYW4NCg==

