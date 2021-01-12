Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86002F28E0
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 08:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbhALHZY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jan 2021 02:25:24 -0500
Received: from verein.lst.de ([213.95.11.211]:54134 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbhALHZX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:25:23 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 572A867373; Tue, 12 Jan 2021 08:24:41 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:24:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 1/9] block: export bio_add_hw_pages()
Message-ID: <20210112072441.GA24155@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

EXPORT_SYMBOL_GPL, please.
