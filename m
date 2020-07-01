Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78564210484
	for <lists+linux-block@lfdr.de>; Wed,  1 Jul 2020 09:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGAHLi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jul 2020 03:11:38 -0400
Received: from verein.lst.de ([213.95.11.211]:38919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727847AbgGAHLh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 03:11:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EBE5868B02; Wed,  1 Jul 2020 09:11:35 +0200 (CEST)
Date:   Wed, 1 Jul 2020 09:11:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: remove not needed fields from struct block_device
Message-ID: <20200701071135.GA29425@lst.de>
References: <20200626080158.1998621-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Any more comments on this series?

On Fri, Jun 26, 2020 at 10:01:51AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series put struct block_device on a bit of a diet by removing
> fields that are unused or rather pointless.
---end quoted text---
