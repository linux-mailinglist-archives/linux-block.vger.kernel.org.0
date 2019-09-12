Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32852B0A0F
	for <lists+linux-block@lfdr.de>; Thu, 12 Sep 2019 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfILIUL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Sep 2019 04:20:11 -0400
Received: from verein.lst.de ([213.95.11.211]:45257 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfILIUL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 04:20:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EDB0B227A81; Thu, 12 Sep 2019 10:20:08 +0200 (CEST)
Date:   Thu, 12 Sep 2019 10:20:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Gopal Tiwari <gtiwari@redhat.com>, dmilburn@redhat.com
Subject: Re: [PATCH 10/15] nvme-pci: do not build a scatterlist to map
 metadata
Message-ID: <20190912082008.GC14283@lst.de>
References: <20190321231037.25104-1-hch@lst.de> <20190321231037.25104-11-hch@lst.de> <20190828092057.GA15524@ming.t460p> <20190912010256.GB2731@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912010256.GB2731@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in my todo queue, which is big..
