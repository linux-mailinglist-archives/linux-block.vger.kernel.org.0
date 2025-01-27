Return-Path: <linux-block+bounces-16584-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11CA1DD36
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2025 21:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C071885E42
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2025 20:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48521194C6A;
	Mon, 27 Jan 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="niru5JTt"
X-Original-To: linux-block@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353A53BE;
	Mon, 27 Jan 2025 20:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738008781; cv=fail; b=XA7NVLTH0eKi1HrAbe3KX537IhvFYminRv9SdZJDgW+AcszmyDQu3sI/ngmFhqO/da29HOcT9rD95NlTrm/c9wMnBhjh6n73uIRbcR187Q2u3rXrYVt3dWjlFZ1odOuZx+AJouIpQ8+1Us96o49NeW1iIjPu94EkRPDvdbauL7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738008781; c=relaxed/simple;
	bh=5cMFlUN4y6OVyHZfGnuqO/o9hA8MmCxMtnxb0f2GIy0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ooVjplz0iBtzx8LBSalSjZQdWCWPECHsIf2c6X28zXvJuUjmD7tkrsjxfN9jti7iqro12PgAR1P4i9su9zK9Kc5i4R0ki4OksONCOpMZi0wtL3ISNwrVdep/zIQ8ZQgrzH8zgxpksNcnAvuZ6k+YVVmfWUh6OW3flauC/b9i3YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=niru5JTt; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFuukV013306;
	Mon, 27 Jan 2025 20:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=5cMFlUN4y6OVyHZfGnuqO/o9hA8MmCxMtnxb0f2GIy0=; b=niru5JTt
	wxTxMk3ILW8UO2XwSsGl0cA4N8nbDqD4eYtKy58Nbz7T7fL7hMrDUVkcZgEgLwec
	2R8rLnIV1Ix6ZhExOjrceKf9dNKXpDfdN/U0BX+gUHIXUTxAMK7jS0+vEup3N47C
	a5+S04+4mesnc4MJ9pFXLYiUn6jyIpfIRiNnkTIxmpfy/NgLbCOzNfXVKDY3/uG7
	ovrvYjq+mE3KjGLFvZMoO5eUInRgQXPi9KQlcANamui0UcfS7jXtZb2ehx3CuAAT
	fSGx9xTqOATmYcwA7Kqp7eFNcIl3lEXERE7l+VUbJLnGRgd8P17uvskqDLWJaGYv
	rUdl+GHrIlqG7Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ecyt97vr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 20:12:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCZdnGpZwOw+2+9AEtIWUNH75f5J1M6fCWjnnyhayFj/v9oy5OEP6FiweltvV68TfPXiizFaMmdqZzbi+ktvtEoDYTJVC2ieWeN8p+0JSKuafZAo7a2MfS2VFHN5G5MiS5haJQXhP3Siv0Pfo9pDdfmnAaVYnJgncssohuUZLwjNMAgbAAYW4O2sm4Gok3CQV8YILr4jeIBjTReW76H9q3GX4GOCVdYjwEERXxystUSygbPI2ysxldRxhDubkdLaFxU8adEK7r9gEKtlcxENHItURvx6+twCqp4wBPZT8uwwR7z98HPJYSDcOuRbOuLbtXSYpUFlU8/+pU07UvhojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cMFlUN4y6OVyHZfGnuqO/o9hA8MmCxMtnxb0f2GIy0=;
 b=LvWY4L6o4hIT6/Kg73S2/qcpZyc7wLwVv+s7Nei/HCMipd6FqyJK4L8RvX9tefAsBMCNjTNWsdHzXDN/QNYYoGw+dRWhdBBn2yIJvT1m+pn4n2IXUArcWhnOoNI1FNmJzzw60/UcLz9BHbFohj0EpmMEtWbDSs+xS0LQ+BwsqC+LcD6A/AKXw+NB6tCu8wisrnmvqBD1iUwzfy90FI5nn7cDVUNAo1ecZJcgV9syDNlHtzJhnKVRvAYPSU8AXgA6Xqn+vX3uNCLHF3uAYiwznvCicAGV7rgJ8bWrOOPaEgPLsnS+bOEi1tD6bhipVJCrkE9bdO9ec62mGpj37vq5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4578.namprd15.prod.outlook.com (2603:10b6:806:19a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 20:12:45 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:12:45 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH] Introduce generalized data
 temperature estimation framework
Thread-Index: AQHbbyQxAlWz/FUOJUiu3/MyPVevgbMrEV4A
Date: Mon, 27 Jan 2025 20:12:45 +0000
Message-ID: <1fda0adb75b0ae026e3782c860fb355f1f162320.camel@ibm.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
	 <7e6eb0d6f42ec77779e2da211db8854dffa6dbcd.camel@kernel.org>
