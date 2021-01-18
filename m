Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0220C2FA897
	for <lists+linux-block@lfdr.de>; Mon, 18 Jan 2021 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407392AbhARSU0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jan 2021 13:20:26 -0500
Received: from verein.lst.de ([213.95.11.211]:49135 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393198AbhARSUZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 13:20:25 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36D0B6736F; Mon, 18 Jan 2021 19:19:43 +0100 (CET)
Date:   Mon, 18 Jan 2021 19:19:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, damien.lemoal@wdc.com
Subject: Re: [PATCH V9 2/9] nvmet: add lba to sect conversion helpers
Message-ID: <20210118181942.GA11082@lst.de>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com> <20210112042623.6316-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112042623.6316-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Applied to nvme-5.12.
