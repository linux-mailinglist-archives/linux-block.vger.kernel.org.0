Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D01D163F
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 15:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbgEMNpq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 09:45:46 -0400
Received: from verein.lst.de ([213.95.11.211]:46637 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgEMNpq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:45:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7FC7A68BEB; Wed, 13 May 2020 15:45:43 +0200 (CEST)
Date:   Wed, 13 May 2020 15:45:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/11] loop: Remove sector_t truncation checks
Message-ID: <20200513134543.GA12367@lst.de>
References: <20200513133845.244903-1-maco@android.com> <20200513133845.244903-3-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513133845.244903-3-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 13, 2020 at 03:38:36PM +0200, Martijn Coenen wrote:
> sector_t is now always u64, so we don't need to check for truncation.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
