Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB8E6C44D2
	for <lists+linux-block@lfdr.de>; Wed, 22 Mar 2023 09:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjCVIXm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Mar 2023 04:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCVIXl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 04:23:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C728413D6D
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 01:23:39 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9906E68C7B; Wed, 22 Mar 2023 09:23:36 +0100 (CET)
Date:   Wed, 22 Mar 2023 09:23:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        Keith Busch <kbusch@kernel.org>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Message-ID: <20230322082336.GB22782@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
