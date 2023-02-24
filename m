Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E85B6A1EFD
	for <lists+linux-block@lfdr.de>; Fri, 24 Feb 2023 16:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBXPyC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Feb 2023 10:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjBXPyB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2023 10:54:01 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E195A7A9A;
        Fri, 24 Feb 2023 07:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677254038; x=1708790038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yMJlx+a8dj+1R6kPnER00YD2gvoX+QGI/EI5WJHYVfg=;
  b=M6Mb1D39KqNk96K6Um6FcsI3FD9y9uZ19WcYkmG832AbLPlUMJyI66Q7
   lAHc0+dcGCD3tWPLWsTnUzpRcQwrkeQTACa2Z8hdrzK4yC/nTV6e1Vy/C
   KrqgUzdlKpPGKmDxkLfpO1bXO87ttOVdDLx0IGohJ2/aOek6PGFvty6gJ
   bVDS1R8sYS7j/Q2vXEuoe2sp5Ua2puAkahnMdtyaNtB2mZPw4zl+xVeJd
   s4kGk7CldrrZ+GWV+HHqIqr5MbLZFfd3vm9ugy/iIHWQzOPPH4IdqSqev
   sv+WPjTvnhGQPUNtn2luqMj33HauGzqI+wlISRReDZzSWhuuyqNSTnhqf
   A==;
X-IronPort-AV: E=Sophos;i="5.97,325,1669046400"; 
   d="scan'208";a="222436984"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2023 23:53:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KM03TBy9Nh6+AObgEnEZ1Ll3rKup/VL6IcS1x3WPdqbk3XcD3USzVFNkIAX1F3P1jxWHdlKt9pGFhwvjk3hqbsKWP0kf/qxJd+c/qt60/Qjd/BclXgUP4KFrXzKx794cLPxi5zGKgmaFnwIv3iWABt4PcUkAjqFc1ESTbprgKB6y639MJfHFFDkJPHPZhqH4fzEafc1FU7tTfkYqRSsFUH8Zw3FYQ4xE+8indiKFlmDlo/z0EC5x4sv1ErEjOL0L8snMCigNWqiezb+VSFC7Uphdh070AwDcLjZZ35CqZle4CdH9B8lsDJCeWdt7IOy9O4j4iCUkOApIgjm7T8AJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMJlx+a8dj+1R6kPnER00YD2gvoX+QGI/EI5WJHYVfg=;
 b=HviUu6I2chhp9t7+g5w+UTVkVkTlE6TksNem0YixSE4MEOO8XQICS3dG8H69w8Hk/C8jhmgq1fQ8/mvs7OYCyQAS92RaW38tOEG065CIcTMvivcChyisOJqjLynawX6cZHmFe1A1HZTdM/PvBVvR+/CYV33jy0w3cE6FwwDLfUblwmQ4ZuGt4nlGeGZVsmG1fZWGdXo4o9bWLa7icbjTzESBhybfXBgZF/EaCjnAOh1KT8h1kZs1C79OGkX2pn1QoKb0YgwKqG8GPU5GMRxmff+dW+CDonZMTHK81aZEg9sPgGxgPT49HffYYbI2bF+7VKDRn8lNj4LW96bwZ/cAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMJlx+a8dj+1R6kPnER00YD2gvoX+QGI/EI5WJHYVfg=;
 b=Bu/9tX2oH9yNrY2V1yE7Pxa7x9v2sda0EkUQ8TzLhtH/r84HVGq/xHgGuRUYQiOob+eZuts9qHh1D6GeRyHRVIo0v0oc88N+mvgZAiEq2P799+/qeoVyMfGBGitcUJWa6ISEihB0TYKtM9qUNjOdSp0dXCMC8fFnT65gkVCFBtY=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by MWHPR04MB1135.namprd04.prod.outlook.com (2603:10b6:300:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Fri, 24 Feb
 2023 15:53:54 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::4fcf:ae46:b9c4:127a%7]) with mapi id 15.20.6134.024; Fri, 24 Feb 2023
 15:53:54 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: ublk: enable zoned storage support
