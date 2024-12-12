Return-Path: <linux-block+bounces-15277-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0D99EE7D9
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 14:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5D616716E
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 13:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731CF215178;
	Thu, 12 Dec 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="t0mcP4JG"
X-Original-To: linux-block@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3C2135BE
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010792; cv=none; b=V4eHn04Bhc+diqdjTTvXO8+I5pWWPMY1Mmjc1f5R9HT4gj6zkXuvbeAYDJrNbO5Z7vXKMgHYsafqp2c1+9AaHSaqsV0/U9bgKNY44wGKpJ9MVZPabNXTx0v15doOm+QfzlP4PDXZ1SvBCnXWO90Q8mz+hbX8UJg1w5sEx+OoxqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010792; c=relaxed/simple;
	bh=9Mx+wakWh59QVSPolqX2ZOXUvKB4IIWdPTof/zgmp/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abzziRW5XpfwscCSa6GZzMyiIkhD8ctOj1OzFW+f4OdbIru3AicCWBSwx5OHOqiqtuT0up6SXzBcYe7MJrAhC87OEaNhUCw2oswh0acvwq75bCkUhJDyiMFCTpJvYZEpjGVt1j6M8Kh47ltajTe/Ivt0suWJurueYsHnNgNekVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=t0mcP4JG; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010788;
	bh=drZPh5V15P2Ut5u+90AJAcXYqSdhgaQY4p1DaIP3Gsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=t0mcP4JGt+yQ5RIycZNX54R/zpiXhnN3cFQSmIEslGfRMlL2ucoUef8dqNWHJ7Q0D
	 U/xcFsUold8C28e25OD2i2Y+wLtQJF3fIKTdk7inhTxGjLOCRg6znSLXDKBRsL1R31
	 1TieTEqpOh/6OiRmcCiVcChK6pY6n9t4govLxq0Jsm/2LTWrDfneMCpAVEP9PcY7pT
	 D22Btm6TxwCOri0GPuTufOgCaYfUMMSp1cM5C/kBWhTHptFK1X3+lnhxCVQKyZvYfq
	 gxg7ZNQUdfikIN01XOvv4vPwFA2Z6YGIb6vMAZoSImlDIOn/Srcmpxlq1j/lsYnr85
	 oUSe0/idXeNaA==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id D2F97CC0336;
	Thu, 12 Dec 2024 13:39:39 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:39 +0800
Subject: [PATCH v3 3/9] driver core: bus: Move true expression out of if
 condition in API bus_find_device()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-3-04e20c4f0971@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
In-Reply-To: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: fb8vrTNNLQpsaNJsFTCK1_4fTmMz000u
X-Proofpoint-ORIG-GUID: fb8vrTNNLQpsaNJsFTCK1_4fTmMz000u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For bus_find_device(), get_device() in the if condition always returns
true, move it to if body to make the API's logic more clearer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/bus.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 657c93c38b0dc2a2247e5f482fadd3a9376a58e8..73a56f376d3a05962ce0931a2fe8b4d8839157f2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -402,9 +402,12 @@ struct device *bus_find_device(const struct bus_type *bus,
 
 	klist_iter_init_node(&sp->klist_devices, &i,
 			     (start ? &start->p->knode_bus : NULL));
-	while ((dev = next_device(&i)))
-		if (match(dev, data) && get_device(dev))
+	while ((dev = next_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
 			break;
+		}
+	}
 	klist_iter_exit(&i);
 	subsys_put(sp);
 	return dev;

-- 
2.34.1


