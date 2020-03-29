Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B072196D34
	for <lists+linux-block@lfdr.de>; Sun, 29 Mar 2020 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgC2MKe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 29 Mar 2020 08:10:34 -0400
Received: from verein.lst.de ([213.95.11.211]:58329 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgC2MKe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Mar 2020 08:10:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BB3D68C4E; Sun, 29 Mar 2020 14:10:32 +0200 (CEST)
Date:   Sun, 29 Mar 2020 14:10:32 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] block: return NULL in blk_alloc_queue() on error
Message-ID: <20200329121032.GB5324@lst.de>
References: <20200328182734.5585-1-chaitanya.kulkarni@wdc.com> <22e5e0bf-49db-03a8-d81f-00733f117765@cloud.ionos.com> <BYAPR04MB496593AEBF503ACC8DD6EFAE86CD0@BYAPR04MB4965.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB496593AEBF503ACC8DD6EFAE86CD0@BYAPR04MB4965.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 11:42:17PM +0000, Chaitanya Kulkarni wrote:
> >> >@@ -555,7 +555,7 @@ struct request_queue *blk_alloc_queue(make_request_fn make_request, int node_id)
> >> >   	struct request_queue *q;
> >> >
> >> >   	if (WARN_ON_ONCE(!make_request))
> >> >-		return -EINVAL;
> >> >+		return NULL;
> > Maybe return ERR_PTR(-EINVAL) is better.
> >
> 
> Initially I used that, what if existing callers are reallying on
> NULL vs !NULL return value ? Use of NULL just makes the code
> consistent with existing return value.
> 
> If Jens is okay with ERR_PTR(), I'll send V2.

The callers can't handle an ERR_PTR, so v1 is correct.
