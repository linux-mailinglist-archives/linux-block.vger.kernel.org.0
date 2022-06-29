Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5675355F5A5
	for <lists+linux-block@lfdr.de>; Wed, 29 Jun 2022 07:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiF2FUa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Jun 2022 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiF2FU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 01:20:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2831520
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 22:20:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A02768AFE; Wed, 29 Jun 2022 07:20:25 +0200 (CEST)
Date:   Wed, 29 Jun 2022 07:20:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     tj@kernel.org, jack@suse.cz, hch@lst.de, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 2/2] blk-cgroup: factor out blkcg_free_all_cpd()
Message-ID: <20220629052024.GB16113@lst.de>
References: <20220629015022.2667445-1-yanaijie@huawei.com> <20220629015022.2667445-3-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629015022.2667445-3-yanaijie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
