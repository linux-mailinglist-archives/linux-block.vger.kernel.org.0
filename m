Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A092033F15B
	for <lists+linux-block@lfdr.de>; Wed, 17 Mar 2021 14:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCQNnD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Mar 2021 09:43:03 -0400
Received: from verein.lst.de ([213.95.11.211]:37322 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhCQNnB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 09:43:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E2CAC68BFE; Wed, 17 Mar 2021 14:42:59 +0100 (CET)
Date:   Wed, 17 Mar 2021 14:42:59 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove RQF_ALLOCED
Message-ID: <20210317134259.GA9958@lst.de>
References: <20210317072122.155380-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317072122.155380-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 17, 2021 at 08:21:22AM +0100, Christoph Hellwig wrote:
> This flag is not used anywhere.

Except that blk-mq-debugfs prints it in a completely obsfucated way.
Sight, I'll need to fix that mess while I'm at it.
