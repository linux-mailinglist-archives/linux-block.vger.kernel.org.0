Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF62DA9C4
	for <lists+linux-block@lfdr.de>; Tue, 15 Dec 2020 10:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgLOJH7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Dec 2020 04:07:59 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60443 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgLOJHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 04:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608023437; x=1639559437;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xgEIlug8rquQtuMIZjdUAJJI60D8K/8z5EWFRHlfGh4=;
  b=KU7ljazPfBxHrBfYdvjUn6ZplMKS5wB9XwLjY58J7mJD2Hkr7x9GRaUE
   i1ApChwfJgkF01+Qhv6/E+221L2+hjvrYOd1NgEQjr9s+L8JeTwd1Whxa
   mowgD+NcglkajFlAjNDlMgZrDti097ZCPudq7XNihghbUgnEYCAdI/liU
   sSkqB4XFUg1VMQq3kYiURHK/CHk7iENaS3Ks9O2elaSz69O/HtKsdlX+h
   dlpe1kVren0MHSfkq5y4g+ay0/So6m+HUpNG4CsUmWnYvYrimsaumgWz+
   Jb8wScpzOWwl7/S2+8FMlXawzdy0SFVSNYUG5D7IGrx+WuF/jw2lhr8a8
   Q==;
IronPort-SDR: AYosgUxBP5sowQoh9+jkvqyxAUAcStiejJM7BHmR/yJsnu2dVa+yxG7dBeDSNaAZEGIOnboThp
 mapHt0UulwnHqbauvwMdxoqr7fHS/3gChsaoVUckXzIQXpoD3rVhwc2Y24kFhnOE5e6AcPYBp0
 eLfIDrPoLZP5mVUmL2xVwEA/eBboSmzfW4piYcd9/XCcOCKWdVPiRYSA+6/zl2pIAC1bLpjehU
 I7KP4i0Zl0xGqxdtYl3975K/SXd/rrG6wzd3kmJLRSD2UjZIHLvnDB4zXU5N0MZNf2RmZ5PPXS
 ieo=
X-IronPort-AV: E=Sophos;i="5.78,420,1599494400"; 
   d="scan'208";a="258938075"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2020 17:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmTceCDk532fTDFVXJpTh32uu5uDJsTQGdAMus9nIKVtYl4rduIK+XywYde178JbN9yFkAudIAwuE3xTaBM9YdqHIyAh+vn8kWgkBCceMwFRuuCHFn1BysBLCZr2hZofpwABfp58WkL/7Z0XuvEk2AHRsWkpc4CM4HfWt90c3YrcLKWr7AdTNzl9FtFsT7orCyHL/Evj1XkezCVfqV02IMw0mnSCNQe2PBV3BEROxVStVTuLrLkCrxBQ1T/NEPP+fxo7nNA7pKGks0lK/5z3K7UuPTQoMNNkKTSTnuETWWaZv9X7XuYUsOokC8HMAuhJUs0O9mOHAQnWXi/daKIQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HxDHMCy0iW8+xn+8rruxGhrX3D7nA16Q7Cig1NKwos=;
 b=Th2tI/hMLpTvWI87bCM8vl0KH/VyFWyr3mNW0tfW0osWPK09gESyQ7lT3fHeIx2Q9moe9Qxtwrb+SQBX0rePIGk9oVDwo0pDJm20rnsoPD9skgrH7FbQfKCB6asG2bStOob/Ps6jKGiyCghPABQTmPsEvrg9pNxM9YBzra69uojfySFwvHGbIJRHevAtrfO6V6HgbZn3By1IfmDcO3xWQEO2zozxdY8Enf4vom1KsqUKMclRu7i98ed3OtWKAHVsEnucj1kkYfQ3lvOva1T+TD5oSWth3sMr29FTXA0uEic7YvyQmkqULGf09ecm1zwmLefHPXZIQSmXN+jRGgMyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HxDHMCy0iW8+xn+8rruxGhrX3D7nA16Q7Cig1NKwos=;
 b=eqUeQQGoIcfvQqxp1392/qrjyrdFSJYuwvnbZt2EZZG1VhnMWWcD1LaoieMSuHUK6kdTYTH5czhP5h0aRO/kPrTJ8e5JkIKE9nLAXhGw9pJWmzAtyJfR+r7CkAAIVUQgFElH0NFVBum/pAJHcgdhJHh+A5//J2ZfSmk4LxhKAO0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6950.namprd04.prod.outlook.com (2603:10b6:610:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 09:06:33 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%6]) with mapi id 15.20.3654.026; Tue, 15 Dec 2020
 09:06:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V7 4/6] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW0qgRFs/FzWenxk2tjrXm7qX1YQ==
