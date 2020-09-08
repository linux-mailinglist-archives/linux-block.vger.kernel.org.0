Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D98261F50
	for <lists+linux-block@lfdr.de>; Tue,  8 Sep 2020 22:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgIHUBY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Sep 2020 16:01:24 -0400
Received: from verein.lst.de ([213.95.11.211]:53135 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgIHPfM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 43E6168C7B; Tue,  8 Sep 2020 16:27:18 +0200 (CEST)
Date:   Tue, 8 Sep 2020 16:27:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: improve the block queue sysfs helper macros
Message-ID: <20200908142718.GA7775@lst.de>
References: <20200903060701.229481-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903060701.229481-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 03, 2020 at 08:06:59AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series improves the macros to generate the queue sysfs boilerplate.

can you take a look at this series?  I have another pile sitting on top
of it waiting..
