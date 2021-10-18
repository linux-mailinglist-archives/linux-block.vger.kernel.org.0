Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF339431637
	for <lists+linux-block@lfdr.de>; Mon, 18 Oct 2021 12:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJRKhV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Oct 2021 06:37:21 -0400
Received: from verein.lst.de ([213.95.11.211]:33309 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229473AbhJRKhU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:37:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 244EC68AFE; Mon, 18 Oct 2021 12:35:07 +0200 (CEST)
Date:   Mon, 18 Oct 2021 12:35:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, willy@infradead.org,
        sunhao.th@gmail.com, hch@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: fix incorrect references to disk objects
Message-ID: <20211018103506.GA8624@lst.de>
References: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
