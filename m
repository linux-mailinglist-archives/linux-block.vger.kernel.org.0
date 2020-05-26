Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A111B345F
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 03:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDVBMz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 21:12:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:23545 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDVBMy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 21:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587517972; x=1619053972;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KSC2ecy2oddd7yPL2po5qRusajlniXVv8iwB/9eYrk8=;
  b=OGuWV6IR3Sy+qijbd2RAyGtAT0lNrquFY8UKE0qYGKS6tFK7IoJsvU4v
   LwVU+4LrMZiAGlYnV6rCQobGC+2PhwuzNfqCIL3Dec7DV8Pug8v+a+8nF
   yX8qhyTkyyKZDVLyuZg7MvCXzLyMVTQOGnkQm2Mlwq9okfxzJarz9rY24
   CB7y0qaVRQNslnONTw4GLg1OgOmOfCkwtyhZHHNm5vEyYjIT4QYqfPH2e
   Zg7rmAtpFgZ4HUclk31oR6wDrDI2gINNraOVehL0uN8Ln35w7C64DNMbt
   9Pz08C45/OrSLhLJ2ZKYqTtsD2q3Nb/oeDpFZniHB7l1BApTkyKwMbY9r
   g==;
IronPort-SDR: mDmlp4UGbLW1cDjSN0+mgjY/FjIDw+AJVSwtIXQiRaxXXMSvgtG+K2AGYrVqDtEwaKT7zvvtXN
 6cy6PkiJL6y04iwFM5DgFU3lVwViu0/4LanC5syWFte//bggyCmBCYHsu3RjCyeoi833K54DMm
 2Tl29e+QcjcOUo7vogPgVIH/DMq+LB7XsLDiHpTZUGV6khCmE213nr5knsw/Wl4j8OIZvtVvN9
 vL2nSTQ2ZFNQKy9mS3Lp86xXxZdYJQCjDsMGw+C9y3IzOxPtp/fJCN0SphtI8NYKV36sQ4kYPT
 Nic=
X-IronPort-AV: E=Sophos;i="5.72,412,1580745600"; 
   d="scan'208";a="244558303"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2020 09:12:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E33wk2LGgfvCrm5cQNgLWxlAD96kbiIJFn/TgXQVg9n5rAH18+mx78W+2ZhTxfJempm/WGU4uGOGLQ2SGX9PhzWRoBzZkLhJWryciIuOCPyNMhgRzd0P6W04Lb8ot/0gpKrQDbu96nS8+sga0Hj0DhBF7YH6xyHLQ4+BTEFscvsxkNP1U+2yZhTTO2r+2l9v9Zy+zILpiSR+ooN4zDCdWLICKx+aWNQfhWfO3F/XWcElXrYOjLDDxa2QhvQ3/5vh8ptUa3PubfakBIVzqqjvY8gotVP+47/zrmUQRgn3UfZIQsNkzOBTuJ09xWizgonIESRG1BVJ0F9YFB0nIxRvEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gRlKHzViO6GnNEIhiuJhEinZKKJjSY4Og0zDh3oBis=;
 b=cXu5siiN2LPwKJQ2QFZ7JMHzMIADAsDxxJ/06po6gAnJDgF+Yt8jcFJnUy8P6MzI/CD8Z4cDiWhjrsXb9s2exowMnMGFEUd0f7D07U5na19vqWz3Y433IujIrctUfBWWnMCnvB5JvfAB242g2Kr49oPrg4o2X2Z1YL0OWD613gM64YWf8wKJjMR+/twCGqF9VJVVYoCzZI24pj1USBMYQSs352SRgTgVbX0NWRDKm71+/lCeE5gmFfpo98tuPL/eh0Xgcnih0KR5dwUrw3WoNbRhUix+JaFM1/plg9PuDpVQqeT3h0m48u5DhxTTJ4oAv0enY3EcKn/1vVkbD/lzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gRlKHzViO6GnNEIhiuJhEinZKKJjSY4Og0zDh3oBis=;
 b=ze4L1vuihrC1sg7eORLLab+IZ0YKKvd58ThRyLWbq0wegzdlbvXEVLIPiwIGi6Yuc5gnVdK4XFcVu69HfSIkpwPsi9BqGF/2l/WypP77bUXGt3tn0UzDmBpcU0DbBt40Gpb0BMKE1uOEyVZu7GeYgNtjx1i2o5N3mbkRLHadQnU=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5190.namprd04.prod.outlook.com (2603:10b6:a03:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 01:12:51 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 01:12:51 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v2] Fix unintentional skipping of tests
