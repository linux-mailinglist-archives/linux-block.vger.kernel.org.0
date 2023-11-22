Return-Path: <linux-block+bounces-373-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BCE7F3ED3
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 08:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75B3280EE3
	for <lists+linux-block@lfdr.de>; Wed, 22 Nov 2023 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5E1C298;
	Wed, 22 Nov 2023 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bak1w5nm"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3312C;
	Tue, 21 Nov 2023 23:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bak1w5nmTqdapVHUeSibvY0xrs
	OlQyOW/ViYQDVXErcrqszBMwuSPgWgHpP69c3vDSYbXqkU0MYp/PpcLf2o8L9lqQMkWccOg0eBBhz
	I6WEmC44Gu9TfE/WfkjC9qvUy0gKMTRM/uU/hGL4viYxwWTV+dUAXFPHSS8Gju1DpaMadabZZW+1i
	FEndiipvl3BL3kjDCGs6FxYbEwZcN612+CpqOYAU0yGQRb0cMYWI3MeikHgy+uL9kezd/QfIrJpTH
	B8RUwnlGPzXexFIJNFCTc4yA1zWgNeTM/kniZ89jvNogtUY4BNRsBGiJCO43zY7X8C0V6vTE69/ZF
	TjDDCmOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r5ha9-000tul-2L;
	Wed, 22 Nov 2023 07:23:33 +0000
Date: Tue, 21 Nov 2023 23:23:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 1/3] block: move .bd_inode into 1st cacheline of
 block_device
Message-ID: <ZV2sdZjvqPXH5T9f@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122103103.1104589-2-yukuai1@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

