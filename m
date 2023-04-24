Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3706EC4B1
	for <lists+linux-block@lfdr.de>; Mon, 24 Apr 2023 07:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjDXFLu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Apr 2023 01:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDXFLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 01:11:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E8C30EC
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 22:11:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B40B67373; Mon, 24 Apr 2023 07:11:44 +0200 (CEST)
Date:   Mon, 24 Apr 2023 07:11:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     martin.petersen@oracle.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
        israelr@nvidia.com
Subject: Re: [PATCH v1 0/2] Fix failover to non integrity NVMe path
Message-ID: <20230424051144.GA9288@lst.de>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141330.40437-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 23, 2023 at 05:13:28PM +0300, Max Gurtovoy wrote:
> Hi Christoph/Sagi/Martin,
> 
> We're encountered a crash while testing failover between NVMeF/RDMA
> paths to a target that expose a namespace with metadata. The scenario is
> the following:
> Configure one initiator/host path on PI offload capable port (e.g ConnectX-5
> device) and configure second initiator/host path on non PI offload capable
> port (e.g ConnectX-3).

Hmm.  I suspect the right thing to do here is to just fail the second
connect.
