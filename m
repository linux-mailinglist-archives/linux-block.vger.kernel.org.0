Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3FC706107
	for <lists+linux-block@lfdr.de>; Wed, 17 May 2023 09:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjEQHWs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 May 2023 03:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjEQHWb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 03:22:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5D49EA
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 00:22:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 36D3F68C4E; Wed, 17 May 2023 09:22:19 +0200 (CEST)
Date:   Wed, 17 May 2023 09:22:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH V2 2/2] blk-mq: make sure elevator callbacks aren't
 called for passthrough request
Message-ID: <20230517072218.GB27026@lst.de>
References: <20230515144601.52811-1-ming.lei@redhat.com> <20230515144601.52811-3-ming.lei@redhat.com> <c0c4fc86-29ff-5a70-1f32-dca9af4602d5@acm.org> <ZGKUehOEnKThjFpR@kbusch-mbp> <ZGLad5yYUDJBleBQ@ovpn-8-19.pek2.redhat.com> <20230516062409.GB7325@lst.de> <ZGNBKSaULn/gpsL0@ovpn-8-19.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGNBKSaULn/gpsL0@ovpn-8-19.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 16, 2023 at 04:39:05PM +0800, Ming Lei wrote:
> I can understand the point, but it may not be done by single flag,

Can you explain why?  Note that we also already have RQF_ELVPRIV for
any request that has elevator private data.  I don't really think we
need a third flag.
