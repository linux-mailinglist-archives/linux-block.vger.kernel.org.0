Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2357D2C
	for <lists+linux-block@lfdr.de>; Thu, 27 Jun 2019 09:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfF0HcE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Jun 2019 03:32:04 -0400
Received: from verein.lst.de ([213.95.11.211]:50216 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfF0HcE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 03:32:04 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E808768B20; Thu, 27 Jun 2019 09:31:32 +0200 (CEST)
Date:   Thu, 27 Jun 2019 09:31:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: Remove unused code
Message-ID: <20190627073132.GA10007@lst.de>
References: <20190627025941.32262-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627025941.32262-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

The function has been unused going back to at least Linux 3.15.
