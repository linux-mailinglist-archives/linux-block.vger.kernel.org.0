Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442163EA1C1
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 11:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbhHLJRI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 05:17:08 -0400
Received: from verein.lst.de ([213.95.11.211]:43585 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235954AbhHLJRG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 05:17:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5AB5667373; Thu, 12 Aug 2021 11:16:39 +0200 (CEST)
Date:   Thu, 12 Aug 2021 11:16:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
Message-ID: <20210812091639.GA4695@lst.de>
References: <20210812091501.22648-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812091501.22648-1-paskripkin@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
