Return-Path: <linux-block+bounces-22457-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14650AD4B6A
	for <lists+linux-block@lfdr.de>; Wed, 11 Jun 2025 08:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C598618996F2
	for <lists+linux-block@lfdr.de>; Wed, 11 Jun 2025 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2183227E92;
	Wed, 11 Jun 2025 06:19:04 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD327455
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749622744; cv=none; b=bUvI06yD7AB/rmpOoQ9k+cU71z6bqK3ULKpNAcMgdL34M5U1wut3I8It72qrYKkjXeP1JP8/NCpFzzXe2zF7Q2UxUtz/Wu5odH1qW12fvZ5eKaUdbOpT5Pe+ZfzK9ANXz2RRa/lRDuFSdAx5JhZ4UZWPfTkTQASgnOYsgag6jI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749622744; c=relaxed/simple;
	bh=RSHT1oY/4SE0sxZXPri5fFvRULSQf3AGrCiatjoGsIE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=h0gbofbsAGNoVb0lIITvpDO3Evqr6djHaBkNWZnm79I7qeyDRl0qc+W3awSULojrR+3Qe5qC5dSC0ixkFqN6K0tf6M3LgrhcmRNkiu5TQTYJ7MXKJNgNv8mS+D3nFaDJstH8cUNvTiLqNMK5sD8m1ExVamAILSov55hwle56fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bHFq25bCBzKHMt5
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 14:18:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2699F1A1015
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 14:18:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB32l7MH0loV4+pPA--.61745S3;
	Wed, 11 Jun 2025 14:18:53 +0800 (CST)
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
To: Yi Zhang <yi.zhang@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
 <CAHj4cs9qZ2wGDJbrRhxbExfwjD1cwAZKO+rpt9-yxCfBCJtr=A@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <108eaabf-e9df-ace6-3bc9-62925b0915ac@huaweicloud.com>
Date: Wed, 11 Jun 2025 14:18:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9qZ2wGDJbrRhxbExfwjD1cwAZKO+rpt9-yxCfBCJtr=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB32l7MH0loV4+pPA--.61745S3
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYk7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0
	xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_JF
	0_Jw1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYDGYDUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/06/11 8:05, Yi Zhang 写道:
> Unfortunately, the issue still can be reproduced with the change.

Thanks for the test, looks like the problem is not related to
unbalanced nvme_mpath_{start, end}_request, I'll try if I can reporduce
it in my VM.

Kuai


