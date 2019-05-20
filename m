Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D9623215
	for <lists+linux-block@lfdr.de>; Mon, 20 May 2019 13:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732504AbfETLRg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 May 2019 07:17:36 -0400
Received: from verein.lst.de ([213.95.11.211]:51590 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfETLRg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 07:17:36 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1348068B05; Mon, 20 May 2019 13:17:15 +0200 (CEST)
Date:   Mon, 20 May 2019 13:17:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190520111714.GA5369@lst.de>
References: <20190516084058.20678-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516084058.20678-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

is this ok for 5.2?  If not we need to hack around the sector
accounting in nvme, and possibly virtio.
