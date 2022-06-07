Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADDD537B35
	for <lists+linux-block@lfdr.de>; Mon, 30 May 2022 15:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbiE3NRh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 30 May 2022 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbiE3NRg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:17:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0A3A5E4
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:17:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8C8F68AFE; Mon, 30 May 2022 15:17:31 +0200 (CEST)
Date:   Mon, 30 May 2022 15:17:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Subject: Re: reduce the dependency on modules
Message-ID: <20220530131731.GA5175@lst.de>
References: <20220530130811.3006554-1-hch@lst.de> <ca206223-112f-2d60-34a3-bb7e6295de7a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca206223-112f-2d60-34a3-bb7e6295de7a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 30, 2022 at 07:12:22AM -0600, Jens Axboe wrote:
> Which null_blk options can only be set at load time?

The example I ran into is the queue mode.

> If there are some,
> we should get them fixed up / added to the configfs side. Yes, the
> configfs side also kind of sucks, but at least it's there.

That is my plan.  I just wanted to get this series out first and then
work on the non-tivial bits involving the kernel.
