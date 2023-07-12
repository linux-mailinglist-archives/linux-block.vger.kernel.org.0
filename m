Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C69750E5F
	for <lists+linux-block@lfdr.de>; Wed, 12 Jul 2023 18:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGLQYH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Jul 2023 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjGLQXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 12:23:55 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804582D61
        for <linux-block@vger.kernel.org>; Wed, 12 Jul 2023 09:23:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52FEC67373; Wed, 12 Jul 2023 18:23:10 +0200 (CEST)
Date:   Wed, 12 Jul 2023 18:23:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set
 max_discard_sectors in blk_queue_max_discard_sectors
Message-ID: <20230712162310.GA29557@lst.de>
References: <20230707094616.108430-1-hch@lst.de> <20230707094616.108430-2-hch@lst.de> <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKvgnI5qZ/Z70ycL@ovpn-8-33.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 06:42:36PM +0800, Ming Lei wrote:
> Userspace may write 0 to discard_max_bytes, and this patch still can
> override user setting.

True.  Maybe the right thing is to have a user_limit field, and just
looks at the min of that and the hw limit everywhere.  These hardware
vs user limits are a pain, and we'll probably need some proper
infrastructure for them :P