In-Reply-To: <7e6eb0d6f42ec77779e2da211db8854dffa6dbcd.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4578:EE_
x-ms-office365-filtering-correlation-id: 191c7e31-bbc9-4d7c-ac22-08dd3f0ef672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3dsL2MxQVZPdnNuZExkSEM4MnpFYW1CdmFQN2txaW9EaDlPV21HOXJjWlhk?=
 =?utf-8?B?RU9Vb0loSFBOMGR6RTNKTEFmQ1lodVJiYytwVDM5SlVLRUhZb2c4dndSUm1n?=
 =?utf-8?B?SzduUkNYQ3owM294dEhneDhDcldkc0tLcG12ZTNjZXZQY0xleUN1Z0llbklY?=
 =?utf-8?B?Q1R2Y3lYMm1SOXRXMVJwV0tFM0hndjFIb2E4TC9yaTlUVENKVm1BWXN0YWMr?=
 =?utf-8?B?b1pIa1pmMzdaTTNYa2M0R3dJbzZuQUFCc3JpNTNCZ2RMRU9pcjV4YnpDdjZY?=
 =?utf-8?B?djhrclI3U3hQTW1xbFdPMUFJUE80aXlTMVNHMXRXOUtYRzErekhpREcxVitT?=
 =?utf-8?B?OFFad1I5bGhtUHZ5Q0tWUzRLTlJtRVNycC9BeFQ0eE9Fd0lFaE9icDcwUjhh?=
 =?utf-8?B?SEdFQmFRazExRGdtcHJDVVVwYnFyL0ZPb2tpZlNJOXhvaW91R0JUVkNzODRa?=
 =?utf-8?B?dW52cHNVN2QzUEJ1dExoTGQvbTlHY3ozaHhSUWtNanlLcU9GS1V2bWJodUx2?=
 =?utf-8?B?QXdSUm9WaFB5Y2I0VHk1dUs0Y1lYTCs5SGNYYnliblMrdXRueGdsc1cwSTdK?=
 =?utf-8?B?RC9yWlh1VTk1SDk2OXBad2FKbzZNUDVraFJkc0ExRXNKTzRvZ3RrZHlqcEk0?=
 =?utf-8?B?NDN6RW1EVHB0UmpZMmFLdWlXU2paMCtJSmphYVo3UHRpZGw0bDN4Tm95N3hR?=
 =?utf-8?B?SFlNQjM0aDA4cCtheFpYRFcyczllQmZQaUUzZ1NKZUhYRHllSG5hRmtYWDhB?=
 =?utf-8?B?RHpCT0U1Q3VIRmhWZmk1K2c5ZlBSUXRxWjN6VHJwdDlQQmJObjJWUFFiY3d2?=
 =?utf-8?B?b1N4MXVlQ1RXdWRRRUhsSFA0SExGRlZIZG5jMU9CZ0NjZTdGRERUNnYwRThj?=
 =?utf-8?B?aTRZTVVDU0ZvMFhkY1ZOdVBrbzNtS1QwR1VHWXVjYmJKTW1HUVIxQUExd2xt?=
 =?utf-8?B?aE5UY3BCYVIwTjdsUy9Qem15WUVhUEZxOEc4bkdQRHVaNU1iMXh0djl3bWhX?=
 =?utf-8?B?NmdjdnZZWUlvRHY0Y0Mxd3N6cE95NzROWjdFTU8xRWpEYnNlWU9sN1hRZkdw?=
 =?utf-8?B?bHZSNnQvMlkwb3FyWENiMGNkRHJqQjByU3pyUTdCMzdDd04vOHMxYmZtczJ1?=
 =?utf-8?B?dDlnVDRmOXhoYWgyak5CTy9BNGdJYVlrRzNzYlR0WE80MmdkTHRTKzRwcnlG?=
 =?utf-8?B?eWx6ZUVNYnBQMzVkUWdrcjVXQlV5Yi9Bckg2SnJRNG00NUhaVkYzVUFUUE9w?=
 =?utf-8?B?UXVQbDJpdDJ6TThPU1pZeGFXUkJpZHFlUWluU09TdTlhVklwK1REVEkwWmFa?=
 =?utf-8?B?OVBEblU0RXZXS2R6czVIdVkzbU5QUlNZdGJjYUpTN2krYUZIeFE2NFVFMjhx?=
 =?utf-8?B?SVpHQ1p1ZnJXbTViRGl1YzFhQVhGWjkwVEpBcDM2SDBJY0F2WDNHSDhsRFBO?=
 =?utf-8?B?MkhUUW5EUnF2WS8zTmR0dXRGTWtDS1RJemF4dVU1ZmI2QXM2azlBZUVmMG9n?=
 =?utf-8?B?a2g4YTdFZkRoQmQzZTM0c0kwQ2lnUDZodlNsdFdsa0xQVGxMaFRDRGJmaU1r?=
 =?utf-8?B?MzhMekc2OFNLeW8yOU1jUUw3QWswQjJPTlZtUmFlTTBqUmMxTFE3OUlkR0xv?=
 =?utf-8?B?UDRtYVBuZ0VHbUh0M2V0SWFQaG1LZkdCMU5iNS8rcTFHTVpsb2ZEVjIvVlpw?=
 =?utf-8?B?cFpaak9kRUNOVDEzVkNadXdETWRYa2JkTElmK1h4OUZFajlNeTUvazFLUEo2?=
 =?utf-8?B?T0wzc1F0VTgvWEp3UUNuZVJnWFpycUlRMUlJdGFaTzJGNHNMRTNoVEhaMFRQ?=
 =?utf-8?B?V2JjcnQzaEdmV3lYQnZ5RmFaVStJQzFLUWJIOFV1WlNzYlFNT0UveGxRL1pQ?=
 =?utf-8?B?OXJQUThvNnVCK0NxM3NjbDRCSUZLbnpXSlM4aVNtTVp2cGRZaDgrdjFQUjBU?=
 =?utf-8?Q?cPFSIWwfvXNG6QWO96R46+ROmBDx0uZo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QVF0M0g2c0JjOTVjY1V6V1hLMy9mL2ZTRVVhWWMzNW5WbkQ5RHBjeHZFdmdi?=
 =?utf-8?B?eWI1d2F2RzVIdmlMZFJJVGhCZUJOZjhaL0ZUcU45YUQxWXhGb3h0Z0NsQWds?=
 =?utf-8?B?bTFNNThLTS83UGM1c3RNWDRUYm9SV3kza3B1M1dub3F4RTBqVmducldtMzRR?=
 =?utf-8?B?TTNSK0QrcnVveXhacnpyckRNR0M2d1lZMzdPOVhldi9YeDVJL0lmV2lRczli?=
 =?utf-8?B?MW9yTnhaNFMyWGpHdnhxMEFiOWdkSGV3aGEzclprK2lwa3FweUxmUmhzL29P?=
 =?utf-8?B?WVh0VU1UK25VOHBPVWgxVHJEeUZkTFVqaGxIOUhxTjBhMkl3bmdObEtJa28y?=
 =?utf-8?B?MG1oTFR4M2VPRFl2OXBOQ0tWZVVwYlIwdkkycHJBSE90Qm9aSFdZY05wOVgw?=
 =?utf-8?B?ZDRyLzVrNWNSaGtKa0x1UUFjUlVRelRhMVdadDVEV3hGWWZ3RkxZR2dqZ2Js?=
 =?utf-8?B?VTBkNG1MVmdYUE5Pb1lIMmx5eklvZXJyekdMMElBWm91NHppR0Rlay95ZlRQ?=
 =?utf-8?B?cnk3RmhkZkhhZm1tbzFTN1hlOXptTVRmQkNDc1hmSGNTRWVNbUJNOGY4MWNR?=
 =?utf-8?B?Tk5xajI2S3ZUSGJnSGxGTVpBakVVRHJRWGFrZ20veGJxc3FOWGdDcXlNQmsw?=
 =?utf-8?B?ZjhYcmJkZ1ZRS1F3dGRwaitBVEpqVUtkVTJlZEtPWDEvM1E2cXdTcnNtcTRi?=
 =?utf-8?B?cE9DWWNwUVFYMjA3RWFnVUJ2UzZCeEgzcFRsTVlUeFNjNGIwUGFCMlBEcjhW?=
 =?utf-8?B?ak5IN0xoTFB3TFV5T2U2TlNjeHA5UnRHbjNqc3d3L05zWGppdGxzSWFsYTJm?=
 =?utf-8?B?NGhMQkdGaWdnTFl0ZERRZFZnbEZYeDUveVFBaUZlclBRbytrN0hoWlJrUFVy?=
 =?utf-8?B?ZSs5TmhaNXNIRU5GZWM4Ky96aEhDYk95T3VwVzlkT0pEak5QeXVjdFBPejRu?=
 =?utf-8?B?MXR5Ry85WHJMbkNhNmg0dFJCRjBPN0ZJYzFkaHpleEUzVXlaTkh0TzZqMCtn?=
 =?utf-8?B?MHIvck1Ba0Z3NmtldkpkU0xXYk16TmhKSXpNWC9MZjQ0M25qRmZLMUpsb0Fs?=
 =?utf-8?B?SWN3ZHBIZEc5alN2VWFFcXQrV3JOWVVLcTU2MDNkbWpScHlHdStMbmpXQWF3?=
 =?utf-8?B?WXI4UVpFRnJmdkcvclljdUNVdzVZVkVlYmxibzBTanJqdkNSdWtwcDF2aWYy?=
 =?utf-8?B?VHpJVWVad1NLUG1QeDgxbUpqRk9UY1MxWkpnNVpxQWhBUmVkeEIwTDdVTFpn?=
 =?utf-8?B?TVpRcWhabS9ldVd2aXIyYksrWHU5bVhPcGFtSGpiY2dZaGxkM3JwdDE5MUla?=
 =?utf-8?B?a3FoNzcxdHUycFhGUFVDWlJuNEtoWWZQL2lnV0ZlT0tHUXZiS0h2LytMdTVJ?=
 =?utf-8?B?VnZOK2ZFS1E5bU5Fa2t3MUIzdUdnb1BXMHB6QkdtUzF6TkFseTU5L3BGNHg5?=
 =?utf-8?B?blJLZml5TDMzVUVvTzM4dlNQMlgwZUFWRDZHZHNuUTl0SWhGQTViamdGRjR3?=
 =?utf-8?B?KzVCRm9DMmhySXdRK1JYS2RLVEZkd09FWndWMEZkMUJjbjNYZFlnUDdoMFBi?=
 =?utf-8?B?RGhTdWdFT1g0bTlkTEI5UThxbjVIR2ZXRjBWRXhNNFlLWStCMWlyVXVuaWdu?=
 =?utf-8?B?ZDlBSVhEV1pEVTNvRE5tVFMwbWZHRWZTNHN5NWhNRnpBc3VHTXlCbFlvNzdU?=
 =?utf-8?B?TTFGR0ErQzJKb1REZ20vdk5aRUxBR1FMa2Q0cnk3alArSUcrRlYvbWRuY3hk?=
 =?utf-8?B?djBKSkwyM2hvNGx3NzZqUTE1ZzVFU2ZYRlhFQXY5OXZOajVtaXJqSm1abjl4?=
 =?utf-8?B?WnhBYkNkVXdDa01WOTJyNnhwcklCZ1V4SXFzRDUzc1E3Z0JmeHhCRHdSKzln?=
 =?utf-8?B?RnJaNVZYcTJHQ3l5NExPTFdRRWZzQ1REOWRTbmtaUVVQQlRzVDdQUHlCaWNO?=
 =?utf-8?B?c2crU1ZyOUVLNVJUTEFSa0MzMDF5ZUh4VDluYVQ5Q3U4WHMzdXU3OFhSdW8z?=
 =?utf-8?B?cStoNnkyRkt4YmRSVmJZRkZlSndkQzV1RG1YeUttWk5DNExxVWNIWTU4cTZC?=
 =?utf-8?B?STcwM25iR3c5NzY0YlgvaTZBV0l0NWtqanVJa0xaV2JscjVUVkRNM2FoUTRW?=
 =?utf-8?B?V0dndCtCR1hndjFyYTQ3anhlcHk1NHlZUUZQSGl0R2J6djF0WGhubG90bndD?=
 =?utf-8?Q?Fq7RbvRZU6zKY+1vk5cGKE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92222BF84587034A8DDB76A18807AE11@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 191c7e31-bbc9-4d7c-ac22-08dd3f0ef672
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 20:12:45.2990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /UquaZYr8QCnh4xhDYsJRER1rmh0S5RRY51lN1Uoa0V3IzuRV95jkSr0XdThqUe6yOkQXB+NpndvAoqbh0J1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4578
X-Proofpoint-GUID: DdZUwMwCB27JW1cVSO3Bm2BN4gsYUyoZ
X-Proofpoint-ORIG-GUID: DdZUwMwCB27JW1cVSO3Bm2BN4gsYUyoZ
Subject: RE: [RFC PATCH] Introduce generalized data temperature estimation framework
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_09,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270154

