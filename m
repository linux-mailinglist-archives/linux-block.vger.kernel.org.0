Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BF22CAC73
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 20:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392298AbgLATfu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 14:35:50 -0500
Received: from verein.lst.de ([213.95.11.211]:51111 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387432AbgLATfu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Dec 2020 14:35:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5F8E067373; Tue,  1 Dec 2020 20:35:07 +0100 (CET)
Date:   Tue, 1 Dec 2020 20:35:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        joshi.k@samsung.com, k.jensen@samsung.com, Niklas.Cassel@wdc.com,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [V5] nvme: enable ro namespace for ZNS without append
Message-ID: <20201201193507.GA3171@lst.de>
References: <20201201120221.29279-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201120221.29279-1-javier.gonz@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied to nvme-5.11 after fixing a bunch of overly long lines and
removing the changelog from the commit log.
