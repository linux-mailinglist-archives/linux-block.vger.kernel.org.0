Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED62F2901
	for <lists+linux-block@lfdr.de>; Tue, 12 Jan 2021 08:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbhALHfp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jan 2021 02:35:45 -0500
Received: from verein.lst.de ([213.95.11.211]:54172 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhALHfp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 02:35:45 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96D3767373; Tue, 12 Jan 2021 08:35:03 +0100 (CET)
Date:   Tue, 12 Jan 2021 08:35:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 8/9] nvmet: add common I/O length check helper
Message-ID: <20210112073503.GC24288@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-9-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I can't say I like this helper.  The semantics are a little confusing,
not helped by the name.