Thread-Topic: [PATCH blktests v2] Fix unintentional skipping of tests
Thread-Index: AQHWF69CKwO0zD6OTkGNF5Fz4okO8qiEVukA
Date:   Wed, 22 Apr 2020 01:12:51 +0000
Message-ID: <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
References: <20200421073321.92302-1-its@irrelevant.dk>
In-Reply-To: <20200421073321.92302-1-its@irrelevant.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1931a32-a2a4-4541-8702-08d7e65a4786
x-ms-traffictypediagnostic: BYAPR04MB5190:
x-microsoft-antispam-prvs: <BYAPR04MB519025696F5B7A3644564471EDD20@BYAPR04MB5190.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(186003)(316002)(44832011)(54906003)(26005)(4326008)(6486002)(2906002)(6506007)(6512007)(9686003)(6916009)(30864003)(5660300002)(478600001)(86362001)(8676002)(8936002)(66556008)(64756008)(81156014)(91956017)(66946007)(71200400001)(66476007)(76116006)(1076003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HDKlO8ji7NhkfQjPYxmc+MsfEAM0qjX0bp5L5VTLNH7rti5mvvx3TL3F4fu5sTCVjxV/e916WNzJE0jgx9QS3d2SYRuSuyLVcCxm+QfArH5Eh8wFPTQzYd0D7ViEgNs+vvkHLfIPcgmZTgO5E/dHVIdK6Eg/2bpWtI/xlmRrFqqYIUWXV1D6ijKFfJ3dlhhF/QZUiXjZCiLIM6JtsazPRk07AEXfDM5I3WJFviIVHkEpCq+s2pqKji4mXlwJ56PSPvEzZ57RbwPyJGInj53NxaFGTWLKFhy3vwYhmC7/3KIlLNvyEkArSA+m0Mk3gUMjWTT+L6mtI6oQ+1Rw2yAiSEx20IUCrZhJdkul+QH7r4DGRtYULta3+rgO1WdT9zv+/FUEwmfIQmoas7YIeKjjSoj82vBJ9tBmurNlddkKujsz8dlP/asT3KFfyBZt3ZTZ
x-ms-exchange-antispam-messagedata: ZInpAjQyQhfcH+qSLWTUeCNz5QHMKoAle0lVOXTIzcvNqIB3bnKX8+iLST2Ob30sOKTCqmp3VM+e4/pMkSMoUMkQmO0Rg3ZAxhKCyLcGXLTlF66isHkHdTlir6UEea1zZNtOtyb7ac934HlnzUTCtg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F311B527293D346B3329070568A0FD3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1931a32-a2a4-4541-8702-08d7e65a4786
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 01:12:51.5839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9oY5tXooVAe27n8ZiCJ0y3jkd7eSjKL3ac75X8nirTyxUyC4VqGGz5WNwYC6Ha4U4UxWjnJVoIY8uy0IoDTCXwTVqMznYN1yQSa9TUlonRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5190
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Klaus,

Thank you for this patch. I also face the unexpected "not run" messages and=
 this
patch fixes them. I made a couple of comments on your patch in line.

On Apr 21, 2020 / 09:33, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> cd11d001fe86 ("Support skipping tests from test{,_device}()") breaks a
> handful of tests in the block group.
>=20
> For example, block/005 uses _test_dev_is_rotational to check if the
> device is rotational and uses the result to size up the fio run. As a
> side-effect, _test_dev_is_rotational also sets SKIP_REASON, which (since
> commit cd11d001fe86) causes the test to print out a "[not run]" even
> through the test actually ran successfully.
>=20
> Fix this by renaming the existing helpers to _require_foo (e.g. a
> _require_test_dev_is_rotational) and add the non-_require variant where
> needed.
>=20
> Fixes: cd11d001fe86 ("Support skipping tests from test{,_device}()")
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  check           | 10 ++++------
>  common/iopoll   |  4 ++--
>  common/rc       | 35 ++++++++++++++++++++++++++++-------
>  new             | 12 ++++++------
>  tests/block/004 |  8 ++++----
>  tests/block/007 |  3 ++-
>  tests/block/011 |  2 +-
>  tests/block/019 |  2 +-
>  tests/nvme/032  |  2 +-
>  tests/nvme/rc   |  4 ++--
>  tests/scsi/006  |  2 +-
>  tests/scsi/rc   |  6 +++---
>  tests/zbd/007   |  2 +-
>  tests/zbd/rc    | 11 +++++++++--
>  14 files changed, 65 insertions(+), 38 deletions(-)
>=20
> diff --git a/check b/check
> index 398eca05e3a4..84ec086c408b 100755
> --- a/check
> +++ b/check
> @@ -423,18 +423,16 @@ _call_test() {
>  _test_dev_is_zoned() {
>  	if [[ ! -f "${TEST_DEV_SYSFS}/queue/zoned" ]] ||
>  	      grep -q none "${TEST_DEV_SYSFS}/queue/zoned"; then
> -		SKIP_REASON=3D"${TEST_DEV} is not a zoned block device"
>  		return 1
>  	fi
>  	return 0
>  }
> =20
> -_test_dev_is_not_zoned() {
> -	if _test_dev_is_zoned; then
> -		SKIP_REASON=3D"${TEST_DEV} is a zoned block device"
> +_require_test_dev_is_zoned() {
> +	if ! _test_dev_is_zoned; then
> +		SKIP_REASON=3D"${TEST_DEV} is not a zoned block device"
>  		return 1
>  	fi
> -	unset SKIP_REASON
>  	return 0
>  }
> =20
> @@ -497,7 +495,7 @@ _run_test() {
>  			local unset_skip_reason=3D0
>  			if [[ ! -v SKIP_REASON ]]; then
>  				unset_skip_reason=3D1
> -				if (( !CAN_BE_ZONED )) && ! _test_dev_is_not_zoned; then
> +				if (( !CAN_BE_ZONED )) && _test_dev_is_zoned; then
>  					SKIP_REASON=3D"${TEST_DEV} is a zoned block device"
>  				elif declare -fF device_requires >/dev/null; then
>  					device_requires
> diff --git a/common/iopoll b/common/iopoll
> index 80a5f99b08ca..dfdd2cf6f08f 100644
> --- a/common/iopoll
> +++ b/common/iopoll
> @@ -17,7 +17,7 @@ _have_fio_with_poll() {
>  	return 0
>  }
> =20
> -_test_dev_supports_io_poll() {
> +_require_test_dev_supports_io_poll() {
>  	local old_io_poll
>  	if ! old_io_poll=3D"$(cat "${TEST_DEV_SYSFS}/queue/io_poll" 2>/dev/null=
)"; then
>  		SKIP_REASON=3D"kernel does not support polling"
> @@ -30,7 +30,7 @@ _test_dev_supports_io_poll() {
>  	return 0
>  }
> =20
> -_test_dev_supports_io_poll_delay() {
> +_require_test_dev_supports_io_poll_delay() {
>  	local old_io_poll_delay
>  	if ! old_io_poll_delay=3D"$(cat "${TEST_DEV_SYSFS}/queue/io_poll_delay"=
 2>/dev/null)"; then
>  		SKIP_REASON=3D"kernel does not support hybrid polling"
> diff --git a/common/rc b/common/rc
> index 1893dda2b2f7..dfa7ac0e4ffc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -181,22 +181,36 @@ _have_tracepoint() {
>  	return 0
>  }
> =20
> -_test_dev_can_discard() {
> -	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
> -		SKIP_REASON=3D"$TEST_DEV does not support discard"
> +_test_dev_is_rotational() {
> +	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
>  		return 1
>  	fi
>  	return 0
>  }
> =20
> -_test_dev_is_rotational() {
> -	if [[ $(cat "${TEST_DEV_SYSFS}/queue/rotational") -eq 0 ]]; then
> +_require_test_dev_is_rotational() {
> +	if ! _test_dev_is_rotational; then
>  		SKIP_REASON=3D"$TEST_DEV is not rotational"
>  		return 1
>  	fi
>  	return 0
>  }
> =20
> +_test_dev_can_discard() {
> +	if [[ $(cat "${TEST_DEV_SYSFS}/queue/discard_max_bytes") -eq 0 ]]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_test_dev_can_discard() {
> +	if ! _test_dev_can_discard; then
> +		SKIP_REASON=3D"$TEST_DEV does not support discard"
> +		return 1
> +	fi
> +	return 0
> +}
> +

Don't we need replace _test_dev_can_discard() in block/003 with
_require_test_dev_can_discard()?

>  _test_dev_queue_get() {
>  	if [[ $1 =3D scheduler ]]; then
>  		sed -e 's/.*\[//' -e 's/\].*//' "${TEST_DEV_SYSFS}/queue/scheduler"
> @@ -214,7 +228,7 @@ _test_dev_queue_set() {
>  	echo "$2" >"${TEST_DEV_SYSFS}/queue/$1"
>  }
> =20
> -_test_dev_is_pci() {
> +_require_test_dev_is_pci() {
>  	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q pci; then
>  		# nvme needs some special casing
>  		if readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
> @@ -247,7 +261,7 @@ _get_pci_parent_from_blkdev() {
>  		tail -2 | head -1
>  }
> =20
> -_test_dev_in_hotplug_slot() {
> +_require_test_dev_in_hotplug_slot() {
>  	local parent
>  	parent=3D"$(_get_pci_parent_from_blkdev)"
> =20
> @@ -262,6 +276,13 @@ _test_dev_in_hotplug_slot() {
> =20
>  _test_dev_is_partition() {
>  	if [[ -z ${TEST_DEV_PART_SYSFS} ]]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_test_dev_is_partition() {
> +	if ! _test_dev_is_partition; then
>  		SKIP_REASON=3D"${TEST_DEV} is not a partition device"
>  		return 1
>  	fi
> diff --git a/new b/new
> index 31973ed1add2..73f0faa8fa96 100755
> --- a/new
> +++ b/new
> @@ -85,10 +85,10 @@ group_requires() {
>  #
>  # Usually, group_device_requires() just needs to check that the test dev=
ice is
>  # the right type of hardware or supports any necessary features using th=
e
> -# _test_dev_foo helpers. If group_device_requires() sets \$SKIP_REASON, =
all
> -# tests in this group will be skipped on that device.
> +# _require_test_dev_foo helpers. If group_device_requires() sets \$SKIP_=
REASON,
> +# all tests in this group will be skipped on that device.
>  # group_device_requires() {
> -# 	_test_dev_is_foo && _test_dev_supports_bar
> +# 	_require_test_dev_is_foo && _require_test_dev_supports_bar
>  # }
> =20
>  # TODO: define any helpers that are specific to this group.
> @@ -171,10 +171,10 @@ DESCRIPTION=3D""
>  #
>  # Usually, device_requires() just needs to check that the test device is=
 the
>  # right type of hardware or supports any necessary features using the
> -# _test_dev_foo helpers. If device_requires() sets \$SKIP_REASON, the te=
st will
> -# be skipped on that device.
> +# _require_test_dev_foo helpers. If device_requires() sets \$SKIP_REASON=
, the
> +# test will be skipped on that device.
>  # device_requires() {
> -# 	_test_dev_is_foo && _test_dev_supports_bar
> +# 	_require_test_dev_is_foo && _require_test_dev_supports_bar
>  # }
> =20
>  # TODO: define the test. The output of this function (stdout and stderr)=
 will
> diff --git a/tests/block/004 b/tests/block/004
> index d181725e6f80..92060858d4c6 100755
> --- a/tests/block/004
> +++ b/tests/block/004
> @@ -14,10 +14,6 @@ requires() {
>  	_have_fio
>  }
> =20
> -device_requires() {
> -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> -}
> -
>  test_device() {
>  	echo "Running ${TEST_NAME}"
> =20
> @@ -25,6 +21,10 @@ test_device() {
>  	local zbdmode=3D""
> =20
>  	if _test_dev_is_zoned; then
> +		if ! _have_fio_zbd_zonemode; then
> +			return
> +		fi
> +

This check is equivalent to device_requires() you removed, isn't it?
If the skip check in test_device() is the last resort, it would be the
better to check in device_requires(), I think.

>  		_test_dev_queue_set scheduler deadline
>  		directio=3D"--direct=3D1"
>  		zbdmode=3D"--zonemode=3Dzbd"
> diff --git a/tests/block/007 b/tests/block/007
> index f03935084ce6..b19a57024b42 100755
> --- a/tests/block/007
> +++ b/tests/block/007
> @@ -15,7 +15,8 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_test_dev_supports_io_poll && _test_dev_supports_io_poll_delay
> +	_require_test_dev_supports_io_poll && \
> +		_require_test_dev_supports_io_poll_delay
>  }
> =20
>  run_fio_job() {
> diff --git a/tests/block/011 b/tests/block/011
> index c3432a63e274..4f331b4a7522 100755
> --- a/tests/block/011
> +++ b/tests/block/011
> @@ -15,7 +15,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_test_dev_is_pci
> +	_require_test_dev_is_pci
>  }
> =20
>  test_device() {
> diff --git a/tests/block/019 b/tests/block/019
> index 7cd26bd512bc..113a3d6e8986 100755
> --- a/tests/block/019
> +++ b/tests/block/019
> @@ -14,7 +14,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_test_dev_is_pci && _test_dev_in_hotplug_slot
> +	_require_test_dev_is_pci && _require_test_dev_in_hotplug_slot
>  }
> =20
>  test_device() {
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index a91a473ac5df..ce45657951a1 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -19,7 +19,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_test_dev_is_nvme
> +	_require_test_dev_is_nvme
>  }
> =20
>  test_device() {
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 40f0413d32d2..6ffa971b4308 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -11,12 +11,12 @@ group_requires() {
>  }
> =20
>  group_device_requires() {
> -	_test_dev_is_nvme
> +	_require_test_dev_is_nvme
>  }
> =20
>  NVMET_CFS=3D"/sys/kernel/config/nvmet/"
> =20
> -_test_dev_is_nvme() {
> +_require_test_dev_is_nvme() {
>  	if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
>  		SKIP_REASON=3D"$TEST_DEV is not a NVMe device"
>  		return 1
> diff --git a/tests/scsi/006 b/tests/scsi/006
> index f220f61e3c1e..05ed6520d600 100755
> --- a/tests/scsi/006
> +++ b/tests/scsi/006
> @@ -12,7 +12,7 @@ DESCRIPTION=3D"toggle SCSI cache type"
>  QUICK=3D1
> =20
>  device_requires() {
> -	_test_dev_is_scsi_disk
> +	_require_test_dev_is_scsi_disk
>  }
> =20
>  test_device() {
> diff --git a/tests/scsi/rc b/tests/scsi/rc
> index 2a192fd0f969..1477cecc5593 100644
> --- a/tests/scsi/rc
> +++ b/tests/scsi/rc
> @@ -11,14 +11,14 @@ group_requires() {
>  }
> =20
>  group_device_requires() {
> -	_test_dev_is_scsi
> +	_require_test_dev_is_scsi
>  }
> =20
>  _have_scsi_generic() {
>  	_have_modules sg
>  }
> =20
> -_test_dev_is_scsi() {
> +_require_test_dev_is_scsi() {
>  	if [[ ! -d ${TEST_DEV_SYSFS}/device/scsi_device ]]; then
>  		SKIP_REASON=3D"$TEST_DEV is not a SCSI device"
>  		return 1
> @@ -26,7 +26,7 @@ _test_dev_is_scsi() {
>  	return 0
>  }
> =20
> -_test_dev_is_scsi_disk() {
> +_require_test_dev_is_scsi_disk() {
>  	if [[ ! -d ${TEST_DEV_SYSFS}/device/scsi_disk ]]; then
>  		SKIP_REASON=3D"$TEST_DEV is not a SCSI disk"
>  		return 1
> diff --git a/tests/zbd/007 b/tests/zbd/007
> index b4dcbd89f179..2376b3aedaa0 100755
> --- a/tests/zbd/007
> +++ b/tests/zbd/007
> @@ -18,7 +18,7 @@ requires() {
>  }
> =20
>  device_requires() {
> -	_test_dev_is_logical
> +	_require_test_dev_is_logical
>  }
> =20
>  # Select test target zones. Pick up the first sequential required zones.=
 If
> diff --git a/tests/zbd/rc b/tests/zbd/rc
> index 9c1dc5210b1a..a910a2425567 100644
> --- a/tests/zbd/rc
> +++ b/tests/zbd/rc
> @@ -18,7 +18,7 @@ group_requires() {
>  }
> =20
>  group_device_requires() {
> -	_test_dev_is_zoned
> +	_require_test_dev_is_zoned
>  }
> =20
>  _fallback_null_blk_zoned() {
> @@ -254,13 +254,20 @@ _find_two_contiguous_seq_zones() {
> =20
>  _test_dev_is_dm() {
>  	if [[ ! -r "${TEST_DEV_SYSFS}/dm/name" ]]; then
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +_require_test_dev_is_dm() {
> +	if ! _test_dev_is_dm; then
>  		SKIP_REASON=3D"$TEST_DEV is not device-mapper"
>  		return 1
>  	fi
>  	return 0
>  }
> =20
> -_test_dev_is_logical() {
> +_require_test_dev_is_logical() {
>  	if ! _test_dev_is_partition && ! _test_dev_is_dm; then
>  		SKIP_REASON=3D"$TEST_DEV is not a logical device"
>  		return 1
> --=20
> 2.26.2
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
