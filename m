Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967BB1E769F
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 09:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgE2H2O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 03:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgE2H2N (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 03:28:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7DFCCAC24;
        Fri, 29 May 2020 07:28:12 +0000 (UTC)
Date:   Fri, 29 May 2020 09:28:11 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200529072811.lmafd7db3gmoyxee@beryllium.lan>
References: <20200528153441.3501777-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528153441.3501777-1-kbusch@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 08:34:40AM -0700, Keith Busch wrote:
> For when drivers have a need to bypass error injection.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