Date:   Tue, 15 Dec 2020 09:06:33 +0000
Message-ID: <CH2PR04MB6522AC040C900B2574125884E7C60@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201215060305.28141-1-chaitanya.kulkarni@wdc.com>
 <20201215060305.28141-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f0b5:b4fe:45e3:5658]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21659477-9025-4606-3a85-08d8a0d8b820
x-ms-traffictypediagnostic: CH2PR04MB6950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB69502173A3E57836AC8E4EB4E7C60@CH2PR04MB6950.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7pcXHlHrG3OumZhzk69jupsOd7950lRj99lqQbSpXR6j4ZTkyMZfCcp8MWpmdNlLrjUpgBnUunKVLxCrsWDFQj2q1o0RwP4Ge8QJtwFFI4NY+dOeCNyl8HFAlIpXYUnNyTrycuTWkVGieKU3fdUBvvHgTzg2W8eWe4EKWna0FqVZx4Qhznm87v4o9pulL83boSEzSM6iFKnt2cBk/xMQkuI2RsE+gqVM1OZj4IkBYxZAG4boakH9js9vrUW9HEM6wBGUXqM66QVRwXZqX6dRSTtmmznMkJl84jAfLP+kmK0guu/DmiKUjm5kuQuD02n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(52536014)(86362001)(54906003)(4326008)(71200400001)(8936002)(66476007)(508600001)(30864003)(83380400001)(55016002)(66556008)(110136005)(186003)(5660300002)(66446008)(53546011)(76116006)(66946007)(2906002)(8676002)(7696005)(6506007)(64756008)(91956017)(33656002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?H9gIJHyvT3Inc0lamR0lAhyyAP3QwQXTnSLE3dG2SNYjHyihilORXpRC?=
 =?Windows-1252?Q?6387zsCPwCCVo02qTPoLn58jZqBAIcXfhoXv7p6OVsAKdZE1uML3Q6xh?=
 =?Windows-1252?Q?pHCSPNPsLh776S2u6wzYQXOfsd9m+my2hWUJ1/dPYvudb6y/OCnMctF6?=
 =?Windows-1252?Q?M1JnQ0gaiiU1v1te8F62HupauLmmBOT8RU/8JDN8xvr57DXKPlzVofw1?=
 =?Windows-1252?Q?fF/yCp53cHlc8yB9CyNAulhSfzNLEBH3k9tBFUxDcNdgRvbeaUzesXak?=
 =?Windows-1252?Q?9MTTTps2dLqirQNY4l+nqttbwxclC3q80t70LWh4kuKCo6Kkg93Dzhbs?=
 =?Windows-1252?Q?3vJgnpBxPVgCwIgs6LXRhV/P9yMlA+PEQFyiTtSQRW6wosYXjt3hnQHz?=
 =?Windows-1252?Q?eDzK6ph5aQqFeyvprme+bhXSlyHqDRu8FYMgwHBhQTb5OdQNcR5pb7gX?=
 =?Windows-1252?Q?tSKsm0BMF5uJRFphzdD7LCb2WhrJ01sj5+Wmc8V9xkDWPiKpbCJ2FefI?=
 =?Windows-1252?Q?qToV5bHdr2a/FEgM4d7aHlRFXuDEQ5eBB17Z9xlyANyUofTjL4BOZjoP?=
 =?Windows-1252?Q?Kd2d8k9wCJk37a0o2xLVbcX1ImG/tp3/SrILnkr4Nj+5Upk2+eV0u2/W?=
 =?Windows-1252?Q?NY/0LUrUf6UkwWQBl4juESdgBDqkdAdlQXlrbQgpaPa7P3U+DwKLoXsk?=
 =?Windows-1252?Q?XN56g9XnXKStk2juJtIgvsfy51mWDPFvQP+/dJjaO7o04ZUifzC4Q7EL?=
 =?Windows-1252?Q?obg/TiEqJMFyqEa3j5sRT+tjJn+H68qjEj8IXreQOIxxLGsasTnbZwG0?=
 =?Windows-1252?Q?XPFwy4TqUBcWTdFk6PuSF1j6K71720YONIxxDVioVYfV45n9Xcoesmri?=
 =?Windows-1252?Q?Ert2iV1+xGpMqLvvcLtRB5mJt3HQs5WO93I8mhB6a05cE0OanwpkfuTj?=
 =?Windows-1252?Q?28pnubnvtiCoJoqI78+xIUAWun5Ep2PrOdr/WaCxdlCxwpk90r0quakH?=
 =?Windows-1252?Q?csZIkxcM4aWIDXvMz7Mu6ekOnuXc6hZ5k11AlmzyYiOik3BqGXdGZLw9?=
 =?Windows-1252?Q?8NNYCpPKmZ73ogRDmnlCP2KxgLrYPusX+4pUq5vqQqZTO7OrjBLp5CA4?=
 =?Windows-1252?Q?PoOM9er82cLxX8ddNGa1dgJV?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21659477-9025-4606-3a85-08d8a0d8b820
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 09:06:33.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2s9gwTXOuu3kkjl6addjBuw+ofD2rpOe7+cSBCYdl+QtyH5EMs587NK2q/t1wjb2td8TahlxSMmyaTRE80Fqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6950
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/12/15 15:03, Chaitanya Kulkarni wrote:=0A=
> NVMe TP 4053 =96 Zoned Namespaces (ZNS) allows host software to=0A=
> communicate with a non-volatile memory subsystem using zones for=0A=
> NVMe protocol based controllers. NVMeOF already support the ZNS NVMe=0A=
> Protocol compliant devices on the target in the passthru mode. There=0A=
> are Generic zoned block devices like  Shingled Magnetic Recording (SMR)=
=0A=
> HDDs which are not based on the NVMe protocol.=0A=
> =0A=
> This patch adds ZNS backend to support the ZBDs for NVMeOF target.=0A=
> =0A=
> This support includes implementing the new command set NVME_CSI_ZNS,=0A=
> adding different command handlers for ZNS command set such as=0A=
> NVMe Identify Controller, NVMe Identify Namespace, NVMe Zone Append,=0A=
> NVMe Zone Management Send and NVMe Zone Management Receive.=0A=
> =0A=
> With new command set identifier we also update the target command effects=
=0A=
> logs to reflect the ZNS compliant commands.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  drivers/nvme/target/Makefile      |   1 +=0A=
>  drivers/nvme/target/admin-cmd.c   |  26 +++=0A=
>  drivers/nvme/target/core.c        |   1 +=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  33 ++-=0A=
>  drivers/nvme/target/nvmet.h       |  38 ++++=0A=
>  drivers/nvme/target/zns.c         | 342 ++++++++++++++++++++++++++++++=
=0A=
>  6 files changed, 433 insertions(+), 8 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
> diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile=
=0A=
> index ebf91fc4c72e..9837e580fa7e 100644=0A=
> --- a/drivers/nvme/target/Makefile=0A=
> +++ b/drivers/nvme/target/Makefile=0A=
> @@ -12,6 +12,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+=3D nvmet-tcp.o=0A=
>  nvmet-y		+=3D core.o configfs.o admin-cmd.o fabrics-cmd.o \=0A=
>  			discovery.o io-cmd-file.o io-cmd-bdev.o=0A=
>  nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+=3D passthru.o=0A=
> +nvmet-$(CONFIG_BLK_DEV_ZONED)		+=3D zns.o=0A=
>  nvme-loop-y	+=3D loop.o=0A=
>  nvmet-rdma-y	+=3D rdma.o=0A=
>  nvmet-fc-y	+=3D fc.o=0A=
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-=
cmd.c=0A=
> index f4c0f3aca485..6f5279b15aa6 100644=0A=
> --- a/drivers/nvme/target/admin-cmd.c=0A=
> +++ b/drivers/nvme/target/admin-cmd.c=0A=
> @@ -192,6 +192,15 @@ static void nvmet_execute_get_log_cmd_effects_ns(str=
uct nvmet_req *req)=0A=
>  		log->iocs[nvme_cmd_dsm]			=3D cpu_to_le32(1 << 0);=0A=
>  		log->iocs[nvme_cmd_write_zeroes]	=3D cpu_to_le32(1 << 0);=0A=
>  		break;=0A=
> +	case NVME_CSI_ZNS:=0A=
> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
> +			u32 *iocs =3D log->iocs;=0A=
> +=0A=
> +			iocs[nvme_cmd_zone_append]	=3D cpu_to_le32(1 << 0);=0A=
> +			iocs[nvme_cmd_zone_mgmt_send]	=3D cpu_to_le32(1 << 0);=0A=
> +			iocs[nvme_cmd_zone_mgmt_recv]	=3D cpu_to_le32(1 << 0);=0A=
> +		}=0A=
> +		break;=0A=
>  	default:=0A=
>  		status =3D NVME_SC_INVALID_LOG_PAGE;=0A=
>  		break;=0A=
> @@ -614,6 +623,7 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req =
*req, u8 type, u8 len,=0A=
>  =0A=
>  static void nvmet_execute_identify_desclist(struct nvmet_req *req)=0A=
>  {=0A=
> +	u16 nvme_cis_zns =3D NVME_CSI_ZNS;=0A=
>  	u16 status =3D 0;=0A=
>  	off_t off =3D 0;=0A=
>  =0A=
> @@ -638,6 +648,14 @@ static void nvmet_execute_identify_desclist(struct n=
vmet_req *req)=0A=
>  		if (status)=0A=
>  			goto out;=0A=
>  	}=0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {=0A=
> +		if (req->ns->csi =3D=3D NVME_CSI_ZNS)=0A=
> +			status =3D nvmet_copy_ns_identifier(req, NVME_NIDT_CSI,=0A=
> +							  NVME_NIDT_CSI_LEN,=0A=
> +							  &nvme_cis_zns, &off);=0A=
> +		if (status)=0A=
> +			goto out;=0A=
> +	}=0A=
>  =0A=
>  	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,=
=0A=
>  			off) !=3D NVME_IDENTIFY_DATA_SIZE - off)=0A=
> @@ -655,8 +673,16 @@ static void nvmet_execute_identify(struct nvmet_req =
*req)=0A=
>  	switch (req->cmd->identify.cns) {=0A=
>  	case NVME_ID_CNS_NS:=0A=
>  		return nvmet_execute_identify_ns(req);=0A=
> +	case NVME_ID_CNS_CS_NS:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ns(req);=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_CTRL:=0A=
>  		return nvmet_execute_identify_ctrl(req);=0A=
> +	case NVME_ID_CNS_CS_CTRL:=0A=
> +		if (req->cmd->identify.csi =3D=3D NVME_CSI_ZNS)=0A=
> +			return nvmet_execute_identify_cns_cs_ctrl(req);=0A=
> +		break;=0A=
>  	case NVME_ID_CNS_NS_ACTIVE_LIST:=0A=
>  		return nvmet_execute_identify_nslist(req);=0A=
>  	case NVME_ID_CNS_NS_DESC_LIST:=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index 672e4009f8d6..17a99c7134dc 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -1107,6 +1107,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)=0A=
>  static inline bool nvmet_cc_css_check(u8 cc_css)=0A=
>  {=0A=
>  	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {=0A=
> +	case NVME_CC_CSS_CSI:=0A=
>  	case NVME_CC_CSS_NVM:=0A=
>  		return true;=0A=
>  	default:=0A=
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-c=
md-bdev.c=0A=
> index 23095bdfce06..6178ef643962 100644=0A=
> --- a/drivers/nvme/target/io-cmd-bdev.c=0A=
> +++ b/drivers/nvme/target/io-cmd-bdev.c=0A=
> @@ -63,6 +63,14 @@ static void nvmet_bdev_ns_enable_integrity(struct nvme=
t_ns *ns)=0A=
>  	}=0A=
>  }=0A=
>  =0A=
> +void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (ns->bdev) {=0A=
> +		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
> +		ns->bdev =3D NULL;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>  {=0A=
>  	int ret;=0A=
> @@ -86,15 +94,15 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)=0A=
>  	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY_T10))=0A=
>  		nvmet_bdev_ns_enable_integrity(ns);=0A=
>  =0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
> -void nvmet_bdev_ns_disable(struct nvmet_ns *ns)=0A=
> -{=0A=
> -	if (ns->bdev) {=0A=
> -		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);=0A=
> -		ns->bdev =3D NULL;=0A=
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) && bdev_is_zoned(ns->bdev)) {=0A=
> +		if (!nvmet_bdev_zns_enable(ns)) {=0A=
> +			nvmet_bdev_ns_disable(ns);=0A=
> +			return -EINVAL;=0A=
> +		}=0A=
> +		ns->csi =3D NVME_CSI_ZNS;=0A=
>  	}=0A=
> +=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)=0A=
> @@ -448,6 +456,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)=
=0A=
>  	case nvme_cmd_write_zeroes:=0A=
>  		req->execute =3D nvmet_bdev_execute_write_zeroes;=0A=
>  		return 0;=0A=
> +	case nvme_cmd_zone_append:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_append;=0A=
> +		return 0;=0A=
> +	case nvme_cmd_zone_mgmt_recv:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_recv;=0A=
> +		return 0;=0A=
> +	case nvme_cmd_zone_mgmt_send:=0A=
> +		req->execute =3D nvmet_bdev_execute_zone_mgmt_send;=0A=
> +		return 0;=0A=
>  	default:=0A=
>  		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,=0A=
>  		       req->sq->qid);=0A=
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h=0A=
> index 476b3cd91c65..7361665585a2 100644=0A=
> --- a/drivers/nvme/target/nvmet.h=0A=
> +++ b/drivers/nvme/target/nvmet.h=0A=
> @@ -252,6 +252,10 @@ struct nvmet_subsys {=0A=
>  	unsigned int		admin_timeout;=0A=
>  	unsigned int		io_timeout;=0A=
>  #endif /* CONFIG_NVME_TARGET_PASSTHRU */=0A=
> +=0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +	u8			zasl;=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
>  };=0A=
>  =0A=
>  static inline struct nvmet_subsys *to_subsys(struct config_item *item)=
=0A=
> @@ -614,4 +618,38 @@ static inline sector_t nvmet_lba_to_sect(struct nvme=
t_ns *ns, __le64 lba)=0A=
>  	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);=0A=
>  }=0A=
>  =0A=
> +#ifdef CONFIG_BLK_DEV_ZONED=0A=
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req);=0A=
> +#else  /* CONFIG_BLK_DEV_ZONED */=0A=
> +static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	return false;=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +static inline void=0A=
> +nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +}=0A=
> +#endif /* CONFIG_BLK_DEV_ZONED */=0A=
> +=0A=
>  #endif /* _NVMET_H */=0A=
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c=0A=
> new file mode 100644=0A=
> index 000000000000..3981baa647b2=0A=
> --- /dev/null=0A=
> +++ b/drivers/nvme/target/zns.c=0A=
> @@ -0,0 +1,342 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +/*=0A=
> + * NVMe ZNS-ZBD command implementation.=0A=
> + * Copyright (c) 2020-2021 HGST, a Western Digital Company.=0A=
> + */=0A=
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt=0A=
> +#include <linux/nvme.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +#include "nvmet.h"=0A=
> +=0A=
> +/*=0A=
> + * We set the Memory Page Size Minimum (MPSMIN) for target controller to=
 0=0A=
> + * which gets added by 12 in the nvme_enable_ctrl() which results in 2^1=
2 =3D 4k=0A=
> + * as page_shift value. When calculating the ZASL use shift by 12.=0A=
> + */=0A=
> +#define NVMET_MPSMIN_SHIFT	12=0A=
> +=0A=
> +static u16 nvmet_bdev_zns_checks(struct nvmet_req *req)=0A=
> +{=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +=0A=
> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.zra !=3D NVME_ZRA_ZONE_REPORT) {=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.zrasf !=3D NVME_ZRASF_ZONE_REPORT_ALL) {=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (req->cmd->zmr.pr !=3D NVME_REPORT_ZONE_PARTIAL)=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +=0A=
> +out:=0A=
> +	return status;=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + *  ZNS related command implementation and helpers.=0A=
> + */=0A=
> +=0A=
> +static inline u8 nvmet_zasl(unsigned int zone_append_sects)=0A=
> +{=0A=
> +	/*=0A=
> +	 * Zone Append Size Limit is the value experessed in the units=0A=
> +	 * of minimum memory page size (i.e. 12) and is reported power of 2.=0A=
> +	 */=0A=
> +	return ilog2((zone_append_sects << 9) >> NVMET_MPSMIN_SHIFT);=0A=
> +}=0A=
> +=0A=
> +static inline bool nvmet_zns_update_zasl(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	struct request_queue *q =3D ns->bdev->bd_disk->queue;=0A=
> +	u8 zasl =3D nvmet_zasl(queue_max_zone_append_sectors(q));=0A=
> +=0A=
> +	if (ns->subsys->zasl)=0A=
> +		return ns->subsys->zasl < zasl ? false : true;=0A=
> +=0A=
> +	ns->subsys->zasl =3D zasl;=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +=0A=
> +static int nvmet_bdev_validate_zns_zones_cb(struct blk_zone *z,=0A=
> +					    unsigned int idx, void *data)=0A=
> +{=0A=
> +	if (z->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		return -EOPNOTSUPP;=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static bool nvmet_bdev_has_conv_zones(struct block_device *bdev)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	if (bdev->bd_disk->queue->conv_zones_bitmap)=0A=
> +		return true;=0A=
> +=0A=
> +	ret =3D blkdev_report_zones(bdev, 0, blkdev_nr_zones(bdev->bd_disk),=0A=
> +				  nvmet_bdev_validate_zns_zones_cb, NULL);=0A=
> +=0A=
> +	return ret < 0 ? true : false;=0A=
> +}=0A=
> +=0A=
> +bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	if (nvmet_bdev_has_conv_zones(ns->bdev))=0A=
> +		return false;=0A=
> +=0A=
> +	/*=0A=
> +	 * For ZBC and ZAC devices, writes into sequential zones must be aligne=
d=0A=
> +	 * to the device physical block size. So use this value as the logical=
=0A=
> +	 * block size to avoid errors.=0A=
> +	 */=0A=
> +	ns->blksize_shift =3D blksize_bits(bdev_physical_block_size(ns->bdev));=
=0A=
> +=0A=
> +	if (!nvmet_zns_update_zasl(ns))=0A=
> +		return false;=0A=
> +=0A=
> +	return !(get_capacity(ns->bdev->bd_disk) &=0A=
> +			(bdev_zone_sectors(ns->bdev) - 1));=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * ZNS related Admin and I/O command handlers.=0A=
> + */=0A=
> +void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)=0A=
> +{=0A=
> +	u8 zasl =3D req->sq->ctrl->subsys->zasl;=0A=
> +	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;=0A=
> +	struct nvme_id_ctrl_zns *id;=0A=
> +	u16 status;=0A=
> +=0A=
> +	id =3D kzalloc(sizeof(*id), GFP_KERNEL);=0A=
> +	if (!id) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (ctrl->ops->get_mdts)=0A=
> +		id->zasl =3D min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);=0A=
> +	else=0A=
> +		id->zasl =3D zasl;=0A=
> +=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, id, sizeof(*id));=0A=
> +=0A=
> +	kfree(id);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)=0A=
> +{=0A=
> +	struct nvme_id_ns_zns *id_zns;=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	u64 zsze;=0A=
> +=0A=
> +	if (le32_to_cpu(req->cmd->identify.nsid) =3D=3D NVME_NSID_ALL) {=0A=
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	id_zns =3D kzalloc(sizeof(*id_zns), GFP_KERNEL);=0A=
> +	if (!id_zns) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	req->ns =3D nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid=
);=0A=
> +	if (!req->ns) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto done;=0A=
> +	}=0A=
> +=0A=
> +	if (!bdev_is_zoned(req->ns->bdev)) {=0A=
> +		req->error_loc =3D offsetof(struct nvme_identify, nsid);=0A=
> +		status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +		goto done;=0A=
> +	}=0A=
> +=0A=
> +	nvmet_ns_revalidate(req->ns);=0A=
> +	zsze =3D (bdev_zone_sectors(req->ns->bdev) << 9) >>=0A=
> +					req->ns->blksize_shift;=0A=
> +	id_zns->lbafe[0].zsze =3D cpu_to_le64(zsze);=0A=
> +	id_zns->mor =3D cpu_to_le32(bdev_max_open_zones(req->ns->bdev));=0A=
> +	id_zns->mar =3D cpu_to_le32(bdev_max_active_zones(req->ns->bdev));=0A=
> +=0A=
> +done:=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));=0A=
> +	kfree(id_zns);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +struct nvmet_report_zone_data {=0A=
> +	struct nvmet_ns *ns;=0A=
> +	struct nvme_zone_report *rz;=0A=
> +};=0A=
> +=0A=
> +static int nvmet_bdev_report_zone_cb(struct blk_zone *z, unsigned int id=
x,=0A=
> +				     void *data)=0A=
> +{=0A=
> +	struct nvmet_report_zone_data *report_zone_data =3D data;=0A=
> +	struct nvme_zone_descriptor *entries =3D report_zone_data->rz->entries;=
=0A=
> +	struct nvmet_ns *ns =3D report_zone_data->ns;=0A=
> +=0A=
> +	entries[idx].zcap =3D nvmet_sect_to_lba(ns, z->capacity);=0A=
> +	entries[idx].zslba =3D nvmet_sect_to_lba(ns, z->start);=0A=
> +	entries[idx].wp =3D nvmet_sect_to_lba(ns, z->wp);=0A=
> +	entries[idx].za =3D z->reset ? 1 << 2 : 0;=0A=
> +	entries[idx].zt =3D z->type;=0A=
> +	entries[idx].zs =3D z->cond << 4;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);=0A=
> +	u32 bufsize =3D (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;=0A=
> +	struct nvmet_report_zone_data data =3D { .ns =3D req->ns };=0A=
> +	unsigned int nr_zones;=0A=
> +	int reported_zones;=0A=
> +	u16 status;=0A=
> +=0A=
> +	nr_zones =3D (bufsize - sizeof(struct nvme_zone_report)) /=0A=
> +			sizeof(struct nvme_zone_descriptor);=0A=
=0A=
You could move this right before the vmalloc call since it is first used th=
ere.=0A=
=0A=
> +=0A=
> +	status =3D nvmet_bdev_zns_checks(req);=0A=
> +	if (status)=0A=
> +		goto out;=0A=
> +=0A=
> +	data.rz =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO)=
;=0A=
> +	if (!data.rz) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	reported_zones =3D blkdev_report_zones(req->ns->bdev, sect, nr_zones,=
=0A=
> +					     nvmet_bdev_report_zone_cb,=0A=
> +					     &data);=0A=
> +	if (reported_zones < 0) {=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +		goto out_free_report_zones;=0A=
> +	}=0A=
> +=0A=
> +	data.rz->nr_zones =3D cpu_to_le64(reported_zones);=0A=
> +=0A=
> +	status =3D nvmet_copy_to_sgl(req, 0, data.rz, bufsize);=0A=
> +=0A=
> +out_free_report_zones:=0A=
> +	kvfree(data.rz);=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->zms.slba);=0A=
> +	sector_t nr_sect =3D bdev_zone_sectors(req->ns->bdev);=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	enum req_opf op;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (req->cmd->zms.select_all)=0A=
> +		nr_sect =3D get_capacity(req->ns->bdev->bd_disk);=0A=
> +=0A=
> +	switch (req->cmd->zms.zsa) {=0A=
> +	case NVME_ZONE_OPEN:=0A=
> +		op =3D REQ_OP_ZONE_OPEN;=0A=
> +		break;=0A=
> +	case NVME_ZONE_CLOSE:=0A=
> +		op =3D REQ_OP_ZONE_CLOSE;=0A=
> +		break;=0A=
> +	case NVME_ZONE_FINISH:=0A=
> +		op =3D REQ_OP_ZONE_FINISH;=0A=
> +		break;=0A=
> +	case NVME_ZONE_RESET:=0A=
> +		op =3D REQ_OP_ZONE_RESET;=0A=
> +		break;=0A=
> +	default:=0A=
> +		status =3D NVME_SC_INVALID_FIELD;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D blkdev_zone_mgmt(req->ns->bdev, op, sect, nr_sect, GFP_KERNEL);=
=0A=
> +	if (ret)=0A=
> +		status =3D NVME_SC_INTERNAL;=0A=
> +out:=0A=
> +	nvmet_req_complete(req, status);=0A=
> +}=0A=
> +=0A=
> +void nvmet_bdev_execute_zone_append(struct nvmet_req *req)=0A=
> +{=0A=
> +	sector_t sect =3D nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);=0A=
> +	struct request_queue *q =3D req->ns->bdev->bd_disk->queue;=0A=
> +	unsigned int max_sects =3D queue_max_zone_append_sectors(q);=0A=
> +	u16 status =3D NVME_SC_SUCCESS;=0A=
> +	unsigned int total_len =3D 0;=0A=
> +	struct scatterlist *sg;=0A=
> +	int ret =3D 0, sg_cnt;=0A=
> +	struct bio *bio;=0A=
> +=0A=
> +	if (!nvmet_check_transfer_len(req, nvmet_rw_data_len(req)))=0A=
> +		return;=0A=
> +=0A=
> +	if (!req->sg_cnt) {=0A=
> +		nvmet_req_complete(req, 0);=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (req->transfer_len <=3D NVMET_MAX_INLINE_DATA_LEN) {=0A=
> +		bio =3D &req->b.inline_bio;=0A=
> +		bio_init(bio, req->inline_bvec, ARRAY_SIZE(req->inline_bvec));=0A=
> +	} else {=0A=
> +		bio =3D bio_alloc(GFP_KERNEL, req->sg_cnt);=0A=
> +	}=0A=
> +=0A=
> +	bio_set_dev(bio, req->ns->bdev);=0A=
> +	bio->bi_iter.bi_sector =3D sect;=0A=
> +	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
> +	if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))=0A=
> +		bio->bi_opf |=3D REQ_FUA;=0A=
> +=0A=
> +	for_each_sg(req->sg, sg, req->sg_cnt, sg_cnt) {=0A=
> +		struct page *p =3D sg_page(sg);=0A=
> +		unsigned int l =3D sg->length;=0A=
> +		unsigned int o =3D sg->offset;=0A=
> +		bool same_page =3D false;=0A=
> +=0A=
> +		ret =3D bio_add_hw_page(q, bio, p, l, o, max_sects, &same_page);=0A=
> +		if (ret !=3D sg->length) {=0A=
> +			status =3D NVME_SC_INTERNAL;=0A=
> +			goto out_bio_put;=0A=
> +		}=0A=
> +		if (same_page)=0A=
> +			put_page(p);=0A=
> +=0A=
> +		total_len +=3D sg->length;=0A=
> +	}=0A=
> +=0A=
> +	if (total_len !=3D nvmet_rw_data_len(req)) {=0A=
> +		status =3D NVME_SC_INTERNAL | NVME_SC_DNR;=0A=
> +		goto out_bio_put;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +	req->cqe->result.u64 =3D nvmet_sect_to_lba(req->ns,=0A=
> +						 bio->bi_iter.bi_sector);=0A=
> +=0A=
> +out_bio_put:=0A=
> +	if (bio !=3D &req->b.inline_bio)=0A=
> +		bio_put(bio);=0A=
> +	nvmet_req_complete(req, ret < 0 ? NVME_SC_INTERNAL : status);=0A=
> +}=0A=
=0A=
Wasn't it the plan to integrate this function into the normal read-write=0A=
proccessing ? I remember Christoph commenting on that.=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
