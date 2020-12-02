Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90F2CB82F
	for <lists+linux-block@lfdr.de>; Wed,  2 Dec 2020 10:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgLBJKJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Dec 2020 04:10:09 -0500
Received: from verein.lst.de ([213.95.11.211]:53056 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387891AbgLBJKI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 04:10:08 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 10DAD68AFE; Wed,  2 Dec 2020 10:09:27 +0100 (CET)
Date:   Wed, 2 Dec 2020 10:09:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, damien.lemoal@wdc.com,
        johannes.thumshirn@wdc.com
Subject: Re: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Message-ID: <20201202090926.GC2952@lst.de>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com> <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As mentioned before CSI support is a feature independen of ZNS and should
be supported on all controllers, and in a separate prep patch.
