Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F324C2470
	for <lists+linux-block@lfdr.de>; Thu, 24 Feb 2022 08:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiBXHZ5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Feb 2022 02:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiBXHZ5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 02:25:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383C023401C;
        Wed, 23 Feb 2022 23:25:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A19D468AA6; Thu, 24 Feb 2022 08:25:24 +0100 (CET)
Date:   Thu, 24 Feb 2022 08:25:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 10/12] block: move blk_exit_queue into disk_release
Message-ID: <20220224072524.GA21228@lst.de>
References: <20220222141450.591193-1-hch@lst.de> <20220222141450.591193-11-hch@lst.de> <4b9a4121-7f37-9bd3-036a-51892a456eef@acm.org> <YhXapc7fuhb8mlwW@T590> <d2cbbf56-6984-fc54-9eb4-2142a69c379a@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2cbbf56-6984-fc54-9eb4-2142a69c379a@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 23, 2022 at 12:04:03PM -0800, Bart Van Assche wrote:
> On 2/22/22 22:56, Ming Lei wrote:
>> But I admit here the name of blk_mq_release_queue() is very misleading,
>> maybe blk_mq_release_io_queue() is better?
>
> I'm not sure what the best name for that function would be. Anyway, thanks 
> for having clarified that disk structures are removed before the request 
> queue is cleaned up. That's something I was missing.

Maybe disk_release_mq?