Thread-Topic: [PATCH] block: ublk: enable zoned storage support
Thread-Index: AQHZSGgyrRYNUqNJ0E+BNxJDaEh1Mw==
Date:   Fri, 24 Feb 2023 15:53:54 +0000
Message-ID: <Y/jdkCR4ug7iZZ+L@x1-carbon>
References: <20230224125950.214779-1-nmi@metaspace.dk>
In-Reply-To: <20230224125950.214779-1-nmi@metaspace.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|MWHPR04MB1135:EE_
x-ms-office365-filtering-correlation-id: 28a8717f-5b6f-435f-f67c-08db167f54e6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TECfB0KVQvxyu5PpMZEwR4E0ESROLfFwR5E3q4y9WJLwW4SxjsiUSCdDUz4XtLUBK3EtxpSgRbe3ThF0XXk5M6Ev1YovPBpUh+Ubjys27uvS+hJiEN3GKcFK3qSUHnj4h7MrXkMzLkDxyU6KBehrdhL86nbzmgD0/2lfEKo8gOgTJlbTqVYVMBq92/QZaOVQgv9LGw+lnY1glkA5CPeDYQ35O5/vZ3F1+9omBg/AOxWBjbYO8TnSSqcLoaoxkSdwNEQk9AiDQMFd+QY8dT/Jda5ZnPo2ldXQV2HJ6EhX5xjdorrZdenOIEyeFl7sflOnkR/8UOTc83yvKAqWmI5xYTWswr39XGB14QuEXiHe75SEEkJFrhoS5zKK92Of9ZS/yMM8TB2bWcDERSqqm5hApL/tSyshfOfZTmEr8CSS4RnB0coBNNwaon7UTU3ydDaBwk/QdLukb6zGWo6G+ONAh59obPe9w4PL3ZPwoVMKcUlc+yyfReh1GAAQEWDCLNwrtC/wGcF2B93Xukg3px54TUOUYUR3Nt78bGHF5AMy4VevKNy0c0aw5UeYFj1cHCnE+Uq9+ytRa0emAKNFA14P989dDfvakXs67iQtISUGrsiRyeWG+bTYm4JdLW8CBUcu/y8+ZEr9vbzMw3cw9YWtnqcCcUOykPutAHZSTyEvvo6tFRRPTDKsS8ta/MzUvTixKXe0TUmJZV1z8oTjG0OZSaf0rgTeyXWRkrNyZDq0wlw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199018)(33716001)(316002)(54906003)(83380400001)(71200400001)(8676002)(41300700001)(26005)(76116006)(186003)(82960400001)(966005)(6512007)(6506007)(9686003)(86362001)(38070700005)(2906002)(5660300002)(478600001)(4326008)(30864003)(8936002)(6486002)(66946007)(66446008)(66476007)(38100700002)(91956017)(122000001)(66556008)(64756008)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFA2KzhVOGFTbmpTTDF4S1FUMlJSYnhkNTBsY01BYXdGRTNHemdsRzkrakcy?=
 =?utf-8?B?MktnVk5TRDlJSVR0VjVTd0l2WDExL212dWFTUHZrNGZiYTZJRWJTNzNWYVY1?=
 =?utf-8?B?RDdXOHpJd3VaaFVlbi81NFRrNDVDWGV3RVhwajdCNTNFbWp0NVBRTXhnTm5y?=
 =?utf-8?B?STVTbVhVbmVoNHZ5a3ltOGcyNWxEU3JoT0ZRZ1FNSWYxZmlHT29VUWVoNy93?=
 =?utf-8?B?enpRTll5dDR0MzQ4Zmk4Vm4yb0V0aDB0WDVzYXRYby9SbGNydGNWL3hRZjl4?=
 =?utf-8?B?dFJGVTVxekkrTTg2dWlhQ0x3SFlRZUxnNnA4UUxFNnNWdnFjTC9xZG1UdVRs?=
 =?utf-8?B?ZWtpdFdNQXpUSXNXbUxhZnAyTjZLNk1tR25FT2Y0R1ZPK250SE1rR29Fb2I3?=
 =?utf-8?B?cEJrMWd3Sm9NdEdMeWpHQ3BzM2JWeSs1RU1RRFV4RjcyTHkyc0o5V2tyVnRl?=
 =?utf-8?B?bkxMU1dRcmp3Z08waTBUUllTQzRpNEFtLzZaNjU2NGJ1M0ZHU3UrWWJqRlNP?=
 =?utf-8?B?RHprNjltaXhRUFMyWVhBWnV2N3YvRnVsZFlHM2xZMFhyeXY0S2NrNzJ4Mis0?=
 =?utf-8?B?MHJDalppUkZadkgrWFJvREJsM29XU2J4VFI4NldLQlQyQ29zZjQ2YTdhSGU4?=
 =?utf-8?B?cDR5Rm8wVStwTXo5MHNYcjF0QUVGOU1xWHIyRWpIVGVFeC9SY2s1eTdMaXdW?=
 =?utf-8?B?RnFlQjFHK3JIeXd6cVl0TWt6R25PVGpmRWs2aVJXRGVrcjVid3pvK05nakY3?=
 =?utf-8?B?NUVMWjJWdjUxS0c4R3pFRFVtYXBSU2djK0ltRUNCaDNVa3AzY25IV2VRaFY4?=
 =?utf-8?B?bzJDVUw4WlpLc3JvTE9ZTnZFNEhQQ24vaUs5dFluajgrdzBJNjBhdlk1Kzln?=
 =?utf-8?B?QUN2RlB6UDRnWE1SREs3RzJYZDRPS1pUSU9rZnZJOFdvVVR0NTcyQ3cyTS9L?=
 =?utf-8?B?eitpWm5GUHM3Si9BQXNRMFNGZFNlWWdhUGZOZUpEaXR4Q1pqWTgxdjNYOFg3?=
 =?utf-8?B?ZTdNRWpVTTFlYWQ2MkhnQm1iUkYyVTJUUC90dmRLbDYyL1FMa3ZvVFNBV090?=
 =?utf-8?B?cVM2L2dMT0lBQlh6bTZDcU1OQXpIQlArdGJNRVhJR2FhMXYzV1p2T2ZkQTVJ?=
 =?utf-8?B?dTNKekNJQzBqVXl1L3NhK0x4Z3VIZm5FdDdSMWJrU3JaMXJZL0tpRk1Eb2Nw?=
 =?utf-8?B?NWJCUjhLd05VWFhZOFFTcmZVMXFmTmoyM0F5Zjl6dVV6MlZ6UWw5YU45NnBz?=
 =?utf-8?B?eng0SFZJblRmbzBUR2RqbEV3WnNiWjFGZmp1aGE1dEtWeVc4ZUFQcS9JMk94?=
 =?utf-8?B?NytTYVZPQUlISkV2dDMvbFNEZFNGWElKSUpkb2h3bUNWTnhHK09hald5dGZI?=
 =?utf-8?B?RktOaVRVMEVKcmdXeGdpS2FDUkppWXVsOXJCbmlGcWJGeUlyTStUMVQ0dUpm?=
 =?utf-8?B?MVIwQUZrMDFTWFFmRDVkN2VtaVU1ektvQUsxMnhXMURQM21jSis4S3UrRUVl?=
 =?utf-8?B?ZGxwTCtQbXNQcnVFcmFLQUUzYW81VG5qSCtNdm1aN0xERTF1bkdnN0xEbWRj?=
 =?utf-8?B?QWtSdFI3VWZId0dnZUJJZzFQMzVSZklZa0tJWEFYaVJ6NTBONjBCb2lWQ1Zx?=
 =?utf-8?B?VG9XcTNUTjlVV3RZVXo1WjlaSmRGaExDVldMMHFIQ29xdW4rTTdpb0I4SHNl?=
 =?utf-8?B?R2FvMlJXZXdGNWZaTmJTNHp1ZE9pSmhvS2V5bEczMzd2LzRmTk5EblhsUGdI?=
 =?utf-8?B?T2h3dUZFRGJMY3dwSk5JN0VqeXIyS3I2TnV3cVZleGFxYTRVWmlEVDBNeTJR?=
 =?utf-8?B?QWcxWEp2TWdMTC8xNjdjdGRQUXRleUpnT0E4bDJXY1hVczF2dVRRMDBFZ3NQ?=
 =?utf-8?B?NGFwMzVpM1ZoY0Z1a214dUlaenZjMkplb2M5ZkNwRHdIazBFdWhjQ0hhdnpR?=
 =?utf-8?B?TFZ4ZHV3djVnVWNBVlpkTUpZcWdHdHVFZElmeFk3U3JHTk9rb0NEL200b2NI?=
 =?utf-8?B?ZWk5ZG9lSS9TNmFHVDRnNWp1MkJSLy9haU92ZzJYQVhhQVJEMGp0MEZQTDNO?=
 =?utf-8?B?SUdybU5IYkpxTEpmV0ZUdk9oUnk5UWx3YmxwVGVEQlJvV2hBVTVvQ0x6dnBJ?=
 =?utf-8?B?NUIyVW52Z3FJWDQ4V0poM0ZJVk95dFlVaXFvYWVSdTRqTTRGeVBCZlRZMnRM?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDC783DFE191544DB592EC777FD279B6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YI6B+UCz/dkf+/R1N94BouWhLEKEr+Kwz+yk0qxB7pGU4S+P8pcvUaVkEejbus9HSXKi5UYp91614zz8HboXj+uVfS3i3Qjos5dsf94LdNnHdbwWTEBxMUTj6WHmvXDxJLk3m5sZS4tSWnx0RJ0kpeTkyoeJpDwHeeiLB6pTy6XesZU0ZSioKs1RK6VzmbH9dCet5XNrcIe1MDYjBVfZIhRNXCx3ziUi9QIViERqFpTQ9naxWNBSfp+JEAjbcVaWNAXb8PI3vWGAO3fFuso5khhM9cFRKOVVCByEEV1O05lISuyMpQdHE++VYBOejT8yCBd8rGgmoLGzq8rD/GLLFtnZTEYMwvbtuVkjgWc2irOztCGx6UdFOlzrEVTWw3nMAjNk0XIv7GQZ+aU0evnVZlLfTix5zgzDuqbZ8fHdpdfl504ziMeJbokFvNeEiWdvnL4D0WD3GyxH0MNR9iokTk7LS4i8Mtia279K7xZcHzsqu9jPd4Rlf9alhIJCRD7Fdxv4cHLVQJXqTUGB1cXWHi9VJfIGcRIBvtaJej3Q5qMcBUTf3LgMVtgGcqjOZNTrNG2dk6kCIwR+ZVEW2E9ecsvPZbFXY+wheBDeSz4oT3Vt3IBRmYxIwyAcDpV6ijE8Mffw4mLjxHvg60EqC7YsFbqjlxRE3Rl2aKKZhlfcyZ8GYq+sZen1T/tqdqtPCQwRSJw+5tqb/mP7kLFHjkU6Tst/DSRfmtcOAJoUoIvRUeNcBLO3ctXkiX3O5DOxRRZ8XKw2xoM+VCD5H33aaVTy7rVfYVBOvdIBTiDKaPKy/3+h/ElwJ+6K51Mln2D+tphWxWdm1fKgFG++rj6z0Mh77K9DgircJEcH3Eoudww5e+WITRiuz2MZoX1VlNh6aPHXLaDT5OC4eZh1WrPS+yKNxg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a8717f-5b6f-435f-f67c-08db167f54e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 15:53:54.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cx+iuHQoxBJUXqu/tMJYxDrr+dgVKsdeGWezyJxW7ZZQhf3/PwdqSujsA/J8WqUa0ibEbyhBYf1eRYyv9N4hSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1135
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

