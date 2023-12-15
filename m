Return-Path: <linux-block+bounces-1151-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403181410A
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 05:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2E2283F7E
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 04:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7861C13;
	Fri, 15 Dec 2023 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUjEIToi"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C541C31
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=UUjEIToiXBvG9TEbECOAYxMjG4
	eK72yFK1azEQTivS7AMdLzV8LUkNbW44AuRezRBH+hoz31xN9lknTDrKDOV8Pm/IonQORF8CQ3eoa
	76ZlfvOHUKEi5vhPo+RwbWQ4RPF4EzNKAyMQG3ClcbNSAqJJbjr8RPRzlicfy305EEIZz4K50KUXf
	pEQNI95Vl74QGmvu/dY9oxQj1j0gjmcMsANhWFqvbfpXnH9C+GRSjOhoTeHgWwgu5pBjvPhWlTgdC
	i95w9p7Gs7sIlSoAWt/e+Y5lgNcbBQxovKtAZ/Ke0N/YeNAB7Gwt0/ku0j1u9J2NbK1UgQu0xF7Dt
	yq3m7npQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rE0Az-0020pt-0M;
	Fri, 15 Dec 2023 04:51:53 +0000
Date: Thu, 14 Dec 2023 20:51:53 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: improve struct request_queue layout
Message-ID: <ZXvbaThP+31xP2tV@infradead.org>
References: <d2b7b61c-4868-45c0-9060-4f9c73de9d7e@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2b7b61c-4868-45c0-9060-4f9c73de9d7e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

