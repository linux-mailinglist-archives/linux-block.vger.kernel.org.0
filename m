Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58F6F1176
	for <lists+linux-block@lfdr.de>; Fri, 28 Apr 2023 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjD1Fsf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Apr 2023 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjD1Fse (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 01:48:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52E72109
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 22:48:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0CF5068D0A; Fri, 28 Apr 2023 07:48:31 +0200 (CEST)
Date:   Fri, 28 Apr 2023 07:48:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 6/9] block: mq-deadline: Improve
 deadline_skip_seq_writes()
Message-ID: <20230428054830.GG8549@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424203329.2369688-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 01:33:26PM -0700, Bart Van Assche wrote:
> Make deadline_skip_seq_writes() do what its name suggests, namely to
> skip sequential writes.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
