Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D01366E06
	for <lists+linux-block@lfdr.de>; Wed, 21 Apr 2021 16:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhDUOWr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Apr 2021 10:22:47 -0400
Received: from verein.lst.de ([213.95.11.211]:54833 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235421AbhDUOWr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Apr 2021 10:22:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32B6C67373; Wed, 21 Apr 2021 16:22:10 +0200 (CEST)
Date:   Wed, 21 Apr 2021 16:22:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] ataflop: potential out of bounds in do_format()
Message-ID: <20210421142209.GA29072@lst.de>
References: <YH/7+65JruUO/wsg@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH/7+65JruUO/wsg@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
