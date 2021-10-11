Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06044287BA
	for <lists+linux-block@lfdr.de>; Mon, 11 Oct 2021 09:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhJKHh7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Oct 2021 03:37:59 -0400
Received: from verein.lst.de ([213.95.11.211]:36161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231974AbhJKHh6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 03:37:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C8AF568AFE; Mon, 11 Oct 2021 09:35:56 +0200 (CEST)
Date:   Mon, 11 Oct 2021 09:35:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, paskripkin@gmail.com,
        "Yan, Zheng" <yanzheng03@kuaishou.com>
Subject: Re: [PATCH v2] block: nbd: fix sanity check for first_minor
Message-ID: <20211011073556.GA10735@lst.de>
References: <20211011024509.2012-1-ukernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011024509.2012-1-ukernel@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 11, 2021 at 10:45:09AM +0800, Yan, Zheng wrote:
> From: "Yan, Zheng" <yanzheng03@kuaishou.com>
> 
> Device's minor is a 20-bits number, max value is 0xfffff.

I'd just drop this check again now that we do have proper error
handling in add_disk.
