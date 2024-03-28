Return-Path: <linux-block+bounces-4104-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE0872FB9
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 08:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89F91C24A4E
	for <lists+linux-block@lfdr.de>; Wed,  6 Mar 2024 07:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741B179BF;
	Wed,  6 Mar 2024 07:33:02 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C5E5CDCC
	for <linux-block@vger.kernel.org>; Wed,  6 Mar 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710382; cv=none; b=NLhH1M5pYSX8QQib46HMG2s0slLqkTVR7p8WVmhCO6zKvU0Mw/agMGn+3e26F3epc5rOLL1ufCQoB1S/LB2riL1y1ONmMysf5OazXEwPiA7NQey9zvvCS6RF/No6pcQTh1Wtue91wdCujS2hrVB2v6Sv64e6pT2xe1xfo9puso0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710382; c=relaxed/simple;
	bh=cLInQDVMZTj/TRvrVUxK3BV4HHYY/+2PdbjgF+Wk5CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spAKbyW2s2I6Id2lSVzGVS6q0EuMD8LtmTV3rQv1j4YH6t7YOyO4OkDUDtlsemDA1eEwNxfLBSX/PFOan0reZZrlg4XvroI0ow5d7w2n9gIQt0X8d5b5nHSEHytI4M1ZWmv6zHS5qisWsShdQh0pStOArd+rFoQGXmNJSb4mwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rhllH-0000M9-Dp; Wed, 06 Mar 2024 08:32:23 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rhllF-004hY8-2M; Wed, 06 Mar 2024 08:32:21 +0100
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1rhllE-004oYv-35;
	Wed, 06 Mar 2024 08:32:20 +0100
Date: Wed, 6 Mar 2024 08:32:20 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	Thomas =?iso-8859-15?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Hannes Reinecke <hare@suse.de>,
	Christian Loehle <CLoehle@hyperstone.com>,
	Avri Altman <avri.altman@wdc.com>, Bean Huo <beanhuo@micron.com>,
	Yeqi Fu <asuk4.q@gmail.com>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	Diping Zhang <diping.zhang@gl-inet.com>,
	Jianhui Zhao <zhaojh329@gmail.com>,
	Jieying Zeng <jieying.zeng@gl-inet.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	Adam Fox <adam.fox@adtran.com>, John Crispin <john@phrozen.org>
Subject: Re: [RFC PATCH v2 1/8] dt-bindings: block: add basic bindings for
 block devices
Message-ID: <ZegcBGE2xp-oUL2q@pengutronix.de>
References: <cover.1709667858.git.daniel@makrotopia.org>
 <f70bb480aef6f55228a25ce20ff0e88e670e1b70.1709667858.git.daniel@makrotopia.org>
 <ZegZ0zJ1OT7ikrE8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZegZ0zJ1OT7ikrE8@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-block@vger.kernel.org

On Wed, Mar 06, 2024 at 08:22:59AM +0100, Sascha Hauer wrote:
> Hi Daniel,
> 
> On Tue, Mar 05, 2024 at 08:23:20PM +0000, Daniel Golle wrote:
> > diff --git a/Documentation/devicetree/bindings/block/partition.yaml b/Documentation/devicetree/bindings/block/partition.yaml
> > new file mode 100644
> > index 0000000000000..df561dd33cbc9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/block/partition.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/block/partition.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Partition on a block device
> > +
> > +description: |
> > +  This binding describes a partition on a block storage device.
> > +  Partitions may be matched by a combination of partition number, name,
> > +  and UUID.
> > +
> > +maintainers:
> > +  - Daniel Golle <daniel@makrotopia.org>
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: '^block-partition-.+$'
> > +
> > +  partnum:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Matches partition by number if present.
> > +
> > +  partname:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description:
> > +      Matches partition by PARTNAME if present.
> 
> In the mtd world we originally had the partition nodes directly under
> the hardware device node as well. That was changed to put a
> partitions subnode between the hardware device node and the partitions.
> 
> From fe2585e9c29a ("doc: dt: mtd: support partitions in a special
> 'partitions' subnode"):
> 
>     To avoid conflict with other drivers using subnodes of the mtd device
>     create only one ofpart-specific node rather than any number of
>     arbitrary partition subnodes.
> 
> Does it make sense to do the same for block devices?

Hm, looking at the example in 5/8 it seems you've already done that. I
think I have misread the binding.

Sascha


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

