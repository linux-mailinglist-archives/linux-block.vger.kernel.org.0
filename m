Return-Path: <linux-block+bounces-685-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F78803BAF
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 18:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C342F1F211F4
	for <lists+linux-block@lfdr.de>; Mon,  4 Dec 2023 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C672E84E;
	Mon,  4 Dec 2023 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D5IqRq6U"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20436D42
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=licO8txLEFUxgmCn/0segrv+NOb5m55Lvlxso8w4B3s=; b=D5IqRq6U3bW7n+tliyeO7bFeo5
	bwlQa58ZA3C0dRp+NUENQ3Q5NM54NMZ4KRqqVoS0fiWdGawTnqD3xN4DkLQC/ZEQSBG75YrCR+cq2
	UyGs/kdNZDzqAGiCVi9FmXLbKznDZEPCdVCkFI+BnvGBAtKcW0cg+Hea++U7mnvpSGs7DgYRjJvJ5
	bO58gA72vKF0VtlS8F0HntZgfZF9iJmrvBq+TiivmGzOpIZ5QifZqwcgZmaDqE05mHFTAkVOww3ko
	G/DiiOEtmcmXrz4UFoCBo/BDt/fGhbEwnqC1tzYtFJlNOKFykpYCRm2FkbeBEeSMVjD98+z+SpH5N
	3Y4aoOxQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rACps-005Csn-1m;
	Mon, 04 Dec 2023 17:34:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: fix bio_add_hw_page for larger folios / compound pages
Date: Mon,  4 Dec 2023 18:34:17 +0100
Message-Id: <20231204173419.782378-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Jens,

bio_add_hw_page currently fails miserably when trying to add larger
contiguous ranges than support by the underlying hardware, a it
always adds everything or nothing.  That isn't really a problem yet
as there are no callers that actually pass anything where off + len
doesn't fit in a single page, but I've been working on code that
will, which immediately tripped it.

Diffstat:
 bio.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

