Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2D3113E8E
	for <lists+linux-block@lfdr.de>; Thu,  5 Dec 2019 10:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfLEJwn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Dec 2019 04:52:43 -0500
Received: from verein.lst.de ([213.95.11.211]:54325 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfLEJwn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Dec 2019 04:52:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id A670668B05; Thu,  5 Dec 2019 10:52:40 +0100 (CET)
Date:   Thu, 5 Dec 2019 10:52:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Justin Tee <justin.tee@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix memleak of bio integrity data
Message-ID: <20191205095240.GA21803@lst.de>
References: <20191205020901.18737-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205020901.18737-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
