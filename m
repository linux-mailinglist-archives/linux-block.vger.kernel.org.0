Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9941C55D1
	for <lists+linux-block@lfdr.de>; Tue,  5 May 2020 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEEMnN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 May 2020 08:43:13 -0400
Received: from verein.lst.de ([213.95.11.211]:35163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbgEEMnM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 May 2020 08:43:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 135E768C4E; Tue,  5 May 2020 14:43:08 +0200 (CEST)
Date:   Tue, 5 May 2020 14:43:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] hfs: stop using ioctl_by_bdev
Message-ID: <20200505124308.GA26266@lst.de>
References: <20200504135927.2835750-1-hch@lst.de> <20200504135927.2835750-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504135927.2835750-6-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,

can you pick up this patch as well?  I forgot about hfs earlier and this
was only added to the most recent resend.  The changes are identical to
those in hfsplus.
