Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C58F8A83
	for <lists+linux-block@lfdr.de>; Tue, 12 Nov 2019 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfKLIbd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Nov 2019 03:31:33 -0500
Received: from verein.lst.de ([213.95.11.211]:54437 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfKLIbd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 03:31:33 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ACA5B68AFE; Tue, 12 Nov 2019 09:31:30 +0100 (CET)
Date:   Tue, 12 Nov 2019 09:31:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Junichi Nomura <j-nomura@ce.jp.nec.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: check bi_size overflow before merge
Message-ID: <20191112083130.GA4514@lst.de>
References: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
