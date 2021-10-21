Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F1A435BC3
	for <lists+linux-block@lfdr.de>; Thu, 21 Oct 2021 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhJUHfA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Oct 2021 03:35:00 -0400
Received: from verein.lst.de ([213.95.11.211]:45205 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhJUHe7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 03:34:59 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB3EF68BEB; Thu, 21 Oct 2021 09:32:41 +0200 (CEST)
Date:   Thu, 21 Oct 2021 09:32:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jackie Liu <liu.yun@linux.dev>
Cc:     axboe@kernel.dk, hch@lst.de, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: bdev: fix conflicting comment from lookup_bdev
Message-ID: <20211021073241.GA29460@lst.de>
References: <20211021071344.1600362-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021071344.1600362-1-liu.yun@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
