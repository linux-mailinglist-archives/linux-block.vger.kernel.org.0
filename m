Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFB2F28F7
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 08:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404085AbhALHd6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jan 2021 02:33:58 -0500
Received: from verein.lst.de ([213.95.11.211]:54162 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404075AbhALHd6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:33:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0525867373; Tue, 12 Jan 2021 08:33:16 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:33:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Message-ID: <20210112073315.GA24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm not a huge fan of this helper, especially as it sets an end_io
callback only for the allocated case, which is a weird calling
convention.
