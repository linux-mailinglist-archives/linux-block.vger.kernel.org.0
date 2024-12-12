Return-Path: <linux-block+bounces-15278-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310D9EE7DC
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 14:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6981888A59
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2022153D8;
	Thu, 12 Dec 2024 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ujccATt5"
X-Original-To: linux-block@vger.kernel.org
Received: from st43p00im-ztfb10071701.me.com (st43p00im-ztfb10071701.me.com [17.58.63.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74636214804
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734010802; cv=none; b=fR92KrQqKIIhTUFPJTCL/kmkD9UQzcJ5YREbERhrgYRjg2mYzezEoIcAWdHDmOIl1DaZ8IuP+GZFyO1P6f2uGAxoAo2dASYg7J4Wy86yudDFSAlrDAzJ05zqnxTC7lObliY6ewf48N+37zDncJ3lVTIufLcMWDas0ktO4q6nm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734010802; c=relaxed/simple;
	bh=MpfYSOt0Ypq02pEOaoX882rZBpc3JH29gpuB0mSAjzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JFVjwxl8tWGoyYJ/9X1QiKwhIXngzGdOaPsQPttCBT+t2FGS074QqlDeI4BWZdN9DRQWu8NWT9LtQL7RjB3EjxiHhIcreFS9yrK3of6IpZWYHzDvYKN+AwjZom6L1MstfbeufAbg0gy6VR9UhZ9FRwTpVzEwEmaJqZxi5Fi4Buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ujccATt5; arc=none smtp.client-ip=17.58.63.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734010799;
	bh=T0BucTNeqdeFW4ea8vuRFEDfGvQqFsZrvBOQltEORx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=ujccATt573FQggCea4OwX3Tocp+1RtO3tS0Oh4PUc7Q7JkujjwQzJh/9A7PTYYMVG
	 OOS9PAx1c3FYi2JndNgWYumdSi6rgIa4BnxdjjpYUCUXbZvYE1ePdv14foMK+6HQ3I
	 +UvJPJi0jUlnqR+SPoU8wpu7xxcpzTmdjhkcdiM2cJ2EpouChekYEXT2u8/Dx7pxcJ
	 4wytEVG1qLm2UE7YucN3Z1wjJqktMNILdgN5XqKDsbFnxTyMXiWtI7NehHca1pjFka
	 7kjgDBJgLvOFsuQMIaxJTsY9BtPYEbYUD7pnRwkmCyvSvDL4HtY3fDz5xkrQBGsCZU
	 uqHG8yOrHwh1Q==
Received: from [192.168.1.26] (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id AC6CACC01A4;
	Thu, 12 Dec 2024 13:39:49 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 12 Dec 2024 21:38:40 +0800
Subject: [PATCH v3 4/9] driver core: Move true expression out of if
 condition in API driver_find_device()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-class_fix-v3-4-04e20c4f0971@quicinc.com>
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
X-Proofpoint-GUID: okDoNSfcrFTO1Uiyr0O5JhWQ4058QbKW
X-Proofpoint-ORIG-GUID: okDoNSfcrFTO1Uiyr0O5JhWQ4058QbKW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_09,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 mlxscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412120098
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

For driver_find_device(), get_device() in the if condition always returns
true, move it to if body to make the API's logic more clearer.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/driver.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index b4eb5b89c4ee7bc35458fc75730b16a6d1e804d3..6f033a741aa7ce6138d1c61e49e72b2a3eb85e06 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -160,9 +160,12 @@ struct device *driver_find_device(const struct device_driver *drv,
 
 	klist_iter_init_node(&drv->p->klist_devices, &i,
 			     (start ? &start->p->knode_driver : NULL));
-	while ((dev = next_device(&i)))
-		if (match(dev, data) && get_device(dev))
+	while ((dev = next_device(&i))) {
+		if (match(dev, data)) {
+			get_device(dev);
 			break;
+		}
+	}
 	klist_iter_exit(&i);
 	return dev;
 }

-- 
2.34.1


