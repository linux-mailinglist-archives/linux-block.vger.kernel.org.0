Return-Path: <linux-block+bounces-242-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247F7EF3B2
	for <lists+linux-block@lfdr.de>; Fri, 17 Nov 2023 14:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43C391C20430
	for <lists+linux-block@lfdr.de>; Fri, 17 Nov 2023 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11DB328AF;
	Fri, 17 Nov 2023 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B355D50
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 05:26:56 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39F836732D; Fri, 17 Nov 2023 14:26:52 +0100 (CET)
Date: Fri, 17 Nov 2023 14:26:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-ID: <20231117132652.GA7867@lst.de>
References: <20231113035231.2708053-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113035231.2708053-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Only processing my travel back log now.  I obviously like the patch,
but given I only did a bunch of cleanups and a trivial fix, I think
this should have still been attributed to you.