SGVsbG8gQW5kcmVhcywNCg0KT24gRnJpLCBGZWIgMjQsIDIwMjMgYXQgMDE6NTk6NTBQTSArMDEw
MCwgQW5kcmVhcyBIaW5kYm9yZyB3cm90ZToNCj4gQWRkIHpvbmVkIHN0b3JhZ2Ugc3VwcG9ydCB0
byB1YmxrOiByZXBvcnRfem9uZXMgYW5kIG9wZXJhdGlvbnM6DQo+ICAtIFJFUV9PUF9aT05FX09Q
RU4NCj4gIC0gUkVRX09QX1pPTkVfQ0xPU0UNCj4gIC0gUkVRX09QX1pPTkVfRklOSVNIDQo+ICAt
IFJFUV9PUF9aT05FX1JFU0VUDQo+IA0KPiBUaGlzIGFsbG93cyBpbXBsZW1lbnRhdGlvbiBvZiB6
b25lZCBzdG9yYWdlIGRldmljZXMgaW4gdXNlciBzcGFjZS4gQW4NCj4gZXhhbXBsZSB1c2VyIHNw
YWNlIGltcGxlbWVudGF0aW9uIGJhc2VkIG9uIHViZHNydiBpcyBhdmFpbGFibGUgWzFdLg0KPiAN
Cj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9tZXRhc3BhY2UvdWJkc3J2L2NvbW1pdC8xNGEyYjcw
OGY3NGY3MGNmZWNiMDc2ZDkyZTY4MGRjNzE4Y2MxZjZkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZWFzIEhpbmRib3JnIDxhLmhpbmRib3JnQHNhbXN1bmcuY29tPg0KPiAtLS0NCg0KRGlkIHlv
dSB0cnkgdG8gYnVpbGQgdGhpcyBwYXRjaCB3aXRoIENPTkZJR19CTEtfREVWX1pPTkVEIGRpc2Fi
bGVkPw0KDQpJIGdvdCB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9ycyB3aGVuIGJ1aWxkaW5nIGl0
IG9uIHRvcCBvZiB2YW5pbGxhIHY2LjINCndoZW4gQ09ORklHX0JMS19ERVZfWk9ORUQgaXMgZGlz
YWJsZWQ6DQoNCmRyaXZlcnMvYmxvY2svdWJsa19kcnYuYzogSW4gZnVuY3Rpb24g4oCYdWJsa19k
ZXZfcGFyYW1fYmFzaWNfYXBwbHnigJk6DQpkcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmM6MjIxOjI4
OiBlcnJvcjog4oCYc3RydWN0IGdlbmRpc2vigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhucl96
b25lc+KAmQ0KICAyMjEgfCAgICAgICAgICAgICAgICAgdWItPnViX2Rpc2stPm5yX3pvbmVzID0g
cC0+ZGV2X3NlY3RvcnMgLyBwLT5jaHVua19zZWN0b3JzOw0KICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBefg0KZHJpdmVycy9ibG9jay91YmxrX2Rydi5jOiBJbiBmdW5jdGlvbiDi
gJh1YmxrX2Rldl9wYXJhbV96b25lZF9hcHBseeKAmToNCmRyaXZlcnMvYmxvY2svdWJsa19kcnYu
YzoyNDQ6MTc6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhkaXNr
X3NldF9tYXhfYWN0aXZlX3pvbmVz4oCZOyBkaWQgeW91IG1lYW4g4oCYYmRldl9tYXhfYWN0aXZl
X3pvbmVz4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAgMjQ0
IHwgICAgICAgICAgICAgICAgIGRpc2tfc2V0X21heF9hY3RpdmVfem9uZXModWItPnViX2Rpc2ss
IHAtPm1heF9hY3RpdmVfem9uZXMpOw0KICAgICAgfCAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KICAgICAgfCAgICAgICAgICAgICAgICAgYmRldl9tYXhfYWN0aXZl
X3pvbmVzDQpkcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmM6MjQ1OjE3OiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYZGlza19zZXRfbWF4X29wZW5fem9uZXPigJk7IGRp
ZCB5b3UgbWVhbiDigJhiZGV2X21heF9vcGVuX3pvbmVz4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1m
dW5jdGlvbi1kZWNsYXJhdGlvbl0NCiAgMjQ1IHwgICAgICAgICAgICAgICAgIGRpc2tfc2V0X21h
eF9vcGVuX3pvbmVzKHViLT51Yl9kaXNrLCBwLT5tYXhfb3Blbl96b25lcyk7DQoNCg0KPiAgZHJp
dmVycy9ibG9jay91YmxrX2Rydi5jICAgICAgfCAxNDUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLQ0KPiAgaW5jbHVkZS91YXBpL2xpbnV4L3VibGtfY21kLmggfCAgMTggKysrKysN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMTU3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay91YmxrX2Rydi5jIGIvZHJpdmVycy9ibG9j
ay91YmxrX2Rydi5jDQo+IGluZGV4IDYzNjhiNTZlYWNmMS4uOTc0MWI0YjE2NDdiIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3VibGtfZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ibG9jay91
YmxrX2Rydi5jDQo+IEBAIC0yMCw2ICsyMCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvbWFqb3Iu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC93YWl0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvYmxrZGV2
Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvYmxrem9uZWQuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9p
bml0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc3dhcC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCj4gQEAgLTUxLDEwICs1MiwxMiBAQA0KPiAgCQl8IFVCTEtfRl9VUklOR19DTURfQ09N
UF9JTl9UQVNLIFwNCj4gIAkJfCBVQkxLX0ZfTkVFRF9HRVRfREFUQSBcDQo+ICAJCXwgVUJMS19G
X1VTRVJfUkVDT1ZFUlkgXA0KPiAtCQl8IFVCTEtfRl9VU0VSX1JFQ09WRVJZX1JFSVNTVUUpDQo+
ICsJCXwgVUJMS19GX1VTRVJfUkVDT1ZFUllfUkVJU1NVRSBcDQo+ICsJCXwgVUJMS19GX1pPTkVE
KQ0KPiAgDQo+ICAvKiBBbGwgVUJMS19QQVJBTV9UWVBFXyogc2hvdWxkIGJlIGluY2x1ZGVkIGhl
cmUgKi8NCj4gLSNkZWZpbmUgVUJMS19QQVJBTV9UWVBFX0FMTCAoVUJMS19QQVJBTV9UWVBFX0JB
U0lDIHwgVUJMS19QQVJBTV9UWVBFX0RJU0NBUkQpDQo+ICsjZGVmaW5lIFVCTEtfUEFSQU1fVFlQ
RV9BTEwgKFVCTEtfUEFSQU1fVFlQRV9CQVNJQyB8IFVCTEtfUEFSQU1fVFlQRV9ESVNDQVJEIFwN
Cj4gKwkJCSAgICAgfCBVQkxLX1BBUkFNX1RZUEVfWk9ORUQpDQo+ICANCj4gIHN0cnVjdCB1Ymxr
X3JxX2RhdGEgew0KPiAgCXN0cnVjdCBsbGlzdF9ub2RlIG5vZGU7DQo+IEBAIC0yMTIsNiArMjE1
LDExIEBAIHN0YXRpYyB2b2lkIHVibGtfZGV2X3BhcmFtX2Jhc2ljX2FwcGx5KHN0cnVjdCB1Ymxr
X2RldmljZSAqdWIpDQo+ICAJCXNldF9kaXNrX3JvKHViLT51Yl9kaXNrLCB0cnVlKTsNCj4gIA0K
PiAgCXNldF9jYXBhY2l0eSh1Yi0+dWJfZGlzaywgcC0+ZGV2X3NlY3RvcnMpOw0KPiArDQo+ICsJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX0JMS19ERVZfWk9ORUQpICYmDQo+ICsJICAgIHViLT5kZXZf
aW5mby5mbGFncyAmIFVCTEtfRl9aT05FRCAmJiBwLT5jaHVua19zZWN0b3JzKSB7DQo+ICsJCXVi
LT51Yl9kaXNrLT5ucl96b25lcyA9IHAtPmRldl9zZWN0b3JzIC8gcC0+Y2h1bmtfc2VjdG9yczsN
Cj4gKwl9DQoNCktlcm5lbCBjb2Rpbmcgc3R5bGUgc2F5cyB0byBub3QgdW5uZWNlc3NhcmlseSB1
c2UgYnJhY2VzIHdoZXJlIGEgc2luZ2xlDQpzdGF0ZW1lbnQgd2lsbCBkbzoNCmh0dHBzOi8vd3d3
Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjcGxh
Y2luZy1icmFjZXMtYW5kLXNwYWNlcw0KDQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIHVibGtf
ZGV2X3BhcmFtX2Rpc2NhcmRfYXBwbHkoc3RydWN0IHVibGtfZGV2aWNlICp1YikNCj4gQEAgLTIy
Nyw2ICsyMzUsMTkgQEAgc3RhdGljIHZvaWQgdWJsa19kZXZfcGFyYW1fZGlzY2FyZF9hcHBseShz
dHJ1Y3QgdWJsa19kZXZpY2UgKnViKQ0KPiAgCWJsa19xdWV1ZV9tYXhfZGlzY2FyZF9zZWdtZW50
cyhxLCBwLT5tYXhfZGlzY2FyZF9zZWdtZW50cyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB2b2lk
IHVibGtfZGV2X3BhcmFtX3pvbmVkX2FwcGx5KHN0cnVjdCB1YmxrX2RldmljZSAqdWIpDQo+ICt7
DQo+ICsJY29uc3Qgc3RydWN0IHVibGtfcGFyYW1fem9uZWQgKnAgPSAmdWItPnBhcmFtcy56b25l
ZDsNCj4gKw0KPiArCWlmIChJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pPTkVEKSAmJg0KPiAr
CSAgICB1Yi0+ZGV2X2luZm8uZmxhZ3MgJiBVQkxLX0ZfWk9ORUQpIHsNCj4gKwkJZGlza19zZXRf
bWF4X2FjdGl2ZV96b25lcyh1Yi0+dWJfZGlzaywgcC0+bWF4X2FjdGl2ZV96b25lcyk7DQo+ICsJ
CWRpc2tfc2V0X21heF9vcGVuX3pvbmVzKHViLT51Yl9kaXNrLCBwLT5tYXhfb3Blbl96b25lcyk7
DQo+ICsJCS8qIFdlIGRvIG5vdCBzdXBwb3J0IHpvbmUgYXBwZW5kIHlldCAqLw0KPiArCQkvL2Js
a19xdWV1ZV9tYXhfem9uZV9hcHBlbmRfc2VjdG9ycyhxLCB6b25lX3NpemUpOw0KDQpSZW1vdmUg
Y29tbWVudGVkIG91dCBjb2RlLg0KSXQgY2FuIGJlIGFkZGVkIG9uY2UgdGhhdCBmZWF0dXJlIGlz
IGFkZGVkLg0KDQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHVibGtfdmFsaWRhdGVf
cGFyYW1zKGNvbnN0IHN0cnVjdCB1YmxrX2RldmljZSAqdWIpDQo+ICB7DQo+ICAJLyogYmFzaWMg
cGFyYW0gaXMgdGhlIG9ubHkgb25lIHdoaWNoIG11c3QgYmUgc2V0ICovDQo+IEBAIC0yNjgsNiAr
Mjg5LDkgQEAgc3RhdGljIGludCB1YmxrX2FwcGx5X3BhcmFtcyhzdHJ1Y3QgdWJsa19kZXZpY2Ug
KnViKQ0KPiAgCWlmICh1Yi0+cGFyYW1zLnR5cGVzICYgVUJMS19QQVJBTV9UWVBFX0RJU0NBUkQp
DQo+ICAJCXVibGtfZGV2X3BhcmFtX2Rpc2NhcmRfYXBwbHkodWIpOw0KPiAgDQo+ICsJaWYgKHVi
LT5wYXJhbXMudHlwZXMgJiBVQkxLX1BBUkFNX1RZUEVfWk9ORUQpDQo+ICsJCXVibGtfZGV2X3Bh
cmFtX3pvbmVkX2FwcGx5KHViKTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IEBA
IC0zNjEsOSArMzg1LDE4IEBAIHN0YXRpYyB2b2lkIHVibGtfZnJlZV9kaXNrKHN0cnVjdCBnZW5k
aXNrICpkaXNrKQ0KPiAgCXB1dF9kZXZpY2UoJnViLT5jZGV2X2Rldik7DQo+ICB9DQo+ICANCj4g
KyNpZiBJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pPTkVEKQ0KDQpIZXJlIHlvdSB1c2UgIiNp
ZiBJU19FTkFCTEVEKENPTkZJR19CTEtfREVWX1pPTkVEKSINCnlldCBmdXJ0aGVyIGRvd24geW91
IHVzZQ0KIiNpZmRlZiBDT05GSUdfQkxLX0RFVl9aT05FRCIuDQoNCklTX0VOQUJMRUQoKSBpcyB1
c3VhbGx5IHVzZWQgd2hlbiB0ZXN0aW5nIGZvciBhIEtjb25maWcgd2l0aGluDQphIG5vcm1hbCBD
IGNvbmRpdGlvbmFsLCBlLmcuIGlmIChJU19FTkFCTEVEKCkpLCB3aGVyZSBwb3NzaWJsZSwNCmlu
IG9yZGVyIHRvIGF2b2lkIHVnbHkgQyBwcmVwcm9jZXNzb3IgY29uZGl0aW9uYWxzIGNvbXBsZXRl
bHkuDQoNCkhvd2V2ZXIsIGlmIHlvdSBoYXZlIHRvIHVzZSBDIHByZXByb2Nlc3NvciBjb25kaXRp
b25hbHMsIHRoZW4NCiNpZmRlZiBDT05GSUdfU09NRVRISU5HDQppcyB0aGUgbW9zdCBjb21tb24g
d2F5IHRvIGNvbmRpdGlvbmFsbHkgaW5jbHVkZSBzb21ldGhpbmcuDQoNCj4gK3N0YXRpYyBpbnQg
dWJsa19yZXBvcnRfem9uZXMoc3RydWN0IGdlbmRpc2sgKmRpc2ssIHNlY3Rvcl90IHNlY3RvciwN
Cj4gKwkJCSAgICAgdW5zaWduZWQgaW50IG5yX3pvbmVzLCByZXBvcnRfem9uZXNfY2IgY2IsDQo+
ICsJCQkgICAgIHZvaWQgKmRhdGEpOw0KPiArI2VuZGlmDQo+ICsNCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgYmxvY2tfZGV2aWNlX29wZXJhdGlvbnMgdWJfZm9wcyA9IHsNCj4gLQkub3duZXIgPQlU
SElTX01PRFVMRSwNCj4gLQkuZnJlZV9kaXNrID0JdWJsa19mcmVlX2Rpc2ssDQo+ICsJLm93bmVy
ID0gVEhJU19NT0RVTEUsDQo+ICsJLmZyZWVfZGlzayA9IHVibGtfZnJlZV9kaXNrLA0KPiArI2lm
IElTX0VOQUJMRUQoQ09ORklHX0JMS19ERVZfWk9ORUQpDQo+ICsJLnJlcG9ydF96b25lcyA9IHVi
bGtfcmVwb3J0X3pvbmVzLA0KPiArI2VuZGlmDQo+ICB9Ow0KPiAgDQo+ICAjZGVmaW5lIFVCTEtf
TUFYX1BJTl9QQUdFUwkzMg0KPiBAQCAtNDk5LDcgKzUzMiw3IEBAIHN0YXRpYyBpbnQgdWJsa191
bm1hcF9pbyhjb25zdCBzdHJ1Y3QgdWJsa19xdWV1ZSAqdWJxLA0KPiAgew0KPiAgCWNvbnN0IHVu
c2lnbmVkIGludCBycV9ieXRlcyA9IGJsa19ycV9ieXRlcyhyZXEpOw0KPiAgDQo+IC0JaWYgKHJl
cV9vcChyZXEpID09IFJFUV9PUF9SRUFEICYmIHVibGtfcnFfaGFzX2RhdGEocmVxKSkgew0KPiAr
CWlmICgocmVxX29wKHJlcSkgPT0gUkVRX09QX1JFQUQgfHwgcmVxX29wKHJlcSkgPT0gUkVRX09Q
X0RSVl9JTikgJiYgdWJsa19ycV9oYXNfZGF0YShyZXEpKSB7DQo+ICAJCXN0cnVjdCB1YmxrX21h
cF9kYXRhIGRhdGEgPSB7DQo+ICAJCQkudWJxCT0JdWJxLA0KPiAgCQkJLnJxCT0JcmVxLA0KPiBA
QCAtNTY2LDYgKzU5OSwyNiBAQCBzdGF0aWMgYmxrX3N0YXR1c190IHVibGtfc2V0dXBfaW9kKHN0
cnVjdCB1YmxrX3F1ZXVlICp1YnEsIHN0cnVjdCByZXF1ZXN0ICpyZXEpDQo+ICAJY2FzZSBSRVFf
T1BfV1JJVEVfWkVST0VTOg0KPiAgCQl1YmxrX29wID0gVUJMS19JT19PUF9XUklURV9aRVJPRVM7
DQo+ICAJCWJyZWFrOw0KPiArI2lmZGVmIENPTkZJR19CTEtfREVWX1pPTkVEDQo+ICsJY2FzZSBS
RVFfT1BfWk9ORV9PUEVOOg0KPiArCQl1YmxrX29wID0gVUJMS19JT19PUF9aT05FX09QRU47DQo+
ICsJCWJyZWFrOw0KPiArCWNhc2UgUkVRX09QX1pPTkVfQ0xPU0U6DQo+ICsJCXVibGtfb3AgPSBV
QkxLX0lPX09QX1pPTkVfQ0xPU0U7DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgUkVRX09QX1pPTkVf
RklOSVNIOg0KPiArCQl1YmxrX29wID0gVUJMS19JT19PUF9aT05FX0ZJTklTSDsNCj4gKwkJYnJl
YWs7DQo+ICsJY2FzZSBSRVFfT1BfWk9ORV9SRVNFVDoNCj4gKwkJdWJsa19vcCA9IFVCTEtfSU9f
T1BfWk9ORV9SRVNFVDsNCj4gKwkJYnJlYWs7DQo+ICsJY2FzZSBSRVFfT1BfRFJWX0lOOg0KPiAr
CQl1YmxrX29wID0gVUJMS19JT19PUF9EUlZfSU47DQo+ICsJCWJyZWFrOw0KPiArCWNhc2UgUkVR
X09QX1pPTkVfQVBQRU5EOg0KPiArCQkvKiBXZSBkbyBub3Qgc3VwcG9ydCB6b25lIGFwcGVuZCB5
ZXQgKi8NCj4gKwkJZmFsbHRocm91Z2g7DQo+ICsjZW5kaWYNCj4gIAlkZWZhdWx0Og0KPiAgCQly
ZXR1cm4gQkxLX1NUU19JT0VSUjsNCj4gIAl9DQo+IEBAIC02MTIsNyArNjY1LDggQEAgc3RhdGlj
IHZvaWQgdWJsa19jb21wbGV0ZV9ycShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KPiAgCSAqDQo+ICAJ
ICogQm90aCB0aGUgdHdvIG5lZWRuJ3QgdW5tYXAuDQo+ICAJICovDQo+IC0JaWYgKHJlcV9vcChy
ZXEpICE9IFJFUV9PUF9SRUFEICYmIHJlcV9vcChyZXEpICE9IFJFUV9PUF9XUklURSkgew0KPiAr
CWlmIChyZXFfb3AocmVxKSAhPSBSRVFfT1BfUkVBRCAmJiByZXFfb3AocmVxKSAhPSBSRVFfT1Bf
V1JJVEUgJiYNCj4gKwkgICAgcmVxX29wKHJlcSkgIT0gUkVRX09QX0RSVl9JTikgew0KPiAgCQli
bGtfbXFfZW5kX3JlcXVlc3QocmVxLCBCTEtfU1RTX09LKTsNCj4gIAkJcmV0dXJuOw0KPiAgCX0N
Cj4gQEAgLTE0OTMsNiArMTU0Nyw3MyBAQCBzdGF0aWMgc3RydWN0IHVibGtfZGV2aWNlICp1Ymxr
X2dldF9kZXZpY2VfZnJvbV9pZChpbnQgaWR4KQ0KPiAgCXJldHVybiB1YjsNCj4gIH0NCj4gIA0K
PiArI2lmZGVmIENPTkZJR19CTEtfREVWX1pPTkVEDQo+ICtzdGF0aWMgaW50IHVibGtfcmVwb3J0
X3pvbmVzKHN0cnVjdCBnZW5kaXNrICpkaXNrLCBzZWN0b3JfdCBzZWN0b3IsDQo+ICsJCQkgICAg
IHVuc2lnbmVkIGludCBucl96b25lcywgcmVwb3J0X3pvbmVzX2NiIGNiLA0KPiArCQkJICAgICB2
b2lkICpkYXRhKQ0KPiArew0KPiArCXN0cnVjdCB1YmxrX2RldmljZSAqdWI7DQo+ICsJdW5zaWdu
ZWQgaW50IHpvbmVfc2l6ZTsNCj4gKwl1bnNpZ25lZCBpbnQgZmlyc3Rfem9uZTsNCj4gKwlpbnQg
cmV0ID0gMDsNCj4gKw0KPiArCXViID0gZGlzay0+cHJpdmF0ZV9kYXRhOw0KPiArDQo+ICsJaWYg
KCEodWItPmRldl9pbmZvLmZsYWdzICYgVUJMS19GX1pPTkVEKSkNCj4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ICsNCj4gKwl6b25lX3NpemUgPSBkaXNrLT5xdWV1ZS0+bGltaXRzLmNodW5rX3NlY3Rv
cnM7DQo+ICsJZmlyc3Rfem9uZSA9IHNlY3RvciA+PiBpbG9nMih6b25lX3NpemUpOw0KPiArDQo+
ICsJbnJfem9uZXMgPSBtaW4odWItPnViX2Rpc2stPm5yX3pvbmVzIC0gZmlyc3Rfem9uZSwgbnJf
em9uZXMpOw0KPiArDQo+ICsJZm9yICh1bnNpZ25lZCBpbnQgaSA9IDA7IGkgPCBucl96b25lczsg
aSsrKSB7DQo+ICsNCg0KTm8gbmVlZCBmb3IgZW1wdHkgbGluZSBoZXJlLg0KDQo+ICsJCXN0cnVj
dCByZXF1ZXN0ICpyZXE7DQo+ICsJCWJsa19zdGF0dXNfdCBzdGF0dXM7DQo+ICsJCXN0cnVjdCBi
bGtfem9uZSBpbmZvOw0KDQpTaW5jZSB0aGlzIGlzIGFsbG9jYXRlZCBvbiB0aGUgc3RhY2ssIGRv
ZXMgaXQgbmVlZCBtZW1zZXQoKT8NCg0KbnVsbF9ibGsgc2VlbXMgdG8gbWVtc2V0IGJsa196b25l
IGJlZm9yZSB0aGUgbG9vcCwgYnV0IG5vdCBpbnNpZGUgdGhlIGxvb3A6DQpodHRwczovL2dpdGh1
Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi92Ni4yL2RyaXZlcnMvYmxvY2svbnVsbF9ibGsvem9u
ZWQuYyNMMjA2DQoNClNvIEknbSBhIGJpdCBjb25mdXNlZC4uLg0KDQpJZiBlLmcuIGNiKCkgaXMg
YmxrZGV2X2NvcHlfem9uZV90b191c2VyKCkNCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9s
aW51eC9ibG9iL3Y2LjIvYmxvY2svYmxrLXpvbmVkLmMjTDMxOA0KDQpJdCB3aWxsIGNvcHkgd2hh
dGV2ZXIgdGhlIGtlcm5lbCBhbGxvY2F0ZWQuDQpTbyBJIGd1ZXNzIHRoYXQgc2luY2UgeW91IGNh
bid0IGd1YXJhbnRlZSB0aGF0IHRoZSB1YmxrIHVzZXIgc3BhY2UgZHJpdmVyDQp3aWxsIGZpbGwg
aW4gYWxsIGZpZWxkcyBpbiB0aGUgem9uZSB3aGVuIHJlY2VpdmluZyBhIFJFUV9PUF9EUlZfSU4s
DQpJIGFzc3VtZSB0aGF0IHlvdSBkbyBuZWVkIHRvIGRvIGEgbWVtc2V0KCkgaW4gb3JkZXIgdG8g
bm90IHBvdGVudGlhbGx5DQpsZWFrIGtlcm5lbCBzcGFjZSBkYXRhLg0KDQoNCj4gKw0KPiArCQly
ZXEgPSBibGtfbXFfYWxsb2NfcmVxdWVzdChkaXNrLT5xdWV1ZSwgUkVRX09QX0RSVl9JTiwgMCk7
DQo+ICsNCj4gKwkJaWYgKElTX0VSUihyZXEpKSB7DQo+ICsJCQlyZXQgPSBQVFJfRVJSKHJlcSk7
DQo+ICsJCQlnb3RvIG91dDsNCj4gKwkJfQ0KPiArDQo+ICsJCXJlcS0+X19zZWN0b3IgPSBzZWN0
b3I7DQo+ICsNCj4gKwkJcmV0ID0gYmxrX3JxX21hcF9rZXJuKGRpc2stPnF1ZXVlLCByZXEsICZp
bmZvLCBzaXplb2YoaW5mbyksDQo+ICsJCQkJICAgICAgR0ZQX0tFUk5FTCk7DQo+ICsNCj4gKwkJ
aWYgKHJldCkNCj4gKwkJCWdvdG8gb3V0Ow0KPiArDQo+ICsJCXN0YXR1cyA9IGJsa19leGVjdXRl
X3JxKHJlcSwgMCk7DQo+ICsJCXJldCA9IGJsa19zdGF0dXNfdG9fZXJybm8oc3RhdHVzKTsNCj4g
KwkJaWYgKHJldCkNCj4gKwkJCWdvdG8gb3V0Ow0KPiArDQo+ICsJCWJsa19tcV9mcmVlX3JlcXVl
c3QocmVxKTsNCj4gKw0KPiArCQlyZXQgPSBjYigmaW5mbywgaSwgZGF0YSk7DQo+ICsJCWlmIChy
ZXQpDQo+ICsJCQlnb3RvIG91dDsNCj4gKw0KPiArCQkvKiBBIHplcm8gbGVuZ3RoIHpvbmUgbWVh
bnMgZG9uJ3QgYXNrIGZvciBtb3JlIHpvbmVzICovDQo+ICsJCWlmICghaW5mby5sZW4pIHsNCj4g
KwkJCW5yX3pvbmVzID0gaTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsNCj4gKwkJc2VjdG9y
ICs9IHpvbmVfc2l6ZTsNCj4gKwl9DQo+ICsJcmV0ID0gbnJfem9uZXM7DQo+ICsNCj4gKyBvdXQ6
DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKyNlbmRpZg0KPiArDQo+ICBzdGF0aWMgaW50IHVi
bGtfY3RybF9zdGFydF9kZXYoc3RydWN0IGlvX3VyaW5nX2NtZCAqY21kKQ0KPiAgew0KPiAgCXN0
cnVjdCB1Ymxrc3J2X2N0cmxfY21kICpoZWFkZXIgPSAoc3RydWN0IHVibGtzcnZfY3RybF9jbWQg
KiljbWQtPmNtZDsNCj4gQEAgLTE1MzUsNiArMTY1NiwxNSBAQCBzdGF0aWMgaW50IHVibGtfY3Ry
bF9zdGFydF9kZXYoc3RydWN0IGlvX3VyaW5nX2NtZCAqY21kKQ0KPiAgCWlmIChyZXQpDQo+ICAJ
CWdvdG8gb3V0X3B1dF9kaXNrOw0KPiAgDQo+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX0JMS19E
RVZfWk9ORUQpICYmDQo+ICsJICAgIHViLT5kZXZfaW5mby5mbGFncyAmIFVCTEtfRl9aT05FRCkg
ew0KPiArCQlkaXNrX3NldF96b25lZChkaXNrLCBCTEtfWk9ORURfSE0pOw0KPiArCQlibGtfcXVl
dWVfcmVxdWlyZWRfZWxldmF0b3JfZmVhdHVyZXMoZGlzay0+cXVldWUsIEVMRVZBVE9SX0ZfWkJE
X1NFUV9XUklURSk7DQo+ICsJCXJldCA9IGJsa19yZXZhbGlkYXRlX2Rpc2tfem9uZXMoZGlzaywg
TlVMTCk7DQo+ICsJCWlmIChyZXQpDQo+ICsJCQlnb3RvIG91dF9wdXRfZGlzazsNCj4gKwl9DQo+
ICsNCj4gIAlnZXRfZGV2aWNlKCZ1Yi0+Y2Rldl9kZXYpOw0KPiAgCXJldCA9IGFkZF9kaXNrKGRp
c2spOw0KPiAgCWlmIChyZXQpIHsNCj4gQEAgLTE2NzMsNiArMTgwMyw5IEBAIHN0YXRpYyBpbnQg
dWJsa19jdHJsX2FkZF9kZXYoc3RydWN0IGlvX3VyaW5nX2NtZCAqY21kKQ0KPiAgCWlmICghSVNf
QlVJTFRJTihDT05GSUdfQkxLX0RFVl9VQkxLKSkNCj4gIAkJdWItPmRldl9pbmZvLmZsYWdzIHw9
IFVCTEtfRl9VUklOR19DTURfQ09NUF9JTl9UQVNLOw0KPiAgDQo+ICsJaWYgKCFJU19FTkFCTEVE
KENPTkZJR19CTEtfREVWX1pPTkVEKSkNCj4gKwkJdWItPmRldl9pbmZvLmZsYWdzICY9IH5VQkxL
X0ZfWk9ORUQ7DQo+ICsNCj4gIAkvKiBXZSBhcmUgbm90IHJlYWR5IHRvIHN1cHBvcnQgemVybyBj
b3B5ICovDQo+ICAJdWItPmRldl9pbmZvLmZsYWdzICY9IH5VQkxLX0ZfU1VQUE9SVF9aRVJPX0NP
UFk7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC91YmxrX2NtZC5oIGIv
aW5jbHVkZS91YXBpL2xpbnV4L3VibGtfY21kLmgNCj4gaW5kZXggOGY4OGUzYTI5OTk4Li4wNzRi
OTc4MjE1NzUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC91YmxrX2NtZC5oDQo+
ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC91YmxrX2NtZC5oDQo+IEBAIC03OCw2ICs3OCwxMCBA
QA0KPiAgI2RlZmluZSBVQkxLX0ZfVVNFUl9SRUNPVkVSWQkoMVVMIDw8IDMpDQo+ICANCj4gICNk
ZWZpbmUgVUJMS19GX1VTRVJfUkVDT1ZFUllfUkVJU1NVRQkoMVVMIDw8IDQpDQo+ICsvKg0KPiAr
ICogRW5hYmxlIHpvbmVkIGRldmljZSBzdXBwb3J0DQo+ICsgKi8NCj4gKyNkZWZpbmUgVUJMS19G
X1pPTkVEICgxVUxMIDw8IDUpDQo+ICANCj4gIC8qIGRldmljZSBzdGF0ZSAqLw0KPiAgI2RlZmlu
ZSBVQkxLX1NfREVWX0RFQUQJMA0KPiBAQCAtMTI5LDYgKzEzMywxMiBAQCBzdHJ1Y3QgdWJsa3Ny
dl9jdHJsX2Rldl9pbmZvIHsNCj4gICNkZWZpbmUJCVVCTEtfSU9fT1BfRElTQ0FSRAkzDQo+ICAj
ZGVmaW5lCQlVQkxLX0lPX09QX1dSSVRFX1NBTUUJNA0KPiAgI2RlZmluZQkJVUJMS19JT19PUF9X
UklURV9aRVJPRVMJNQ0KPiArI2RlZmluZQkJVUJMS19JT19PUF9aT05FX09QRU4JCTEwDQo+ICsj
ZGVmaW5lCQlVQkxLX0lPX09QX1pPTkVfQ0xPU0UJCTExDQo+ICsjZGVmaW5lCQlVQkxLX0lPX09Q
X1pPTkVfRklOSVNICQkxMg0KPiArI2RlZmluZQkJVUJMS19JT19PUF9aT05FX0FQUEVORAkJMTMN
Cj4gKyNkZWZpbmUJCVVCTEtfSU9fT1BfWk9ORV9SRVNFVAkJMTUNCj4gKyNkZWZpbmUJCVVCTEtf
SU9fT1BfRFJWX0lOCQkzNA0KPiAgDQo+ICAjZGVmaW5lCQlVQkxLX0lPX0ZfRkFJTEZBU1RfREVW
CQkoMVUgPDwgOCkNCj4gICNkZWZpbmUJCVVCTEtfSU9fRl9GQUlMRkFTVF9UUkFOU1BPUlQJKDFV
IDw8IDkpDQo+IEBAIC0yMTQsNiArMjI0LDEyIEBAIHN0cnVjdCB1YmxrX3BhcmFtX2Rpc2NhcmQg
ew0KPiAgCV9fdTE2CXJlc2VydmVkMDsNCj4gIH07DQo+ICANCj4gK3N0cnVjdCB1YmxrX3BhcmFt
X3pvbmVkIHsNCj4gKwlfX3U2NAltYXhfb3Blbl96b25lczsNCj4gKwlfX3U2NAltYXhfYWN0aXZl
X3pvbmVzOw0KPiArCV9fdTY0CW1heF9hcHBlbmRfc2l6ZTsNCj4gK307DQo+ICsNCj4gIHN0cnVj
dCB1YmxrX3BhcmFtcyB7DQo+ICAJLyoNCj4gIAkgKiBUb3RhbCBsZW5ndGggb2YgcGFyYW1ldGVy
cywgdXNlcnNwYWNlIGhhcyB0byBzZXQgJ2xlbicgZm9yIGJvdGgNCj4gQEAgLTIyNCwxMCArMjQw
LDEyIEBAIHN0cnVjdCB1YmxrX3BhcmFtcyB7DQo+ICAJX191MzIJbGVuOw0KPiAgI2RlZmluZSBV
QkxLX1BBUkFNX1RZUEVfQkFTSUMgICAgICAgICAgICgxIDw8IDApDQo+ICAjZGVmaW5lIFVCTEtf
UEFSQU1fVFlQRV9ESVNDQVJEICAgICAgICAgKDEgPDwgMSkNCj4gKyNkZWZpbmUgVUJMS19QQVJB
TV9UWVBFX1pPTkVEICAgICAgICAgICAoMSA8PCAyKQ0KPiAgCV9fdTMyCXR5cGVzOwkJCS8qIHR5
cGVzIG9mIHBhcmFtZXRlciBpbmNsdWRlZCAqLw0KPiAgDQo+ICAJc3RydWN0IHVibGtfcGFyYW1f
YmFzaWMJCWJhc2ljOw0KPiAgCXN0cnVjdCB1YmxrX3BhcmFtX2Rpc2NhcmQJZGlzY2FyZDsNCj4g
KwlzdHJ1Y3QgdWJsa19wYXJhbV96b25lZAkJem9uZWQ7DQo+ICB9Ow0KPiAgDQo+ICAjZW5kaWYN
Cj4gLS0gDQo+IDIuMzkuMg0KPiA=
