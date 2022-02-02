Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C54A72C4
	for <lists+linux-block@lfdr.de>; Wed,  2 Feb 2022 15:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244926AbiBBOML (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Feb 2022 09:12:11 -0500
Received: from verein.lst.de ([213.95.11.211]:34252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237388AbiBBOMK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Feb 2022 09:12:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B4DBF68AFE; Wed,  2 Feb 2022 15:12:07 +0100 (CET)
Date:   Wed, 2 Feb 2022 15:12:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH] block: fix DIO handling regressions in
 blkdev_read_iter()
Message-ID: <20220202141207.GA24276@lst.de>
References: <20220201100420.25875-1-idryomov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201100420.25875-1-idryomov@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