T24gU2F0LCAyMDI1LTAxLTI1IGF0IDA3OjI1IC0wNTAwLCBKZWZmIExheXRvbiB3cm90ZToNCj4g
T24gVGh1LCAyMDI1LTAxLTIzIGF0IDEyOjI0IC0wODAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+ID4gW1BST0JMRU0gREVDTEFSQVRJT05dDQo+ID4gRWZmaWNpZW50IGRhdGEgcGxhY2Vt
ZW50IHBvbGljeSBpcyBhIEhvbHkgR3JhaWwgZm9yIGRhdGENCj4gPiBzdG9yYWdlIGFuZCBmaWxl
IHN5c3RlbSBlbmdpbmVlcnMuIEFjaGlldmluZyB0aGlzIGdvYWwgaXMNCj4gPiBlcXVhbGx5IGlt
cG9ydGFudCBhbmQgcmVhbGx5IGhhcmQuIE11bHRpcGxlIGRhdGEgc3RvcmFnZQ0KPiA+IGFuZCBm
aWxlIHN5c3RlbSB0ZWNobm9sb2dpZXMgaGF2ZSBiZWVuIGludmVudGVkIHRvIG1hbmFnZQ0KPiA+
IHRoZSBkYXRhIHBsYWNlbWVudCBwb2xpY3kgKGZvciBleGFtcGxlLCBDT1csIFpOUywgRkRQLCBl
dGMpLg0KPiA+IEJ1dCB0aGVzZSB0ZWNobm9sb2dpZXMgc3RpbGwgcmVxdWlyZSB0aGUgaGludHMg
cmVsYXRlZCB0bw0KPiA+IG5hdHVyZSBvZiBkYXRhIGZyb20gYXBwbGljYXRpb24gc2lkZS4NCj4g
PiANCj4gPiBbREFUQSAiVEVNUEVSQVRVUkUiIENPTkNFUFRdDQo+ID4gT25lIG9mIHRoZSB3aWRl
bHkgdXNlZCBhbmQgaW50dWl0aXZlbHkgY2xlYXIgaWRlYSBvZiBkYXRhDQo+ID4gbmF0dXJlIGRl
ZmluaXRpb24gaXMgZGF0YSAidGVtcGVyYXR1cmUiIChjb2xkLCB3YXJtLA0KPiA+IGhvdCBkYXRh
KS4gSG93ZXZlciwgZGF0YSAidGVtcGVyYXR1cmUiIGlzIGFzIGludHVpdGl2ZWx5DQo+ID4gc291
bmQgYXMgaWxsdXNpdmUgZGVmaW5pdGlvbiBvZiBkYXRhIG5hdHVyZS4gR2VuZXJhbGx5DQo+ID4g
c3BlYWtpbmcsIHRoZXJtb2R5bmFtaWNzIGRlZmluZXMgdGVtcGVyYXR1cmUgYXMgYSB3YXkNCj4g
PiB0byBlc3RpbWF0ZSB0aGUgYXZlcmFnZSBraW5ldGljIGVuZXJneSBvZiB2aWJyYXRpbmcNCj4g
PiBhdG9tcyBpbiBhIHN1YnN0YW5jZS4gQnV0IHdlIGNhbm5vdCBzZWUgYSBkaXJlY3QgYW5hbG9n
eQ0KPiA+IGJldHdlZW4gZGF0YSAidGVtcGVyYXR1cmUiIGFuZCB0ZW1wZXJhdHVyZSBpbiBwaHlz
aWNzDQo+ID4gYmVjYXVzZSBkYXRhIGlzIG5vdCBzb21ldGhpbmcgdGhhdCBoYXMga2luZXRpYyBl
bmVyZ3kuDQo+ID4gDQo+ID4gW1dIQVQgSVMgR0VORVJBTElaRUQgREFUQSAiVEVNUEVSQVRVUkUi
IEVTVElNQVRJT05dDQo+ID4gV2UgdXN1YWxseSBpbXBseSB0aGF0IGlmIHNvbWUgZGF0YSBpcyB1
cGRhdGVkIG1vcmUNCj4gPiBmcmVxdWVudGx5LCB0aGVuIHN1Y2ggZGF0YSBpcyBtb3JlIGhvdCB0
aGFuIG90aGVyIG9uZS4NCj4gPiBCdXQsIGl0IGlzIHBvc3NpYmxlIHRvIHNlZSBzZXZlcmFsIHBy
b2JsZW1zIGhlcmU6DQo+ID4gKDEpIEhvdyBjYW4gd2UgZXN0aW1hdGUgdGhlIGRhdGEgImhvdG5l
c3MiIGluDQo+ID4gcXVhbnRpdGF0aXZlIHdheT8gKDIpIFdlIGNhbiBzdGF0ZSB0aGF0IGRhdGEg
aXMgImhvdCINCj4gPiBhZnRlciBzb21lIG51bWJlciBvZiB1cGRhdGVzLiBJdCBtZWFucyB0aGF0
IHRoaXMNCj4gPiBkZWZpbml0aW9uIGltcGxpZXMgc3RhdGUgb2YgdGhlIGRhdGEgaW4gdGhlIHBh
c3QuDQo+ID4gV2lsbCB0aGlzIGRhdGEgY29udGludWUgdG8gYmUgImhvdCIgaW4gdGhlIGZ1dHVy
ZT8NCj4gPiBHZW5lcmFsbHkgc3BlYWtpbmcsIHRoZSBjcnVjaWFsIHByb2JsZW0gaXMgaG93IHRv
IGRlZmluZQ0KPiA+IHRoZSBkYXRhIG5hdHVyZSBvciBkYXRhICJ0ZW1wZXJhdHVyZSIgaW4gdGhl
IGZ1dHVyZS4NCj4gPiBCZWNhdXNlLCB0aGlzIGtub3dsZWRnZSBpcyB0aGUgZnVuZGFtZW50YWwg
YmFzaXMgZm9yDQo+ID4gZWxhYm9yYXRpb24gYW4gZWZmaWNpZW50IGRhdGEgcGxhY2VtZW50IHBv
bGljeS4NCj4gPiBHZW5lcmFsaXplZCBkYXRhICJ0ZW1wZXJhdHVyZSIgZXN0aW1hdGlvbiBmcmFt
ZXdvcmsNCj4gPiBzdWdnZXN0cyB0aGUgd2F5IHRvIGRlZmluZSBhIGZ1dHVyZSBzdGF0ZSBvZiB0
aGUgZGF0YQ0KPiA+IGFuZCB0aGUgYmFzaXMgZm9yIHF1YW50aXRhdGl2ZSBtZWFzdXJlbWVudCBv
ZiBkYXRhDQo+ID4gInRlbXBlcmF0dXJlIi4NCj4gPiANCj4gPiBbQVJDSElURUNUVVJFIE9GIEZS
QU1FV09SS10NCj4gPiBVc3VhbGx5LCBmaWxlIHN5c3RlbSBoYXMgYSBwYWdlIGNhY2hlIGZvciBl
dmVyeSBpbm9kZS4gQW5kDQo+ID4gaW5pdGlhbGx5IG1lbW9yeSBwYWdlcyBiZWNvbWUgZGlydHkg
aW4gcGFnZSBjYWNoZS4gRmluYWxseSwNCj4gPiBkaXJ0eSBwYWdlcyB3aWxsIGJlIHNlbnQgdG8g
c3RvcmFnZSBkZXZpY2UuIFRlY2huaWNhbGx5DQo+ID4gc3BlYWtpbmcsIHRoZSBudW1iZXIgb2Yg
ZGlydHkgcGFnZXMgaW4gYSBwYXJ0aWN1bGFyIHBhZ2UNCj4gPiBjYWNoZSBpcyB0aGUgcXVhbnRp
dGF0aXZlIG1lYXN1cmVtZW50IG9mIGN1cnJlbnQgImhvdG5lc3MiDQo+ID4gb2YgYSBmaWxlLiBC
dXQgbnVtYmVyIG9mIGRpcnR5IHBhZ2VzIGlzIHN0aWxsIG5vdCBzdGFibGUNCj4gPiBiYXNpcyBm
b3IgcXVhbnRpdGF0aXZlIG1lYXN1cmVtZW50IG9mIGRhdGEgInRlbXBlcmF0dXJlIi4NCj4gPiBJ
dCBpcyBwb3NzaWJsZSB0byBzdWdnZXN0IG9mIHVzaW5nIHRoZSB0b3RhbCBudW1iZXIgb2YNCj4g
PiBsb2dpY2FsIGJsb2NrcyBpbiBhIGZpbGUgYXMgYSB1bml0IG9mIG9uZSBkZWdyZWUgb2YgZGF0
YQ0KPiA+ICJ0ZW1wZXJhdHVyZSIuIEFzIGEgcmVzdWx0LCBpZiB0aGUgd2hvbGUgZmlsZSB3YXMg
dXBkYXRlZA0KPiA+IHNldmVyYWwgdGltZXMsIHRoZW4gInRlbXBlcmF0dXJlIiBvZiB0aGUgZmls
ZSBoYXMgYmVlbg0KPiA+IGluY3JlYXNlZCBmb3Igc2V2ZXJhbCBkZWdyZWVzLiBBbmQgaWYgdGhl
IGZpbGUgaXMgdW5kZXINCj4gPiBjb250aW5vdXMgdXBkYXRlcywgdGhlbiB0aGUgZmlsZSAidGVt
cGVyYXR1cmUiIGlzIGdyb3dpbmcuDQo+ID4gDQo+ID4gV2UgbmVlZCB0byBrZWVwIG5vdCBvbmx5
IGN1cnJlbnQgbnVtYmVyIG9mIGRpcnR5IHBhZ2VzLA0KPiA+IGJ1dCBhbHNvIHRoZSBudW1iZXIg
b2YgdXBkYXRlZCBwYWdlcyBpbiB0aGUgbmVhciBwYXN0DQo+ID4gZm9yIGFjY3VtdWxhdGluZyB0
aGUgdG90YWwgInRlbXBlcmF0dXJlIiBvZiBhIGZpbGUuDQo+ID4gR2VuZXJhbGx5IHNwZWFraW5n
LCB0b3RhbCBudW1iZXIgb2YgdXBkYXRlZCBwYWdlcyBpbiB0aGUNCj4gPiBuZWFyZXN0IHBhc3Qg
ZGVmaW5lcyB0aGUgYWdncmVnYXRlZCAidGVtcGVyYXR1cmUiIG9mIGZpbGUuDQo+ID4gQW5kIG51
bWJlciBvZiBkaXJ0eSBwYWdlcyBkZWZpbmVzIHRoZSBkZWx0YSBvZg0KPiA+ICJ0ZW1wZXJhdHVy
ZSIgZ3Jvd3RoIGZvciBjdXJyZW50IHVwZGF0ZSBvcGVyYXRpb24uDQo+ID4gVGhpcyBhcHByb2Fj
aCBkZWZpbmVzIHRoZSBtZWNoYW5pc20gb2YgInRlbXBlcmF0dXJlIiBncm93dGguDQo+ID4gDQo+
ID4gQnV0IGlmIHdlIGhhdmUgbm8gbW9yZSB1cGRhdGVzIGZvciB0aGUgZmlsZSwgdGhlbg0KPiA+
ICJ0ZW1wZXJhdHVyZSIgbmVlZHMgdG8gZGVjcmVhc2UuIFN0YXJ0aW5nIGFuZCBlbmRpbmcNCj4g
PiB0aW1lc3RhbXBzIG9mIHVwZGF0ZSBvcGVyYXRpb24gY2FuIHdvcmsgYXMgYSBiYXNpcyBmb3IN
Cj4gPiBkZWNyZWFzaW5nICJ0ZW1wZXJhdHVyZSIgb2YgYSBmaWxlLiBJZiB3ZSBrbm93IHRoZSBu
dW1iZXINCj4gPiBvZiB1cGRhdGVkIGxvZ2ljYWwgYmxvY2tzIG9mIHRoZSBmaWxlLCB0aGVuIHdl
IGNhbiBkaXZpZGUNCj4gPiB0aGUgZHVyYXRpb24gb2YgdXBkYXRlIG9wZXJhdGlvbiBvbiBudW1i
ZXIgb2YgdXBkYXRlZA0KPiA+IGxvZ2ljYWwgYmxvY2tzLiBBcyBhIHJlc3VsdCwgdGhpcyBpcyB0
aGUgd2F5IHRvIGRlZmluZQ0KPiA+IGEgdGltZSBkdXJhdGlvbiBwZXIgb25lIGxvZ2ljYWwgYmxv
Y2suIEJ5IG1lYW5zIG9mDQo+ID4gbXVsdGlwbHlpbmcgdGhpcyB2YWx1ZSAodGltZSBkdXJhdGlv
biBwZXIgb25lIGxvZ2ljYWwNCj4gPiBibG9jaykgb24gdG90YWwgbnVtYmVyIG9mIGxvZ2ljYWwg
YmxvY2tzIGluIGZpbGUsIHdlDQo+ID4gY2FuIGNhbGN1bGF0ZSB0aGUgdGltZSBkdXJhdGlvbiBv
ZiAidGVtcGVyYXR1cmUiDQo+ID4gZGVjcmVhc2luZyBmb3Igb25lIGRlZ3JlZS4gRmluYWxseSwg
dGhlIG9wZXJhdGlvbiBvZg0KPiA+IGRpdmlzaW9uIHRoZSB0aW1lIHJhbmdlIChiZXR3ZWVuIGVu
ZCBvZiBsYXN0IHVwZGF0ZQ0KPiA+IG9wZXJhdGlvbiBhbmQgYmVnaW4gb2YgbmV3IHVwZGF0ZSBv
cGVyYXRpb24pIG9uDQo+ID4gdGhlIHRpbWUgZHVyYXRpb24gb2YgInRlbXBlcmF0dXJlIiBkZWNy
ZWFzaW5nIGZvcg0KPiA+IG9uZSBkZWdyZWUgcHJvdmlkZXMgdGhlIHdheSB0byBkZWZpbmUgaG93
IG1hbnkNCj4gPiBkZWdyZWVzIHNob3VsZCBiZSBzdWJ0cmFjdGVkIGZyb20gY3VycmVudCAidGVt
cGVyYXR1cmUiDQo+ID4gb2YgdGhlIGZpbGUuDQo+ID4gDQo+ID4gW0hPVyBUTyBVU0UgVEhFIEFQ
UFJPQUNIXQ0KPiA+IFRoZSBsaWZldGltZSBvZiBkYXRhICJ0ZW1wZXJhdHVyZSIgdmFsdWUgZm9y
IGEgZmlsZQ0KPiA+IGNhbiBiZSBleHBsYWluZWQgYnkgc3RlcHM6ICgxKSBpZ2V0KCkgbWV0aG9k
IHNldHMNCj4gPiB0aGUgZGF0YSAidGVtcGVyYXR1cmUiIG9iamVjdDsgKDIpIGZvbGlvX2FjY291
bnRfZGlydGllZCgpDQo+ID4gbWV0aG9kIGFjY291bnRzIHRoZSBudW1iZXIgb2YgZGlydHkgbWVt
b3J5IHBhZ2VzIGFuZA0KPiA+IHRyaWVzIHRvIGVzdGltYXRlIHRoZSBjdXJyZW50IHRlbXBlcmF0
dXJlIG9mIHRoZSBmaWxlOw0KPiA+ICgzKSBmb2xpb19jbGVhcl9kaXJ0eV9mb3JfaW8oKSBkZWNy
ZWFzZSBudW1iZXIgb2YgZGlydHkNCj4gPiBtZW1vcnkgcGFnZXMgYW5kIGluY3JlYXNlcyBudW1i
ZXIgb2YgdXBkYXRlZCBwYWdlczsNCj4gPiAoNCkgZm9saW9fYWNjb3VudF9kaXJ0aWVkKCkgYWxz
byBkZWNyZWFzZXMgZmlsZSdzDQo+ID4gInRlbXBlcmF0dXJlIiBpZiB1cGRhdGVzIGhhc24ndCBo
YXBwZW5lZCBzb21lIHRpbWU7DQo+ID4gKDUpIGZpbGUgc3lzdGVtIGNhbiBnZXQgZmlsZSdzIHRl
bXBlcmF0dXJlIGFuZA0KPiA+IHRvIHNoYXJlIHRoZSBoaW50IHdpdGggYmxvY2sgbGF5ZXI7ICg2
KSBpbm9kZQ0KPiA+IGV2aWN0aW9uIG1ldGhvZCByZW1vdmVzIGFuZCBmcmVlIHRoZSBkYXRhICJ0
ZW1wZXJhdHVyZSINCj4gPiBvYmplY3QuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVmlhY2hl
c2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvLmNvbT4NCj4gPiAtLS0NCj4gPiAgZnMvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiA+ICBmcy9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGZzL2RhdGEtdGVtcGVyYXR1
cmUvS2NvbmZpZyAgICAgICAgICAgIHwgIDExICsNCj4gPiAgZnMvZGF0YS10ZW1wZXJhdHVyZS9N
YWtlZmlsZSAgICAgICAgICAgfCAgIDMgKw0KPiA+ICBmcy9kYXRhLXRlbXBlcmF0dXJlL2RhdGFf
dGVtcGVyYXR1cmUuYyB8IDM0NyArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1
ZGUvbGludXgvZGF0YV90ZW1wZXJhdHVyZS5oICAgICAgIHwgMTI0ICsrKysrKysrKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L2ZzLmggICAgICAgICAgICAgICAgICAgICB8ICAgNCArDQo+ID4gIG1tL3Bh
Z2Utd3JpdGViYWNrLmMgICAgICAgICAgICAgICAgICAgIHwgICA5ICsNCj4gPiAgOCBmaWxlcyBj
aGFuZ2VkLCA1MDEgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZnMvZGF0
YS10ZW1wZXJhdHVyZS9LY29uZmlnDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9kYXRhLXRl
bXBlcmF0dXJlL01ha2VmaWxlDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBmcy9kYXRhLXRlbXBl
cmF0dXJlL2RhdGFfdGVtcGVyYXR1cmUuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVk
ZS9saW51eC9kYXRhX3RlbXBlcmF0dXJlLmgNCj4gPiANCj4gDQo+IA0KPiBUaGlzIHNlZW1zIGxp
a2UgYW4gaW50ZXJlc3RpbmcgaWRlYSwgYnV0IGhvdyBkbyB5b3UgaW50ZW5kIHRvIHVzZSB0aGUN
Cj4gdGVtcGVyYXR1cmU/DQo+IA0KDQpZZXMsIGl0J3Mgbm90IGNvbXBsZXRlIGltcGxlbWVudGF0
aW9uLiBUaGUgY29tcGxldGUgaW1wbGVtZW50YXRpb24gcmVxdWlyZXMgb2YNCm1vZGlmaWNhdGlv
biBvZiBwYXJ0aWN1bGFyIGZpbGUgc3lzdGVtKHMpLiBBbmQgSSBhbSBzaW1wbHkgc2hhcmluZyB0
aGUgaW5pdGlhbA0KdmlzaW9uLg0KDQpQb3RlbnRpYWxseSwgZGlmZmVyZW50IGZpbGUgc3lzdGVt
IGNhbiB1c2UgdGhlIHRlbXBlcmF0dXJlIGluIGRpZmZlcmVudCB3YXkuIFRoZQ0Kc2ltcGxlc3Qg
YXBwcm9hY2ggaXMgdG8gcHJvdmlkZSB0aGUgdGVtcGVyYXR1cmUgYXMgYSBoaW50IGZvciBibG9j
ayBsYXllciBhbmQNCnRoaXMgaGludCB2YWx1ZSBjYW4gYmUgdXNlZCBieSBGRFAgU1NELCBmb3Ig
ZXhhbXBsZS4gQnV0IGZpbGUgc3lzdGVtIGl0c2VsZiBjYW4NCnVzZSB0ZW1wZXJhdHVyZSB2YWx1
ZSBmb3IgZWxhYm9yYXRpbmcgZGF0YSBwbGFjZW1lbnQgcG9saWN5LiBJZiBmaWxlIHN5c3RlbSB1
c2VzDQpzZWdtZW50IGNvbmNlcHQsIHRoZW4gZGlmZmVyZW50IHR5cGUgb2Ygc2VnbWVudHMgY2Fu
IHN0b3JlIGRhdGEgd2l0aCBkaWZmZXJlbnQNCnRlbXBlcmF0dXJlLiBVc3VhbGx5LCBpdCBpcyBl
YXN5IHRvIHN0b3JlIGRpZmZlcmVudCB0eXBlcyBvZiBtZXRhZGF0YSBpbg0KZGlmZmVyZW50IHNl
Z21lbnRzLiBIb3dldmVyLCBldmVuIGRpZmZlcmVudCB0eXBlcyBvZiBtZXRhZGF0YSBjb3VsZCBi
ZSBncm91cGVkDQpvbiB0ZW1wZXJhdHVyZSBiYXNpcy4gQnV0IHByb3BlciBwbGFjZW1lbnQgcG9s
aWN5IGZvciB1c2VyIGRhdGEgaXMgYWx3YXlzIGhhcmQNCnBvaW50IGZvciBmaWxlIHN5c3RlbS4g
U28sIHRlbXBlcmF0dXJlIGJhc2lzIHByb3ZpZGVzIHRoZSB3YXkgdG8gaW50cm9kdWNlIGEgc2V0
DQpvZiBzZWdtZW50cyB0aGF0IGNhbiByZWNlaXZlIHVzZXIgZGF0YSB3aXRoIGRpZmZlcmVudCB0
ZW1wZXJhdHVyZS4NCg0KQnV0IGV2ZW4gaWYgZmlsZSBzeXN0ZW0gZG9lc24ndCB1c2UgdGhlIHNl
Z21lbnQgY29uY2VwdCwgdGhlbiBtdWx0aXBsZSBmaWxlDQpzeXN0ZW1zIHVzZSB0aGUgQWxsb2Nh
dGlvbiBHcm91cHMgY29uY2VwdC4gQW5kLCBwb3RlbnRpYWxseSwgZmlsZXMgd2l0aA0KZGlmZmVy
ZW50IHRlbXBlcmF0dXJlcyBjYW4gYmUgc3RvcmVkIG9yIGdyb3VwZWQgaW50byBkaWZmZXJlbnQg
QWxsb2NhdGlvbg0KZ3JvdXBzLg0KDQpJIGJlbGlldmUsIHBvdGVudGlhbGx5LCBHQyBzdWJzeXN0
ZW0gb2YgTEZTIGZpbGUgc3lzdGVtcyBjYW4gdXNlIHRoZSB0ZW1wZXJhdHVyZQ0KdG8gZWxhYm9y
YXRlIG1vcmUgZWZmaWNpZW50IHBvbGljeS4gQmVjYXVzZSBpdCBpcyBjbGVhciB0aGF0IGZpbGVz
JyBjb250ZW50IHdpdGgNCmhpZ2ggdGVtcGVyYXR1cmUgZG9uJ3QgbmVlZCB0byBiZSBwcm9jZXNz
ZWQgYnkgR0MuIEkgZG9uJ3QgaGF2ZSBpbiBtaW5kIHRoZQ0KY2xlYXIgYWxnb3JpdGhtIG9mIHRo
aXMgcG9saWN5LCBidXQgaG90IHNlZ21lbnRzIGNhbiBiZSBjbGVhbmVkIHdpdGhvdXQgR0MNCmlu
dGVydmVudGlvbiwgZm9yIGV4YW1wbGUuDQoNCkFsc28sIGludGVyZXN0aW5nIHBvaW50IHRoYXQg
dGhpcyBhcHByb2FjaCBpcyB0cnlpbmcgdG8gZGVjcmVhc2UgdGVtcGVyYXR1cmUgaWYNCm51bWJl
ciBvZiB1cGRhdGVzIGlzIGRlY3JlYXNpbmcuIEl0IG1lYW5zIHRoYXQgQ09XIHBvbGljeSBjYW4g
c3RvcmUgZmlsZSdzDQpjb250ZW50IGluIHNlZ21lbnRzIHdpdGggZGlmZmVyZW50IHRlbXBlcmF0
dXJlIGZvciBldmVyeSB1cGRhdGUgb2YgZm9sbG93aW5nIHRvDQp0ZW1wZXJhdHVyZSBjaGFuZ2lu
ZyB3aXRoIHRpbWUuIEhvd2V2ZXIsIGRpZmZlcmVudCBwb3J0aW9uIG9mIGJpZyBmaWxlIGNhbiBi
ZQ0KZGlzdHJpYnV0ZWQgYW1vbmcgbXVsdGlwbGUgc2VnbWVudHMuIEJ1dCwgYmlnIGZpbGUgaXMg
YWx3YXlzIGRpc3RyaWJ1dGVkIGFtb25nDQptdWx0aXBsZSBzZWdtZW50cy4gDQoNCj4gV2l0aCB0
aGlzIHBhdGNoLCBpdCBsb29rcyBsaWtlIHlvdSdyZSBqdXN0IGNhbGN1bGF0aW5nIGl0LCBidXQg
dGhlcmUgaXMNCj4gbm90aGluZyB0aGF0IHVzZXMgaXQgYW5kIHRoZXJlIGlzIG5vIHdheSB0byBh
Y2Nlc3MgdGhlIHRlbXBlcmF0dXJlIGZyb20NCj4gdXNlcmxhbmQuIEl0IHdvdWxkIGJlIG5pY2Ug
dG8gc2VlIHRoaXMgdmFsdWUgdXNlZCBieSBhbiBleGlzdGluZw0KPiBzdWJzeXN0ZW0gdG8gZHJp
dmUgZGF0YSBwbGFjZW1lbnQgc28gd2UgY2FuIHNlZSBob3cgaXQgd2lsbCBoZWxwDQo+IHRoaW5n
cy4NCj4gDQo+ID4gDQoNCkkgZGlkIGJlbmNobWFya2luZyBieSB1c2luZyBTU0RGUyBmaWxlIHN5
c3RlbSAoYnV0IGFueSBvdGhlciBmaWxlIHN5c3RlbSBjYW4gIGJlDQp1c2VkIGZvciBiZW5jaG1h
cmtpbmcgdG9vKS4gQW5kIEkgYW0gZ29pbmcgdG8gaW50cm9kdWNlIHNldmVyYWwgY3VycmVudCBz
ZWdtZW50cw0KZm9yIHVzZXIgZGF0YSB3aXRoIHRoZSBnb2FsIHRvIGRpc3RyaWJ1dGUgdXNlciBk
YXRhIHdpdGggdmFyaW91cyB0ZW1wZXJhdHVyZS4NCkFsc28sIGFzIEkgbWVudGlvbmVkLCB0aGVz
ZSBjdXJyZW50IHNlZ21lbnRzIGNhbiBiZSBzdG9yZWQgYnkgcHJvdmlkaW5nIGhpbnRzIHRvDQpG
RFAgU1NEIHRocm91Z2ggYmxvY2sgbGF5ZXIgbG9naWMuIEFuZCBJIHNoYXJlZCBhYm92ZSBwb3Rl
bnRpYWwgd2F5cyBob3cgdmFyaW91cw0KZmlsZSBzeXN0ZW1zIGNhbiBlbXBsb3kgdGhlIGNhbGN1
bGF0ZWQgdGVtcGVyYXR1cmUuDQoNClJlbGF0ZWQgdG8gdXNlcmxhbmQuLi4gSSBkaWRuJ3QgY29u
c2lkZXIgdG8gc2hhcmUgdGhlIHRlbXBlcmF0dXJlIHdpdGggdXNlci0NCnNwYWNlIHN1YnN5c3Rl
bXMuIEJ1dCBpdCBpcyB0aGUgZ3JlYXQgcG9pbnQuIFBvdGVudGlhbGx5LCBpdCBpcyBlYXN5IHRv
DQppbnRyb2R1Y2UgYW4gaW9jdGwgdGhhdCBjYW4gcmV0cmlldmUgdGhlIHRlbXBlcmF0dXJlIG9m
IGEgcGFydGljdWxhciBmaWxlLiBPcg0KbWF5YmUgc3lzZnMgY2FuIGJlIHVzZWQgdG8gZXhwb3Nl
IHRoZSBkaXN0cmlidXRpb24gb2YgZGF0YSBhbW9uZyB0ZW1wZXJhdHVyZQ0KZ3JvdXBzL3Jhbmdl
cy4gQW5kIGFwcGxpY2F0aW9uIGNhbiB1c2UgdGhpcyBkYXRhIHRvIGVsYWJvcmF0ZSBkYXRhIHBs
YWNlbWVudA0KcG9saWN5LiBMZXQgbWUgdGhpbmsgYWJvdXQgaXQgbW9yZS4NCg0KVGhhbmtzLA0K
U2xhdmEuDQoNCg==

