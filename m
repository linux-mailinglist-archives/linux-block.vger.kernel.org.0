Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0021111AA51
	for <lists+linux-block@lfdr.de>; Wed, 11 Dec 2019 12:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLKL4O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Dec 2019 06:56:14 -0500
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:20935 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKL4N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 06:56:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576065373;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x+mOS5NASMRzp3pD2IpuENxWuCCrbFLiS87vKIsLe/U=;
  b=hDcocNtecQuI4L4BLPGOP+KrDWbmDJ9M2ZgK+C2AJybIfDr+aRZfdqRy
   XQJZRRFM1oIImO/OLc5ofPgIOAzb3/07YJWKl4LufwuJpQkE/FkTLkJVL
   0snG9YvCLMTdtup86CTY3zUfg0AgM/zgmhlkmRS4ZUtJu/L2ruAwBmtjr
   g=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: YA8PlSwaIQJsapTXNoWtgaI8GoZmb2RIdgt2QMy2CcTvDuGW4n1JrXzz6WMJUo6uwpHVUeZVek
 17D58EKrVRRybk1Qg9oW9Z+mDb8Feenq91lvB9ROCrgGdEPsdAMM9xEql1q0kRR2hdaunVvbPO
 pBvTCI2R4AlibRPiRdl7mC2rOrKW5T1Rw+PuTomAFES+jWAz1xr327+SBothLRVlAsl8WBxq9c
 8IX+y6ZePZF+6tAayYDrmqntYpAlZz2Zb/hh8JoBuWIp7RxdXwSd45mdTMOCOoIRi2JYYnRszX
 P2c=
X-SBRS: 2.7
X-MesageID: 9646652
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9646652"
Date:   Wed, 11 Dec 2019 12:56:06 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        "SeongJae Park" <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/3] xen/blkback: Remove unnecessary static variable
 name prefixes
Message-ID: <20191211115606.GO980@Air-de-Roger>
References: <20191211042428.5961-1-sjpark@amazon.de>
 <20191211042733.6143-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191211042733.6143-1-sjpark@amazon.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 04:27:33AM +0000, SeongJae Park wrote:
> A few of static variables in blkback have 'xen_blkif_' prefix, though it
> is unnecessary for static variables.  This commit removes such prefixes.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Thanks.

Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
